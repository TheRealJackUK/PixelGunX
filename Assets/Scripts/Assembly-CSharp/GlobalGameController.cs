using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

public class GlobalGameController
{
	public static bool InsideTraining;

	public static bool LeftHanded;

	public static bool switchingWeaponSwipe;

	public static bool ShowRec;

	public static List<int> survScoreThresh;

	public static int curThr;

	public static int thrStep;

	public static Font fontHolder;

	public static int EditingLogo;

	public static string TempClanName;

	public static Texture2D LogoToEdit;

	public static List<Texture2D> Logos;

	public static readonly int NumOfLevels;

	private static int _currentLevel;

	private static int _allLevelsCompleted;

	public static bool showTableMyPlayer;

	public static bool imDeadInHungerGame;

	public static bool isFullVersion;

	public static Vector3 posMyPlayer;

	public static Quaternion rotMyPlayer;

	public static float healthMyPlayer;

	public static int numOfCompletedLevels;

	public static int totalNumOfCompletedLevels;

	public static int countKillsBlue;

	public static int countKillsRed;

	public static int EditingCape;

	public static bool EditedCapeSaved;

	private static int? _enemiesToKillOverride;

	private static SaltedInt _saltedScore;

	private static SaltedInt _saltedCountKills;

	public static int coinsBase;

	public static int coinsBaseAdding;

	public static int levelsToGetCoins;

	public static string AppVersion;

	public static float armorMyPlayer { get; set; }

	public static int currentLevel
	{
		get
		{
			return _currentLevel;
		}
		set
		{
			_currentLevel = value;
		}
	}

	public static int AllLevelsCompleted
	{
		get
		{
			return _allLevelsCompleted;
		}
		set
		{
			_allLevelsCompleted = value;
		}
	}

	public static int ZombiesInWave
	{
		get
		{
			return 4;
		}
	}

	public static int EnemiesToKill
	{
		get
		{
			if (Defs.isTrainingFlag || Application.loadedLevelName.Equals("Training"))
			{
				return 4;
			}
			if (_enemiesToKillOverride.HasValue)
			{
				return _enemiesToKillOverride.Value;
			}
			if (!Defs.IsSurvival)
			{
				return ZombieCreator.GetCountMobsForLevel();
			}
			return 35;
		}
		set
		{
			_enemiesToKillOverride = value;
		}
	}

	internal static int Score
	{
		get
		{
			return _saltedScore.Value;
		}
		set
		{
			_saltedScore.Value = value;
		}
	}

	internal static int CountKills
	{
		get
		{
			return _saltedCountKills.Value;
		}
		set
		{
			_saltedCountKills.Value = value;
		}
	}

	public static int SimultaneousEnemiesOnLevelConstraint
	{
		get
		{
			if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
			{
				return (!MemoryLimit.OptOut()) ? 20 : 7;
			}
			return 20;
		}
	}

	internal static bool NewVersionAvailable { get; set; }

	public static string MultiplayerProtocolVersion
	{
		get
		{
			return Application.version;
		}
	}

	static GlobalGameController()
	{
		InsideTraining = false;
		LeftHanded = true;
		switchingWeaponSwipe = false;
		ShowRec = true;
		survScoreThresh = new List<int>();
		thrStep = 10000;
		fontHolder = null;
		EditingLogo = 0;
		NumOfLevels = 11;
		_currentLevel = -1;
		_allLevelsCompleted = 0;
		showTableMyPlayer = false;
		imDeadInHungerGame = false;
		isFullVersion = true;
		numOfCompletedLevels = 0;
		totalNumOfCompletedLevels = 0;
		countKillsBlue = 0;
		countKillsRed = 0;
		EditingCape = 0;
		EditedCapeSaved = false;
		_saltedScore = new SaltedInt(233495534);
		_saltedCountKills = new SaltedInt(233495534);
		coinsBase = 1;
		coinsBaseAdding = 0;
		levelsToGetCoins = 1;
	}

	void Start()
	{
		AppVersion = Application.version;
	}
	public static void SetMultiMode()
	{
		Defs.isMulti = true;
		Defs.isCOOP = false;
		Defs.isHunger = false;
		Defs.isCompany = false;
		Defs.isFlag = false;
		Defs.IsSurvival = false;
		Defs.isCapturePoints = false;
	}

	private static void Swap(IList<int> list, int indexA, int indexB)
	{
		int value = list[indexA];
		list[indexA] = list[indexB];
		list[indexB] = value;
	}

	public static void ResetParameters()
	{
		AllLevelsCompleted = 0;
		numOfCompletedLevels = -1;
		totalNumOfCompletedLevels = -1;
	}
}
