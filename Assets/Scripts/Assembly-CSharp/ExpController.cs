using System;
using System.Collections;
using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

public sealed class ExpController : MonoBehaviour
{
	public const int MaxLobbyLevel = 4;

	public ExpView experienceView;

	public static readonly int[] LevelsForTiers = new int[6] { 1, 7, 12, 17, 22, 27 };

	private static ExpController _instance;

	private bool _escapePressed;

	private bool _inAddingState;

	public static ExpController Instance
	{
		get
		{
			return _instance;
		}
	}

	public bool InAddingState
	{
		get
		{
			return _inAddingState;
		}
	}

	public bool InterfaceEnabled
	{
		get
		{
			return experienceView != null && experienceView.interfaceHolder != null && experienceView.interfaceHolder.gameObject.activeInHierarchy;
		}
		set
		{
			SetInterfaceEnabled(value);
		}
	}

	public static int LobbyLevel
	{
		get
		{
			if (Storager.getInt(Defs.LobbyLevelApplied, false) == 0)
			{
				return 4;
			}
			int result = 1;
			if (!Defs.isTrainingFlag)
			{
				result = 2;
				if (ExperienceController.sharedController != null)
				{
					int currentLevel = ExperienceController.sharedController.currentLevel;
					if (currentLevel >= 3)
					{
						result = 4;
					}
					else if (currentLevel >= 2)
					{
						result = 3;
					}
				}
			}
			return result;
		}
	}

	public bool IsLevelUpShown { get; private set; }

	public int Rank
	{
		set
		{
			if (!(experienceView == null))
			{
				int num = Mathf.Clamp(value, 1, ExperienceController.maxLevel);
				experienceView.RankSprite = num;
				experienceView.LevelLabel = FormatLevelLabel(num);
			}
		}
	}

	public bool WaitingForLevelUpView { get; private set; }

	public int OurTier
	{
		get
		{
			if (ExperienceController.sharedController != null)
			{
				int currentLevel = ExperienceController.sharedController.currentLevel;
				return TierForLevel(currentLevel);
			}
			return 0;
		}
	}

	private int Experience
	{
		set
		{
			if (!(experienceView == null) && !(ExperienceController.sharedController == null))
			{
				int num = ExperienceController.MaxExpLevels[ExperienceController.sharedController.currentLevel];
				int num2 = Mathf.Clamp(value, 0, num);
				experienceView.ExperienceLabel = FormatExperienceLabel(num2, num);
				float num3 = (float)num2 / (float)num;
				if (ExperienceController.sharedController.currentLevel == ExperienceController.maxLevel)
				{
					num3 = 1f;
				}
				experienceView.CurrentProgress = num3;
				experienceView.OldProgress = num3;
			}
		}
	}

	private void SetInterfaceEnabled(bool value)
	{
		if (InterfaceEnabled == value || !(experienceView != null) || !(experienceView.interfaceHolder != null))
		{
			return;
		}
		if (!value)
		{
			experienceView.StopAnimation();
			if (ExperienceController.sharedController != null)
			{
				Rank = ExperienceController.sharedController.currentLevel;
				Experience = ExperienceController.sharedController.CurrentExperience;
			}
		}
		experienceView.interfaceHolder.gameObject.SetActive(value);
		if (value && experienceView.experienceCamera != null)
		{
			AudioListener component = experienceView.experienceCamera.GetComponent<AudioListener>();
			if (component != null)
			{
				component.enabled = false;
			}
		}
	}

	public void HandleContinueButton(GameObject tierPanel)
	{
		if (WeaponManager.sharedManager != null)
		{
			WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(Application.loadedLevelName) ? Defs.filterMaps[Application.loadedLevelName] : 0);
		}
		HideTierPanel(tierPanel);
	}

	public void HandleShopButtonFromTierPanel(GameObject tierPanel)
	{
		StartCoroutine(HandleShopButtonFromTierPanelCoroutine(tierPanel));
	}

	public void HandleNewAvailableItem(GameObject tierPanel, NewAvailableItemInShop itemInfo)
	{
		if (CurrentFilterMap() != 0)
		{
			int[] target = new int[0];
			bool flag = true;
			if (itemInfo != null && itemInfo.tag != null)
			{
				flag = ItemDb.GetByTag(itemInfo.tag) != null;
				if (flag)
				{
					target = ItemDb.GetItemFilterMap(itemInfo.tag);
				}
			}
			if (flag && !target.Contains(CurrentFilterMap()))
			{
				HandleShopButtonFromTierPanel(tierPanel);
				return;
			}
		}
		if (ShopNGUIController.sharedShop == null)
		{
			Debug.LogWarning("ShopNGUIController.sharedShop == null");
		}
		else
		{
			if (!(itemInfo == null))
			{
				string text = itemInfo.tag ?? string.Empty;
				Debug.Log("Available item:   " + text + "    " + itemInfo.category);
				StartCoroutine(HandleShopButtonFromNewAvailableItemCoroutine(tierPanel, text, itemInfo.category));
				return;
			}
			Debug.LogWarning("itemInfo == null");
		}
		StartCoroutine(HandleShopButtonFromTierPanelCoroutine(tierPanel));
	}

	public static int CurrentFilterMap()
	{
		return Defs.filterMaps.ContainsKey(Application.loadedLevelName) ? Defs.filterMaps[Application.loadedLevelName] : 0;
	}

	private IEnumerator HandleShopButtonFromTierPanelCoroutine(GameObject tierPanel)
	{
		if (WeaponManager.sharedManager != null)
		{
			WeaponManager.sharedManager.Reset(CurrentFilterMap());
		}
		yield return null;
		ShopNGUIController.sharedShop.resumeAction = null;
		ShopNGUIController.GuiActive = true;
		yield return null;
		HideTierPanel(tierPanel);
	}

	private IEnumerator HandleShopButtonFromNewAvailableItemCoroutine(GameObject tierPanel, string itemTag, ShopNGUIController.CategoryNames category)
	{
		ShopNGUIController.sharedShop.SetOfferID(itemTag);
		ShopNGUIController.sharedShop.offerCategory = category;
		if (WeaponManager.sharedManager != null)
		{
			WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(Application.loadedLevelName) ? Defs.filterMaps[Application.loadedLevelName] : 0);
		}
		yield return null;
		ShopNGUIController.sharedShop.resumeAction = null;
		ShopNGUIController.GuiActive = true;
		yield return null;
		HideTierPanel(tierPanel);
	}

	public void Refresh()
	{
		if (ExperienceController.sharedController != null)
		{
			Rank = ExperienceController.sharedController.currentLevel;
			Experience = ExperienceController.sharedController.CurrentExperience;
		}
		if (experienceView != null)
		{
			experienceView.Refresh();
		}
	}

	public static int TierForLevel(int lev)
	{
		if (lev < LevelsForTiers[1])
		{
			return 0;
		}
		if (lev < LevelsForTiers[2])
		{
			return 1;
		}
		if (lev < LevelsForTiers[3])
		{
			return 2;
		}
		if (lev < LevelsForTiers[4])
		{
			return 3;
		}
		if (lev < LevelsForTiers[5])
		{
			return 4;
		}
		return 5;
	}

	public static int GetOurTier()
	{
		int currentLevelWithUpdateCorrection = ExperienceController.GetCurrentLevelWithUpdateCorrection();
		return TierForLevel(currentLevelWithUpdateCorrection);
	}

	public void AddExperience(int oldLevel, int oldExperience, int addend, AudioClip exp2, AudioClip levelup, AudioClip tierup = null)
	{
		if (experienceView == null || ExperienceController.sharedController == null)
		{
			return;
		}
		int num = oldExperience + addend;
		int num2 = ExperienceController.MaxExpLevels[oldLevel];
		if (num < num2)
		{
			float percentage = GetPercentage(num);
			experienceView.CurrentProgress = percentage;
			experienceView.StartBlinkingWithNewProgress();
			experienceView.WaitAndUpdateOldProgress(exp2);
			experienceView.ExperienceLabel = FormatExperienceLabel(num, num2);
			if (experienceView.currentProgress != null && !experienceView.currentProgress.gameObject.activeInHierarchy)
			{
				experienceView.OldProgress = percentage;
			}
		}
		else
		{
			float num3 = 1f;
			experienceView.CurrentProgress = num3;
			AudioClip sound = levelup;
			if (tierup != null && Array.IndexOf(LevelsForTiers, oldLevel + 1) > 0)
			{
				sound = tierup;
			}
			if (oldLevel < ExperienceController.maxLevel - 1)
			{
				experienceView.StartBlinkingWithNewProgress();
				int num4 = oldLevel + 1;
				int newExperience = num - num2;
				StartCoroutine(WaitAndUpdateExperience(num4, newExperience, ExperienceController.MaxExpLevels[num4], true, sound));
			}
			else if (oldLevel == ExperienceController.maxLevel - 1)
			{
				experienceView.StartBlinkingWithNewProgress();
				int num5 = oldLevel + 1;
				int newExperience2 = ExperienceController.MaxExpLevels[num5];
				StartCoroutine(WaitAndUpdateExperience(num5, newExperience2, ExperienceController.MaxExpLevels[num5], true, sound));
			}
			else
			{
				if (ExperienceController.sharedController.currentLevel == ExperienceController.maxLevel)
				{
					num3 = 1f;
				}
				experienceView.OldProgress = num3;
				experienceView.StartBlinkingWithNewProgress();
				int maxLevel = ExperienceController.maxLevel;
				int newExperience3 = ExperienceController.MaxExpLevels[maxLevel];
				StartCoroutine(WaitAndUpdateExperience(maxLevel, newExperience3, ExperienceController.MaxExpLevels[maxLevel], false, exp2));
			}
		}
		StartCoroutine(SetAddingState());
	}

	public bool IsRenderedWithCamera(Camera c)
	{
		return experienceView != null && experienceView.experienceCamera != null && experienceView.experienceCamera == c;
	}

	private string SubstituteTempGunIfReplaced(string constTg)
	{
		if (constTg == null)
		{
			return null;
		}
		KeyValuePair<string, string> keyValuePair = WeaponManager.replaceConstWithTemp.Find((KeyValuePair<string, string> kvp) => kvp.Key.Equals(constTg));
		if (keyValuePair.Key == null || keyValuePair.Value == null)
		{
			return constTg;
		}
		if (!TempItemsController.GunsMappingFromTempToConst.ContainsKey(keyValuePair.Value))
		{
			return keyValuePair.Value;
		}
		return constTg;
	}

	private IEnumerator WaitAndUpdateExperience(int newRank, int newExperience, int newBound, bool showLevelUpPanel, AudioClip sound)
	{
		experienceView.RankSprite = newRank;
		experienceView.LevelLabel = FormatLevelLabel(newRank);
		experienceView.ExperienceLabel = FormatExperienceLabel(newExperience, newBound);
		WaitingForLevelUpView = showLevelUpPanel;
		yield return new WaitForSeconds(1.2f);
		WaitingForLevelUpView = false;
		Experience = newExperience;
		if (showLevelUpPanel && ExperienceController.sharedController != null)
		{
			LevelUpWithOffers levelUpPanelToShow2 = null;
			List<string> itemsToShow = new List<string>();
			int i = Array.BinarySearch(LevelsForTiers, ExperienceController.sharedController.currentLevel);
			if (0 <= i && i < LevelsForTiers.Length)
			{
				switch (i)
				{
				case 1:
					itemsToShow = new List<string>
					{
						"Armor_Steel_1",
						"hat_Steel_1",
						SubstituteTempGunIfReplaced(WeaponTags.Tesla_Cannon_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.Solar_Power_Cannon_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.FreezeGunTag)
					};
					break;
				case 2:
					itemsToShow = new List<string>
					{
						"Armor_Royal_1",
						"hat_Royal_1",
						SubstituteTempGunIfReplaced(WeaponTags.DragonGun_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.LaserDiscThower_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.Hydra_Tag)
					};
					break;
				case 3:
					itemsToShow = new List<string>
					{
						"Armor_Almaz_1",
						"hat_Almaz_1",
						SubstituteTempGunIfReplaced(WeaponTags.Dark_Matter_Generator_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.ElectroBlastRifle_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.Photon_Pistol_Tag)
					};
					break;
				case 4:
					itemsToShow = new List<string>
					{
						SubstituteTempGunIfReplaced(WeaponTags.Assault_Machine_GunBuy_3_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.RailRevolverBuy_3_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.RayMinigun_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.Autoaim_RocketlauncherBuy_3_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.Impulse_Sniper_RifleBuy_3_Tag)
					};
					break;
				case 5:
					itemsToShow = new List<string>
					{
						SubstituteTempGunIfReplaced(WeaponTags.PX_3000_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.DualHawks_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.StormHammer_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.Sunrise_Tag),
						SubstituteTempGunIfReplaced(WeaponTags.Bastion_Tag)
					};
					break;
				}
				levelUpPanelToShow2 = ((i != 5) ? experienceView.levelUpPanelTier : experienceView.levelUpPanelEliteTier);
			}
			else
			{
				itemsToShow = GetNewItemsForNewLevel();
				levelUpPanelToShow2 = ((itemsToShow.Count <= 0) ? experienceView.levelUpPanelClear : experienceView.levelUpPanel);
			}
			int oldRank = Math.Max(0, newRank - 1);
			int reward = ExperienceController.sharedController.addCoinsFromLevels[oldRank];
			string totalCoins = Storager.getInt("Coins", false).ToString();
			int gemsReward = ExperienceController.sharedController.addGemsFromLevels[oldRank];
			string totalGems = Storager.getInt("GemsCurrency", false).ToString();
			experienceView.ShowLevelUpPanel(levelUpPanelToShow2, itemsToShow, newRank, reward, totalCoins, gemsReward, totalGems);
		}
		if (Defs.isSoundFX)
		{
			NGUITools.PlaySound(sound);
		}
	}

	private List<string> GetNewItemsForNewLevel()
	{
		string arm;
		string hat;
		List<string> list = PromoActionsGUIController.FilteredLevelUpPurchases(out arm, out hat);
		List<string> list2 = new List<string>();
		int num = 5;
		Debug.Log(("armor: " + arm) ?? "null");
		if (arm != null)
		{
			list2.Add(arm);
			num--;
		}
		Debug.Log(("hat: " + hat) ?? "null");
		if (hat != null)
		{
			list2.Add(hat);
			num--;
		}
		int num2 = Mathf.Min(list.Count, num);
		for (int i = 0; i < num2; i++)
		{
			list2.Add(list[i]);
		}
		return list2;
	}

	private IEnumerator SetAddingState()
	{
		_inAddingState = true;
		yield return new WaitForSeconds(1.2f);
		_inAddingState = false;
	}

	private static float GetPercentage(int experience)
	{
		if (ExperienceController.sharedController == null)
		{
			return 0f;
		}
		int num = ExperienceController.MaxExpLevels[ExperienceController.sharedController.currentLevel];
		int num2 = Mathf.Clamp(experience, 0, num);
		return (float)num2 / (float)num;
	}

	private static string FormatExperienceLabel(int xp, int bound)
	{
		string text = LocalizationStore.Get("Key_0928");
		string text2 = string.Format("{0} {1}/{2}", LocalizationStore.Get("Key_0204"), xp, bound);
		return (xp != bound && ExperienceController.sharedController.currentLevel != ExperienceController.maxLevel) ? text2 : text;
	}

	private static string FormatLevelLabel(int level)
	{
		return string.Format("{0} {1}", LocalizationStore.Key_0226, level);
	}

	private void OnGUI()
	{
		if (InterfaceEnabled && !(experienceView == null))
		{
			GUILayout.BeginArea(new Rect(0.25f * (float)Screen.width, 11f * Defs.Coef, 0.25f * (float)Screen.width, 0.25f * (float)Screen.height));
			if (ExperienceController.sharedController != null && Time.timeScale > 0f && DeveloperConsoleController.isDebugGuiVisible && GUI.Button(new Rect(0f, 0f, 96f * Defs.Coef, 48f * Defs.Coef), "Add Exp"))
			{
				int experience = Convert.ToInt32(3f * (float)ExperienceController.MaxExpLevels[ExperienceController.sharedController.currentLevel] / 11f);
				ExperienceController.sharedController.addExperience(experience);
			}
			GUILayout.EndArea();
		}
	}

	private void OnEnable()
	{
		if (ExperienceController.sharedController != null)
		{
			Rank = ExperienceController.sharedController.currentLevel;
			Experience = ExperienceController.sharedController.CurrentExperience;
		}
	}

	private void Awake()
	{
		if (!Application.loadedLevelName.EndsWith("Workbench"))
		{
			InterfaceEnabled = false;
		}
	}

	private void Start()
	{
		if (_instance != null)
		{
			Debug.LogWarning("ExpController is not null while starting.");
		}
		_instance = this;
	}

	private void OnDestroy()
	{
		_instance = null;
	}

	private void Update()
	{
		if (ExperienceController.sharedController != null)
		{
			SetInterfaceEnabled(ExperienceController.sharedController.isShowRanks);
		}
		if (_escapePressed)
		{
			_escapePressed = false;
		}
	}

	private void LateUpdate()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			_escapePressed = true;
		}
	}

	public static void ShowTierPanel(GameObject tierPanel)
	{
		if (tierPanel != null)
		{
			tierPanel.SetActive(true);
			if (Instance != null)
			{
				Instance.IsLevelUpShown = true;
			}
			MainMenuController.SetInputEnabled(false);
			LevelCompleteScript.SetInputEnabled(false);
		}
	}

	public static void HideTierPanel(GameObject tierPanel)
	{
		if (tierPanel != null)
		{
			tierPanel.SetActive(false);
			if (Instance != null)
			{
				Instance.IsLevelUpShown = false;
			}
			MainMenuController.SetInputEnabled(true);
			LevelCompleteScript.SetInputEnabled(true);
		}
	}
}
