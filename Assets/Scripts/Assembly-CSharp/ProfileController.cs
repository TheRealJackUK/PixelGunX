using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Holoville.HOTween;
using Holoville.HOTween.Core;
using Holoville.HOTween.Plugins;
using Rilisoft;
using UnityEngine;

internal sealed class ProfileController : MonoBehaviour
{
	private const string NicknameKey = "NamePlayer";

	public ProfileView profileView;

	private static ProfileController _instance;

	private bool _dirty;

	private bool _escapePressed;

	private Action[] _exitCallbacks = new Action[0];

	private float _idleTimeStart;

	private Quaternion _initialLocalRotation;

	private float _lastTime;

	private Rect? _touchZone;

	private Color? _storedAmbientLight;

	public static ProfileController Instance
	{
		get
		{
			return _instance;
		}
	}

	public string DesiredWeaponTag { get; set; }

	public bool InterfaceEnabled
	{
		get
		{
			return profileView != null && profileView.interfaceHolder != null && profileView.interfaceHolder.gameObject.activeInHierarchy;
		}
		private set
		{
			if (!(profileView != null) || !(profileView.interfaceHolder != null))
			{
				return;
			}
			profileView.interfaceHolder.gameObject.SetActive(value);
			if (value)
			{
				Refresh(true);
				if (ExperienceController.sharedController != null && ExpController.Instance != null)
				{
					ExperienceController.sharedController.isShowRanks = true;
					ExpController.Instance.InterfaceEnabled = true;
				}
			}
			else
			{
				DesiredWeaponTag = string.Empty;
			}
			FreeAwardShowHandler.CheckShowChest(value);
		}
	}

	public event EventHandler<ProfileView.InputEventArgs> NicknameInput
	{
		add
		{
			if (profileView != null)
			{
				profileView.NicknameInput += value;
			}
		}
		remove
		{
			if (profileView != null)
			{
				profileView.NicknameInput -= value;
			}
		}
	}

	public event EventHandler BackRequested
	{
		add
		{
			if (profileView != null)
			{
				profileView.BackButtonPressed += value;
			}
			this.EscapePressed = (EventHandler)Delegate.Combine(this.EscapePressed, value);
		}
		remove
		{
			if (profileView != null)
			{
				profileView.BackButtonPressed -= value;
			}
			this.EscapePressed = (EventHandler)Delegate.Remove(this.EscapePressed, value);
		}
	}

	private event EventHandler EscapePressed;

	public void HandleBankButton()
	{
		if (BankController.Instance != null)
		{
			EventHandler handleBackFromBank = null;
			handleBackFromBank = delegate
			{
				BankController.Instance.BackRequested -= handleBackFromBank;
				BankController.Instance.InterfaceEnabled = false;
				InterfaceEnabled = true;
			};
			BankController.Instance.BackRequested += handleBackFromBank;
			BankController.Instance.InterfaceEnabled = true;
			InterfaceEnabled = false;
		}
		else
		{
			Debug.LogWarning("BankController.Instance == null");
		}
	}

	public void HandleAchievementsButton()
	{
		if (Application.isEditor)
		{
			Debug.Log("[Achievements] button pressed");
		}
		switch (BuildSettings.BuildTarget)
		{
		case BuildTarget.iPhone:
			if (!Application.isEditor)
			{
				if (Social.localUser.authenticated)
				{
					Social.ShowAchievementsUI();
				}
				else
				{
					GameCenterSingleton.Instance.updateGameCenter();
				}
			}
			break;
		case BuildTarget.Android:
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro)
			{
				Social.ShowAchievementsUI();
			}
			else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
			{
				AGSAchievementsClient.ShowAchievementsOverlay();
			}
			break;
		}
	}

	public void HandleLeaderboardsButton()
	{
		if (Application.isEditor)
		{
			Debug.Log("[Leaderboards] button pressed");
		}
		switch (BuildSettings.BuildTarget)
		{
		case BuildTarget.iPhone:
			if (!Application.isEditor)
			{
				if (Social.localUser.authenticated)
				{
					Social.ShowLeaderboardUI();
				}
				else
				{
					GameCenterSingleton.Instance.updateGameCenter();
				}
			}
			break;
		case BuildTarget.Android:
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro)
			{
				Social.ShowLeaderboardUI();
			}
			else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
			{
				AGSLeaderboardsClient.ShowLeaderboardsOverlay();
			}
			break;
		}
	}

	public void ShowInterface(params Action[] exitCallbacks)
	{
		FriendsController.sharedController.GetOurWins();
		InterfaceEnabled = true;
		_exitCallbacks = exitCallbacks ?? new Action[0];
	}

	private void Awake()
	{
		_instance = this;
	}

	private void Start()
	{
		BackRequested += HandleBackRequest;
		if (profileView != null)
		{
			profileView.Nickname = Defs.GetPlayerNameOrDefault();
			profileView.NicknameInput += HandleNicknameInput;
			_initialLocalRotation = profileView.characterView.character.localRotation;
			switch (BuildSettings.BuildTarget)
			{
			case BuildTarget.iPhone:
				UpdateButton(profileView.achievementsButton, "gamecntr");
				UpdateButton(profileView.leaderboardsButton, "gamecntr");
				break;
			case BuildTarget.Android:
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro)
				{
					UpdateButton(profileView.achievementsButton, "google");
					UpdateButton(profileView.leaderboardsButton, "google");
				}
				else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
				{
					UpdateButton(profileView.achievementsButton, "amazon");
					UpdateButton(profileView.leaderboardsButton, "amazon");
				}
				else
				{
					profileView.achievementsButton.gameObject.SetActive(false);
				}
				break;
			default:
				profileView.achievementsButton.gameObject.SetActive(false);
				break;
			}
		}
		InterfaceEnabled = false;
		FriendsController.OurInfoUpdated += HandleOurInfoUpdated;
	}

	private void HandleOurInfoUpdated()
	{
		if (InterfaceEnabled)
		{
			Refresh(false);
		}
	}

	private void UpdateButton(UIButton button, string spriteName)
	{
		if (!(button == null))
		{
			button.normalSprite = spriteName;
			button.pressedSprite = spriteName + "_n";
			button.hoverSprite = spriteName;
			button.disabledSprite = spriteName;
		}
	}

	private void OnDestroy()
	{
		FriendsController.OurInfoUpdated -= HandleOurInfoUpdated;
		if (profileView != null)
		{
			profileView.NicknameInput -= HandleNicknameInput;
		}
	}

	private void Refresh(bool updateWeapon = true)
	{
		if (profileView != null)
		{
			profileView.Nickname = Defs.GetPlayerNameOrDefault();
			Dictionary<string, object> dictionary = ((!(FriendsController.sharedController != null) || FriendsController.sharedController.ourInfo == null || !FriendsController.sharedController.ourInfo.ContainsKey("wincount") || FriendsController.sharedController.ourInfo["wincount"] == null) ? null : (FriendsController.sharedController.ourInfo["wincount"] as Dictionary<string, object>));
			profileView.DeathmatchWinCount = Storager.getInt(Defs.RatingDeathmatch, false).ToString();
			profileView.TeamBattleWinCount = Storager.getInt(Defs.RatingTeamBattle, false).ToString();
			profileView.DeadlyGamesWinCount = Storager.getInt(Defs.RatingHunger, false).ToString();
			profileView.FlagCaptureWinCount = Storager.getInt(Defs.RatingFlag, false).ToString();
			profileView.TotalWinCount = (Storager.getInt(Defs.RatingDeathmatch, false) + Storager.getInt(Defs.RatingTeamBattle, false) + Storager.getInt(Defs.RatingHunger, false) + Storager.getInt(Defs.RatingFlag, false)).ToString();
			profileView.PixelgunFriendsID = ((!(FriendsController.sharedController != null) || FriendsController.sharedController.id == null) ? string.Empty : FriendsController.sharedController.id);
			object value;
			profileView.TotalWeeklyWinCount = ((dictionary == null || !dictionary.TryGetValue("weekly", out value)) ? 0 : ((long)value)).ToString();
			profileView.CoopTimeSurvivalPointCount = Storager.getInt(Defs.RatingCOOP, false).ToString();
			profileView.WaveCountLabel = PlayerPrefs.GetInt(Defs.WavesSurvivedS, 0).ToString();
			profileView.KilledCountLabel = PlayerPrefs.GetInt(Defs.KilledZombiesSett, 0).ToString();
			profileView.SurvivalScoreLabel = PlayerPrefs.GetInt(Defs.SurvivalScoreSett, 0).ToString();
			profileView.Box1StarsLabel = InitializeStarCountLabelForBox(0);
			profileView.Box2StarsLabel = InitializeStarCountLabelForBox(1);
			profileView.Box3StarsLabel = InitializeStarCountLabelForBox(2);
			profileView.SecretCoinsLabel = InitializeSecretCoinCountLabel();
			if (updateWeapon && WeaponManager.sharedManager != null)
			{
				Weapon[] array = WeaponManager.sharedManager.playerWeapons.OfType<Weapon>().ToArray();
				if (array.Length > 0)
				{
					if (!string.IsNullOrEmpty(DesiredWeaponTag) && array.Any((Weapon w) => w.weaponPrefab.tag.Equals(DesiredWeaponTag)))
					{
						profileView.SetWeaponAndSkin(DesiredWeaponTag);
					}
					else
					{
						System.Random random = new System.Random(Time.frameCount);
						int num = random.Next(array.Length);
						Weapon weapon = array[num];
						profileView.SetWeaponAndSkin(weapon.weaponPrefab.tag);
					}
				}
				else
				{
					profileView.SetWeaponAndSkin("Knife");
				}
			}
			if (FriendsController.sharedController != null)
			{
				if (FriendsController.sharedController.hatName != Defs.HatNoneEqupped)
				{
					profileView.UpdateHat(FriendsController.sharedController.hatName);
				}
				else
				{
					profileView.RemoveHat();
				}
				if (FriendsController.sharedController.capeName != Defs.CapeNoneEqupped)
				{
					profileView.UpdateCape(FriendsController.sharedController.capeName);
				}
				else
				{
					profileView.RemoveCape();
				}
				if (FriendsController.sharedController.bootsName != Defs.BootsNoneEqupped)
				{
					profileView.UpdateBoots(FriendsController.sharedController.bootsName);
				}
				else
				{
					profileView.RemoveBoots();
				}
				if (FriendsController.sharedController.armorName != Defs.ArmorNoneEqupped)
				{
					profileView.UpdateArmor(FriendsController.sharedController.armorName);
				}
				else
				{
					profileView.RemoveArmor();
				}
				profileView.SetClanLogo(FriendsController.sharedController.clanLogo ?? string.Empty);
			}
			else
			{
				profileView.SetClanLogo(string.Empty);
			}
		}
		_idleTimeStart = Time.realtimeSinceStartup;
	}

	private void OnEnable()
	{
		Refresh(true);
	}

	private void Update()
	{
		EventHandler escapePressed = this.EscapePressed;
		if (_escapePressed && escapePressed != null)
		{
			escapePressed(this, EventArgs.Empty);
			_escapePressed = false;
		}
		if (Time.realtimeSinceStartup - _idleTimeStart > ShopNGUIController.IdleTimeoutPers)
		{
			ReturnCharacterToInitialState();
		}
	}

	private void LateUpdate()
	{
		if (profileView != null && InterfaceEnabled && !HOTween.IsTweening(profileView.characterView.character))
		{
			float num = -120f;
			num *= ((BuildSettings.BuildTarget != BuildTarget.Android) ? 0.5f : 2f);
			if (Input.touchCount > 0)
			{
				if (!_touchZone.HasValue)
				{
					_touchZone = new Rect(0f, 0.1f * (float)Screen.height, 0.5f * (float)Screen.width, 0.8f * (float)Screen.height);
				}
				Touch touch = Input.GetTouch(0);
				if (touch.phase == TouchPhase.Moved && _touchZone.Value.Contains(touch.position))
				{
					_idleTimeStart = Time.realtimeSinceStartup;
					profileView.characterView.character.Rotate(Vector3.up, touch.deltaPosition.x * num * 0.5f * (Time.realtimeSinceStartup - _lastTime));
				}
			}
			else if (Application.isEditor)
			{
				float num2 = Input.GetAxis("Mouse ScrollWheel") * 30f * num * (Time.realtimeSinceStartup - _lastTime);
				profileView.characterView.character.Rotate(Vector3.up, num2);
				if (num2 != 0f)
				{
					_idleTimeStart = Time.realtimeSinceStartup;
				}
			}
			_lastTime = Time.realtimeSinceStartup;
		}
		if (Input.GetKeyUp(KeyCode.Escape) && (!(BankController.Instance != null) || !BankController.Instance.InterfaceEnabled))
		{
			_escapePressed = true;
		}
	}

	private void ReturnCharacterToInitialState()
	{
		if (profileView == null)
		{
			Debug.LogWarning("profileView == null");
			return;
		}
		int num = HOTween.Kill(profileView.characterView.character);
		if (num > 0 && Application.isEditor)
		{
			Debug.LogWarning("Tweens killed: " + num);
		}
		_idleTimeStart = Time.realtimeSinceStartup;
		HOTween.To(profileView.characterView.character, 0.5f, new TweenParms().Prop("localRotation", new PlugQuaternion(_initialLocalRotation)).UpdateType(UpdateType.TimeScaleIndependentUpdate).Ease(EaseType.Linear)
			.OnComplete((TweenDelegate.TweenCallback)delegate
			{
				_idleTimeStart = Time.realtimeSinceStartup;
			}));
	}

	private string InitializeStarCountLabelForBox(int boxIndex)
	{
		if (boxIndex >= LevelBox.campaignBoxes.Count)
		{
			Debug.LogWarning("Box index is out of range:    " + boxIndex);
			return string.Empty;
		}
		LevelBox levelBox = LevelBox.campaignBoxes[boxIndex];
		List<CampaignLevel> levels = levelBox.levels;
		Dictionary<string, int> value;
		if (!CampaignProgress.boxesLevelsAndStars.TryGetValue(levelBox.name, out value))
		{
			Debug.LogWarning("ProfileController: Box not found in dictionary: " + levelBox.name);
			value = new Dictionary<string, int>();
		}
		int num = 0;
		for (int i = 0; i != levels.Count; i++)
		{
			string sceneName = levels[i].sceneName;
			int value2 = 0;
			value.TryGetValue(sceneName, out value2);
			num += value2;
		}
		return string.Concat(num, '/', levels.Count * 3);
	}

	private string InitializeSecretCoinCountLabel()
	{
		string[] array = Storager.getString(Defs.LevelsWhereGetCoinS, false).Split(new char[1] { '#' }, StringSplitOptions.RemoveEmptyEntries);
		int num = Math.Min(20, array.Length);
		return string.Concat(num, '/', 20);
	}

	private void HandleNicknameInput(object sender, ProfileView.InputEventArgs e)
	{
		if (Application.isEditor)
		{
			Debug.Log("Saving new name:    " + e.Input);
		}
		PlayerPrefs.SetString("NamePlayer", e.Input);
		if (WeaponManager.sharedManager != null && WeaponManager.sharedManager.myTable != null)
		{
			NetworkStartTable component = WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>();
			if (component != null)
			{
				component.SetNewNick();
			}
		}
		_dirty = true;
	}

	private void HandleBackRequest(object sender, EventArgs e)
	{
		if (_dirty && FriendsController.sharedController != null)
		{
			FriendsController.sharedController.SendOurData(false);
			_dirty = false;
		}
		Action action = _exitCallbacks.FirstOrDefault();
		if (action != null)
		{
			action();
		}
		StartCoroutine(ExitCallbacksCoroutine());
	}

	private IEnumerator ExitCallbacksCoroutine()
	{
		for (int i = 1; i < _exitCallbacks.Length; i++)
		{
			Action exitCallback = _exitCallbacks[i];
			exitCallback();
			yield return null;
		}
		_exitCallbacks = new Action[0];
		InterfaceEnabled = false;
	}
}
