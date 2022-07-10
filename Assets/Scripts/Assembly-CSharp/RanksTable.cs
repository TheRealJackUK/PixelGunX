using System.Collections.Generic;
using UnityEngine;

public class RanksTable : MonoBehaviour
{
	private const int maxCountInCommandPlusOther = 6;

	private bool isMulti;

	private bool isInet;

	private bool isCompany;

	private bool isCOOP;

	private bool isHunger;

	public GameObject panelRanks;

	public GameObject panelRanksTeam;

	public GameObject tekPanel;

	public UILabel[] namesPlayers;

	public UILabel[] scorePlayers;

	public UILabel[] namesPlayers1;

	public UILabel[] scorePlayers1;

	public UILabel[] namesPlayers2;

	public UILabel[] scorePlayers2;

	public GameObject[] skulls;

	public UISprite[] ranks;

	public UISprite[] ranks1;

	public UISprite[] ranks2;

	public UITexture[] clansLogo;

	public UITexture[] clansLogo1;

	public UITexture[] clansLogo2;

	public ActionInTableButton[] playersBut;

	private GameObject[] tabs;

	private List<GameObject> tabsBlue = new List<GameObject>();

	private List<GameObject> tabsRed = new List<GameObject>();

	private List<GameObject> tabsWhite = new List<GameObject>();

	public bool isShowRanks;

	public bool isShowTableStart;

	public bool isShowTableWin;

	public NetworkStartTable myNetworkStartTable;

	private string othersStr = "Others";

	public int totalBlue;

	public int totalRed;

	public int sumBlue;

	public int sumRed;

	private void Awake()
	{
		isMulti = Defs.isMulti;
		isInet = Defs.isInet;
		isCompany = Defs.isCompany;
		isCOOP = Defs.isCOOP;
		isHunger = Defs.isHunger;
		othersStr = LocalizationStore.Get("Key_1224");
	}

	private void Start()
	{
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints)
		{
			panelRanksTeam.SetActive(true);
			panelRanks.SetActive(false);
		}
		else
		{
			panelRanksTeam.SetActive(false);
			panelRanks.SetActive(true);
		}
	}

	private void Update()
	{
		if (isShowRanks || isShowTableStart)
		{
			ReloadTabsFromReal();
			UpdateRanksFromTabs();
		}
	}

	public void UpdateInfoFromMyTableWin()
	{
	}

	private void ReloadTabsFromReal()
	{
		tabs = GameObject.FindGameObjectsWithTag("NetworkTable");
		tabsBlue = new List<GameObject>();
		tabsRed = new List<GameObject>();
		tabsWhite = new List<GameObject>();
		for (int i = 1; i < tabs.Length; i++)
		{
			NetworkStartTable component = tabs[i].GetComponent<NetworkStartTable>();
			for (int j = 0; j < i; j++)
			{
				NetworkStartTable component2 = tabs[j].GetComponent<NetworkStartTable>();
				if ((!Defs.isFlag && (component.score > component2.score || (component.score == component2.score && component.CountKills > component2.CountKills))) || (Defs.isFlag && (component.CountKills > component2.CountKills || (component.CountKills == component2.CountKills && component.score > component2.score))))
				{
					GameObject gameObject = tabs[i];
					for (int num = i - 1; num >= j; num--)
					{
						tabs[num + 1] = tabs[num];
					}
					tabs[j] = gameObject;
					break;
				}
			}
		}
		if (ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.TeamFight && ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.FlagCapture && ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.CapturePoints)
		{
			return;
		}
		for (int k = 0; k < tabs.Length; k++)
		{
			if (tabs[k].GetComponent<NetworkStartTable>().myCommand == 1)
			{
				tabsBlue.Add(tabs[k]);
			}
			else if (tabs[k].GetComponent<NetworkStartTable>().myCommand == 2)
			{
				tabsRed.Add(tabs[k]);
			}
			else
			{
				tabsWhite.Add(tabs[k]);
			}
		}
	}

	private bool IsShowAdd(string _pixelBookID)
	{
		bool result = true;
		if (_pixelBookID.Equals("-1") || _pixelBookID.Equals(FriendsController.sharedController.id))
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

	private void UpdateRanksFromTabs()
	{
		if (Defs.isCompany)
		{
			if (WeaponManager.sharedManager.myPlayerMoveC != null)
			{
				totalBlue = WeaponManager.sharedManager.myPlayerMoveC.countKillsCommandBlue;
				totalRed = WeaponManager.sharedManager.myPlayerMoveC.countKillsCommandRed;
			}
			else
			{
				totalBlue = GlobalGameController.countKillsBlue;
				totalRed = GlobalGameController.countKillsRed;
			}
		}
		if (Defs.isFlag && WeaponManager.sharedManager.myNetworkStartTable != null)
		{
			totalBlue = WeaponManager.sharedManager.myNetworkStartTable.scoreCommandFlag1;
			totalRed = WeaponManager.sharedManager.myNetworkStartTable.scoreCommandFlag2;
		}
		if (Defs.isCapturePoints)
		{
			totalBlue = Mathf.RoundToInt(CapturePointController.sharedController.scoreBlue);
			totalRed = Mathf.RoundToInt(CapturePointController.sharedController.scoreRed);
		}
		bool flag = Defs2.IsAvalibleAddFrends();
		sumRed = 0;
		sumBlue = 0;
		bool flag2 = false;
		bool flag3 = false;
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints)
		{
			for (int i = 0; i < 6; i++)
			{
				if (i < tabsBlue.Count || (!flag2 && totalBlue != sumBlue))
				{
					if (i < tabsBlue.Count && i < 5)
					{
						NetworkStartTable component = tabsBlue[i].GetComponent<NetworkStartTable>();
						bool isMine = tabsBlue[i].Equals(WeaponManager.sharedManager.myTable);
						string text = Mathf.RoundToInt(component.CountKills).ToString();
						if (text.Equals("-1"))
						{
							text = "0";
						}
						string text2 = component.score.ToString();
						if (text2.Equals("-1"))
						{
							text2 = "0";
						}
						int num = int.Parse(text);
						sumBlue += num;
						string pixelbookID = component.pixelBookID.ToString();
						playersBut[i].UpdateState(true, isMine, 1, component.NamePlayer, text2, text, component.myRanks, component.myClanTexture, pixelbookID);
					}
					else if (ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.CapturePoints)
					{
						if (totalBlue > sumBlue)
						{
							totalBlue = sumBlue;
						}
						playersBut[i].UpdateState(true, false, 1, othersStr, string.Empty, (totalBlue - sumBlue).ToString(), -1, null, string.Empty);
						flag2 = true;
					}
					else
					{
						playersBut[i].UpdateState(false, false, 0, string.Empty, string.Empty, string.Empty, 1, null, string.Empty);
					}
				}
				else
				{
					playersBut[i].UpdateState(false, false, 0, string.Empty, string.Empty, string.Empty, 1, null, string.Empty);
				}
				if (i < tabsRed.Count || (!flag3 && totalRed != sumRed))
				{
					if (i < tabsRed.Count && i < 5)
					{
						NetworkStartTable component2 = tabsRed[i].GetComponent<NetworkStartTable>();
						bool isMine2 = tabsRed[i].Equals(WeaponManager.sharedManager.myTable);
						string text3 = component2.CountKills.ToString();
						if (text3.Equals("-1"))
						{
							text3 = "0";
						}
						string text4 = component2.score.ToString();
						if (text4.Equals("-1"))
						{
							text4 = "0";
						}
						int num2 = int.Parse(text3);
						sumRed += num2;
						string pixelbookID2 = component2.pixelBookID.ToString();
						playersBut[i + 6].UpdateState(true, isMine2, 2, component2.NamePlayer, text4, text3, component2.myRanks, component2.myClanTexture, pixelbookID2);
					}
					else if (ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.CapturePoints)
					{
						if (totalRed > sumRed)
						{
							totalRed = sumRed;
						}
						playersBut[i + 6].UpdateState(true, false, 2, othersStr, string.Empty, (totalRed - sumRed).ToString(), -1, null, string.Empty);
						flag3 = true;
					}
					else
					{
						playersBut[i].UpdateState(false, false, 0, string.Empty, string.Empty, string.Empty, 1, null, string.Empty);
					}
				}
				else
				{
					playersBut[i + 6].UpdateState(false, false, 0, string.Empty, string.Empty, string.Empty, 1, null, string.Empty);
				}
			}
			NetworkStartTableNGUIController.sharedController.totalBlue.text = totalBlue.ToString();
			NetworkStartTableNGUIController.sharedController.totalRed.text = totalRed.ToString();
			return;
		}
		for (int j = 0; j < 12; j++)
		{
			if (j < tabs.Length)
			{
				NetworkStartTable component3 = tabs[j].GetComponent<NetworkStartTable>();
				bool isMine3 = tabs[j].Equals(WeaponManager.sharedManager.myTable);
				string text5 = component3.CountKills.ToString();
				if (text5.Equals("-1"))
				{
					text5 = "0";
				}
				string text6 = component3.score.ToString();
				if (text6.Equals("-1"))
				{
					text6 = "0";
				}
				string pixelbookID3 = component3.pixelBookID.ToString();
				playersBut[j].UpdateState(true, isMine3, 0, component3.NamePlayer, text6, text5, component3.myRanks, component3.myClanTexture, pixelbookID3);
			}
			else
			{
				playersBut[j].UpdateState(false, false, 0, string.Empty, string.Empty, string.Empty, 1, null, string.Empty);
			}
		}
	}

	public void UpdateRanksFromOldSpisok()
	{
		bool flag = Defs2.IsAvalibleAddFrends();
		NetworkStartTable networkStartTable = ((!(WeaponManager.sharedManager.myTable != null)) ? null : WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>());
		if (networkStartTable == null)
		{
			return;
		}
		sumRed = 0;
		sumBlue = 0;
		bool flag2 = false;
		bool flag3 = false;
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints)
		{
			for (int i = 0; i < 6; i++)
			{
				if (i < networkStartTable.oldSpisokNameBlue.Length || (!flag2 && totalBlue != sumBlue))
				{
					if (i < networkStartTable.oldSpisokNameBlue.Length && i < 5)
					{
						bool isMine = networkStartTable.oldIndexMy == i && networkStartTable.myCommandOld == 1;
						string text = networkStartTable.oldCountLilsSpisokBlue[i];
						if (text.Equals("-1"))
						{
							text = "0";
						}
						string text2 = networkStartTable.oldScoreSpisokBlue[i];
						if (text2.Equals("-1"))
						{
							text2 = "0";
						}
						int num = int.Parse(text);
						sumBlue += num;
						string pixelbookID = networkStartTable.oldSpisokPixelBookIDBlue[i].ToString();
						playersBut[i].UpdateState(true, isMine, 1, networkStartTable.oldSpisokNameBlue[i], text2, text, networkStartTable.oldSpisokRanksBlue[i], networkStartTable.oldSpisokMyClanLogoBlue[i], pixelbookID);
					}
					else if (ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.CapturePoints)
					{
						playersBut[i].UpdateState(true, false, 1, othersStr, string.Empty, ((totalBlue <= sumBlue) ? sumBlue : (totalBlue - sumBlue)).ToString(), -1, null, string.Empty);
						flag2 = true;
					}
				}
				else
				{
					playersBut[i].UpdateState(false, false, 0, string.Empty, string.Empty, string.Empty, 1, null, string.Empty);
				}
				if (i < networkStartTable.oldSpisokNameRed.Length || (!flag3 && totalRed != sumRed))
				{
					if (i < networkStartTable.oldSpisokNameRed.Length && i < 5)
					{
						bool isMine2 = networkStartTable.oldIndexMy == i && networkStartTable.myCommandOld == 2;
						string text3 = networkStartTable.oldCountLilsSpisokRed[i];
						if (text3.Equals("-1"))
						{
							text3 = "0";
						}
						string text4 = networkStartTable.oldScoreSpisokRed[i];
						if (text4.Equals("-1"))
						{
							text4 = "0";
						}
						int num2 = int.Parse(text3);
						sumRed += num2;
						string pixelbookID2 = networkStartTable.oldSpisokPixelBookIDRed[i].ToString();
						playersBut[i + 6].UpdateState(true, isMine2, 2, networkStartTable.oldSpisokNameRed[i], text4, text3, networkStartTable.oldSpisokRanksRed[i], networkStartTable.oldSpisokMyClanLogoRed[i], pixelbookID2);
					}
					else if (ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.CapturePoints)
					{
						playersBut[i + 6].UpdateState(true, false, 2, othersStr, string.Empty, ((totalRed <= sumRed) ? sumRed : (totalRed - sumRed)).ToString(), -1, null, string.Empty);
						flag3 = true;
					}
				}
				else
				{
					playersBut[i + 6].UpdateState(false, false, 0, string.Empty, string.Empty, string.Empty, 1, null, string.Empty);
				}
			}
			if (ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.CapturePoints)
			{
				if (totalBlue > sumBlue)
				{
					totalBlue = sumBlue;
					NetworkStartTableNGUIController.sharedController.totalBlue.text = totalBlue.ToString();
				}
				if (totalRed > sumRed)
				{
					totalRed = sumRed;
					NetworkStartTableNGUIController.sharedController.totalRed.text = totalRed.ToString();
				}
			}
			return;
		}
		for (int j = 0; j < 12; j++)
		{
			if (j < networkStartTable.oldSpisokName.Length)
			{
				bool isMine3 = networkStartTable.oldIndexMy == j;
				string text5 = networkStartTable.oldCountLilsSpisok[j];
				if (text5.Equals("-1"))
				{
					text5 = "0";
				}
				string text6 = networkStartTable.oldScoreSpisok[j];
				if (text6.Equals("-1"))
				{
					text6 = "0";
				}
				string pixelbookID3 = networkStartTable.oldSpisokPixelBookID[j].ToString();
				playersBut[j].UpdateState(true, isMine3, 0, networkStartTable.oldSpisokName[j], text6, text5, networkStartTable.oldSpisokRanks[j], networkStartTable.oldSpisokMyClanLogo[j], pixelbookID3);
			}
			else
			{
				playersBut[j].UpdateState(false, false, 0, string.Empty, string.Empty, string.Empty, 1, null, string.Empty);
			}
		}
	}
}
