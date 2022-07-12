using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using Prime31;
using Rilisoft;
using UnityEngine;
using Rilisoft.MiniJson;
using UnityEngine;

[RequireComponent(typeof(FrameStopwatchScript))]
internal sealed class Switcher : MonoBehaviour
{
	internal const string AbuseMethodKey = "AbuseMethod";

	public static Dictionary<string, int> sceneNameToGameNum;

	public static Dictionary<string, int> counCreateMobsInLevel;

	public static string LoadingInResourcesPath;

	public static string[] loadingNames;

	public GameObject coinsShopPrefab;

	public GameObject nickStackPrefab;

	public GameObject skinsManagerPrefab;

	public GameObject ExperienceControllerPrefab;

	public GameObject weaponManagerPrefab;

	public GameObject flurryPrefab;

	public GameObject backgroundMusicPrefab;

	public GameObject guiHelperPrefab;

	public GameObject experienceGuiPrefab;

	public GameObject bankGuiPrefab;

	public GameObject freeAwardGuiPrefab;

	private Rect plashkaCoinsRect;

	private Texture fonToDraw;

	private bool _newLaunchingApproach;

	private float _progress;

	private static AbuseMetod? _abuseMethod;

	internal static AbuseMetod AbuseMethod
	{
		get
		{
			if (!_abuseMethod.HasValue)
			{
				_abuseMethod = (AbuseMetod)Storager.getInt("AbuseMethod", false);
			}
			return _abuseMethod.Value;
		}
	}

	static Switcher()
	{
		sceneNameToGameNum = new Dictionary<string, int>();
		counCreateMobsInLevel = new Dictionary<string, int>();
		LoadingInResourcesPath = "LevelLoadings";
		loadingNames = new string[17]
		{
			"Loading_coliseum", "loading_Cementery", "Loading_Maze", "Loading_City", "Loading_Hospital", "Loading_Jail", "Loading_end_world_2", "Loading_Arena", "Loading_Area52", "Loading_Slender",
			"Loading_Hell", "Loading_bloody_farm", "Loading_most", "Loading_school", "Loading_utopia", "Loading_sky", "Loading_winter"
		};
		sceneNameToGameNum.Add("Training", 0);
		sceneNameToGameNum.Add("Cementery", 1);
		sceneNameToGameNum.Add("Maze", 2);
		sceneNameToGameNum.Add("City", 3);
		sceneNameToGameNum.Add("Hospital", 4);
		sceneNameToGameNum.Add("Jail", 5);
		sceneNameToGameNum.Add("Gluk_2", 6);
		sceneNameToGameNum.Add("Arena", 7);
		sceneNameToGameNum.Add("Area52", 8);
		sceneNameToGameNum.Add("Slender", 9);
		sceneNameToGameNum.Add("Castle", 10);
		sceneNameToGameNum.Add("Farm", 11);
		sceneNameToGameNum.Add("Bridge", 12);
		sceneNameToGameNum.Add("School", 13);
		sceneNameToGameNum.Add("Utopia", 14);
		sceneNameToGameNum.Add("Sky_islands", 15);
		sceneNameToGameNum.Add("Winter", 16);
		sceneNameToGameNum.Add("Swamp_campaign3", 17);
		sceneNameToGameNum.Add("Castle_campaign3", 18);
		sceneNameToGameNum.Add("Space_campaign3", 19);
		sceneNameToGameNum.Add("Parkour", 20);
		sceneNameToGameNum.Add("Code_campaign3", 21);
		counCreateMobsInLevel.Add("Farm", 10);
		counCreateMobsInLevel.Add("Cementery", 15);
		counCreateMobsInLevel.Add("City", 20);
		counCreateMobsInLevel.Add("Hospital", 25);
		counCreateMobsInLevel.Add("Bridge", 25);
		counCreateMobsInLevel.Add("Jail", 30);
		counCreateMobsInLevel.Add("Slender", 30);
		counCreateMobsInLevel.Add("Area52", 35);
		counCreateMobsInLevel.Add("School", 35);
		counCreateMobsInLevel.Add("Utopia", 25);
		counCreateMobsInLevel.Add("Maze", 30);
		counCreateMobsInLevel.Add("Sky_islands", 30);
		counCreateMobsInLevel.Add("Winter", 30);
		counCreateMobsInLevel.Add("Castle", 35);
		counCreateMobsInLevel.Add("Gluk_2", 35);
		counCreateMobsInLevel.Add("Swamp_campaign3", 30);
		counCreateMobsInLevel.Add("Castle_campaign3", 35);
		counCreateMobsInLevel.Add("Space_campaign3", 25);
		counCreateMobsInLevel.Add("Parkour", 15);
		counCreateMobsInLevel.Add("Code_campaign3", 35);
	}

	internal static IEnumerable<float> InitializeStorager()
	{
		float progress3 = 0f;
		/*if (!Storager.hasKey(Defs.initValsInKeychain15))
		{
			UnityEngine.Debug.LogError("resetting or some shit");
			Storager.setInt(Defs.initValsInKeychain15, 0, false);
			Storager.setInt(Defs.LobbyLevelApplied, 1, false);
			Storager.setString(Defs.CapeEquppedSN, Defs.CapeNoneEqupped, false);
			Storager.setString(Defs.HatEquppedSN, Defs.HatNoneEqupped, false);
			Storager.setInt(Defs.IsFirstLaunchFreshInstall, 1, false);
			yield return progress3;
		}*/
		if (Storager.getInt(Defs.LobbyLevelApplied, false) == 0)
		{
			Storager.setInt(Defs.ShownLobbyLevelSN, 4, false);
		}
		if (!Storager.hasKey(Defs.IsFirstLaunchFreshInstall))
		{
			Storager.setInt(Defs.IsFirstLaunchFreshInstall, 0, false);
		}
		progress3 = 0.25f;
		if ((Application.platform == RuntimePlatform.IPhonePlayer && UnityEngine.Debug.isDebugBuild) || (Application.platform == RuntimePlatform.IPhonePlayer && !Storager.hasKey(Defs.initValsInKeychain17)))
		{
			Storager.setInt(Defs.initValsInKeychain17, 0, false);
			PlayerPrefs.SetFloat(value: SecondsFrom1970(), key: Defs.TimeFromWhichShowEnder_SN);
		}
		/*if (!Storager.hasKey(Defs.initValsInKeychain27))
		{
			UnityEngine.Debug.LogError("resetting boots or some shit");
			Storager.setInt(Defs.initValsInKeychain27, 0, false);
			Storager.setString(Defs.BootsEquppedSN, Defs.BootsNoneEqupped, false);
			yield return progress3;
		}*/
		progress3 = 0.5f;
		yield return progress3;
		/*if (!Storager.hasKey(Defs.initValsInKeychain40))
		{
			UnityEngine.Debug.LogError("resetting armor or some shit");
			Storager.setInt(Defs.initValsInKeychain40, 0, false);
			Storager.setString(Defs.ArmorNewEquppedSN, Defs.ArmorNewNoneEqupped, false);
			Storager.setInt("GrenadeID", 5, false);
			UnityEngine.Debug.LogError("trolled");
			yield return progress3;
		}*/
		if (Storager.hasKey(Defs.initValsInKeychain41))
		{
			UnityEngine.Debug.LogError("keychain41 will always be found");
			Storager.setInt(Defs.initValsInKeychain41, 0, false);
			string hatBought = null;
			string visualHatArmor = null;
			if (Storager.getInt(Wear.hat_Almaz_1, false) > 0)
			{
				hatBought = Wear.hat_Army_3;
				Storager.setInt(Wear.hat_Almaz_1, 0, false);
				Storager.setInt(Wear.hat_Royal_1, 0, false);
				Storager.setInt(Wear.hat_Steel_1, 0, false);
				visualHatArmor = Wear.hat_Almaz_1;
				UnityEngine.Debug.LogError("hatBought is " + hatBought);
				UnityEngine.Debug.LogError("visualHatArmor is " + visualHatArmor);
				yield return progress3;
			}
			else if (Storager.getInt(Wear.hat_Royal_1, false) > 0)
			{
				hatBought = Wear.hat_Army_2;
				Storager.setInt(Wear.hat_Royal_1, 0, false);
				Storager.setInt(Wear.hat_Steel_1, 0, false);
				visualHatArmor = Wear.hat_Royal_1;
				UnityEngine.Debug.LogError("hatBought is " + hatBought);
				UnityEngine.Debug.LogError("visualHatArmor is " + visualHatArmor);
				yield return progress3;
			}
			else if (Storager.getInt(Wear.hat_Steel_1, false) > 0)
			{
				hatBought = Wear.hat_Army_1;
				Storager.setInt(Wear.hat_Steel_1, 0, false);
				visualHatArmor = Wear.hat_Steel_1;
				UnityEngine.Debug.LogError("hatBought is " + hatBought);
				UnityEngine.Debug.LogError("visualHatArmor is " + visualHatArmor);
				yield return progress3;
			}


			if (hatBought != null)
			{
				string hatEquipped = Storager.getString(Defs.HatEquppedSN, false);
				if (hatEquipped.Equals(Wear.hat_Almaz_1) || hatEquipped.Equals(Wear.hat_Royal_1) || hatEquipped.Equals(Wear.hat_Steel_1))
				{
					Storager.setString(Defs.HatEquppedSN, hatBought, false);
				}
				for (int j = 0; j <= Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0].IndexOf(hatBought); j++)
				{
					Storager.setInt(Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0][j], 1, false);
					yield return progress3;
				}
			}
			if (BuildSettings.BuildTarget == BuildTarget.iPhone)
			{
				Storager.setString(Defs.VisualHatArmor, string.Empty, false);
			}
			if (visualHatArmor != null)
			{
				Storager.setString(Defs.VisualHatArmor, visualHatArmor, false);
			}
			// string[] foundHats = new string[]{};
			yield return progress3;
			string armorBought = null;
			string visualArmor = null;
			if (Storager.getInt(Wear.Armor_Almaz_1, false) > 0)
			{
				armorBought = Wear.Armor_Army_3;
				Storager.setInt(Wear.Armor_Almaz_1, 0, false);
				Storager.setInt(Wear.Armor_Royal_1, 0, false);
				Storager.setInt(Wear.Armor_Steel, 0, false);
				visualArmor = Wear.Armor_Almaz_1;
				yield return progress3;
			}
			else if (Storager.getInt(Wear.Armor_Royal_1, false) > 0)
			{
				armorBought = Wear.Armor_Army_2;
				Storager.setInt(Wear.Armor_Royal_1, 0, false);
				Storager.setInt(Wear.Armor_Steel, 0, false);
				visualArmor = Wear.Armor_Royal_1;
				yield return progress3;
			}
			else if (Storager.getInt(Wear.Armor_Steel, false) > 0)
			{
				armorBought = Wear.Armor_Army_1;
				Storager.setInt(Wear.Armor_Steel, 0, false);
				visualArmor = Wear.Armor_Steel;
				yield return progress3;
			}
			if (BuildSettings.BuildTarget == BuildTarget.iPhone)
			{
				Storager.setString(Defs.VisualArmor, string.Empty, false);
			}
			if (visualArmor != null)
			{
				UnityEngine.Debug.LogError("visual armor is " + visualArmor);
				Storager.setString(Defs.VisualArmor, visualArmor, false);
			}
			yield return progress3;
			
			if (armorBought != null)
			{
				string armorEquipped = Storager.getString(Defs.ArmorNewEquppedSN, false);
				if (armorEquipped.Equals(Wear.Armor_Almaz_1) || armorEquipped.Equals(Wear.Armor_Royal_1) || armorEquipped.Equals(Wear.Armor_Steel))
				{
					Storager.setString(Defs.ArmorNewEquppedSN, armorBought, false);
					yield return progress3;
				}
				for (int i = 0; i <= Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0].IndexOf(armorBought); i++)
				{
					Storager.setInt(Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0][i], 1, false);
					yield return progress3;
				}
			}
		}
		progress3 = 0.75f;
		if (!Storager.IsInitialized(Defs.initValsInKeychain43))
		{
			Storager.SetInitialized(Defs.initValsInKeychain43);
			if (!Storager.hasKey(GearManager.Jetpack))
			{
				Storager.setInt(GearManager.Jetpack, 4, false);
			}
			if (!Storager.hasKey(GearManager.Turret))
			{
				Storager.setInt(GearManager.Turret, 4, false);
			}
			if (!Storager.hasKey(GearManager.Mech))
			{
				Storager.setInt(GearManager.Mech, 4, false);
			}
			PlayerPrefs.SetString(Defs.StartTimeShowBannersKey, DateTimeOffset.UtcNow.ToString("s"));
			PlayerPrefs.Save();
			yield return progress3;
			if (BuildSettings.BuildTarget == BuildTarget.iPhone)
			{
				Storager.setInt(Defs.NeedTakeMarathonBonus, 0, false);
				Storager.setInt(Defs.NextMarafonBonusIndex, 0, false);
				yield return progress3;
			}
		}
		Defs.StartTimeShowBannersString = PlayerPrefs.GetString(Defs.StartTimeShowBannersKey, string.Empty);
		UnityEngine.Debug.Log(" StartTimeShowBannersString=" + Defs.StartTimeShowBannersString);
		if (!Storager.IsInitialized(Defs.initValsInKeychain44))
		{
			Storager.SetInitialized(Defs.initValsInKeychain44);
			if (Storager.hasKey(Defs.NextMarafonBonusIndex) && Storager.getInt(Defs.NextMarafonBonusIndex, false) == -1)
			{
				Storager.setInt(Defs.NextMarafonBonusIndex, 0, false);
			}
			yield return progress3;
		}
		if (!Storager.hasKey("Win Count Timestamp"))
		{
			Storager.setString("Win Count Timestamp", "{ \"1970-01-01\": 0 }", false);
		}
		if (!Storager.hasKey("StartTimeShowStarterPack"))
		{
			Storager.setString("StartTimeShowStarterPack", string.Empty, false);
			yield return progress3;
		}
		if (!Storager.hasKey("TimeEndStarterPack"))
		{
			Storager.setString("TimeEndStarterPack", string.Empty, false);
			yield return progress3;
		}
		if (!Storager.hasKey("NextNumberStarterPack"))
		{
			Storager.setInt("NextNumberStarterPack", 0, false);
			yield return progress3;
		}
		if (!Storager.hasKey(Defs.ArmorEquppedSN))
		{
			Storager.setString(Defs.ArmorEquppedSN, Defs.ArmorNoneEqupped, false);
		}
		if (!Storager.hasKey(Defs.ShowSorryWeaponAndArmor))
		{
			Storager.setInt(Defs.ShowSorryWeaponAndArmor, 0, false);
		}
		if (Storager.getInt(Defs.IsFirstLaunchFreshInstall, false) > 0)
		{
			Storager.setInt(Defs.IsFirstLaunchFreshInstall, 0, false);
		}
		if (!Storager.hasKey(Defs.NewbieEventX3StartTime))
		{
			Storager.setString(Defs.NewbieEventX3StartTime, 0L.ToString(), false);
			Storager.setString(Defs.NewbieEventX3StartTimeAdditional, 0L.ToString(), false);
			Storager.setString(Defs.NewbieEventX3LastLoggedTime, 0L.ToString(), false);
			PlayerPrefs.SetInt(Defs.WasNewbieEventX3, 0);
		}
		if (!PlayerPrefs.HasKey(Defs.LastTimeUpdateAvailableShownSN))
		{
			DateTime myDate1 = new DateTime(1970, 1, 9, 0, 0, 0);
			PlayerPrefs.SetString(value: new DateTimeOffset(myDate1).ToString("s"), key: Defs.LastTimeUpdateAvailableShownSN);
			PlayerPrefs.Save();
		}
		string lastTimeUpdateShownString = PlayerPrefs.GetString(Defs.LastTimeUpdateAvailableShownSN);
		DateTimeOffset lastTimeUpdateShown = default(DateTimeOffset);
		if (!DateTimeOffset.TryParse(lastTimeUpdateShownString, out lastTimeUpdateShown) && UnityEngine.Debug.isDebugBuild)
		{
			UnityEngine.Debug.LogWarning("Cannot parse " + lastTimeUpdateShownString);
		}
		if (DateTimeOffset.Now - lastTimeUpdateShown > TimeSpan.FromHours(12.0))
		{
			PlayerPrefs.SetInt(Defs.UpdateAvailableShownTimesSN, 3);
			PlayerPrefs.SetString(Defs.LastTimeUpdateAvailableShownSN, DateTimeOffset.Now.ToString("s"));
			yield return progress3;
		}
		float eventX3ShowTimeoutHours = 1f / 12f;
		if (!PlayerPrefs.HasKey(Defs.EventX3WindowShownLastTime))
		{
			PlayerPrefs.SetInt(Defs.EventX3WindowShownCount, 1);
			PlayerPrefs.SetString(Defs.EventX3WindowShownLastTime, PromoActionsManager.CurrentUnixTime.ToString());
			yield return progress3;
		}
		long eventX3WindowShownLastTime;
		long.TryParse(PlayerPrefs.GetString(Defs.EventX3WindowShownLastTime), out eventX3WindowShownLastTime);
		if (PromoActionsManager.CurrentUnixTime - eventX3WindowShownLastTime > (long)TimeSpan.FromHours(eventX3ShowTimeoutHours).TotalSeconds)
		{
			PlayerPrefs.SetInt(Defs.EventX3WindowShownCount, 1);
			PlayerPrefs.SetString(Defs.EventX3WindowShownLastTime, PromoActionsManager.CurrentUnixTime.ToString());
		}
		PlayerPrefs.Save();
		yield return progress3;
		float advertShowTimeoutHours = 1f / 12f;
		if (!PlayerPrefs.HasKey(Defs.AdvertWindowShownLastTime))
		{
			PlayerPrefs.SetInt(Defs.AdvertWindowShownCount, 3);
			PlayerPrefs.SetString(Defs.AdvertWindowShownLastTime, PromoActionsManager.CurrentUnixTime.ToString());
		}
		long advertWindowShownLastTime;
		long.TryParse(PlayerPrefs.GetString(Defs.AdvertWindowShownLastTime), out advertWindowShownLastTime);
		if (PromoActionsManager.CurrentUnixTime - advertWindowShownLastTime > (long)TimeSpan.FromHours(advertShowTimeoutHours).TotalSeconds)
		{
			PlayerPrefs.SetInt(Defs.AdvertWindowShownCount, 3);
			PlayerPrefs.SetString(Defs.AdvertWindowShownLastTime, PromoActionsManager.CurrentUnixTime.ToString());
		}
		yield return progress3;
		if (BuildSettings.BuildTarget == BuildTarget.iPhone)
		{
			if (!Storager.hasKey(Defs.LevelsWhereGetCoinS))
			{
				Storager.setString(Defs.LevelsWhereGetCoinS, string.Empty, false);
			}
			if (!Storager.hasKey(Defs.RatingFlag))
			{
				Storager.setInt(Defs.RatingDeathmatch, 0, false);
				Storager.setInt(Defs.RatingCOOP, 0, false);
				Storager.setInt(Defs.RatingTeamBattle, 0, false);
				Storager.setInt(Defs.RatingHunger, 0, false);
				Storager.setInt(Defs.RatingFlag, 0, false);
			}
		}
		PlayerPrefs.Save();
		yield return 1f;
	}

	private static double Hypot(double x, double y)
	{
		x = Math.Abs(x);
		y = Math.Abs(y);
		double num = Math.Max(x, y);
		double num2 = Math.Min(x, y) / num;
		return num * Math.Sqrt(1.0 + num2 * num2);
	}

	private IEnumerator Start()
	{
		_newLaunchingApproach = Application.loadedLevelName.Equals("Launcher");
		if (_newLaunchingApproach)
		{
			yield break;
		}
		foreach (float item in InitializeSwitcher())
		{
			float step2 = item;
			yield return step2;
		}
		foreach (float item2 in LoadMainMenu())
		{
			float step = item2;
			yield return step;
		}
	}

	internal IEnumerable<float> InitializeSwitcher()
	{
		Stopwatch stopwatch = Stopwatch.StartNew();
		UnityEngine.Debug.Log(">>> Switcher.InitializeSwitcher()");
		ProgressBounds bounds = new ProgressBounds();
		Action logBounds = delegate
		{
			UnityEngine.Debug.Log(string.Format("[{0}%, {1}%)    {2}    {3}", bounds.LowerBound * 100f, bounds.UpperBound * 100f, Time.frameCount, Time.realtimeSinceStartup));
		};
		FrameStopwatchScript frameStopwatch = GetComponent<FrameStopwatchScript>();
		if (frameStopwatch == null)
		{
			UnityEngine.Debug.LogWarning("frameStopwatch == null");
			frameStopwatch = base.gameObject.AddComponent<FrameStopwatchScript>();
		}
		bounds.SetBounds(0f, 0.09f);
		logBounds();
		_progress = bounds.LowerBound;
		if (!PlayerPrefs.HasKey("First Launch (Advertisement)"))
		{
			PlayerPrefs.SetString("First Launch (Advertisement)", DateTimeOffset.UtcNow.ToString("s"));
		}
		if (!PlayerPrefs.HasKey(Defs.IsOldUserOldMetodKey))
		{
		}
		if (GlobalGameController.currentLevel == -1)
		{
			string bgTextureName = ConnectSceneNGUIController.MainLoadingTexture();
			fonToDraw = Resources.Load<Texture>(bgTextureName);
		}
		if (!PlayerPrefs.HasKey(Defs.InitialAppVersionKey))
		{
			if (!PlayerPrefs.HasKey("NamePlayer"))
			{
				PlayerPrefs.SetString(Defs.InitialAppVersionKey, GlobalGameController.AppVersion);
			}
			else
			{
				PlayerPrefs.SetString(Defs.InitialAppVersionKey, "1.0.0");
			}
		}
		if (BuildSettings.BuildTarget == BuildTarget.Android)
		{
			AbstractManager.initialize(typeof(GoogleIABManager));
		}
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite)
		{
			try
			{
				if (Defs.IsDeveloperBuild)
				{
					UnityEngine.Debug.Log("Switcher: Trying to initialize Google Play Games...");
				}
			}
			catch (Exception ex2)
			{
				Exception ex = ex2;
				UnityEngine.Debug.LogException(ex);
			}
		}
		_progress = bounds.Lerp(_progress, 0.2f);
		yield return _progress;
		GlobalGameController.LeftHanded = PlayerPrefs.GetInt(Defs.LeftHandedSN, 1) == 1;
		if (!PlayerPrefs.HasKey(Defs.SwitchingWeaponsSwipeRegimSN))
		{
			double diagonalInPixels = Hypot(Screen.width, Screen.height);
			int switchingWeaponMode = 0;
			if (Screen.dpi > 0f)
			{
				double diagonalInInches = diagonalInPixels / (double)Screen.dpi;
				if (UnityEngine.Debug.isDebugBuild)
				{
					UnityEngine.Debug.Log(string.Format("Device dpi: {0},    diagonal: {1} px ({2}\")", Screen.dpi, diagonalInPixels, diagonalInInches));
				}
				switchingWeaponMode = ((!(diagonalInInches < 6.8)) ? 1 : 0);
			}
			else if (UnityEngine.Debug.isDebugBuild)
			{
				UnityEngine.Debug.Log(string.Format("Device dpi: {0},    diagonal: {1} px", Screen.dpi, diagonalInPixels));
			}
			PlayerPrefs.SetInt(Defs.SwitchingWeaponsSwipeRegimSN, switchingWeaponMode);
		}
		GlobalGameController.switchingWeaponSwipe = PlayerPrefs.GetInt(Defs.SwitchingWeaponsSwipeRegimSN, 0) == 1;
		GlobalGameController.ShowRec = PlayerPrefs.GetInt(Defs.ShowRecSN, 1) == 1;
		Tools.AddSessionNumber();
		if (!Storager.hasKey(Defs.WeaponsGotInCampaign))
		{
			Storager.setString(Defs.WeaponsGotInCampaign, string.Empty, false);
		}
		_progress = bounds.Lerp(_progress, 0.2f);
		yield return _progress;
		Screen.sleepTimeout = -1;
		Action<string> log = delegate
		{
		};
		Func<float, long, string> format = delegate(float progress, long ms)
		{
			int num3 = Mathf.RoundToInt(progress * 100f);
			return string.Format(" << {0}%: {1}", num3, ms);
		};
		Storager.setInt(Defs.TrainingCompleted_4_4_Sett, (!Defs.ResetTrainingInDevBuild) ? 1 : 0, false);
		Defs.isTrainingFlag = Storager.getInt(Defs.TrainingCompleted_4_4_Sett, false) == 0;
		_progress = bounds.Lerp(_progress, 0.2f);
		yield return _progress;
		while (_progress < bounds.UpperBound)
		{
			_progress = bounds.Clamp(_progress + 0.01f);
			yield return _progress;
		}
		bounds.SetBounds(0.1f, 0.19f);
		logBounds();
		_progress = bounds.LowerBound;
		yield return _progress;
		for (int n = 0; n != 2; n++)
		{
			_progress = bounds.Clamp(_progress + 0.01f);
			yield return (!Launcher.UsingNewLauncher) ? _progress : (-1f);
		}
		if (ExperienceControllerPrefab == null)
		{
			UnityEngine.Debug.LogError("Switcher.InitializeSwitcher():    ExperienceControllerPrefab == null");
		}
		else if (!GameObject.FindGameObjectWithTag("ExperienceController"))
		{
			using (new StopwatchLogger("Instantiate ExperienceController: " + _progress.ToString("P0")))
			{
				UnityEngine.Object experienceController = UnityEngine.Object.Instantiate(ExperienceControllerPrefab, Vector3.zero, Quaternion.identity);
				UnityEngine.Debug.Log("Initialized ExperienceController with name:    " + experienceController.name);
			}
			_progress = bounds.Lerp(_progress, 0.1f);
			yield return _progress;
			UnityEngine.Debug.Log("Skipping some frames while experience controller is initializing.");
			for (int m = 0; m != 3; m++)
			{
				_progress = bounds.Clamp(_progress + 0.01f);
				yield return (!Launcher.UsingNewLauncher) ? _progress : (-1f);
			}
		}
		if (nickStackPrefab == null)
		{
			UnityEngine.Debug.LogError("Switcher.InitializeSwitcher():    nickStackPrefab == null");
		}
		else if (!GameObject.FindGameObjectWithTag("NickLabelNGUI"))
		{
			using (new StopwatchLogger("Instantiate nickStackPrefab: " + _progress.ToString("P0")))
			{
				UnityEngine.Object nicklabelStack = UnityEngine.Object.Instantiate(nickStackPrefab, Vector3.zero, Quaternion.identity);
				UnityEngine.Debug.Log("Initialized nicklabelStack with name:    " + nicklabelStack.name);
			}
			yield return _progress;
		}
		if (experienceGuiPrefab != null)
		{
			if (UnityEngine.Object.FindObjectsOfType<ExpController>().Length == 0)
			{
				UnityEngine.Object expGui;
				using (new StopwatchLogger("Instantiate ExperienceGui: " + _progress.ToString("P0")))
				{
					expGui = UnityEngine.Object.Instantiate(experienceGuiPrefab, Vector3.zero, Quaternion.identity);
				}
				UnityEngine.Object.DontDestroyOnLoad(expGui);
				yield return _progress;
			}
		}
		else
		{
			UnityEngine.Debug.LogWarning("ExperienceGuiPrefab == null");
		}
		if (bankGuiPrefab != null)
		{
			if (UnityEngine.Object.FindObjectsOfType<BankController>().Length == 0)
			{
				UnityEngine.Object bankGui;
				using (new StopwatchLogger("Instantiate BankGui: " + _progress.ToString("P0")))
				{
					bankGui = UnityEngine.Object.Instantiate(bankGuiPrefab, Vector3.zero, Quaternion.identity);
				}
				UnityEngine.Object.DontDestroyOnLoad(bankGui);
				yield return _progress;
			}
		}
		else
		{
			UnityEngine.Debug.LogWarning("BankGuiPrefab == null");
		}
		if (freeAwardGuiPrefab != null)
		{
			if (UnityEngine.Object.FindObjectsOfType<FreeAwardController>().Length == 0)
			{
				UnityEngine.Object freeAwardGui;
				using (new StopwatchLogger("Instantiate FreeAwardGui: " + _progress.ToString("P0")))
				{
					freeAwardGui = UnityEngine.Object.Instantiate(freeAwardGuiPrefab, Vector3.zero, Quaternion.identity);
				}
				UnityEngine.Object.DontDestroyOnLoad(freeAwardGui);
				yield return _progress;
			}
		}
		else
		{
			UnityEngine.Debug.LogWarning("freeAwardGuiPrefab == null");
		}
		UnityEngine.Debug.Log("Start initializing FriendsController: " + _progress.ToString("P0"));
		if (!GameObject.Find("FriendsController"))
		{
			ResourceRequest friendsControllerTask = Resources.LoadAsync("FriendsController");
			if (Application.platform == RuntimePlatform.Android)
			{
				while (!friendsControllerTask.isDone)
				{
					if (Launcher.UsingNewLauncher || !(frameStopwatch.GetSecondsSinceFrameStarted() * (float)Application.targetFrameRate < 1f))
					{
						yield return _progress;
					}
				}
			}
			UnityEngine.Object fcp = friendsControllerTask.asset;
			using (new StopwatchLogger("Instantiate FriendsController: " + _progress.ToString("P0")))
			{
				UnityEngine.Object.Instantiate(fcp, Vector3.zero, Quaternion.identity);
			}
			_progress = bounds.Lerp(_progress, 0.1f);
			log(format(_progress, stopwatch.ElapsedMilliseconds) + " (FriendsController)");
			yield return _progress;
			UnityEngine.Debug.Log("Skipping some frames while friends controller is initializing.");
			for (int l = 0; l != 4; l++)
			{
				_progress = bounds.Clamp(_progress + 0.01f);
				log(format(_progress, stopwatch.ElapsedMilliseconds));
				yield return (!Launcher.UsingNewLauncher) ? _progress : (-1f);
			}
		}
		if (!GameObject.FindGameObjectWithTag("SkinsManager") && (bool)skinsManagerPrefab)
		{
			using (new StopwatchLogger("Instantiate SkinsManager: " + _progress.ToString("P0")))
			{
				UnityEngine.Object.Instantiate(skinsManagerPrefab, Vector3.zero, Quaternion.identity);
			}
			_progress = bounds.Lerp(_progress, 0.13f);
			log(format(_progress, stopwatch.ElapsedMilliseconds) + " (SkinsManager)");
			yield return _progress;
		}
		if (!GameObject.FindGameObjectWithTag("Flurry") && (bool)flurryPrefab)
		{
			using (new StopwatchLogger("Instantiate Flurry: " + _progress.ToString("P0")))
			{
				UnityEngine.Object.Instantiate(flurryPrefab, Vector3.zero, Quaternion.identity);
			}
			_progress = bounds.Lerp(_progress, 0.03f);
			log(format(_progress, stopwatch.ElapsedMilliseconds) + " (Flurry)");
			yield return _progress;
		}
		if (!GameObject.FindGameObjectWithTag("MenuBackgroundMusic") && (bool)backgroundMusicPrefab)
		{
			using (new StopwatchLogger("Instantiate MenuBackgroundMusic: " + _progress.ToString("P0")))
			{
				UnityEngine.Object.Instantiate(backgroundMusicPrefab, Vector3.zero, Quaternion.identity);
			}
			_progress = bounds.Lerp(_progress, 0.1f);
			yield return _progress;
		}
		if (!GameObject.FindGameObjectWithTag("GUIHelper") && (bool)guiHelperPrefab)
		{
			using (new StopwatchLogger("Instantiate GUIHelper: " + _progress.ToString("P0")))
			{
				UnityEngine.Object.Instantiate(guiHelperPrefab, Vector3.zero, Quaternion.identity);
			}
			_progress = bounds.Lerp(_progress, 0.1f);
			yield return _progress;
		}
		bounds.SetBounds(0.2f, 0.29f);
		logBounds();
		_progress = bounds.LowerBound;
		yield return _progress;
		UnityEngine.Debug.Log("Start initializing ShopNGUI: " + _progress.ToString("P0"));
		ResourceRequest shopTask = Resources.LoadAsync("ShopNGUI");
		if (Application.platform == RuntimePlatform.Android)
		{
			while (!shopTask.isDone)
			{
				if (Launcher.UsingNewLauncher || !(frameStopwatch.GetSecondsSinceFrameStarted() * (float)Application.targetFrameRate < 1f))
				{
					yield return _progress;
				}
			}
		}
		UnityEngine.Object shopP = shopTask.asset;
		_progress = bounds.Clamp(bounds.LowerBound + 0.2f);
		yield return _progress;
		using (new StopwatchLogger("Instantiate ShopNGUI: " + _progress.ToString("P0")))
		{
			UnityEngine.Object.Instantiate(shopP, Vector3.zero, Quaternion.identity);
		}
		_progress = bounds.Lerp(_progress, 0.2f);
		yield return _progress;
		if (!GameObject.FindGameObjectWithTag("WearShopObj"))
		{
			IList<UnityEngine.Object> resources = new List<UnityEngine.Object>(6);
			string[] names = new string[3] { "unequip", "unequip_n", "shop_eq" };
			for (int k = 0; k != names.Length; k++)
			{
				string name = names[k];
				UnityEngine.Object r = Resources.Load("InAppCategories/" + name);
				if (r != null)
				{
					resources.Add(r);
					_progress = bounds.Clamp(_progress + 0.01f);
					yield return _progress;
				}
			}
		}
		if (!GameObject.FindGameObjectWithTag("CoinsShop") && (bool)coinsShopPrefab)
		{
			bounds.SetBounds(0.3f, 0.39f);
			logBounds();
			_progress = bounds.LowerBound;
			yield return _progress;
			object token = new object();
			Storager.Initialize(token != null);
			using (IEnumerator<float> enumerator = InitializeStorager().GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					_progress = bounds.Lerp(time: Mathf.Clamp01(enumerator.Current), progress: bounds.LowerBound);
					if (frameStopwatch != null)
					{
						float elapsedSeconds = frameStopwatch.GetSecondsSinceFrameStarted();
						if (!Launcher.UsingNewLauncher && elapsedSeconds * (float)Application.targetFrameRate < 1f)
						{
							continue;
						}
					}
					yield return _progress;
				}
			}
			_progress = bounds.Lerp(_progress, 0.2f);
			yield return _progress;
			float hoursForReview = 24f;
			int launchCount = 5;
			string appId = "640111933";
			BankController.GiveInitialNumOfCoins();
			bounds.SetBounds(0.4f, 0.49f);
			logBounds();
			_progress = bounds.LowerBound;
			yield return _progress;
			_progress = bounds.Lerp(_progress, 0.1f);
			yield return _progress;
			if (BuildSettings.BuildTarget == BuildTarget.iPhone)
			{
				string[] canBuyWeaponStorageIds = ItemDb.GetCanBuyWeaponStorageIds(true);
				for (int j = 0; j < canBuyWeaponStorageIds.Length; j++)
				{
					string storageId = canBuyWeaponStorageIds[j];
					if (!string.IsNullOrEmpty(storageId))
					{
						Storager.SyncWithCloud(storageId);
					}
					if (j % 10 == 0)
					{
						_progress = bounds.Lerp(_progress, 0.05f + 0.05f * (float)j / (float)(canBuyWeaponStorageIds.Length - 1));
						yield return _progress;
					}
				}
				_progress = bounds.Lerp(_progress, 0.1f);
				yield return _progress;
				foreach (KeyValuePair<ShopNGUIController.CategoryNames, List<List<string>>> item2 in Wear.wear)
				{
					foreach (List<string> ll in item2.Value)
					{
						foreach (string item in ll)
						{
							Storager.SyncWithCloud(item);
						}
					}
				}
				foreach (KeyValuePair<string, string> kvp in InAppData.inAppData.Values)
				{
					if (Storager.getInt(kvp.Value, true) > 0)
					{
						Storager.setInt(kvp.Value, Storager.getInt(kvp.Value, true), true);
					}
				}
				_progress = bounds.Lerp(_progress, 0.1f);
				yield return _progress;
			}
			CountMoneyForGunsFrom831To901();
			string[] _arr = Storager.getString(Defs.WeaponsGotInCampaign, false).Split('#');
			List<string> weaponsGotInCampaign = new List<string>();
			string[] array = _arr;
			foreach (string s2 in array)
			{
				weaponsGotInCampaign.Add(s2);
			}
			foreach (string boxName in CampaignProgress.boxesLevelsAndStars.Keys)
			{
				foreach (string map in CampaignProgress.boxesLevelsAndStars[boxName].Keys)
				{
					string weaponFromBoss;
					if (LevelBox.weaponsFromBosses.TryGetValue(map, out weaponFromBoss) && !weaponsGotInCampaign.Contains(weaponFromBoss))
					{
						weaponsGotInCampaign.Add(weaponFromBoss);
					}
				}
			}
			if (weaponsGotInCampaign.Contains(WeaponManager.ShotgunWN))
			{
				weaponsGotInCampaign[weaponsGotInCampaign.IndexOf(WeaponManager.ShotgunWN)] = WeaponManager.UZI_WN;
			}
			Storager.setString(val: string.Join("#", weaponsGotInCampaign.ToArray()), key: Defs.WeaponsGotInCampaign, useICloud: false);
			_progress = bounds.Lerp(_progress, 0.1f);
			yield return _progress;
			using (new StopwatchLogger("Instantiate CoinsShop"))
			{
				UnityEngine.Object.Instantiate(coinsShopPrefab);
			}
			_progress = bounds.Lerp(_progress, 0.1f);
			yield return _progress;
		}
		bounds.SetBounds(0.5f, 0.89f);
		logBounds();
		_progress = bounds.LowerBound;
		yield return _progress;
		if ((bool)weaponManagerPrefab)
		{
			GameObject o;
			using (new StopwatchLogger("Instantiate WeaponManager: " + _progress.ToString("P0")))
			{
				o = (GameObject)UnityEngine.Object.Instantiate(weaponManagerPrefab, Vector3.zero, Quaternion.identity);
			}
			WeaponManager wm = o.GetComponent<WeaponManager>();
			if (wm != null)
			{
				int i = 0;
				while (!wm.Initialized)
				{
					_progress = bounds.Clamp(Mathf.Lerp(bounds.LowerBound, bounds.UpperBound, 0.004f * (float)i));
					yield return _progress;
					if (Launcher.UsingNewLauncher)
					{
						yield return -1f;
					}
					i++;
				}
			}
			_progress = bounds.Lerp(_progress, 0.12f);
			yield return _progress;
		}
		bounds.SetBounds(0.9f, 0.91f);
		logBounds();
		_progress = bounds.LowerBound;
		yield return _progress;
		using (new StopwatchLogger("CheckHugeUpgrade()", Defs.IsDeveloperBuild))
		{
			CheckHugeUpgrade();
		}
		using (new StopwatchLogger("PerformEssentialInitialization(Defs.Coins)", Defs.IsDeveloperBuild))
		{
			PerformEssentialInitialization("Coins", AbuseMetod.Coins);
		}
		using (new StopwatchLogger("PerformEssentialInitialization(Defs.Gems)", Defs.IsDeveloperBuild))
		{
			PerformEssentialInitialization("GemsCurrency", AbuseMetod.Gems);
		}
		using (new StopwatchLogger("PerformExpendablesInitialization()", Defs.IsDeveloperBuild))
		{
			PerformExpendablesInitialization();
		}
		using (new StopwatchLogger("PerformWeaponInitialization()", Defs.IsDeveloperBuild))
		{
			PerformWeaponInitialization();
		}
		bounds.SetBounds(0.92f, 0.99f);
		logBounds();
		_progress = bounds.LowerBound;
		yield return _progress;
		CampaignProgress.OpenNewBoxIfPossible();
		_progress = bounds.Lerp(_progress, 0.1f);
		yield return _progress;
		CampaignProgress.SaveCampaignProgress();
		Version initialAppVersion2 = new Version(1, 0, 0);
		try
		{
			initialAppVersion2 = new Version(PlayerPrefs.GetString(Defs.InitialAppVersionKey, "1.0.0"));
		}
		catch
		{
			goto IL_26f9;
		}
		if (!(initialAppVersion2 < new Version(8, 0, 0)))
		{
			DateTimeOffset now2 = DateTimeOffset.Now;
			DateTimeOffset lastLaunch;
			if (!PlayerPrefs.HasKey("Retention.LastLaunch") || !DateTimeOffset.TryParse(PlayerPrefs.GetString("Retention.LastLaunch"), out lastLaunch))
			{
				lastLaunch = now2;
			}
			string timeInRankKey = "Statistics.TimeInRank.Level" + 0;
			if (!PlayerPrefs.HasKey(timeInRankKey))
			{
				PlayerPrefs.SetString(timeInRankKey, DateTime.UtcNow.ToString("s"));
			}
			int rating;
			string ratingString = ((!Device.TryGetGpuRating(out rating)) ? "?" : rating.ToString());
			Dictionary<string, string> parameters15 = new Dictionary<string, string>
			{
				{
					"GPU",
					Device.FormatGpuModelMemoryRating()
				},
				{
					"Device",
					Device.FormatDeviceModelMemoryRating()
				},
				{ "Rating", ratingString }
			};
			if (UnityEngine.Debug.isDebugBuild || Defs.IsDeveloperBuild)
			{
				UnityEngine.Debug.Log("System Info : " + Rilisoft.MiniJson.Json.Serialize(parameters15));
			}
			else
			{
				FlurryPluginWrapper.LogEventAndDublicateToConsole("System Info", parameters15);
			}
			string launchAnalyticsPayingEvent = FlurryPluginWrapper.GetEventName("User Retention (Otval)");
			if (!PlayerPrefs.HasKey("Retention.FirstLaunch"))
			{
				PlayerPrefs.SetString("Retention.FirstLaunch", DateTimeOffset.Now.ToString("s"));
				Dictionary<string, string> parameters14 = new Dictionary<string, string> { { "On Day N", "0" } };
				FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval)", parameters14);
				FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEvent, parameters14);
			}
			else
			{
				DateTimeOffset firstLaunch;
				if (!DateTimeOffset.TryParse(PlayerPrefs.GetString("Retention.FirstLaunch"), out firstLaunch))
				{
					firstLaunch = lastLaunch;
				}
				Func<int, int, bool> nowInRange = (int left, int right) => firstLaunch + TimeSpan.FromDays(left) <= now2 && now2 < firstLaunch + TimeSpan.FromDays(right);
				Func<int, bool> lastLaunchIsBefore = (int right) => lastLaunch < firstLaunch + TimeSpan.FromDays(right);
				Func<string, Dictionary<string, string>> formatParameters = (string value) => new Dictionary<string, string>
				{
					{ "On Day N", value },
					{
						string.Format("Levels on Day {0}", value),
						ExperienceController.sharedController.currentLevel.ToString()
					}
				};
				if (lastLaunch <= firstLaunch && nowInRange(0, 1))
				{
					Dictionary<string, string> parameters13 = formatParameters("0-1");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval)", parameters13);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEvent, parameters13);
				}
				else if (lastLaunchIsBefore(1) && nowInRange(1, 3))
				{
					Dictionary<string, string> parameters12 = formatParameters("1-3");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval)", parameters12);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEvent, parameters12);
				}
				else if (lastLaunchIsBefore(3) && nowInRange(3, 7))
				{
					Dictionary<string, string> parameters11 = formatParameters("3-7");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval)", parameters11);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEvent, parameters11);
				}
				else if (lastLaunchIsBefore(7) && nowInRange(7, 14))
				{
					Dictionary<string, string> parameters10 = formatParameters("7-14");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval)", parameters10);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEvent, parameters10);
				}
				else if (lastLaunchIsBefore(14) && nowInRange(14, 30))
				{
					Dictionary<string, string> parameters9 = formatParameters("14-30");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval)", parameters9);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEvent, parameters9);
				}
				else if (lastLaunchIsBefore(30) && firstLaunch + TimeSpan.FromDays(30.0) <= now2)
				{
					Dictionary<string, string> parameters8 = formatParameters("30+");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval)", parameters8);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEvent, parameters8);
				}
				string launchAnalyticsPayingEventCumulative = FlurryPluginWrapper.GetEventName("User Retention (Otval, Cumulative)");
				if (nowInRange(0, 1))
				{
					Dictionary<string, string> parameters7 = formatParameters("0-1");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval, Cumulative)", parameters7);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEventCumulative, parameters7);
				}
				if (nowInRange(0, 3))
				{
					Dictionary<string, string> parameters6 = formatParameters("0-3");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval, Cumulative)", parameters6);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEventCumulative, parameters6);
				}
				if (nowInRange(0, 7))
				{
					Dictionary<string, string> parameters5 = formatParameters("0-7");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval, Cumulative)", parameters5);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEventCumulative, parameters5);
				}
				if (nowInRange(0, 14))
				{
					Dictionary<string, string> parameters4 = formatParameters("0-14");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval, Cumulative)", parameters4);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEventCumulative, parameters4);
				}
				if (nowInRange(0, 30))
				{
					Dictionary<string, string> parameters3 = formatParameters("0-30");
					FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval, Cumulative)", parameters3);
					FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEventCumulative, parameters3);
				}
				Dictionary<string, string> parameters2 = formatParameters("0+");
				FlurryPluginWrapper.LogEventAndDublicateToConsole("User Retention (Otval, Cumulative)", parameters2);
				FlurryPluginWrapper.LogEventAndDublicateToConsole(launchAnalyticsPayingEventCumulative, parameters2);
			}
			PlayerPrefs.SetString("Retention.LastLaunch", now2.ToString("s"));
		}
		goto IL_26f9;
		IL_26f9:
		string lastLoggedDateString = PlayerPrefs.GetString("Statistics.WeaponPopularityTimestamp", "1970-01-01");
		DateTime lastLoggedDate;
		if (!DateTime.TryParse(lastLoggedDateString, out lastLoggedDate))
		{
			lastLoggedDate = new DateTime(1970, 1, 1);
		}
		DateTime now = DateTime.UtcNow.Date;
		if (now > lastLoggedDate)
		{
			string[] mostPopularWeapons = Statistics.Instance.GetMostPopularWeapons();
			if (mostPopularWeapons.Length > 0)
			{
				string eventName = FlurryPluginWrapper.GetEventName("Weapon Popularity");
				string[] array2 = mostPopularWeapons;
				foreach (string w in array2)
				{
					Dictionary<string, string> parameters = new Dictionary<string, string> { { "Favorite Weapon", w } };
					FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, parameters);
				}
				PlayerPrefs.SetString("Statistics.WeaponPopularityTimestamp", now.ToString("yyyy-MM-dd"));
			}
		}
		LogWeaponAndArmorPopularityToFlurry();
		Storager.SyncWithCloud("PayingUser");
		_progress = 0.99f;
		yield return _progress;
		Screen.sleepTimeout = 300;
		stopwatch.Stop();
		UnityEngine.Debug.Log(string.Format("<<< Switcher.InitializeSwitcher():    {0} ms,    Last Frame: {1}", stopwatch.ElapsedMilliseconds, Time.frameCount));
	}

	private static void CheckHugeUpgrade()
	{
	}

	private static void PerformEssentialInitialization(string currencyKey, AbuseMetod abuseMethod)
	{
		if (!Storager.hasKey(currencyKey))
		{
			return;
		}
		int @int = Storager.getInt(currencyKey, false);
		DigestStorager.Instance.Set(currencyKey, @int);
	}

	private static void PerformWeaponInitialization()
	{
		IEnumerable<string> source = WeaponManager.storeIDtoDefsSNMapping.Values.Where((string w) => Storager.getInt(w, false) == 1);
		int value = source.Count();
		DigestStorager.Instance.Set("WeaponsCount", value);
	}

	private static void PerformExpendablesInitialization()
	{
		string[] source = new string[4]
		{
			GearManager.InvisibilityPotion,
			GearManager.Jetpack,
			GearManager.Turret,
			GearManager.Mech
		};
		byte[] value = source.SelectMany((string key) => BitConverter.GetBytes(Storager.getInt(key, false))).ToArray();
		DigestStorager.Instance.Set("ExpendablesCount", value);
	}

	private static void ClearProgress()
	{
	}

	internal static IEnumerable<float> LoadMainMenu()
	{
		string sceneName = DetermineSceneName();
		AsyncOperation loadLevelTask = Application.LoadLevelAsync(sceneName);
		while (!loadLevelTask.isDone)
		{
			yield return loadLevelTask.progress;
		}
	}

	private static void LogWeaponAndArmorPopularityToFlurry()
	{
		LogPopularityToFlurry("Statistics.WeaponPopularityTimestamp", () => Statistics.Instance.GetMostPopularWeapons(), LogWeaponPopularityToFlurry);
		LogPopularityToFlurry("Statistics.WeaponPopularityForTierTimestamp", () => Statistics.Instance.GetMostPopularWeaponsForTier(ExpController.Instance.OurTier), LogWeaponPopularityForTierToFlurry);
		LogPopularityToFlurry("Statistics.ArmorPopularityTimestamp", () => Statistics.Instance.GetMostPopularArmors(), LogArmorPopularityToFlurry);
		LogPopularityToFlurry("Statistics.ArmorPopularityForTierTimestamp", () => Statistics.Instance.GetMostPopularArmorsForTier(ExpController.Instance.OurTier), LogArmorPopularityForTierToFlurry);
		LogPopularityToFlurry("Statistics.ArmorPopularityForLevelTimestamp", () => Statistics.Instance.GetMostPopularArmorsForLevel(ExperienceController.sharedController.currentLevel), LogArmorPopularityForLevelToFlurry);
	}

	private static void LogPopularityToFlurry(string loggedDateTimestampKey, Func<string[]> getMostPopular, Action<string[]> logMostPopular)
	{
		DateTime date = DateTime.UtcNow.Date;
		if (IsLastLoggedDateExpired(loggedDateTimestampKey, date))
		{
			string[] array = getMostPopular();
			if (array.Length > 0)
			{
				logMostPopular(array);
				PlayerPrefs.SetString(loggedDateTimestampKey, date.ToString("yyyy-MM-dd"));
			}
		}
	}

	private static bool IsLastLoggedDateExpired(string timestampKey, DateTime nowDate)
	{
		string @string = PlayerPrefs.GetString(timestampKey, "1970-01-01");
		DateTime result;
		if (!DateTime.TryParse(@string, out result))
		{
			result = new DateTime(1970, 1, 1);
		}
		return nowDate > result;
	}

	private static void LogWeaponPopularityToFlurry(string[] mostPopular)
	{
		string eventName = FlurryPluginWrapper.GetEventName("Weapon Popularity");
		foreach (string value in mostPopular)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Favorite Weapon", value);
			Dictionary<string, string> parameters = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, parameters);
		}
	}

	private static void LogWeaponPopularityForTierToFlurry(string[] mostPopular)
	{
		int ourTier = ExpController.Instance.OurTier;
		string eventName = FlurryPluginWrapper.GetEventName("Weapon Popularity Tier");
		foreach (string value in mostPopular)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Tier " + ourTier, value);
			Dictionary<string, string> parameters = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, parameters);
		}
	}

	private static void LogArmorPopularityToFlurry(string[] mostPopular)
	{
		string eventName = FlurryPluginWrapper.GetEventName("Armor Popularity");
		foreach (string value in mostPopular)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Name", value);
			Dictionary<string, string> parameters = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, parameters);
		}
	}

	private static void LogArmorPopularityForTierToFlurry(string[] mostPopular)
	{
		int ourTier = ExpController.Instance.OurTier;
		string eventName = FlurryPluginWrapper.GetEventName("Armor Popularity Tier");
		foreach (string value in mostPopular)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Tier " + ourTier, value);
			Dictionary<string, string> parameters = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, parameters);
		}
	}

	private static void LogArmorPopularityForLevelToFlurry(string[] mostPopular)
	{
		int currentLevel = ExperienceController.sharedController.currentLevel;
		string payingSuffix = FlurryPluginWrapper.GetPayingSuffix();
		int num = (currentLevel - 1) / 9;
		string arg = string.Format("[{0}, {1})", num * 9 + 1, (num + 1) * 9 + 1);
		string eventName = string.Format("Armor Popularity Level {0}{1}", arg, payingSuffix);
		foreach (string value in mostPopular)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Level " + currentLevel, value);
			Dictionary<string, string> parameters = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, parameters);
		}
	}

	private static bool IsWeaponBought(string weaponTag)
	{
		string value;
		string value2;
		return WeaponManager.tagToStoreIDMapping.TryGetValue(weaponTag, out value) && value != null && WeaponManager.storeIDtoDefsSNMapping.TryGetValue(value, out value2) && value2 != null && Storager.hasKey(value2) && Storager.getInt(value2, true) > 0;
	}

	private static void CountMoneyForGunsFrom831To901()
	{
		Storager.hasKey(Defs.CoinsCountToCompensate);
		Storager.hasKey(Defs.GemsCountToCompensate);
		Storager.hasKey(Defs.MoneyGiven831to901);
		Storager.SyncWithCloud(Defs.MoneyGiven831to901);
		Storager.hasKey(Defs.Weapons831to901);
		if (Storager.getInt(Defs.Weapons831to901, false) != 0)
		{
			return;
		}
		bool flag = Storager.getInt(Defs.MoneyGiven831to901, true) == 0;
		int num = 0;
		int num2 = 0;
		if (flag)
		{
			Dictionary<string, int> dictionary = new Dictionary<string, int>();
			dictionary.Add(WeaponTags.CrossbowTag, 120);
			dictionary.Add(WeaponTags.CrystalCrossbowTag, 155);
			dictionary.Add(WeaponTags.SteelCrossbowTag, 120);
			dictionary.Add(WeaponTags.Bow_3_Tag, 185);
			dictionary.Add(WeaponTags.WoodenBowTag, 100);
			dictionary.Add(WeaponTags.Staff2Tag, 200);
			dictionary.Add(WeaponTags.Staff_3_Tag, 235);
			Dictionary<string, int> dictionary2 = dictionary;
			foreach (KeyValuePair<string, int> item in dictionary2)
			{
				string key = item.Key;
				int value = item.Value;
				if (IsWeaponBought(key))
				{
					num += value;
				}
			}
			dictionary = new Dictionary<string, int>();
			dictionary.Add(WeaponTags.AutoShotgun_Tag, 255);
			dictionary.Add(WeaponTags.TwoRevolvers_Tag, 267);
			dictionary.Add(WeaponTags.TwoBolters_Tag, 249);
			dictionary.Add(WeaponTags.SnowballGun_Tag, 281);
			Dictionary<string, int> dictionary3 = dictionary;
			foreach (KeyValuePair<string, int> item2 in dictionary3)
			{
				string key2 = item2.Key;
				int value2 = item2.Value;
				if (IsWeaponBought(key2))
				{
					num2 += value2;
				}
			}
			dictionary = new Dictionary<string, int>();
			dictionary.Add(Wear.StormTrooperCape, 50);
			dictionary.Add(Wear.HitmanCape, 65);
			dictionary.Add(Wear.BerserkCape, 50);
			dictionary.Add(Wear.SniperCape, 75);
			dictionary.Add(Wear.DemolitionCape, 65);
			Dictionary<string, int> dictionary4 = dictionary;
			foreach (KeyValuePair<string, int> item3 in dictionary4)
			{
				string key3 = item3.Key;
				int value3 = item3.Value;
				if (Storager.hasKey(key3) && Storager.getInt(key3, false) != 0)
				{
					num += value3;
				}
			}
			dictionary = new Dictionary<string, int>();
			dictionary.Add(Wear.StormTrooperBoots, 50);
			dictionary.Add(Wear.HitmanBoots, 50);
			dictionary.Add(Wear.BerserkBoots, 100);
			dictionary.Add(Wear.SniperBoots, 50);
			dictionary.Add(Wear.DemolitionBoots, 75);
			Dictionary<string, int> dictionary5 = dictionary;
			foreach (KeyValuePair<string, int> item4 in dictionary5)
			{
				string key4 = item4.Key;
				int value4 = item4.Value;
				if (Storager.hasKey(key4) && Storager.getInt(key4, false) != 0)
				{
					num += value4;
				}
			}
		}
		Storager.setInt(Defs.CoinsCountToCompensate, num, false);
		Storager.setInt(Defs.GemsCountToCompensate, num2, false);
		Storager.setInt(Defs.Weapons831to901, 1, false);
		Storager.setInt(Defs.MoneyGiven831to901, 1, true);
	}

	public static float SecondsFrom1970()
	{
		DateTime dateTime = new DateTime(1970, 1, 9, 0, 0, 0);
		DateTime now = DateTime.Now;
		return (float)(now - dateTime).TotalSeconds;
	}

	private void OnGUI()
	{
		if (!_newLaunchingApproach)
		{
			Rect position = new Rect(((float)Screen.width - 1366f * Defs.Coef) / 2f, 0f, 1366f * Defs.Coef, Screen.height);
			GUI.DrawTexture(position, fonToDraw, ScaleMode.StretchToFill);
			LoadingProgress.Instance.Draw(_progress);
		}
	}

	private static string DetermineSceneName()
	{
		switch (GlobalGameController.currentLevel)
		{
		case -1:
			return Defs.MainMenuScene;
		case 0:
			return "Cementery";
		case 1:
			return "Maze";
		case 2:
			return "City";
		case 3:
			return "Hospital";
		case 4:
			return "Jail";
		case 5:
			return "Gluk_2";
		case 6:
			return "Arena";
		case 7:
			return "Area52";
		case 101:
			return "Training";
		case 8:
			return "Slender";
		case 9:
			return "Castle";
		default:
			return Defs.MainMenuScene;
		}
	}

	internal static void AppendAbuseMethod(AbuseMetod f)
	{
	}
}
