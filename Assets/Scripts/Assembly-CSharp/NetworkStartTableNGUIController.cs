using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using Rilisoft;
using UnityEngine;

public class NetworkStartTableNGUIController : MonoBehaviour
{
	public static NetworkStartTableNGUIController sharedController;

	public GameObject premiumPanel;

	public GameObject nonPremiumPanel;

	public Transform rentScreenPoint;

	public GameObject ranksInterface;

	public RanksTable ranksTable;

	public GameObject shopAnchor;

	public GameObject startInterfacePanel;

	public GameObject endInterfacePanel;

	public GameObject allInterfacePanel;

	public GameObject randomBtn;

	public GameObject avardPanel;

	public GameObject dayValorPanel;

	public UISprite dayValorCoins;

	public UISprite dayValorExp;

	public GameObject socialPnl;

	public GameObject spectratorModePnl;

	public GameObject spectatorModeBtnPnl;

	public GameObject spectatorModeOnBtn;

	public GameObject spectatorModeOffBtn;

	public UILabel avardCoinsLabel;

	public UILabel avardExpLabel;

	public UILabel winerLabel;

	public GameObject MapSelectPanel;

	public string winner;

	public UILabel HungerStartLabel;

	private int addCoins;

	private int addExperience;

	private bool isCancelHideAvardPanel;

	private bool updateRealTableAfterActionPanel = true;

	public GameObject SexualButton;

	public GameObject InAppropriateActButton;

	public GameObject OtherButton;

	public GameObject ReasonsPanel;

	public GameObject ActionPanel;

	public GameObject AddButton;

	public GameObject ReportButton;

	public string pixelbookID;

	public string nick;

	public GoMapInEndGame[] goMapInEndGameButtons;

	public int CountAddFriens;

	public UILabel totalBlue;

	public UILabel totalRed;

	private void Awake()
	{
		sharedController = this;
	}

	private void OnDestroy()
	{
		sharedController = null;
	}

	private void Start()
	{
		if (SexualButton != null)
		{
			ButtonHandler component = SexualButton.GetComponent<ButtonHandler>();
			if (component != null)
			{
				component.Clicked += SexualButtonHandler;
			}
		}
		if (InAppropriateActButton != null)
		{
			ButtonHandler component2 = InAppropriateActButton.GetComponent<ButtonHandler>();
			if (component2 != null)
			{
				component2.Clicked += InAppropriateActButtonHandler;
			}
		}
		if (OtherButton != null)
		{
			ButtonHandler component3 = OtherButton.GetComponent<ButtonHandler>();
			if (component3 != null)
			{
				component3.Clicked += OtherButtonHandler;
			}
		}
		if (ReportButton != null)
		{
			ButtonHandler component4 = ReportButton.GetComponent<ButtonHandler>();
			if (component4 != null)
			{
				component4.Clicked += ShowReasonPanel;
			}
		}
		if (AddButton != null)
		{
			ButtonHandler component5 = AddButton.GetComponent<ButtonHandler>();
			if (component5 != null)
			{
				component5.Clicked += AddButtonHandler;
			}
		}
	}

	private void Update()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			if (ReasonsPanel != null && ReasonsPanel.activeInHierarchy)
			{
				Input.ResetInputAxes();
				BackFromReasonPanel();
			}
			else if (ActionPanel != null && ActionPanel.activeInHierarchy)
			{
				Input.ResetInputAxes();
				CancelFromActionPanel();
			}
			else if (BankController.Instance.InterfaceEnabled)
			{
				Input.ResetInputAxes();
				BankController.Instance.InterfaceEnabled = false;
			}
			else if (ShopNGUIController.GuiActive && WeaponManager.sharedManager != null && WeaponManager.sharedManager.myTable != null)
			{
				WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().HandleResumeFromShop();
			}
		}
		else if ((Defs.isHunger || Defs.isRegimVidosDebug) && spectatorModeBtnPnl.activeSelf && GameObject.FindGameObjectsWithTag("Player").Length == 0)
		{
			spectatorModeBtnPnl.SetActive(false);
			spectratorModePnl.SetActive(false);
			ShowTable(false);
		}
	}

	public void ShowActionPanel(string _pixelbookID, string _nick)
	{
		pixelbookID = _pixelbookID;
		nick = _nick;
		HideTable();
		ActionPanel.SetActive(true);
		spectatorModeBtnPnl.SetActive(false);
		if (IsShowAdd(pixelbookID) && CountAddFriens < 3)
		{
			AddButton.GetComponent<UIButton>().isEnabled = true;
		}
		else
		{
			AddButton.GetComponent<UIButton>().isEnabled = false;
		}
	}

	public void HideActionPanel()
	{
		ActionPanel.SetActive(false);
		ShowTable(updateRealTableAfterActionPanel);
		if ((Defs.isHunger || Defs.isRegimVidosDebug) && GameObject.FindGameObjectsWithTag("Player").Length > 0)
		{
			spectatorModeBtnPnl.SetActive(true);
		}
	}

	public void ShowReasonPanel(object sender, EventArgs e)
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !ShopNGUIController.GuiActive && !ExperienceController.sharedController.isShowNextPlashka)
		{
			Debug.Log("ShowReasonPanel");
			ReasonsPanel.SetActive(true);
			ActionPanel.SetActive(false);
		}
	}

	public void HideReasonPanel()
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !ShopNGUIController.GuiActive && !ExperienceController.sharedController.isShowNextPlashka)
		{
			ReasonsPanel.SetActive(false);
			ActionPanel.SetActive(true);
		}
	}

	public bool CheckHideInternalPanel()
	{
		if (ActionPanel.activeInHierarchy)
		{
			CancelFromActionPanel();
			return true;
		}
		if (ReasonsPanel.activeInHierarchy)
		{
			BackFromReasonPanel();
			return true;
		}
		return false;
	}

	public void AddButtonHandler(object sender, EventArgs e)
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !ShopNGUIController.GuiActive && !ExperienceController.sharedController.isShowNextPlashka)
		{
			Debug.Log("add " + pixelbookID);
			CountAddFriens++;
			FriendsController.sharedController.SendInvitation(pixelbookID);
			if (!FriendsController.sharedController.notShowAddIds.Contains(pixelbookID))
			{
				FriendsController.sharedController.notShowAddIds.Add(pixelbookID);
			}
			AddButton.GetComponent<UIButton>().isEnabled = false;
		}
	}

	public void CancelFromActionPanel()
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !ShopNGUIController.GuiActive && !ExperienceController.sharedController.isShowNextPlashka)
		{
			HideActionPanel();
		}
	}

	public void BackFromReasonPanel()
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !ShopNGUIController.GuiActive && !ExperienceController.sharedController.isShowNextPlashka)
		{
			HideReasonPanel();
		}
	}

	public void InAppropriateActButtonHandler(object sender, EventArgs e)
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !ShopNGUIController.GuiActive && !ExperienceController.sharedController.isShowNextPlashka)
		{
			Action handler = delegate
			{
				string text = Assembly.GetExecutingAssembly().GetName().Version.ToString();
				string text2 = string.Concat("mailto:", Defs.SupportMail, "?subject=INAPPROPRIATE ACT ", nick, "(", pixelbookID, ")&body=%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A------------%20DO NOT DELETE%20------------%0D%0AUTC%20Time:%20", DateTime.Now.ToString(), "%0D%0AGame:%20PixelGun3D%0D%0AVersion:%20", text, "%0D%0APlayerID:%20", FriendsController.sharedController.id, "%0D%0ACategory:%20INAPPROPRIATE ACT ", nick, "(", pixelbookID, ")%0D%0ADevice%20Type:%20", SystemInfo.deviceType, "%20", SystemInfo.deviceModel, "%0D%0AOS%20Version:%20", SystemInfo.operatingSystem, "%0D%0A------------------------");
				text2 = text2.Replace(" ", "%20");
				FlurryPluginWrapper.LogEventWithParameterAndValue("User Feedback", "Menu", "In Game Menu_inappropriate");
				Application.OpenURL(text2);
			};
			FeedbackMenuController.ShowDialogWithCompletion(handler);
		}
	}

	public void SexualButtonHandler(object sender, EventArgs e)
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !ShopNGUIController.GuiActive && !ExperienceController.sharedController.isShowNextPlashka)
		{
			Action handler = delegate
			{
				string text = Assembly.GetExecutingAssembly().GetName().Version.ToString();
				string text2 = string.Concat("mailto:", Defs.SupportMail, "?subject=CHEATING ", nick, "(", pixelbookID, ")&body=%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A------------%20DO NOT DELETE%20------------%0D%0AUTC%20Time:%20", DateTime.Now.ToString(), "%0D%0AGame:%20PixelGun3D%0D%0AVersion:%20", text, "%0D%0APlayerID:%20", FriendsController.sharedController.id, "%0D%0ACategory:%20CHEATING ", nick, "(", pixelbookID, ")%0D%0ADevice%20Type:%20", SystemInfo.deviceType, "%20", SystemInfo.deviceModel, "%0D%0AOS%20Version:%20", SystemInfo.operatingSystem, "%0D%0A------------------------");
				text2 = text2.Replace(" ", "%20");
				FlurryPluginWrapper.LogEventWithParameterAndValue("User Feedback", "Menu", "In Game Menu_cheater");
				Application.OpenURL(text2);
			};
			FeedbackMenuController.ShowDialogWithCompletion(handler);
		}
	}

	public void OtherButtonHandler(object sender, EventArgs e)
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !ShopNGUIController.GuiActive && !ExperienceController.sharedController.isShowNextPlashka)
		{
			Action handler = delegate
			{
				string text = Assembly.GetExecutingAssembly().GetName().Version.ToString();
				string text2 = string.Concat("mailto:", Defs.SupportMail, "?subject=Report ", nick, "(", pixelbookID, ")&body=%0D%0A%0D%0A%0D%0A%0D%0A%0D%0A------------%20DO NOT DELETE%20------------%0D%0AUTC%20Time:%20", DateTime.Now.ToString(), "%0D%0AGame:%20PixelGun3D%0D%0AVersion:%20", text, "%0D%0APlayerID:%20", FriendsController.sharedController.id, "%0D%0ACategory:%20Report ", nick, "(", pixelbookID, ")%0D%0ADevice%20Type:%20", SystemInfo.deviceType, "%20", SystemInfo.deviceModel, "%0D%0AOS%20Version:%20", SystemInfo.operatingSystem, "%0D%0A------------------------");
				text2 = text2.Replace(" ", "%20");
				FlurryPluginWrapper.LogEventWithParameterAndValue("User Feedback", "Menu", "In Game Menu_other");
				Application.OpenURL(text2);
			};
			FeedbackMenuController.ShowDialogWithCompletion(handler);
		}
	}

	public void StartSpectatorMode()
	{
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.aimPanel.SetActive(true);
		}
		spectatorModeOnBtn.SetActive(true);
		spectatorModeOffBtn.SetActive(false);
		spectratorModePnl.SetActive(true);
		socialPnl.SetActive(false);
		MapSelectPanel.SetActive(false);
		HideTable();
		if (WeaponManager.sharedManager.myTable != null)
		{
			WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().isRegimVidos = true;
		}
	}

	public void EndSpectatorMode()
	{
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.aimPanel.SetActive(false);
		}
		spectatorModeOnBtn.SetActive(false);
		spectatorModeOffBtn.SetActive(true);
		spectratorModePnl.SetActive(false);
		MapSelectPanel.SetActive(true);
		if (WeaponManager.sharedManager.myTable != null)
		{
			WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().isRegimVidos = false;
		}
		ShowTable(true);
	}

	public void ShowAvardPanel()
	{
		avardPanel.SetActive(true);
	}

	[Obfuscation(Exclude = true)]
	public void HideAvardPanel()
	{
		if (!isCancelHideAvardPanel)
		{
			avardPanel.SetActive(false);
			if (addExperience > 0)
			{
				ExperienceController.sharedController.addExperience(addExperience);
			}
			ShowEndInterface(winner);
			if (WeaponManager.sharedManager.myTable != null)
			{
				WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().isShowAvard = false;
			}
			if (addCoins > 0)
			{
				int @int = Storager.getInt("Coins", false);
				Storager.setInt("Coins", @int + addCoins, false);
				FlurryEvents.LogCoinsGained(FlurryEvents.GetPlayingMode(), addCoins);
			}
			isCancelHideAvardPanel = true;
		}
	}

	public void showAvardPanel(string _winner, int _addCoin, int _addExpierence, bool _isCustom)
	{
		isCancelHideAvardPanel = false;
		if (_isCustom)
		{
			addCoins = 0;
			addExperience = 0;
		}
		else
		{
			addCoins = _addCoin;
			addExperience = _addExpierence;
		}
		avardCoinsLabel.text = string.Format("+ {0} {1}", _addCoin, LocalizationStore.Key_0275);
		avardExpLabel.text = string.Format("+ {0} {1}", _addExpierence, LocalizationStore.Key_0204);
		nonPremiumPanel.SetActive(true);
		ConnectSceneNGUIController.RegimGame regim = ConnectSceneNGUIController.regim;
		PremiumAccountController instance = PremiumAccountController.Instance;
		bool flag = regim == ConnectSceneNGUIController.RegimGame.Deathmatch || regim == ConnectSceneNGUIController.RegimGame.FlagCapture || regim == ConnectSceneNGUIController.RegimGame.TeamFight || regim == ConnectSceneNGUIController.RegimGame.CapturePoints;
		bool flag2 = PromoActionsManager.sharedManager.IsDayOfValorEventActive && flag;
		bool flag3 = (instance.IsActiveOrWasActiveBeforeStartMatch() && flag2) || instance.IsActiveOrWasActiveBeforeStartMatch();
		bool flag4 = flag2 && !instance.IsActiveOrWasActiveBeforeStartMatch();
		premiumPanel.SetActive(flag3);
		nonPremiumPanel.SetActive(!flag3);
		dayValorPanel.SetActive(flag4);
		if (flag3 || flag4)
		{
			int num = ((!Defs.isCOOP && !Defs.isHunger) ? AdminSettingsController.GetMultiplyerRewardWithBoostEvent(false) : PremiumAccountController.Instance.RewardCoeff);
			if (num > 1)
			{
				dayValorExp.gameObject.SetActive(true);
				dayValorExp.spriteName = string.Format("{0}x", num);
			}
			int num2 = ((!Defs.isCOOP && !Defs.isHunger) ? AdminSettingsController.GetMultiplyerRewardWithBoostEvent(true) : PremiumAccountController.Instance.RewardCoeff);
			if (num2 > 1)
			{
				dayValorCoins.gameObject.SetActive(true);
				dayValorCoins.spriteName = string.Format("{0}x", num2);
			}
		}
		if (_addCoin == 0)
		{
			avardCoinsLabel.gameObject.SetActive(false);
			dayValorCoins.gameObject.SetActive(false);
			avardExpLabel.transform.localPosition = new Vector3(avardExpLabel.transform.localPosition.x, -53f, avardExpLabel.transform.localPosition.z);
			dayValorExp.transform.localPosition = new Vector3(dayValorExp.transform.localPosition.x, -53f, dayValorExp.transform.localPosition.z);
		}
		else
		{
			avardCoinsLabel.gameObject.SetActive(true);
			avardExpLabel.transform.localPosition = new Vector3(avardExpLabel.transform.localPosition.x, -98f, avardExpLabel.transform.localPosition.z);
			dayValorExp.transform.localPosition = new Vector3(dayValorExp.transform.localPosition.x, -98f, dayValorExp.transform.localPosition.z);
		}
		avardPanel.SetActive(true);
		endInterfacePanel.SetActive(true);
		MapSelectPanel.SetActive(false);
		socialPnl.SetActive(BuildSettings.BuildTarget != BuildTarget.WP8Player);
		winerLabel.gameObject.SetActive(true);
		winner = _winner;
		winerLabel.text = winner;
		Invoke("HideAvardPanel", 15f);
	}

	public void ShowStartInterface()
	{
		allInterfacePanel.SetActive(true);
		startInterfacePanel.SetActive(true);
		ShowTable(true);
	}

	public void HideStartInterface()
	{
		Debug.Log("HideStartInterface");
		allInterfacePanel.SetActive(false);
		startInterfacePanel.SetActive(false);
		ReasonsPanel.SetActive(false);
		ActionPanel.SetActive(false);
		updateRealTableAfterActionPanel = true;
		HideTable();
	}

	public void ShowEndInterface(string _winner)
	{
		if (Defs.isMulti)
		{
			MapSelectPanel.SetActive(true);
		}
		startInterfacePanel.SetActive(false);
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.aimPanel.SetActive(false);
		}
		endInterfacePanel.SetActive(true);
		socialPnl.SetActive(BuildSettings.BuildTarget != BuildTarget.WP8Player);
		winerLabel.gameObject.SetActive(true);
		winner = _winner;
		winerLabel.text = winner;
		allInterfacePanel.SetActive(true);
		ranksTable.UpdateRanksFromOldSpisok();
		if (Defs.isHunger || Defs.isRegimVidosDebug)
		{
			if (Defs.isHunger)
			{
				randomBtn.SetActive(true);
			}
			spectatorModeBtnPnl.SetActive(true);
			updateRealTableAfterActionPanel = (_winner.Equals(string.Empty) ? true : false);
			if (!ActionPanel.activeSelf && !ReasonsPanel.activeSelf)
			{
				ShowTable(string.IsNullOrEmpty(_winner));
			}
		}
		else
		{
			updateRealTableAfterActionPanel = false;
			ShowTable(false);
		}
		StartCoroutine("TryToShowExpiredBanner");
	}

	private IEnumerator TryToShowExpiredBanner()
	{
		while (FriendsController.sharedController == null || TempItemsController.sharedController == null)
		{
			yield return null;
		}
		while (true)
		{
			yield return StartCoroutine(FriendsController.sharedController.MyWaitForSeconds(1f));
			try
			{
				if (!ShopNGUIController.GuiActive && (!(BankController.Instance != null) || !BankController.Instance.InterfaceEnabled) && (!(ExpController.Instance != null) || !ExpController.Instance.WaitingForLevelUpView) && (!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && rentScreenPoint.childCount == 0 && (Storager.getInt(Defs.PremiumEnabledFromServer, false) != 1 || !ShopNGUIController.ShowPremimAccountExpiredIfPossible(rentScreenPoint, "NGUITable", string.Empty)))
				{
					ShopNGUIController.ShowTempItemExpiredIfPossible(rentScreenPoint, "NGUITable");
				}
			}
			catch (Exception e)
			{
				Debug.LogWarning("exception in NetworkTableNGUI  TryToShowExpiredBanner: " + e);
			}
		}
	}

	public void HideEndInterface()
	{
		Debug.Log("HideEndInterface");
		winerLabel.gameObject.SetActive(true);
		socialPnl.SetActive(false);
		winerLabel.gameObject.SetActive(false);
		allInterfacePanel.SetActive(false);
		endInterfacePanel.SetActive(false);
		HideTable();
		ReasonsPanel.SetActive(false);
		ActionPanel.SetActive(false);
		updateRealTableAfterActionPanel = true;
		StopCoroutine("TryToShowExpiredBanner");
	}

	private void ShowTable(bool _isRealUpdate = true)
	{
		ranksTable.isShowRanks = _isRealUpdate;
		ranksTable.tekPanel.SetActive(true);
	}

	private void HideTable()
	{
		ranksTable.isShowRanks = false;
		ranksTable.tekPanel.SetActive(false);
	}

	public void ShowRanksTable()
	{
		ShowTable(true);
		ranksInterface.SetActive(true);
	}

	public void HideRanksTable(bool isHideTable = true)
	{
		if (isHideTable)
		{
			HideTable();
		}
		ranksInterface.SetActive(false);
	}

	public void BackPressFromRanksTable(bool isHideTable = true)
	{
		if (!CheckHideInternalPanel())
		{
			HideRanksTable(isHideTable);
			ReasonsPanel.SetActive(false);
			ActionPanel.SetActive(false);
			if (WeaponManager.sharedManager.myPlayerMoveC != null)
			{
				WeaponManager.sharedManager.myPlayerMoveC.BackRanksPressed();
			}
		}
	}

	public bool IsShowAdd(string _pixelBookID)
	{
		bool result = true;
		if (string.IsNullOrEmpty(_pixelBookID) || _pixelBookID.Equals("0") || _pixelBookID.Equals("-1") || _pixelBookID.Equals(FriendsController.sharedController.id) || !Defs2.IsAvalibleAddFrends() || string.IsNullOrEmpty(FriendsController.sharedController.id))
		{
			return false;
		}
		foreach (Dictionary<string, string> friend in FriendsController.sharedController.friends)
		{
			if (friend["friend"].Equals(_pixelBookID))
			{
				result = false;
			}
		}
		foreach (Dictionary<string, string> invitesFromU in FriendsController.sharedController.invitesFromUs)
		{
			if (invitesFromU["friend"].Equals(_pixelBookID))
			{
				result = false;
			}
		}
		foreach (string notShowAddId in FriendsController.sharedController.notShowAddIds)
		{
			if (notShowAddId.Equals(_pixelBookID))
			{
				result = false;
			}
		}
		return result;
	}

	public void UpdateGoMapButtons()
	{
		int[] array = new int[3]
		{
			UnityEngine.Random.Range(0, ConnectSceneNGUIController.masUseMaps.Length),
			UnityEngine.Random.Range(0, ConnectSceneNGUIController.masUseMaps.Length),
			UnityEngine.Random.Range(0, ConnectSceneNGUIController.masUseMaps.Length)
		};
		while (Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[0]].ToString()].Equals(Application.loadedLevelName) || (Defs.PremiumMaps.ContainsKey(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[0]].ToString()]) && Storager.getInt(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[0]].ToString()] + "Key", true) == 0 && !PremiumAccountController.MapAvailableDueToPremiumAccount(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[0]].ToString()])))
		{
			array[0]++;
			if (array[0] > ConnectSceneNGUIController.masUseMaps.Length - 1)
			{
				array[0] = 0;
			}
		}
		while (array[1] == array[0] || Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[1]].ToString()].Equals(Application.loadedLevelName) || (Defs.PremiumMaps.ContainsKey(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[1]].ToString()]) && Storager.getInt(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[1]].ToString()] + "Key", true) == 0 && !PremiumAccountController.MapAvailableDueToPremiumAccount(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[1]].ToString()])))
		{
			array[1]++;
			if (array[1] > ConnectSceneNGUIController.masUseMaps.Length - 1)
			{
				array[1] = 0;
			}
		}
		while (array[2] == array[0] || array[2] == array[1] || Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[2]].ToString()].Equals(Application.loadedLevelName) || (Defs.PremiumMaps.ContainsKey(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[2]].ToString()]) && Storager.getInt(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[2]].ToString()] + "Key", true) == 0 && !PremiumAccountController.MapAvailableDueToPremiumAccount(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[2]].ToString()])))
		{
			array[2]++;
			if (array[2] > ConnectSceneNGUIController.masUseMaps.Length - 1)
			{
				array[2] = 0;
			}
		}
		goMapInEndGameButtons[0].SetMap(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[0]].ToString()]);
		goMapInEndGameButtons[1].SetMap(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[1]].ToString()]);
		goMapInEndGameButtons[2].SetMap(Defs.levelNamesFromNums[ConnectSceneNGUIController.masUseMaps[array[2]].ToString()]);
	}
}
