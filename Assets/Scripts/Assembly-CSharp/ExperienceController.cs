using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using System.Text;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

public sealed class ExperienceController : MonoBehaviour
{
	public static readonly int[] MaxExpLevels = new int[32]
	{
		0, 15, 35, 50, 90, 100, 110, 115, 120, 125,
		130, 135, 140, 150, 160, 170, 180, 200, 250, 300,
		350, 500, 500, 500, 500, 500, 500, 1000, 1000, 1000,
		1000, 100000
	};

	public bool isMenu;

	public bool isConnectScene;

	public int currentLevelForEditor;

	public static int maxLevel = 31;

	public int[,] limitsLeveling = new int[7, 2]
	{
		{ 1, 2 },
		{ 3, 6 },
		{ 7, 11 },
		{ 12, 16 },
		{ 17, 21 },
		{ 22, 26 },
		{ 27, 31 }
	};

	public static int[,] accessByLevels = new int[maxLevel, maxLevel];

	public Texture2D[] marks;

	private SaltedInt currentExperience = new SaltedInt(12512238, 0);

	private int[] _addCoinsFromLevels = new int[32]
	{
		0, 5, 10, 10, 15, 20, 30, 30, 30, 30,
		30, 35, 35, 35, 35, 35, 40, 40, 40, 40,
		40, 50, 50, 50, 50, 50, 50, 50, 50, 50,
		50, 0
	};

	private int[] _addGemsFromLevels = new int[32]
	{
		0, 3, 3, 5, 5, 7, 10, 10, 10, 10,
		10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
		10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
		10, 0
	};

	private static bool _storagerKeysInitialized = false;

	private bool _isShowRanks = true;

	public bool isShowNextPlashka;

	public Vector2 posRanks = Vector2.zero;

	private int oldCurrentExperience;

	public int oldCurrentLevel;

	public bool isShowAdd;

	private bool animAddExperience;

	private int stepAnim;

	public AudioClip exp_1;

	public AudioClip exp_2;

	public AudioClip exp_3;

	public AudioClip Tierup;

	public static ExperienceController sharedController;

	public int currentLevel
	{
		get
		{
			if (currentLevelForEditor == 0)
			{
				currentLevelForEditor = 1;
			}
			return currentLevelForEditor;
		}
		set
		{
			currentLevelForEditor = value;
		}
	}

	public int[] addCoinsFromLevels
	{
		get
		{
			return _addCoinsFromLevels;
		}
	}

	public int[] addGemsFromLevels
	{
		get
		{
			return _addGemsFromLevels;
		}
	}

	public int CurrentExperience
	{
		get
		{
			return currentExperience.Value;
		}
	}

	public bool isShowRanks
	{
		get
		{
			return _isShowRanks;
		}
		set
		{
			_isShowRanks = value;
			if (ExpController.Instance != null)
			{
				ExpController.Instance.InterfaceEnabled = value;
			}
		}
	}

	public ExperienceController()
	{
		currentLevel = 1;
	}

	private static void InitializeStoragerKeysIfNeeded()
	{
		if (_storagerKeysInitialized)
		{
			return;
		}
		for (int i = 1; i <= maxLevel; i++)
		{
			if (!Storager.hasKey("currentLevel" + i))
			{
				Storager.setInt("currentLevel" + PlayerPrefs.GetInt("currentLevel"), 1, false);
			}
		}
		_storagerKeysInitialized = true;
	}

	public static int GetCurrentLevelWithUpdateCorrection()
	{
		InitializeStoragerKeysIfNeeded();
		int num = GetCurrentLevel();
		if (num < maxLevel && Storager.getInt("currentExperience", false) >= MaxExpLevels[num])
		{
			num++;
		}
		return num;
	}

	public static int GetCurrentLevel()
	{
		return PlayerPrefs.GetInt("currentLevel");
	}

	public void Refresh()
	{
		currentExperience.Value = Storager.getInt("currentExperience", false);
		currentLevel = GetCurrentLevel();
	}

	private void AddCurrenciesForLevelUP()
	{
		int @int = Storager.getInt("GemsCurrency", false);
		int num = addGemsFromLevels[currentLevel - 1];
		Storager.setInt("GemsCurrency", @int + num, false);
		FlurryEvents.LogGemsGained(FlurryEvents.GetPlayingMode(), num);
		CoinsMessage.FireCoinsAddedEvent(true);
		int int2 = Storager.getInt("Coins", false);
		int num2 = addCoinsFromLevels[currentLevel - 1];
		Storager.setInt("Coins", int2 + num2, false);
		FlurryEvents.LogCoinsGained(FlurryEvents.GetPlayingMode(), num2);
		CoinsMessage.FireCoinsAddedEvent(false);
	}

	private void Awake()
	{
		sharedController = this;
	}

	private IEnumerator Start()
	{
		Debug.Log(">>> ExperienceController.Start()");
		for (int i = 0; i < maxLevel; i++)
		{
			for (int d = 0; d < maxLevel; d++)
			{
				accessByLevels[i, d] = 0;
			}
		}
		for (int j = 0; j < maxLevel; j++)
		{
			for (int l = limitsLeveling.GetLowerBound(0); l <= limitsLeveling.GetUpperBound(0); l++)
			{
				int min = limitsLeveling[l, 0] - 1;
				int max = limitsLeveling[l, 1] - 1;
				if (j >= min && j <= max)
				{
					for (int d2 = min; d2 <= max; d2++)
					{
						accessByLevels[j, d2] = 1;
					}
					break;
				}
			}
		}
		yield return null;
		try
		{
			Debug.Log("Calling InitializeStoragerKeysIfNeeded()...");
			InitializeStoragerKeysIfNeeded();
			Debug.Log("InitializeStoragerKeysIfNeeded() succeeded.");
			Debug.Log("Initilaizing current level of experience...");
			for (int k = 1; k <= maxLevel; k++)
			{
				if (Storager.getInt("currentLevel" + k, true) == 1)
				{
					currentLevel = PlayerPrefs.GetInt("currentLevel");
				}
			}
			if (PlayerPrefs.GetInt("MonitorNewTier", 0) == 0)
			{
				PlayerPrefs.SetInt("MonitorNewTier", 1);
				if (currentLevel == 26)
				{
					currentLevel = 27;
					Storager.setInt("currentLevel" + currentLevel, 1, true);
					PlayerPrefs.SetInt("currentLevel", currentLevel);
					PlayerPrefs.SetInt("currentLevel", currentLevel);
					Storager.setInt("currentExperience", 0, false);
				}
			}
			Debug.Log("Current level of experience initialized.");
			currentExperience.Value = Storager.getInt("currentExperience", false);
			UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
			if (currentLevel < maxLevel && currentExperience.Value >= MaxExpLevels[currentLevel])
			{
				currentExperience.Value = 0;
				currentLevel++;
				Storager.setInt("currentLevel" + currentLevel, 1, true);
				PlayerPrefs.SetInt("currentLevel", currentLevel);
				Storager.setInt("currentExperience", currentExperience.Value, false);
				BankController.GiveInitialNumOfCoins();
				AddCurrenciesForLevelUP();
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("<<< ExperienceController.Start() failed.");
			Debug.LogException(ex);
			yield break;
		}
		Debug.Log("<<< ExperienceController.Start()");
	}

	public void addExperience(int experience)
	{
		if (currentLevel == maxLevel)
		{
			return;
		}
		animAddExperience = true;
		stepAnim = 0;
		oldCurrentLevel = currentLevel;
		oldCurrentExperience = currentExperience.Value;
		if (currentLevel < maxLevel && experience >= MaxExpLevels[currentLevel] - currentExperience.Value + MaxExpLevels[currentLevel + 1])
		{
			experience = MaxExpLevels[currentLevel + 1] + MaxExpLevels[currentLevel] - currentExperience.Value - 5;
		}
		string key = "Statistics.ExpInMode.Level" + sharedController.currentLevel;
		if (PlayerPrefs.HasKey(key) && Initializer.lastGameMode != -1)
		{
			string key2 = Initializer.lastGameMode.ToString();
			string @string = PlayerPrefs.GetString(key, "{}");
			try
			{
				Dictionary<string, object> dictionary = (Json.Deserialize(@string) as Dictionary<string, object>) ?? new Dictionary<string, object>();
				object value;
				if (dictionary.TryGetValue(key2, out value))
				{
					int num = Convert.ToInt32(value) + experience;
					dictionary[key2] = num;
				}
				else
				{
					dictionary.Add(key2, experience);
				}
				string value2 = Json.Serialize(dictionary);
				PlayerPrefs.SetString(key, value2);
			}
			catch (OverflowException exception)
			{
				Debug.LogError("Cannot deserialize exp-in-mode: " + @string);
				Debug.LogException(exception);
			}
			catch (Exception exception2)
			{
				Debug.LogError("Unknown exception: " + @string);
				Debug.LogException(exception2);
			}
		}
		currentExperience.Value += experience;
		Storager.setInt("currentExperience", currentExperience.Value, false);
		if (currentLevel < maxLevel && currentExperience.Value >= MaxExpLevels[currentLevel])
		{
			DateTime utcNow = DateTime.UtcNow;
			string key3 = "Statistics.TimeInRank.Level" + (currentLevel + 1);
			PlayerPrefs.SetString(key3, utcNow.ToString("s"));
			string key4 = "Statistics.MatchCount.Level" + sharedController.currentLevel;
			int @int = PlayerPrefs.GetInt(key4, 0);
			string key5 = "Statistics.WinCount.Level" + sharedController.currentLevel;
			int int2 = PlayerPrefs.GetInt(key5, 0);
			WWWForm wWWForm = new WWWForm();
			wWWForm.AddField("action", "log_levelup");
			wWWForm.AddField("round_count", @int);
			wWWForm.AddField("win_count", int2);
			wWWForm.AddField("level", currentLevel);
			wWWForm.AddField("app_version", ProtocolListGetter.CurrentPlatform + ":" + GlobalGameController.AppVersion);
			wWWForm.AddField("initial_version", ProtocolListGetter.CurrentPlatform + ":" + PlayerPrefs.GetString(Defs.InitialAppVersionKey));
			wWWForm.AddField("uniq_id", FriendsController.sharedController.id);
			wWWForm.AddField("auth", FriendsController.Hash("log_levelup"));
			wWWForm.AddField("paying", Convert.ToInt32(FlurryPluginWrapper.IsPayingUser()).ToString());
			wWWForm.AddField("developer", Convert.ToInt32(Defs.IsDeveloperBuild).ToString());
			string string2 = PlayerPrefs.GetString("Statistics.TimeInRank.Level" + currentLevel, utcNow.ToString("s"));
			DateTime result;
			if (DateTime.TryParse(string2, out result))
			{
				wWWForm.AddField("total_hours", (utcNow - result).TotalHours.ToString(CultureInfo.InvariantCulture));
			}
			string key6 = "Statistics.TimeInMode.Level" + sharedController.currentLevel;
			wWWForm.AddField("minutes_in_mode", PlayerPrefs.GetString(key6, "{}"));
			string key7 = "Statistics.RoundsInMode.Level" + sharedController.currentLevel;
			wWWForm.AddField("rounds_in_mode", PlayerPrefs.GetString(key7, "{}"));
			string key8 = "Statistics.ExpInMode.Level" + sharedController.currentLevel;
			wWWForm.AddField("exp_in_mode", PlayerPrefs.GetString(key8, "{}"));
			Debug.Log("Level Up Analytics Event: " + Encoding.UTF8.GetString(wWWForm.data, 0, wWWForm.data.Length));
			WWW wWW = new WWW(URLs.Friends, wWWForm);
			currentExperience.Value -= MaxExpLevels[currentLevel];
			currentLevel++;
			Storager.setInt("currentLevel" + currentLevel, 1, true);
			PlayerPrefs.SetInt("currentLevel", currentLevel);
			Storager.setInt("currentExperience", currentExperience.Value, false);
			ShopNGUIController.SynchronizeAndroidPurchases("Current level: " + currentLevel);
			BankController.GiveInitialNumOfCoins();
			AddCurrenciesForLevelUP();
			FriendsController.sharedController.rank = currentLevel;
			FriendsController.sharedController.SendOurData(false);
		}
		if (Defs.isSoundFX)
		{
			NGUITools.PlaySound(exp_1);
		}
		if (ExpController.Instance != null)
		{
			if (Tierup != null)
			{
				ExpController.Instance.AddExperience(oldCurrentLevel, oldCurrentExperience, experience, exp_2, exp_3, Tierup);
			}
			else
			{
				ExpController.Instance.AddExperience(oldCurrentLevel, oldCurrentExperience, experience, exp_2, exp_3);
			}
		}
	}

	[Obfuscation(Exclude = true)]
	private void AnimAddExperience()
	{
		stepAnim++;
		if (stepAnim < 9)
		{
			Invoke("AnimAddExperience", 0.15f);
			return;
		}
		animAddExperience = false;
		if (oldCurrentLevel < currentLevel)
		{
			isShowNextPlashka = true;
			if (Defs.isSoundFX)
			{
				NGUITools.PlaySound(exp_3);
			}
		}
		else
		{
			isShowAdd = false;
			if (Defs.isSoundFX)
			{
				NGUITools.PlaySound(exp_2);
			}
		}
	}

	private void HideNextPlashka()
	{
		isShowNextPlashka = false;
		isShowAdd = false;
	}

	private void DoOnGUI()
	{
	}

	public static void SetEnable(bool enable)
	{
		if (!(sharedController == null))
		{
			sharedController.isShowRanks = enable;
		}
	}
}
