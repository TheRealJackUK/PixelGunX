using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

internal sealed class VideoRecordingController : MonoBehaviour, IDisposable
{
	public bool isHud;

	public UIButton resumeButton;

	private List<Action> _disposeActions = new List<Action>();

	private bool _disposed;

	private readonly EveryplayWrapper _everyplayWrapper = EveryplayWrapper.Instance;

	private string _normalSpriteName = string.Empty;

	private Pauser _pauser;

	private string _pressedSpriteName = string.Empty;

	private VideoRecordingView _view;

	private bool _shouldChangeSideOnEnable;

	public void Dispose()
	{
		if (_disposed)
		{
			return;
		}
		Debug.Log("Disposing " + GetType().Name);
		foreach (Action item in _disposeActions.Where((Action a) => a != null))
		{
			item();
		}
		_disposed = true;
	}

	private void Awake()
	{
		_view = base.gameObject.GetComponent<VideoRecordingView>();
		if (_view != null)
		{
			if (Defs.IsTraining)
			{
				_view.InterfaceEnabled = false;
			}
			if (!Defs.isMulti && !Defs.IsSurvival)
			{
				_view.InterfaceEnabled = false;
				SafeStop();
			}
			if (!GlobalGameController.ShowRec)
			{
				_view.InterfaceEnabled = false;
			}
		}
	}

	private void ChangeSide()
	{
		Debug.Log(" ChangeSide()");
		ChangeSideCoroutine();
	}

	private void ChangeSideCoroutine()
	{
		if (isHud)
		{
			base.transform.localPosition = new Vector3((float)((!GlobalGameController.LeftHanded) ? 1 : (-1)) * ((float)Screen.width * 768f / (float)Screen.height / 2f - 30f), base.transform.localPosition.y, base.transform.localPosition.z);
		}
	}

	private void Start()
	{
		if (_view != null)
		{
			EventHandler startedHandler = delegate
			{
				Dictionary<string, object> metadata = new Dictionary<string, object> { 
				{
					"Best Score",
					PlayerPrefs.GetInt(Defs.BestScoreSett, 0)
				} };
				Everyplay.SetMetadata(metadata);
			};
			_view.Started += startedHandler;
			_disposeActions.Add(delegate
			{
				_view.Started -= startedHandler;
			});
		}
		if (resumeButton != null)
		{
			_normalSpriteName = resumeButton.normalSprite ?? string.Empty;
			_pressedSpriteName = resumeButton.pressedSprite ?? string.Empty;
		}
		else
		{
			Debug.LogError("resumeButton == null");
		}
		GameObject gameObject = GameObject.FindGameObjectWithTag("GameController");
		if (gameObject != null)
		{
			_pauser = gameObject.GetComponent<Pauser>();
		}
		Everyplay.UploadDidCompleteDelegate uploadHadler = delegate
		{
			int @int = PlayerPrefs.GetInt("PostVideo", 0);
			PlayerPrefs.SetInt("PostVideo", PlayerPrefs.GetInt("PostVideo", 0) + 1);
			if (PlayerPrefs.GetInt("Active_loyal_users_send", 0) == 0 && PlayerPrefs.GetInt("PostFacebookCount", 0) > 2)
			{
				FacebookController.LogEvent("Active_loyal_users");
				PlayerPrefs.SetInt("Active_loyal_users_send", 1);
			}
			if (PlayerPrefs.GetInt("Active_loyal_users_payed_send", 0) == 0 && PlayerPrefs.GetInt("PostFacebookCount", 0) > 2 && StoreKitEventListener.GetDollarsSpent() > 0)
			{
				FacebookController.LogEvent("Active_loyal_users_payed");
				PlayerPrefs.SetInt("Active_loyal_users_payed_send", 1);
			}
		};
		Everyplay.UploadDidComplete += uploadHadler;
		_disposeActions.Add(delegate
		{
			Everyplay.UploadDidComplete -= uploadHadler;
		});
		PauseNGUIController.PlayerHandUpdated += ChangeSide;
		ChangeSideCoroutine();
	}

	private void Update()
	{
		if (_disposed)
		{
			if (Time.frameCount % 300 == 17)
			{
				Debug.LogWarning(GetType().Name + " is disposed.");
			}
			return;
		}
		if (_view != null)
		{
			if (!GlobalGameController.ShowRec)
			{
				SafeStop();
			}
			_view.InterfaceEnabled = GlobalGameController.ShowRec;
			_view.InterfaceEnabled = _view.InterfaceEnabled && !ShopNGUIController.GuiActive;
			if (_pauser != null)
			{
				_view.InterfaceEnabled = _view.InterfaceEnabled && !_pauser.paused;
			}
			if (ExperienceController.sharedController != null)
			{
				_view.InterfaceEnabled = _view.InterfaceEnabled && !ExperienceController.sharedController.isShowNextPlashka;
			}
			if (Defs.isHunger)
			{
				if (isHud)
				{
					WeaponManager sharedManager = WeaponManager.sharedManager;
					if (sharedManager != null && sharedManager.myTable != null)
					{
						NetworkStartTable component = sharedManager.myTable.GetComponent<NetworkStartTable>();
						if (component != null)
						{
							_view.InterfaceEnabled = _view.InterfaceEnabled && !component.isDeadInHungerGame;
						}
					}
					if (HungerGameController.Instance != null && HungerGameController.Instance.isGo && !GameObject.FindGameObjectsWithTag("Player").Any())
					{
						_view.InterfaceEnabled = false;
					}
				}
				else
				{
					NetworkStartTableNGUIController sharedController = NetworkStartTableNGUIController.sharedController;
					bool flag = sharedController != null && sharedController.spectratorModePnl != null && sharedController.spectratorModePnl.activeInHierarchy;
					if (flag)
					{
						SafeStop();
					}
					_view.InterfaceEnabled = _view.InterfaceEnabled && !flag;
				}
			}
			if (Defs.IsTraining)
			{
				_view.InterfaceEnabled = false;
				SafeStop();
			}
			if (!Defs.isMulti && !Defs.IsSurvival)
			{
				_view.InterfaceEnabled = false;
				SafeStop();
			}
		}
		else if (Time.frameCount % 300 == 57)
		{
			Debug.LogWarning("_view == null");
		}
		if (_everyplayWrapper.Elapsed.TotalMinutes >= 20.0)
		{
			SafeStop();
		}
		if (resumeButton != null && _everyplayWrapper.CurrentState == EveryplayWrapper.State.Paused)
		{
			string text = (((int)Time.time % 2 != 0) ? _normalSpriteName : _pressedSpriteName);
			if (resumeButton.normalSprite != text)
			{
				resumeButton.normalSprite = text;
			}
		}
	}

	private void OnDestroy()
	{
		PauseNGUIController.PlayerHandUpdated -= ChangeSide;
		Dispose();
	}

	private void OnEnable()
	{
		ChangeSideCoroutine();
		_shouldChangeSideOnEnable = false;
	}

	private void SafeStop()
	{
		if (_everyplayWrapper.CurrentState == EveryplayWrapper.State.Paused || _everyplayWrapper.CurrentState == EveryplayWrapper.State.Recording)
		{
			_everyplayWrapper.Stop();
		}
	}
}
