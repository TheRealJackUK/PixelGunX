using System;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using UnityEngine;

internal sealed class VideoRecordingView : MonoBehaviour, IDisposable
{
	public UIAnchor interfaceContainer;

	public UILabel caption;

	public UIButton pauseButton;

	public UIButton resumeButton;

	public UIButton shareButton;

	public UIButton stopButton;

	public GameObject frame1;

	public GameObject frame2;

	private string startRecLocalize;

	private string recLocalize;

	private string doneLocalize;

	private readonly List<Action> _disposeActions = new List<Action>();

	private bool _disposed;

	private readonly EveryplayWrapper _everyplayWrapper = EveryplayWrapper.Instance;

	private bool _interfaceEnabled = true;

	public bool InterfaceEnabled
	{
		get
		{
			return _interfaceEnabled;
		}
		set
		{
			_interfaceEnabled = value;
		}
	}

	public static bool IsWeakDevice
	{
		get
		{
			return (BuildSettings.BuildTarget == BuildTarget.Android && Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon) || BuildSettings.BuildTarget == BuildTarget.WP8Player;
		}
	}

	private EveryplayWrapper.State CurrentState
	{
		get
		{
			return _everyplayWrapper.CurrentState;
		}
	}

	public event EventHandler Starting;

	public event EventHandler Started;

	public void Dispose()
	{
		if (_disposed)
		{
			return;
		}
		foreach (Action item in _disposeActions.Where((Action a) => a != null))
		{
			item();
		}
		_disposed = true;
	}

	private void Start()
	{
		startRecLocalize = LocalizationStore.Key_0207;
		recLocalize = LocalizationStore.Key_0558;
		doneLocalize = LocalizationStore.Key_0559;
		if (!Everyplay.IsSupported() && !Application.isEditor)
		{
			Debug.Log("Everyplay is not supported.");
			base.gameObject.SetActive(false);
			return;
		}
		UnityEngine.Object[] source = new UnityEngine.Object[6] { interfaceContainer, caption, pauseButton, resumeButton, shareButton, stopButton };
		if (source.Any((UnityEngine.Object ri) => ri == null))
		{
			_disposed = true;
			return;
		}
		BindHandler(pauseButton, HandlePauseButton);
		BindHandler(resumeButton, HandleResumeButton);
		BindHandler(stopButton, HandleStopButton);
		BindHandler(shareButton, HandleShareButton);
		pauseButton.gameObject.SetActive(false);
		resumeButton.gameObject.SetActive(false);
		shareButton.gameObject.SetActive(false);
		stopButton.gameObject.SetActive(false);
		interfaceContainer.gameObject.SetActive(_interfaceEnabled && (Everyplay.IsSupported() || true));
	}

	private void OnDestroy()
	{
		Dispose();
	}

	private void Update()
	{
		if (_disposed)
		{
			return;
		}
		bool isEditor = true;
		bool isWeakDevice = IsWeakDevice;
		bool flag = Everyplay.IsRecordingSupported();
		interfaceContainer.gameObject.SetActive(_interfaceEnabled && !isWeakDevice && (isEditor || flag));
		if (interfaceContainer.gameObject.activeInHierarchy)
		{
			if (!Application.isEditor)
			{
				bool flag2 = Everyplay.IsPaused();
				bool flag3 = Everyplay.IsRecording();
				pauseButton.isEnabled = flag && !flag2;
				resumeButton.isEnabled = flag && flag2;
				shareButton.isEnabled = flag && !flag3;
				stopButton.isEnabled = flag3 || flag2;
			}
			pauseButton.gameObject.SetActive(CurrentState == EveryplayWrapper.State.Recording);
			resumeButton.gameObject.SetActive(CurrentState == EveryplayWrapper.State.Paused);
			bool flag4 = CurrentState == EveryplayWrapper.State.Idle;
			bool flag5 = CurrentState == EveryplayWrapper.State.Recording || CurrentState == EveryplayWrapper.State.Paused;
			shareButton.gameObject.SetActive(flag4);
			stopButton.gameObject.SetActive(CurrentState == EveryplayWrapper.State.Recording || CurrentState == EveryplayWrapper.State.Paused);
			if ((flag4 || flag5) && frame2 != null && !frame2.activeSelf)
			{
				if (frame1 != null)
				{
					frame1.SetActive(false);
				}
				if (frame2 != null)
				{
					frame2.SetActive(true);
				}
			}
			TimeSpan elapsed = _everyplayWrapper.Elapsed;
			string arg = string.Format("{0}:{1:00}", (int)elapsed.TotalMinutes, elapsed.Seconds);
			switch (CurrentState)
			{
			case EveryplayWrapper.State.Recording:
				caption.text = string.Format("{0}\n{1}", recLocalize, arg);
				break;
			case EveryplayWrapper.State.Paused:
				caption.text = string.Format("{0}\n{1}", recLocalize, arg);
				break;
			case EveryplayWrapper.State.Idle:
				caption.text = string.Format("{0}\n{1}", doneLocalize, arg);
				break;
			default:
				caption.text = startRecLocalize;
				break;
			}
		}
		if (Time.frameCount % 300 == 0 && Everyplay.IsSupported())
		{
			_everyplayWrapper.CheckState();
		}
	}

	private void BindHandler(UIButton button, EventHandler handler)
	{
		if (_disposed || button == null)
		{
			return;
		}
		ButtonHandler buttonHandler = button.GetComponent<ButtonHandler>();
		if (buttonHandler != null)
		{
			buttonHandler.Clicked += handler;
			_disposeActions.Add(delegate
			{
				buttonHandler.Clicked -= handler;
			});
		}
	}

	private void HandlePauseButton(object sender, EventArgs e)
	{
		if (!_disposed && (!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown))
		{
			_everyplayWrapper.Pause();
		}
	}

	private void HandleRecordButton(object sender, EventArgs e)
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !LoadingInAfterGame.isShowLoading && !_disposed)
		{
			EventHandler starting = this.Starting;
			if (starting != null)
			{
				starting(this, EventArgs.Empty);
			}
			if (frame1 != null)
			{
				frame1.SetActive(false);
			}
			if (frame2 != null)
			{
				frame2.SetActive(true);
			}
			_everyplayWrapper.Record();
			EventHandler started = this.Started;
			if (started != null)
			{
				started(this, EventArgs.Empty);
			}
		}
	}

	private void HandleResumeButton(object sender, EventArgs e)
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !_disposed)
		{
			_everyplayWrapper.Resume();
		}
	}

	private void HandleShareButton(object sender, EventArgs e)
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !_disposed)
		{
			_everyplayWrapper.Share();
		}
	}

	private void HandleStopButton(object sender, EventArgs e)
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !_disposed)
		{
			_everyplayWrapper.Stop();
		}
	}
}
