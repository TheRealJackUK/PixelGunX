using System.Collections.Generic;
using System;
using UnityEngine;

public sealed class Defs
{
	public enum GameSecondFireButtonMode
	{
		Sniper,
		On,
		Off
	}

public static float CAMFOV = 44f;

public static string camerafov = Convert.ToString(Defs.CAMFOV);

public static float sensitivity = 5f;

public static string sensitivityvalue = Convert.ToString(Defs.sensitivity);

public static string CAnim(GameObject animator, string con){
        foreach (AnimationState ac in animator.GetComponent<Animation>()){
            string nm = ac.name.ToString();
            if (nm.Contains(con) || nm.StartsWith(con) || nm == con){            
                return nm;
            }
        }
        return null;
    }
	public enum WeaponIndex
	{
		Grenade = 1000,
		Turret
	}

	public enum DisconectGameType
	{
		Exit,
		Reconnect,
		RandomGameInHunger,
		SelectNewMap
	}

	public enum RuntimeAndroidEdition
	{
		None,
		Amazon,
		GoogleLite,
		GooglePro
	}

	public const string GrenadeID = "GrenadeID";

	public const string Coins = "Coins";

	public const string Gems = "GemsCurrency";

	public const string payingUserKey = "PayingUser";

	public const string LastPaymentTimeKey = "Last Payment Time";

	public const string LastPaymentTimeAdvertisementKey = "Last Payment Time (Advertisement)";

	public const string WinCountTimestampKey = "Win Count Timestamp";

	public const string WeaponPopularityKey = "Statistics.WeaponPopularity";

	public const string WeaponPopularityForTierKey = "Statistics.WeaponPopularityForTier";

	public const string WeaponPopularityTimestampKey = "Statistics.WeaponPopularityTimestamp";

	public const string WeaponPopularityForTierTimestampKey = "Statistics.WeaponPopularityForTierTimestamp";

	public const string ArmorPopularityKey = "Statistics.ArmorPopularity";

	public const string ArmorPopularityForTierKey = "Statistics.ArmorPopularityForTier";

	public const string ArmorPopularityForLevelKey = "Statistics.ArmorPopularityForLevel";

	public const string ArmorPopularityTimestampKey = "Statistics.ArmorPopularityTimestamp";

	public const string ArmorPopularityForTierTimestampKey = "Statistics.ArmorPopularityForTierTimestamp";

	public const string ArmorPopularityForLevelTimestampKey = "Statistics.ArmorPopularityForLevelTimestamp";

	public const string TimeInModeKeyPrefix = "Statistics.TimeInMode.Level";

	public const string RoundsInModeKeyPrefix = "Statistics.RoundsInMode.Level";

	public const string ExpInModeKeyPrefix = "Statistics.ExpInMode.Level";

	public const string WantToResetKeychain = "WantToResetKeychain";

	public const string StartTimeStarterPack = "StartTimeShowStarterPack";

	public const string EndTimeStarterPack = "TimeEndStarterPack";

	public const string NextNumberStarterPack = "NextNumberStarterPack";

	public const string LastTimeShowStarterPack = "LastTimeShowStarterPack";

	public const string CountShownStarterPack = "CountShownStarterPack";

	public const string PendingGooglePlayGamesSync = "PendingGooglePlayGamesSync";

	public const string RemotePushNotificationToken = "RemotePushNotificationToken";

	public const int EVENT_X3_SHOW_COUNT = 3;

	public const string FirstLaunchAdvertisementKey = "First Launch (Advertisement)";

	public const string IsLeaderboardsOpened = "Leaderboards.opened";

	public const string DaysOfValorShownCount = "DaysOfValorShownCount";

	public const string LastTimeShowDaysOfValor = "LastTimeShowDaysOfValor";

	public const string StartTimePremiumAccount = "StartTimePremiumAccount";

	public const string EndTimePremiumAccount = "EndTimePremiumAccount";

	public const string BuyHistoryPremiumAccount = "BuyHistoryPremiumAccount";

	public const string LastLoggedTimePremiumAccount = "LastLoggedTimePremiumAccount";

	public const string EndCheatTimePremiumAccount = "EndCheatTimePremiumAccount";

	public static bool ResetTrainingInDevBuild;

	public static readonly string initValsInKeychain43;

	public static readonly string initValsInKeychain44;

	public static readonly string CoinsCountToCompensate;

	public static readonly string GemsCountToCompensate;

	public static bool isMouseControl;

	public static bool isRegimVidosDebug;

	public static readonly string MoneyGiven831to901;

	public static string GotCoinsForTraining;

	public static DisconectGameType typeDisconnectGame;

	public static GameSecondFireButtonMode gameSecondFireButtonMode;

	public static int ZoomButtonX;

	public static int ZoomButtonY;

	public static int ReloadButtonX;

	public static int ReloadButtonY;

	public static int JumpButtonX;

	public static int JumpButtonY;

	public static int FireButtonX;

	public static int FireButtonY;

	public static int JoyStickX;

	public static int JoyStickY;

	public static int GrenadeX;

	public static int GrenadeY;

	public static int FireButton2X;

	public static int FireButton2Y;

	public static string VisualHatArmor;

	public static string VisualArmor;

	public static string RatingDeathmatch;

	public static string RatingTeamBattle;

	public static string RatingHunger;

	public static string RatingCOOP;

	public static string RatingFlag;

	public static int countGrenadeInHunger;

	public static int LogoWidth;

	public static int LogoHeight;

	public static string[] SurvivalMaps;

	public static int CurrentSurvMapIndex;

	public static float FreezerSlowdownTime;

	private static bool _initializedJoystickParams;

	public static bool isShowUserAgrement;

	public static int maxCountFriend;

	public static string bigPorogString;

	public static string smallPorogString;

	public static int ammoInGamePanelPrice;

	public static int healthInGamePanelPrice;

	public static int ClansPrice;

	public static int ProfileFromFriends;

	public static string ServerIp;

	public static bool isMulti;

	public static bool isInet;

	public static bool isCOOP;

	public static bool isCompany;

	public static bool isFlag;

	public static bool isHunger;

	public static bool isGameFromFriends;

	public static bool isGameFromClans;

	public static bool isCapturePoints;

	public static readonly string PixelGunAppID;

	public static readonly string AppStoreURL;

	public static readonly string SupportMail;

	public static Dictionary<string, string> levelNamesFromNums;

	public static bool EnderManAvailable;

	public static bool isSoundMusic;

	public static bool isSoundFX;

	public static float BottomOffs;

	public static Dictionary<string, int> filterMaps;

	private static readonly Dictionary<string, int> _premiumMaps;

	public static Dictionary<string, int> levelNumsForMusicInMult;

	public static List<int> levelsWithVarY;

	public static int NumberOfElixirs;

	public static bool isGrenateFireEnable;

	public static bool isZooming;

	public static bool isJetpackEnabled;

	public static float GoToProfileShopInterval;

	public static readonly string InvertCamSN;

	public static List<GameObject> players;

	public static string PromSceneName;

	public static bool isTrainingFlag;

	public static string _3_shotgun_2;

	public static string _3_shotgun_3;

	public static string flower_2;

	public static string flower_3;

	public static string gravity_2;

	public static string gravity_3;

	public static string grenade_launcher_3;

	public static string revolver_2_2;

	public static string revolver_2_3;

	public static string scythe_3;

	public static string plazma_2;

	public static string plazma_3;

	public static string plazma_pistol_2;

	public static string plazma_pistol_3;

	public static string railgun_2;

	public static string railgun_3;

	public static string Razer_3;

	public static string tesla_3;

	public static string Flamethrower_3;

	public static string FreezeGun_0;

	public static string svd_3;

	public static string barret_3;

	public static string minigun_3;

	public static string LightSword_3;

	public static string Sword_2_3;

	public static string Staff_3;

	public static string DragonGun;

	public static string Bow_3;

	public static string Bazooka_1_3;

	public static string Bazooka_2_1;

	public static string Bazooka_2_3;

	public static string m79_2;

	public static string m79_3;

	public static string m32_1_2;

	public static string Red_Stone_3;

	public static string XM8_1;

	public static string PumpkinGun_1;

	public static string XM8_2;

	public static string XM8_3;

	public static string PumpkinGun_2;

	public static readonly string Weapons800to801;

	public static readonly string Weapons831to901;

	public static readonly string FixWeapons911;

	public static readonly string ReturnAlienGun930;

	public static int diffGame;

	public static bool IsSurvival;

	public static string StartTimeShowBannersString;

	public static bool showTableInNetworkStartTable;

	public static bool showNickTableInNetworkStartTable;

	public static bool isTurretWeapon;

	private static float? _sensitivity;

	private static bool? _isChatOn;

	public static bool inRespawnWindow;

	public static readonly string IsFirstLaunchFreshInstall;

	public static readonly string NewbieEventX3StartTime;

	public static readonly string NewbieEventX3StartTimeAdditional;

	public static readonly string NewbieEventX3LastLoggedTime;

	public static readonly string WasNewbieEventX3;

	public static string ShownLobbyLevelSN
	{
		get
		{
			return "ShownLobbyLevelSN";
		}
	}

	public static string PremiumEnabledFromServer
	{
		get
		{
			return "PremiumEnabledFromServer";
		}
	}

	public static string AllCurrencyBought
	{
		get
		{
			return "AllCurrencyBought";
		}
	}

	public static string LobbyLevelApplied
	{
		get
		{
			return "LobbyLevelApplied";
		}
	}

	public static bool CanShowPremiumAccountExpiredWindow
	{
		get
		{
			return !IsTraining;
		}
	}

	public static string LastTimeTempItemsSuspended
	{
		get
		{
			return "LastTimeTempItemsSuspended";
		}
	}

	public static string TempItemsDictionaryKey
	{
		get
		{
			return "TempItemsDictionaryKey";
		}
	}

	public static string initValsInKeychain15
	{
		get
		{
			return "_initValsInKeychain15_";
		}
	}

	public static string initValsInKeychain17
	{
		get
		{
			return "initValsInKeychain17";
		}
	}

	public static string initValsInKeychain27
	{
		get
		{
			return "initValsInKeychain27";
		}
	}

	public static string initValsInKeychain40
	{
		get
		{
			return "initValsInKeychain40";
		}
	}

	public static string initValsInKeychain41
	{
		get
		{
			return "initValsInKeychain41";
		}
	}

	public static string TierAfter8_3_0Key
	{
		get
		{
			return "TierAfter8_3_0Key";
		}
	}

	public static string InnerWeaponsFolder
	{
		get
		{
			return "WeaponSystem/Inner";
		}
	}

	public static string InnerWeapons_Suffix
	{
		get
		{
			return "_Inner";
		}
	}

	public static IDictionary<string, int> PremiumMaps
	{
		get
		{
			return _premiumMaps;
		}
	}

	public static float HalfLength
	{
		get
		{
			return 17f;
		}
	}

	public static string ShowEnder_SN
	{
		get
		{
			return "ShowEnder_SN";
		}
	}

	public static string TimeFromWhichShowEnder_SN
	{
		get
		{
			return "TimeFromWhichShowEnder_SN";
		}
	}

	public static string CustomTextureName
	{
		get
		{
			return "cape_CustomTexture";
		}
	}

	public static int CustomCapeTextureWidth
	{
		get
		{
			return 12;
		}
	}

	public static int CustomCapeTextureHeight
	{
		get
		{
			return 16;
		}
	}

	public static string LeftHandedSN
	{
		get
		{
			return "LeftHandedSN";
		}
	}

	public static string SwitchingWeaponsSwipeRegimSN
	{
		get
		{
			return "SwitchingWeaponsSwipeRegimSN";
		}
	}

	public static string ShowRecSN
	{
		get
		{
			return "ShowRecSN";
		}
	}

	public static string CampaignWSSN
	{
		get
		{
			return "CampaignWSSN";
		}
	}

	public static string MultiplayerWSSN
	{
		get
		{
			return "MultiplayerWSSN";
		}
	}

	public static string ReplaceSkins_1_SN
	{
		get
		{
			return "ReplaceSkins_1_SN";
		}
	}

	public static string CapeEquppedSN
	{
		get
		{
			return "CapeEquppedSN";
		}
	}

	public static string HatEquppedSN
	{
		get
		{
			return "HatEquppedSN";
		}
	}

	public static string CapeNoneEqupped
	{
		get
		{
			return "cape_NoneEquipped";
		}
	}

	public static string HatNoneEqupped
	{
		get
		{
			return "hat_NoneEquipped";
		}
	}

	public static string BootsEquppedSN
	{
		get
		{
			return "BootsEquppedSN";
		}
	}

	public static string BootsNoneEqupped
	{
		get
		{
			return "boots_NoneEquipped";
		}
	}

	public static string ArmorEquppedSN
	{
		get
		{
			return "ArmorEquppedSN";
		}
	}

	public static string ArmorNoneEqupped
	{
		get
		{
			return "__no_armor";
		}
	}

	public static string ArmorNewEquppedSN
	{
		get
		{
			return "ArmorNewEquppedSN";
		}
	}

	public static string ArmorNewNoneEqupped
	{
		get
		{
			return "__no_armor_NEW";
		}
	}

	public static string AmmoBoughtSN
	{
		get
		{
			return "AmmoBoughtSN";
		}
	}

	public static string LastTimeUpdateAvailableShownSN
	{
		get
		{
			return "LastTimeUpdateAvailableShownSN";
		}
	}

	public static string UpdateAvailableShownTimesSN
	{
		get
		{
			return "UpdateAvailableShownTimesSN";
		}
	}

	public static string EventX3WindowShownLastTime
	{
		get
		{
			return "EventX3WindowShownLastTime";
		}
	}

	public static string CurrentLanguage
	{
		get
		{
			return "CurrentLanguage";
		}
	}

	public static string EventX3WindowShownCount
	{
		get
		{
			return "EventX3WindowShownCount";
		}
	}

	public static string AdvertWindowShownLastTime
	{
		get
		{
			return "AdvertWindowShownLastTime";
		}
	}

	public static string AdvertWindowShownCount
	{
		get
		{
			return "AdvertWindowShownCount";
		}
	}

	public static string SurvSkinsPath
	{
		get
		{
			return "EnemySkins/Survival";
		}
	}

	public static string TrainingCompleted_4_3Sett
	{
		get
		{
			return "TrainingCompleted_4_3Sett";
		}
	}

	public static string TrainingCompleted_4_4_Sett
	{
		get
		{
			return "TrainingCompleted_4_4_Sett";
		}
	}

	public static string InsideTrainiongSN
	{
		get
		{
			return "InsideTrainiongSN";
		}
	}

	public static string BassCannonSN
	{
		get
		{
			return "BassCannonSN";
		}
	}

	public static string ShouldEnableShopSN
	{
		get
		{
			return "ShouldEnableShopSN";
		}
	}

	public static string TrainingSceneName
	{
		get
		{
			return "Training";
		}
	}

	public static string CoinsAfterTrainingSN
	{
		get
		{
			return "CoinsAfterTrainingSN";
		}
	}

	public static bool IsTraining
	{
		get
		{
			return isTrainingFlag && Application.loadedLevelName.Equals(TrainingSceneName);
		}
	}

	public static string CapesDir
	{
		get
		{
			return "Capes";
		}
	}

	public static string HatsDir
	{
		get
		{
			return "Hats";
		}
	}

	public static string BootsDir
	{
		get
		{
			return "Boots";
		}
	}

	public static string ArtLevsS
	{
		get
		{
			return "ArtLevsS";
		}
	}

	public static string ArtBoxS
	{
		get
		{
			return "ArtBoxS";
		}
	}

	public static string BestScoreSett
	{
		get
		{
			return "BestScoreSett";
		}
	}

	public static string SurvivalScoreSett
	{
		get
		{
			return "SurvivalScoreSett";
		}
	}

	public static string InAppBoughtSett
	{
		get
		{
			return "BigAmmoPackBought";
		}
	}

	public static string CurrentWeaponSett
	{
		get
		{
			return "CurrentWeapon";
		}
	}

	public static string MinerWeaponSett
	{
		get
		{
			return "MinerWeaponSett";
		}
	}

	public static string SwordSett
	{
		get
		{
			return "SwordSett";
		}
	}

	public static int ScoreForSurplusAmmo
	{
		get
		{
			return 50;
		}
	}

	public static string ShownNewWeaponsSN
	{
		get
		{
			return "ShownNewWeaponsSN";
		}
	}

	public static string LevelsWhereGetCoinS
	{
		get
		{
			return "LevelsWhereGetCoinS";
		}
	}

	public static string NumberOfElixirsSett
	{
		get
		{
			return "NumberOfElixirsSett";
		}
	}

	public static string WeaponsGotInCampaign
	{
		get
		{
			return "WeaponsGotInCampaign";
		}
	}

	public static float Coef
	{
		get
		{
			return (float)Screen.height / 768f;
		}
	}

	public static string SkinEditorMode
	{
		get
		{
			return "SkinEditorMode";
		}
	}

	public static string SkinNameMultiplayer
	{
		get
		{
			return "SkinNameMultiplayer";
		}
	}

	public static string SkinIndexMultiplayer
	{
		get
		{
			return "SkinIndexMultiplayer";
		}
	}

	public static string SkinBaseName
	{
		get
		{
			return "Mult_Skin_";
		}
	}

	public static string MultSkinsDirectoryName
	{
		get
		{
			return "Multiplayer Skins";
		}
	}

	public static string katana_SN
	{
		get
		{
			return "katana_SN";
		}
	}

	public static string katana_2_SN
	{
		get
		{
			return "katana_2_SN";
		}
	}

	public static string katana_3_SN
	{
		get
		{
			return "katana_3_SN";
		}
	}

	public static string AK74_SN
	{
		get
		{
			return "AK74_SN";
		}
	}

	public static string AK74_2_SN
	{
		get
		{
			return "AK74_2_SN";
		}
	}

	public static string AK74_3_SN
	{
		get
		{
			return "AK74_3_SN";
		}
	}

	public static string FreezeGun_SN
	{
		get
		{
			return "FreezeGun_SN";
		}
	}

	public static string CombatRifleSett
	{
		get
		{
			return "CombatRifleSett";
		}
	}

	public static string m_16_3_Sett
	{
		get
		{
			return "m_16_3_Sett";
		}
	}

	public static string m_16_4_Sett
	{
		get
		{
			return "m_16_4_Sett";
		}
	}

	public static string GoldenEagleSett
	{
		get
		{
			return "GoldenEagleSett";
		}
	}

	public static string SparklyBlasterSN
	{
		get
		{
			return "SparklyBlasterSN";
		}
	}

	public static string CherryGunSN
	{
		get
		{
			return "CherryGunSN";
		}
	}

	public static string MagicBowSett
	{
		get
		{
			return "MagicBowSett";
		}
	}

	public static string FlowePowerSN
	{
		get
		{
			return "FlowePowerSN";
		}
	}

	public static string BuddySN
	{
		get
		{
			return "BuddySN";
		}
	}

	public static string AUGSN
	{
		get
		{
			return "AUGSett";
		}
	}

	public static string AUG_2SN
	{
		get
		{
			return "AUG_2SN";
		}
	}

	public static string RazerSN
	{
		get
		{
			return "RazerSN";
		}
	}

	public static string Razer_2SN
	{
		get
		{
			return "Razer_2SN";
		}
	}

	public static string SPASSett
	{
		get
		{
			return "SPASSett";
		}
	}

	public static string GoldenAxeSett
	{
		get
		{
			return "GoldenAxeSett";
		}
	}

	public static string ChainsawS
	{
		get
		{
			return "ChainsawS";
		}
	}

	public static string FAMASS
	{
		get
		{
			return "FAMASS";
		}
	}

	public static string GlockSett
	{
		get
		{
			return "GlockSett";
		}
	}

	public static string ScytheSN
	{
		get
		{
			return "ScytheSN";
		}
	}

	public static string Scythe_2_SN
	{
		get
		{
			return "Scythe_2_SN";
		}
	}

	public static string ShovelSN
	{
		get
		{
			return "ShovelSN";
		}
	}

	public static string Sword_2_SN
	{
		get
		{
			return "Sword_2_SN";
		}
	}

	public static string HammerSN
	{
		get
		{
			return "HammerSN";
		}
	}

	public static string StaffSN
	{
		get
		{
			return "StaffSN";
		}
	}

	public static string CrystalSPASSN
	{
		get
		{
			return "CrystalSPASSN";
		}
	}

	public static string CrystalGlockSN
	{
		get
		{
			return "CrystalGlockSN";
		}
	}

	public static string LaserRifleSN
	{
		get
		{
			return "LaserRifleSN";
		}
	}

	public static string LightSwordSN
	{
		get
		{
			return "LightSwordSN";
		}
	}

	public static string BerettaSN
	{
		get
		{
			return "BerettaSN";
		}
	}

	public static string Beretta_2_SN
	{
		get
		{
			return "Beretta_2_SN";
		}
	}

	public static string MaceSN
	{
		get
		{
			return "MaceSN";
		}
	}

	public static string MinigunSN
	{
		get
		{
			return "MinigunSN";
		}
	}

	public static string MauserSN
	{
		get
		{
			return "MauserSN";
		}
	}

	public static string ShmaiserSN
	{
		get
		{
			return "ShmaiserSN";
		}
	}

	public static string ThompsonSN
	{
		get
		{
			return "ThompsonSN";
		}
	}

	public static string Thompson_2SN
	{
		get
		{
			return "Thompson_2SN";
		}
	}

	public static string CrossbowSN
	{
		get
		{
			return "CrossbowSN";
		}
	}

	public static string plazmaSN
	{
		get
		{
			return "plazmaSN";
		}
	}

	public static string plazma_pistol_SN
	{
		get
		{
			return "plazma_pistol_SN";
		}
	}

	public static string Tesla_2SN
	{
		get
		{
			return "Tesla_2SN";
		}
	}

	public static string Bazooka_3SN
	{
		get
		{
			return "Bazooka_3SN";
		}
	}

	public static string GravigunSN
	{
		get
		{
			return "GravigunSN";
		}
	}

	public static string GoldenPickSN
	{
		get
		{
			return "GoldenPickSN";
		}
	}

	public static string TreeSN
	{
		get
		{
			return "TreeSN";
		}
	}

	public static string Tree_2_SN
	{
		get
		{
			return "Tree_2_SN";
		}
	}

	public static string FireAxeSN
	{
		get
		{
			return "FireAxeSN";
		}
	}

	public static string _3PLShotgunSN
	{
		get
		{
			return "_3PLShotgunSN";
		}
	}

	public static string Revolver2SN
	{
		get
		{
			return "Revolver2SN";
		}
	}

	public static string CrystakPickSN
	{
		get
		{
			return "CrystakPickSN";
		}
	}

	public static string IronSwordSN
	{
		get
		{
			return "IronSwordSN";
		}
	}

	public static string GoldenSwordSN
	{
		get
		{
			return "GoldenSwordSN";
		}
	}

	public static string GoldenRed_StoneSN
	{
		get
		{
			return "GoldenRed_StoneSN";
		}
	}

	public static string GoldenSPASSN
	{
		get
		{
			return "GoldenSPASSN";
		}
	}

	public static string GoldenGlockSN
	{
		get
		{
			return "GoldenGlockSN";
		}
	}

	public static string RedMinigunSN
	{
		get
		{
			return "RedMinigunSN";
		}
	}

	public static string CrystalCrossbowSN
	{
		get
		{
			return "CrystalCrossbowSN";
		}
	}

	public static string RedLightSaberSN
	{
		get
		{
			return "RedLightSaberSN";
		}
	}

	public static string SandFamasSN
	{
		get
		{
			return "SandFamasSN";
		}
	}

	public static string WhiteBerettaSN
	{
		get
		{
			return "WhiteBerettaSN";
		}
	}

	public static string BlackEagleSN
	{
		get
		{
			return "BlackEagleSN";
		}
	}

	public static string CrystalAxeSN
	{
		get
		{
			return "CrystalAxeSN";
		}
	}

	public static string SteelAxeSN
	{
		get
		{
			return "SteelAxeSN";
		}
	}

	public static string WoodenBowSN
	{
		get
		{
			return "WoodenBowSN";
		}
	}

	public static string Chainsaw2SN
	{
		get
		{
			return "Chainsaw2SN";
		}
	}

	public static string SteelCrossbowSN
	{
		get
		{
			return "SteelCrossbowSN";
		}
	}

	public static string Hammer2SN
	{
		get
		{
			return "Hammer2SN";
		}
	}

	public static string Mace2SN
	{
		get
		{
			return "Mace2SN";
		}
	}

	public static string Sword_22SN
	{
		get
		{
			return "Sword_22SN";
		}
	}

	public static string Staff2SN
	{
		get
		{
			return "Staff2SN";
		}
	}

	public static string BarrettSN
	{
		get
		{
			return "BarrettSN";
		}
	}

	public static string SVDSN
	{
		get
		{
			return "SVDSN";
		}
	}

	public static string Barrett2SN
	{
		get
		{
			return "Barrett2SN";
		}
	}

	public static string SVD_2SN
	{
		get
		{
			return "SVD_2SN";
		}
	}

	public static string FlameThrowerSN
	{
		get
		{
			return "FlameThrowerSN";
		}
	}

	public static string FlameThrower_2SN
	{
		get
		{
			return "FlameThrower_2SN";
		}
	}

	public static string BazookaSN
	{
		get
		{
			return "BazookaSN";
		}
	}

	public static string Bazooka_2SN
	{
		get
		{
			return "Bazooka_2SN";
		}
	}

	public static string GrenadeLnchSN
	{
		get
		{
			return "GrenadeLnchSN";
		}
	}

	public static string GrenadeLnch_2SN
	{
		get
		{
			return "GrenadeLnch_2SN";
		}
	}

	public static string TeslaSN
	{
		get
		{
			return "TeslaSN";
		}
	}

	public static string RailgunSN
	{
		get
		{
			return "RailgunSN";
		}
	}

	public static string NavyFamasSN
	{
		get
		{
			return "NavyFamasSN";
		}
	}

	public static string Eagle_3SN
	{
		get
		{
			return "Eagle_3SN";
		}
	}

	public static string endmanskinBoughtSett
	{
		get
		{
			return "endmanskinBoughtSett";
		}
	}

	public static string chiefBoughtSett
	{
		get
		{
			return "chiefBoughtSett";
		}
	}

	public static string spaceengineerBoughtSett
	{
		get
		{
			return "spaceengineerBoughtSett";
		}
	}

	public static string nanosoldierBoughtSett
	{
		get
		{
			return "nanosoldierBoughtSett";
		}
	}

	public static string steelmanBoughtSett
	{
		get
		{
			return "steelmanBoughtSett";
		}
	}

	public static string captainSett
	{
		get
		{
			return "captainSett";
		}
	}

	public static string hawkSett
	{
		get
		{
			return "hawkSett";
		}
	}

	public static string greenGuySett
	{
		get
		{
			return "greenGuySett";
		}
	}

	public static string TunderGodSett
	{
		get
		{
			return "TunderGodSett";
		}
	}

	public static string gordonSett
	{
		get
		{
			return "gordonSett";
		}
	}

	public static string animeGirlSett
	{
		get
		{
			return "animeGirlSett";
		}
	}

	public static string emoGirlSett
	{
		get
		{
			return "emoGirlSett";
		}
	}

	public static string nurseSett
	{
		get
		{
			return "nurseSett";
		}
	}

	public static string magicGirlSett
	{
		get
		{
			return "magicGirlSett";
		}
	}

	public static string braveGirlSett
	{
		get
		{
			return "braveGirlSett";
		}
	}

	public static string glamGirlSett
	{
		get
		{
			return "glamGirlSett";
		}
	}

	public static string kityyGirlSett
	{
		get
		{
			return "kityyGirlSett";
		}
	}

	public static string famosBoySett
	{
		get
		{
			return "famosBoySett";
		}
	}

	public static string skin810_1
	{
		get
		{
			return "skin810_1";
		}
	}

	public static string skin810_2
	{
		get
		{
			return "skin810_2";
		}
	}

	public static string skin810_3
	{
		get
		{
			return "skin810_3";
		}
	}

	public static string skin810_4
	{
		get
		{
			return "skin810_4";
		}
	}

	public static string skin810_5
	{
		get
		{
			return "skin810_5";
		}
	}

	public static string skin810_6
	{
		get
		{
			return "skin810_6";
		}
	}

	public static string skin931_1
	{
		get
		{
			return "skin931_1";
		}
	}

	public static string skin931_2
	{
		get
		{
			return "skin931_2";
		}
	}

		public static string skin931_3
	{
		get
		{
			return "skin931_3";
		}
	}

			public static string skin931_4
	{
		get
		{
			return "skin931_4";
		}
	}

	public static string skin931_5
	{
		get
		{
			return "skin931_5";
		}
	}


	public static string hungerGamesPurchasedKey
	{
		get
		{
			return "HungerGamesPuchased";
		}
	}

	public static string smallAsAntKey
	{
		get
		{
			return "AntsKey";
		}
	}

	public static string code010110_Key
	{
		get
		{
			return "MatrixKey";
		}
	}

	public static string UnderwaterKey
	{
		get
		{
			return "UnderwaterKey";
		}
	}

	public static string CaptureFlagPurchasedKey
	{
		get
		{
			return "CaptureFlagGamesPuchased";
		}
	}

	public static string defaultPlayerName
	{
		get
		{
			return "Player";
		}
	}

	public static string FacebookName { get; set; }

	public static string FirstLaunch
	{
		get
		{
			return "FirstLaunch";
		}
	}

	public static string inappsRestored_3_1
	{
		get
		{
			return "inappsRestored_3_1";
		}
	}

	public static string restoreWindowShownProfile
	{
		get
		{
			return "restoreWindowShownProfile";
		}
	}

	public static string restoreWindowShownSingle
	{
		get
		{
			return "restoreWindowShownSingle";
		}
	}

	public static string restoreWindowShownMult
	{
		get
		{
			return "restoreWindowShownMult";
		}
	}

	public static string ShowSorryWeaponAndArmor
	{
		get
		{
			return "ShowSorryWeaponAndArmor";
		}
	}

	public static string ChangeOldLanguageName
	{
		get
		{
			return "ChangeOldLanguageName";
		}
	}

	public static string InitialAppVersionKey
	{
		get
		{
			return "InitialAppVersion";
		}
	}

	internal static int SaltSeed
	{
		get
		{
			return 2083243184;
		}
	}

	public static string SkinsMakerInProfileBought
	{
		get
		{
			return "SkinsMakerInProfileBought";
		}
	}

	public static string MostExpensiveWeapon
	{
		get
		{
			return "MostExpensiveWeapon";
		}
	}

	public static string MenuPersWeaponTag
	{
		get
		{
			return "MenuPersWeaponTag";
		}
	}

	public static string TrainingComplSett
	{
		get
		{
			return "TrainingComplSett";
		}
	}

	public static string EarnedCoins
	{
		get
		{
			return "EarnedCoins";
		}
	}

	public static string COOPScore
	{
		get
		{
			return "COOPScore";
		}
	}

	public static string SkinsWrittenToGallery
	{
		get
		{
			return "SkinsWrittenToGallery";
		}
	}

	public static float screenRation
	{
		get
		{
			return (float)Screen.width / (float)Screen.height;
		}
	}

	public static string NumOfMultSkinsSett
	{
		get
		{
			return "NumOfMultSkinsSett";
		}
	}

	public static string KilledZombiesSett
	{
		get
		{
			return "KilledZombiesSett";
		}
	}

	public static string WavesSurvivedS
	{
		get
		{
			return "WavesSurvivedS";
		}
	}

	public static string ProfileEnteredFromMenu
	{
		get
		{
			return "ProfileEnteredFromMenu";
		}
	}

	public static float DiffModif
	{
		get
		{
			float result = 0.6f;
			switch (diffGame)
			{
			case 1:
				result = 0.8f;
				break;
			case 2:
				result = 1f;
				break;
			}
			return result;
		}
	}

	public static string CancelButtonTitle
	{
		get
		{
			return "Cancel";
		}
	}

	public static int skinsMakerPrice
	{
		get
		{
			return 50;
		}
	}

	public static int HungerGamesPrice
	{
		get
		{
			return 75;
		}
	}

	public static int CaptureFlagPrice
	{
		get
		{
			return 100;
		}
	}

	public static int HoursToEndX3ForIndicate
	{
		get
		{
			return 6;
		}
	}

	public static string MainMenuScene
	{
		get
		{
			return "Menu_Bota";
		}
	}

	public static string ShouldReoeatActionSett
	{
		get
		{
			return "ShouldReoeatActionSett";
		}
	}

	public static string DiffSett
	{
		get
		{
			return "DifficultySett";
		}
	}

	public static string GoToProfileAction
	{
		get
		{
			return "GoToProfileAction";
		}
	}

	public static string GoToSkinsMakerAction
	{
		get
		{
			return "GoToSkinsMakerAction";
		}
	}

	public static string GoToPresetsAction
	{
		get
		{
			return "GoToPresetsAction";
		}
	}

	public static string SkinsMakerInMainMenuPurchased
	{
		get
		{
			return "SkinsMakerInMainMenuPurchased";
		}
	}

	public static string IsOldUserOldMetodKey
	{
		get
		{
			return "IsOldUserOldMetod";
		}
	}

	public static string SessionNumberKey
	{
		get
		{
			return "SessionNumber";
		}
	}

	public static string SessionDayNumberKey
	{
		get
		{
			return "SessionDayNumber";
		}
	}

	public static string LastTimeSessionDayKey
	{
		get
		{
			return "LastTimeSessionDay";
		}
	}

	public static string LastTimeShowBanerKey
	{
		get
		{
			return "LastTimeSessionDay";
		}
	}

	public static string StartTimeShowBannersKey
	{
		get
		{
			return "StartTimeShowBanners";
		}
	}

	public static string RankParameterKey
	{
		get
		{
			return "Rank";
		}
	}

	public static string GameModesEventKey
	{
		get
		{
			return "Game Modes";
		}
	}

	public static string MultiplayerModesKey
	{
		get
		{
			return "Multiplayer Modes";
		}
	}

	public static string NextMarafonBonusIndex
	{
		get
		{
			return "NextMarafonBonusIndex";
		}
	}

	public static string GameGUIOffMode
	{
		get
		{
			return "GameGUIOffMode";
		}
	}

	public static string NeedTakeMarathonBonus
	{
		get
		{
			return "NeedTakeMarathonBonus";
		}
	}

	public static string MarathonTestMode
	{
		get
		{
			return "MarathonTestMode";
		}
	}

	public static float Sensitivity
	{
		get
		{
			if (!_sensitivity.HasValue)
			{
				_sensitivity = PlayerPrefs.GetFloat("SensitivitySett", 12f);
			}
			return _sensitivity.Value;
		}
		set
		{
			_sensitivity = value;
			PlayerPrefs.SetFloat("SensitivitySett", value);
		}
	}

	public static bool IsChatOn
	{
		get
		{
			if (!_isChatOn.HasValue)
			{
				_isChatOn = PlayerPrefs.GetInt("ChatOn", 1) == 1;
			}
			return _isChatOn.Value;
		}
		set
		{
			_isChatOn = value;
			PlayerPrefs.SetInt("ChatOn", value ? 1 : 0);
		}
	}

	public static RuntimeAndroidEdition AndroidEdition
	{
		get
		{
			return RuntimeAndroidEdition.GoogleLite;
		}
	}

	public static bool IsDeveloperBuild
	{
		get
		{
			return true;
		}
	}

	public static string HockeyAppID
	{
		get
		{
			return "2d830f37b5a8daaef2b7ada172fc767d";
		}
	}

	static Defs()
	{
		ResetTrainingInDevBuild = false;
		initValsInKeychain43 = "initValsInKeychain43";
		initValsInKeychain44 = "initValsInKeychain44";
		CoinsCountToCompensate = "CoinsCountToCompensate";
		GemsCountToCompensate = "GemsCountToCompensate";
		isMouseControl = false;
		isRegimVidosDebug = false;
		MoneyGiven831to901 = "MoneyGiven831to901";
		GotCoinsForTraining = "GotCoinsForTraining";
		typeDisconnectGame = DisconectGameType.Exit;
		gameSecondFireButtonMode = GameSecondFireButtonMode.Sniper;
		ZoomButtonX = -176;
		ZoomButtonY = 431;
		ReloadButtonX = -72;
		ReloadButtonY = 340;
		JumpButtonX = -95;
		JumpButtonY = 79;
		FireButtonX = -250;
		FireButtonY = 150;
		JoyStickX = 172;
		JoyStickY = 160;
		GrenadeX = -46;
		GrenadeY = 445;
		FireButton2X = 160;
		FireButton2Y = 337;
		VisualHatArmor = "VisualHatArmor";
		VisualArmor = "VisualArmor";
		RatingDeathmatch = "RatingDeathmatch";
		RatingTeamBattle = "RatingTeamBattle";
		RatingHunger = "RatingHunger";
		RatingCOOP = "RatingCOOP";
		RatingFlag = "RatingFlag";
		countGrenadeInHunger = 0;
		LogoWidth = 8;
		LogoHeight = 8;
		SurvivalMaps = new string[8] { "Arena_Swamp", "Arena_Underwater", "Coliseum", "Arena_Castle", "Arena_Space", "Arena_Hockey", "Arena_Mine", "Pizza" };
		CurrentSurvMapIndex = -1;
		FreezerSlowdownTime = 5f;
		_initializedJoystickParams = false;
		isShowUserAgrement = false;
		maxCountFriend = 100;
		bigPorogString = "No space for new friends. Delete friends or requests";
		smallPorogString = "Tap ADD TO FRIENDS to send a friendship request to the player";
		ammoInGamePanelPrice = 3;
		healthInGamePanelPrice = 5;
		ClansPrice = 0;
		ProfileFromFriends = 0;
		PixelGunAppID = "640111933";
		AppStoreURL = "https://itunes.apple.com/app/pixel-gun-3d-block-world-pocket/id" + PixelGunAppID + "?mt=8";
		SupportMail = "pgx.support@proton.me";
		levelNamesFromNums = new Dictionary<string, string>();
		EnderManAvailable = true;
		isSoundMusic = false;
		isSoundFX = false;
		BottomOffs = 21f;
		filterMaps = new Dictionary<string, int>();
		_premiumMaps = new Dictionary<string, int>();
		levelNumsForMusicInMult = new Dictionary<string, int>();
		levelsWithVarY = new List<int>();
		NumberOfElixirs = 1;
		isGrenateFireEnable = true;
		isZooming = false;
		isJetpackEnabled = false;
		GoToProfileShopInterval = 1f;
		InvertCamSN = "InvertCamSN";
		players = new List<GameObject>();
		PromSceneName = "PromScene";
		isTrainingFlag = false;
		_3_shotgun_2 = "_3_shotgun_2";
		_3_shotgun_3 = "_3_shotgun_3";
		flower_2 = "flower_2";
		flower_3 = "flower_3";
		gravity_2 = "gravity_2";
		gravity_3 = "gravity_3";
		grenade_launcher_3 = "grenade_launcher_3";
		revolver_2_2 = "revolver_2_2";
		revolver_2_3 = "revolver_2_3";
		scythe_3 = "scythe_3";
		plazma_2 = "plazma_2";
		plazma_3 = "plazma_3";
		plazma_pistol_2 = "plazma_pistol_2";
		plazma_pistol_3 = "plazma_pistol_3";
		railgun_2 = "railgun_2";
		railgun_3 = "railgun_3";
		Razer_3 = "Razer_3";
		tesla_3 = "tesla_3";
		Flamethrower_3 = "Flamethrower_3";
		FreezeGun_0 = "FreezeGun_0";
		svd_3 = "svd_3";
		barret_3 = "barret_3";
		minigun_3 = "minigun_3";
		LightSword_3 = "LightSword_3";
		Sword_2_3 = "Sword_2_3";
		Staff_3 = "Staff 3";
		DragonGun = "DragonGun";
		Bow_3 = "Bow_3";
		Bazooka_1_3 = "Bazooka_1_3";
		Bazooka_2_1 = "Bazooka_2_1";
		Bazooka_2_3 = "Bazooka_2_3";
		m79_2 = "m79_2";
		m79_3 = "m79_3";
		m32_1_2 = "m32_1_2";
		Red_Stone_3 = "Red_Stone_3";
		XM8_1 = "XM8_1";
		PumpkinGun_1 = "PumpkinGun_1";
		XM8_2 = "XM8_2";
		XM8_3 = "XM8_3";
		PumpkinGun_2 = "PumpkinGun_2";
		Weapons800to801 = "Weapons800to801";
		Weapons831to901 = "Weapons831to901";
		FixWeapons911 = "FixWeapons911";
		ReturnAlienGun930 = "ReturnAlienGun930";
		diffGame = 2;
		StartTimeShowBannersString = string.Empty;
		showTableInNetworkStartTable = false;
		showNickTableInNetworkStartTable = false;
		isTurretWeapon = false;
		inRespawnWindow = false;
		IsFirstLaunchFreshInstall = "IsFirstLaunchFreshInstall";
		NewbieEventX3StartTime = "NewbieEventX3StartTime";
		NewbieEventX3StartTimeAdditional = "NewbieEventX3StartTimeAdditional";
		NewbieEventX3LastLoggedTime = "NewbieEventX3LastLoggedTime";
		WasNewbieEventX3 = "WasNewbieEventX3";
		levelNumsForMusicInMult.Add("Maze", 2);
		levelNumsForMusicInMult.Add("Cementery", 1);
		levelNumsForMusicInMult.Add("City", 3);
		levelNumsForMusicInMult.Add("Gluk", 6);
		levelNumsForMusicInMult.Add("Jail", 5);
		levelNumsForMusicInMult.Add("Hospital", 4);
		levelNumsForMusicInMult.Add("Pool", 1001);
		levelNumsForMusicInMult.Add("Pool_Abandoned", 1050);
		levelNumsForMusicInMult.Add("Lean_Matrix", 1051);
		levelNumsForMusicInMult.Add("Tatuan", 1052);
		levelNumsForMusicInMult.Add("ChinaPand", 1053);
		levelNumsForMusicInMult.Add("PiratIsland", 1054);
		levelNumsForMusicInMult.Add("Slender", 9);
		levelNumsForMusicInMult.Add("Castle", 1002);
		levelNumsForMusicInMult.Add("Ranch", 1003);
		levelNumsForMusicInMult.Add("Arena_MP", 1004);
		levelNumsForMusicInMult.Add("Sky_islands", 1005);
		levelNumsForMusicInMult.Add("Dust", 1006);
		levelNumsForMusicInMult.Add("Bridge", 1007);
		levelNumsForMusicInMult.Add("Assault", 1008);
		levelNumsForMusicInMult.Add("Farm", 4001);
		levelNumsForMusicInMult.Add("Utopia", 4002);
		levelNumsForMusicInMult.Add("Arena", 7);
		levelNumsForMusicInMult.Add("Winter", 4003);
		levelNumsForMusicInMult.Add("Aztec", 4005);
		levelNumsForMusicInMult.Add("School", 1009);
		levelNumsForMusicInMult.Add("Parkour", 1010);
		levelNumsForMusicInMult.Add("Coliseum_MP", 1011);
		levelNumsForMusicInMult.Add("Hungry", 1012);
		levelNumsForMusicInMult.Add("Hungry_Night", 1013);
		levelNumsForMusicInMult.Add("Hungry_2", 1014);
		levelNumsForMusicInMult.Add("Estate", 1020);
		levelNumsForMusicInMult.Add("Space", 1022);
		levelNumsForMusicInMult.Add("Portal", 1023);
		levelNumsForMusicInMult.Add("Two_Castles", 1024);
		levelNumsForMusicInMult.Add("Ships", 1025);
		levelNumsForMusicInMult.Add("Ships_Night", 1026);
		levelNumsForMusicInMult.Add("Gluk_3", 1027);
		levelNumsForMusicInMult.Add("Matrix", 1028);
		levelNumsForMusicInMult.Add("Ants", 1029);
		levelNumsForMusicInMult.Add("Hill", 1030);
		levelNumsForMusicInMult.Add("Heaven", 1031);
		levelNumsForMusicInMult.Add("Underwater", 1032);
		levelNumsForMusicInMult.Add("Knife", 1033);
		levelNumsForMusicInMult.Add("Day_D", 1034);
		levelNumsForMusicInMult.Add("NuclearCity", 1035);
		levelNumsForMusicInMult.Add("Cube", 1036);
		levelNumsForMusicInMult.Add("Train", 1037);
		levelNumsForMusicInMult.Add("Sniper", 1038);
		levelNumsForMusicInMult.Add("Supermarket", 1039);
		levelNumsForMusicInMult.Add("Pumpkins", 1040);
		levelNumsForMusicInMult.Add("Christmas_Town", 1041);
		levelNumsForMusicInMult.Add("Christmas_Town_Night", 1042);
		levelNumsForMusicInMult.Add("Paradise", 1043);
		levelNumsForMusicInMult.Add("Bota", 1044);
		levelNumsForMusicInMult.Add("Pizza", 1045);
		levelNumsForMusicInMult.Add("Barge", 1046);
		levelNumsForMusicInMult.Add("Slender_Multy", 1047);
		levelNumsForMusicInMult.Add("Mine", 1048);
		levelNumsForMusicInMult.Add("DevScene", 1049);
		_premiumMaps.Add("Ants", 15);
		_premiumMaps.Add("Lean_Matrix", 2100000000);
		_premiumMaps.Add("Matrix", 15);
		_premiumMaps.Add("Underwater", 15);
		filterMaps.Add("Knife", 1);
		filterMaps.Add("Sniper", 2);
		foreach (KeyValuePair<string, int> item in levelNumsForMusicInMult)
		{
			levelNamesFromNums.Add(item.Value.ToString(), item.Key);
		}
		levelsWithVarY.Add(8);
		levelsWithVarY.Add(10);
		levelsWithVarY.Add(11);
		levelsWithVarY.Add(12);
		levelsWithVarY.Add(13);
		levelsWithVarY.Add(14);
		levelsWithVarY.Add(15);
		levelsWithVarY.Add(16);
		levelsWithVarY.Add(20);
		levelsWithVarY.Add(1005);
		levelsWithVarY.Add(1006);
		levelsWithVarY.Add(1007);
		levelsWithVarY.Add(1008);
		levelsWithVarY.Add(1009);
		levelsWithVarY.Add(1010);
		levelsWithVarY.Add(1003);
		levelsWithVarY.Add(1011);
		levelsWithVarY.Add(1012);
		levelsWithVarY.Add(1020);
		levelsWithVarY.Add(1021);
		levelsWithVarY.Add(1023);
		levelsWithVarY.Add(4001);
		levelsWithVarY.Add(4002);
		levelsWithVarY.Add(4003);
		levelsWithVarY.Add(4005);
		levelsWithVarY.Add(1025);
		levelsWithVarY.Add(1026);
		levelsWithVarY.Add(1027);
		levelsWithVarY.Add(1028);
		levelsWithVarY.Add(1029);
		levelsWithVarY.Add(1030);
		levelsWithVarY.Add(1031);
		levelsWithVarY.Add(1032);
		levelsWithVarY.Add(1033);
		levelsWithVarY.Add(1034);
		levelsWithVarY.Add(1035);
		levelsWithVarY.Add(1036);
		levelsWithVarY.Add(1037);
		levelsWithVarY.Add(1038);
	}

	public static Color AmbientLightColorForShop()
	{
		return new Color(20f / 51f, 20f / 51f, 20f / 51f, 1f);
	}

	public static int CompareAlphaNumerically(object x, object y)
	{
		string text = x as string;
		if (text == null)
		{
			return 0;
		}
		string text2 = y as string;
		if (text2 == null)
		{
			return 0;
		}
		int length = text.Length;
		int length2 = text2.Length;
		int num = 0;
		int num2 = 0;
		while (num < length && num2 < length2)
		{
			char c = text[num];
			char c2 = text2[num2];
			char[] array = new char[length];
			int num3 = 0;
			char[] array2 = new char[length2];
			int num4 = 0;
			do
			{
				array[num3++] = c;
				num++;
				if (num < length)
				{
					c = text[num];
					continue;
				}
				break;
			}
			while (char.IsDigit(c) == char.IsDigit(array[0]));
			do
			{
				array2[num4++] = c2;
				num2++;
				if (num2 < length2)
				{
					c2 = text2[num2];
					continue;
				}
				break;
			}
			while (char.IsDigit(c2) == char.IsDigit(array2[0]));
			string text3 = new string(array);
			string text4 = new string(array2);
			int num6;
			if (char.IsDigit(array[0]) && char.IsDigit(array2[0]))
			{
				int num5 = int.Parse(text3);
				int value = int.Parse(text4);
				num6 = num5.CompareTo(value);
			}
			else
			{
				num6 = text3.CompareTo(text4);
			}
			if (num6 != 0)
			{
				return num6;
			}
		}
		return length - length2;
	}

	public static void InitCoordsIphone()
	{
		if (!_initializedJoystickParams)
		{
		}
		_initializedJoystickParams = true;
	}

	public static string GetPlayerNameOrDefault()
	{
		if (PlayerPrefs.HasKey("NamePlayer"))
		{
			string @string = PlayerPrefs.GetString("NamePlayer");
			if (@string != null)
			{
				return @string;
			}
		}
		string text = PlayerPrefs.GetString("SocialName", string.Empty);
		if (Social.localUser != null && Social.localUser.authenticated && !string.IsNullOrEmpty(Social.localUser.userName))
		{
			if (IsDeveloperBuild)
			{
				Debug.Log("GetPlayerNameOrDefault(): Social.localUser.userName:    " + Social.localUser.userName);
			}
			if (!text.Equals(Social.localUser.userName))
			{
				text = Social.localUser.userName;
				PlayerPrefs.SetString("SocialName", text);
			}
			return text;
		}
		if (AndroidEdition == RuntimeAndroidEdition.Amazon)
		{
			if (GameCircleSocial.Instance == null)
			{
				Debug.LogWarning("GetPlayerNameOrDefault(): GameCircleSocial.Instance == null");
			}
			else
			{
					if (IsDeveloperBuild)
					{
						Debug.Log("GetPlayerNameOrDefault(): GameCircleSocial.Instance.localUser.userName:    ");
					}
					return text;
				Debug.LogWarning("GetPlayerNameOrDefault(): String.IsNullOrEmpty(GameCircleSocial.Instance.localUser.userName)");
			}
		}
		if (IsDeveloperBuild && !string.IsNullOrEmpty(FacebookName))
		{
			if (IsDeveloperBuild)
			{
				Debug.Log("GetPlayerNameOrDefault(): FacebookName:    " + FacebookName);
			}
			return FacebookName;
		}
		if (!string.IsNullOrEmpty(text))
		{
			if (IsDeveloperBuild)
			{
				Debug.Log("GetPlayerNameOrDefault(): saved social name:    " + text);
			}
			return text;
		}
		if (IsDeveloperBuild)
		{
			Debug.Log("GetPlayerNameOrDefault(): Default name:    " + defaultPlayerName);
		}
		return defaultPlayerName;
	}

	public static string GetIntendedAndroidPackageName()
	{
		return GetIntendedAndroidPackageName(AndroidEdition);
	}

	public static string GetIntendedAndroidPackageName(RuntimeAndroidEdition androidEdition)
	{
		switch (androidEdition)
		{
		case RuntimeAndroidEdition.GoogleLite:
			return "com.pixel.gun3d";
		case RuntimeAndroidEdition.GooglePro:
			return "com.pixelgun3d.pro";
		case RuntimeAndroidEdition.Amazon:
			return "com.PixelGun.a3D";
		default:
			return string.Empty;
		}
	}
}
