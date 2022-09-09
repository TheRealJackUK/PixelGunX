using System;
using System.Collections;
using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

public sealed class FriendsGUIController : MonoBehaviour, IFriendsGUIController
{
	public static Action UpdaeOnlineEvent;

	public GameObject multyButton;

	public GameObject receivingPlashka;

	public UIWrapContent friendsGrid;

	public UIGrid invitationsGrid;

	public UIGrid sentInvitationsGrid;

	public UIGrid ClanInvitationsGrid;

	public LeaderboardsView leaderboardsView;

	public UIPanel friendsPanel;

	public UIPanel inboxPanel;

	public UIPanel friendProfilePanel;

	public UIPanel facebookFriensPanel;

	public UIPanel bestPlayersPanel;

	public GameObject fon;

	public GameObject newMEssage;

	public GameObject canAddLAbel;

	private float timeOfLastSort;

	public static bool ShowProfile;

	private bool invitationsInitialized;

	private FriendProfileController _friendProfileController;

	private LeaderboardsController _leaderboardsController;

	void IFriendsGUIController.Hide(bool h)
	{
		friendsPanel.gameObject.SetActive(!h);
		fon.SetActive(!h);
		ShowProfile = h;
	}

	public static void RaiseUpdaeOnlineEvent()
	{
		if (UpdaeOnlineEvent != null)
		{
			UpdaeOnlineEvent();
		}
	}

	public void HandleProfileButton()
	{
		if (!(ProfileController.Instance != null))
		{
			return;
		}
		IFriendsGUIController hidable = this;
		hidable.Hide(true);
		ProfileController.Instance.ShowInterface(delegate
		{
			if (ExperienceController.sharedController != null && ExpController.Instance != null)
			{
				ExperienceController.sharedController.isShowRanks = false;
				ExpController.Instance.InterfaceEnabled = false;
			}
			hidable.Hide(false);
		});
	}

	public void ShowBestPlayers(bool h)
	{
		friendsPanel.gameObject.SetActive(!h);
		leaderboardsView.gameObject.SetActive(h);
	}

	public void RequestLeaderboards()
	{
		if (_leaderboardsController != null)
		{
			_leaderboardsController.RequestLeaderboards();
		}
	}

	public void MultyButtonHandler(object sender, EventArgs e)
	{
		if (Defs.isTrainingFlag)
		{
			Defs.isFlag = false;
			Defs.isCOOP = false;
			Defs.isMulti = false;
			Defs.isHunger = false;
			Defs.isCompany = false;
			Defs.IsSurvival = false;
			GlobalGameController.Score = 0;
			GlobalGameController.InsideTraining = true;
			WeaponManager.sharedManager.Reset(0);
			Application.LoadLevel("CampaignLoading");
		}
		else
		{
			Defs.isFlag = false;
			Defs.isCOOP = false;
			Defs.isMulti = true;
			Defs.isHunger = false;
			Defs.isCompany = false;
			Defs.IsSurvival = false;
			Defs.isFlag = false;
			FlurryPluginWrapper.LogDeathmatchModePress();
			MenuBackgroundMusic.keepPlaying = true;
			LoadConnectScene.textureToShow = null;
			LoadConnectScene.sceneToLoad = "ConnectScene";
			FlurryPluginWrapper.LogEvent("Launch_Multiplayer");
			LoadConnectScene.noteToShow = null;
			Application.LoadLevel(Defs.PromSceneName);
		}
	}

	private void Start()
	{
		StoreKitEventListener.State.Mode = "Friends";
		StoreKitEventListener.State.PurchaseKey = "In friends";
		StoreKitEventListener.State.Parameters.Clear();
		if (multyButton != null)
		{
			if (!ProtocolListGetter.currentVersionIsSupported)
			{
				multyButton.gameObject.SetActive(false);
			}
			else
			{
				ButtonHandler component = multyButton.GetComponent<ButtonHandler>();
				if (component != null)
				{
					component.Clicked += MultyButtonHandler;
				}
			}
		}
		timeOfLastSort = Time.realtimeSinceStartup;
		Defs.ProfileFromFriends = 0;
		_friendProfileController = new FriendProfileController(this);
		if (leaderboardsView != null && _leaderboardsController == null)
		{
			_leaderboardsController = leaderboardsView.gameObject.AddComponent<LeaderboardsController>();
			_leaderboardsController.LeaderboardsView = leaderboardsView;
			_leaderboardsController.FriendsGuiController = this;
			_leaderboardsController.PlayerId = Storager.getString("AccountCreated", false);
		}
		FriendsController.sharedController.StartRefreshingOnline();
		StartCoroutine(SortFriendPreviewsAfterDelay());
	}

	private void OnEnable()
	{
		FriendsController.FriendsUpdated += UpdateGUI;
		StartCoroutine(__UpdateGUI());
	}

	public void UpdateGUI()
	{
		StartCoroutine(__UpdateGUI());
	}

	private IEnumerator SortFriendPreviewsAfterDelay()
	{
		yield return null;
		yield return null;
		_SortFriendPreviews();
	}

	private void _SortFriendPreviews()
	{
		FriendPreview[] componentsInChildren = friendsGrid.GetComponentsInChildren<FriendPreview>(true);
		FriendPreview[] array = friendsGrid.GetComponentsInChildren<FriendPreview>(false);
		if (array == null)
		{
			array = new FriendPreview[0];
		}
		Array.Sort(array, (FriendPreview fp1, FriendPreview fp2) => fp1.name.CompareTo(fp2.name));
		string text = null;
		float num = 0f;
		if (array.Length > 0)
		{
			text = array[0].gameObject.name;
			Transform parent = friendsGrid.transform.parent;
			if (parent != null)
			{
				UIPanel component = parent.GetComponent<UIPanel>();
				if (component != null)
				{
					num = array[0].transform.localPosition.x - component.clipOffset.x;
				}
			}
		}
		Array.Sort(componentsInChildren, delegate(FriendPreview fp1, FriendPreview fp2)
		{
			if (fp1.id == null || !FriendsController.sharedController.onlineInfo.ContainsKey(fp1.id))
			{
				return 1;
			}
			if (fp2.id == null || !FriendsController.sharedController.onlineInfo.ContainsKey(fp2.id))
			{
				return -1;
			}
			string s = FriendsController.sharedController.onlineInfo[fp1.id]["delta"];
			string s2 = FriendsController.sharedController.onlineInfo[fp1.id]["game_mode"];
			int num3 = int.Parse(s);
			int num4 = int.Parse(s2);
			int num5 = (((float)num3 > FriendsController.onlineDelta || (num4 > 99 && num4 / 100 != (int)ConnectSceneNGUIController.myPlatformConnect && num4 / 100 != 3)) ? 2 : ((num4 == -1) ? 1 : 0));
			string s3 = FriendsController.sharedController.onlineInfo[fp2.id]["delta"];
			string s4 = FriendsController.sharedController.onlineInfo[fp2.id]["game_mode"];
			int num6 = int.Parse(s3);
			int num7 = int.Parse(s4);
			int num8 = (((float)num6 > FriendsController.onlineDelta || (num7 > 99 && num7 / 100 != (int)ConnectSceneNGUIController.myPlatformConnect && num7 / 100 != 3)) ? 2 : ((num7 <= -1) ? 1 : 0));
			int result;
			int result2;
			return (num5 == num8 && int.TryParse(fp1.id, out result) && int.TryParse(fp2.id, out result2)) ? (result - result2) : (num5 - num8);
		});
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].gameObject.name = i.ToString("D7");
		}
		friendsGrid.SortAlphabetically();
		friendsGrid.WrapContent();
		Transform transform = null;
		if (text != null)
		{
			FriendPreview[] array2 = componentsInChildren;
			foreach (FriendPreview friendPreview in array2)
			{
				if (friendPreview.name.Equals(text))
				{
					transform = friendPreview.transform;
					break;
				}
			}
		}
		if (transform == null && componentsInChildren.Length > 0 && friendsGrid.gameObject.activeInHierarchy)
		{
			transform = componentsInChildren[0].transform;
		}
		if (transform != null)
		{
			float num2 = transform.localPosition.x - num;
			Transform parent2 = friendsGrid.transform.parent;
			if (parent2 != null)
			{
				UIPanel component2 = parent2.GetComponent<UIPanel>();
				if (component2 != null)
				{
					component2.clipOffset = new Vector2(num2, component2.clipOffset.y);
					parent2.localPosition = new Vector3(0f - num2, parent2.localPosition.y, parent2.localPosition.z);
				}
			}
		}
		friendsGrid.WrapContent();
	}

	private IEnumerator __UpdateGUI()
	{
		FriendPreview[] fps = friendsGrid.GetComponentsInChildren<FriendPreview>(true);
		Invitation[] invs = invitationsGrid.GetComponentsInChildren<Invitation>(true);
		Invitation[] sentInvs = sentInvitationsGrid.GetComponentsInChildren<Invitation>(true);
		Invitation[] clanInvs = ClanInvitationsGrid.GetComponentsInChildren<Invitation>(true);
		List<Invitation> clanInvtoRemove = new List<Invitation>();
		List<string> existingClanInvs = new List<string>();
		Invitation[] array = clanInvs;
		foreach (Invitation i in array)
		{
			bool found = false;
			foreach (Dictionary<string, string> ClanInv in FriendsController.sharedController.ClanInvites)
			{
			}
			if (!found)
			{
				clanInvtoRemove.Add(i);
			}
			else if (i.id != null)
			{
				existingClanInvs.Add(i.id);
			}
		}
		foreach (Invitation inv3 in clanInvtoRemove)
		{
			inv3.transform.parent = null;
			UnityEngine.Object.Destroy(inv3.gameObject);
		}
		foreach (Dictionary<string, string> ClanInv2 in FriendsController.sharedController.ClanInvites)
		{
			if (!existingClanInvs.Contains(ClanInv2["id"]))
			{
				GameObject f4 = UnityEngine.Object.Instantiate(Resources.Load("Invitation") as GameObject) as GameObject;
				f4.transform.parent = ClanInvitationsGrid.transform;
				f4.transform.localScale = new Vector3(1f, 1f, 1f);
				f4.GetComponent<Invitation>().IsClanInv = true;
				if (ClanInv2.ContainsKey("id"))
				{
					f4.GetComponent<Invitation>().id = ClanInv2["id"];
					f4.GetComponent<Invitation>().recordId = ClanInv2["id"];
				}
				if (ClanInv2.ContainsKey("name"))
				{
					f4.GetComponent<Invitation>().nm.text = ClanInv2["name"];
				}
				string clanLogo;
				if (ClanInv2.TryGetValue("logo", out clanLogo) && !string.IsNullOrEmpty(clanLogo))
				{
					f4.GetComponent<Invitation>().clanLogoString = clanLogo;
				}
			}
		}
		List<Invitation> sentInvtoRemove = new List<Invitation>();
		List<string> existingSentInvs = new List<string>();
		Invitation[] array2 = sentInvs;
		foreach (Invitation j in array2)
		{
			bool found2 = false;
			foreach (Dictionary<string, string> friend in FriendsController.sharedController.invitesFromUs)
			{
				string _id;
				if (!friend.TryGetValue("friend", out _id) || !_id.Equals(j.id))
				{
					UnityEngine.Debug.LogWarning("updategui friend continue");
					UnityEngine.Debug.LogWarning("updategui friend trygetvalue " + !friend.TryGetValue("friend", out _id));
					continue;
				}
				found2 = true;
				if (FriendsController.sharedController.playersInfo.ContainsKey(_id))
				{
					UnityEngine.Debug.LogWarning("updategui friend nick " + (FriendsController.sharedController.playersInfo[_id]["player"] as Dictionary<string, object>)["nick"] as string);
					j.nm.text = (FriendsController.sharedController.playersInfo[_id]["player"] as Dictionary<string, object>)["nick"] as string;
				}
				break;
			}
			if (!found2)
			{
				sentInvtoRemove.Add(j);
			}
			else if (j.id != null)
			{
				existingSentInvs.Add(j.id);
			}
		}
		foreach (Invitation inv2 in sentInvtoRemove)
		{
			inv2.transform.parent = null;
			UnityEngine.Object.Destroy(inv2.gameObject);
		}
		foreach (Dictionary<string, string> friend6 in FriendsController.sharedController.invitesFromUs)
		{
			if (!existingSentInvs.Contains(friend6["friend"]))
			{
				GameObject f3 = UnityEngine.Object.Instantiate(Resources.Load("SentInvitation") as GameObject) as GameObject;
				f3.transform.parent = sentInvitationsGrid.transform;
				f3.transform.localScale = new Vector3(1f, 1f, 1f);
				f3.GetComponent<Invitation>().id = friend6["friend"];
				f3.GetComponent<Invitation>().recordId = friend6["id"];
				if (FriendsController.sharedController.playersInfo.ContainsKey(friend6["friend"]))
				{
					f3.GetComponent<Invitation>().nm.text = (FriendsController.sharedController.playersInfo[friend6["friend"]]["player"] as Dictionary<string, object>)["nick"] as string;
				}
			}
		}
		List<Invitation> invtoRemove = new List<Invitation>();
		List<string> existingInvs = new List<string>();
		Invitation[] array3 = invs;
		foreach (Invitation k in array3)
		{
			bool found3 = false;
			foreach (Dictionary<string, string> friend2 in FriendsController.sharedController.invitesToUs)
			{
				string _id2;
				if (!friend2.TryGetValue("friend", out _id2) || !_id2.Equals(k.id))
				{
					continue;
				}
				found3 = true;
				if (FriendsController.sharedController.playersInfo.ContainsKey(_id2))
				{
					k.nm.text = (FriendsController.sharedController.playersInfo[_id2]["player"] as Dictionary<string, object>)["nick"] as string;
				}
				break;
			}
			if (!found3)
			{
				invtoRemove.Add(k);
			}
			else if (k.id != null)
			{
				existingInvs.Add(k.id);
			}
		}
		foreach (Invitation inv in invtoRemove)
		{
			inv.transform.parent = null;
			UnityEngine.Object.Destroy(inv.gameObject);
		}
		foreach (Dictionary<string, string> friend5 in FriendsController.sharedController.invitesToUs)
		{
			if (!existingInvs.Contains(friend5["friend"]))
			{
				GameObject f2 = UnityEngine.Object.Instantiate(Resources.Load("Invitation") as GameObject) as GameObject;
				f2.transform.parent = invitationsGrid.transform;
				f2.transform.localScale = new Vector3(1f, 1f, 1f);
				f2.GetComponent<Invitation>().id = friend5["friend"];
				f2.GetComponent<Invitation>().recordId = friend5["id"];
				if (FriendsController.sharedController.playersInfo.ContainsKey(friend5["friend"]))
				{
					f2.GetComponent<Invitation>().nm.text = (FriendsController.sharedController.playersInfo[friend5["friend"]]["player"] as Dictionary<string, object>)["nick"] as string;
				}
			}
		}
		List<FriendPreview> toRemove = new List<FriendPreview>();
		List<string> existingPreviews = new List<string>();
		FriendPreview[] array4 = fps;
		foreach (FriendPreview fp in array4)
		{
			bool found4 = false;
			foreach (Dictionary<string, string> friend3 in FriendsController.sharedController.friends)
			{
				string _id3;
				if (!friend3.TryGetValue("friend", out _id3) || !_id3.Equals(fp.id))
				{
					continue;
				}
				found4 = true;
				if (FriendsController.sharedController.playersInfo.ContainsKey(_id3))
				{
					fp.nm.text = (FriendsController.sharedController.playersInfo[_id3]["player"] as Dictionary<string, object>)["nick"] as string;
				}
				break;
			}
			if (!found4)
			{
				toRemove.Add(fp);
			}
			else if (fp.id != null)
			{
				existingPreviews.Add(fp.id);
			}
		}
		foreach (FriendPreview fp2 in toRemove)
		{
			fp2.transform.parent = null;
			UnityEngine.Object.Destroy(fp2.gameObject);
		}
		foreach (Dictionary<string, string> friend4 in FriendsController.sharedController.friends)
		{
			if (!existingPreviews.Contains(friend4["friend"]))
			{
				GameObject f = UnityEngine.Object.Instantiate(Resources.Load("Friend")) as GameObject;
				f.transform.parent = friendsGrid.transform;
				f.transform.localScale = new Vector3(1f, 1f, 1f);
				f.GetComponent<FriendPreview>().id = friend4["friend"];
				f.GetComponent<FriendPreview>().recordId = friend4["id"];
				if (FriendsController.sharedController.playersInfo.ContainsKey(friend4["friend"]))
				{
					f.GetComponent<FriendPreview>().nm.text = (FriendsController.sharedController.playersInfo[friend4["friend"]]["player"] as Dictionary<string, object>)["nick"] as string;
				}
			}
		}
		yield return null;
		invitationsGrid.Reposition();
		sentInvitationsGrid.Reposition();
		ClanInvitationsGrid.Reposition();
		timeOfLastSort = Time.realtimeSinceStartup;
		_SortFriendPreviews();
	}

	private void Update()
	{
		if (receivingPlashka != null && FriendsController.sharedController != null)
		{
			if ((friendsPanel != null && friendsPanel.gameObject.activeInHierarchy) || (inboxPanel != null && inboxPanel.gameObject.activeInHierarchy))
			{
				receivingPlashka.SetActive(FriendsController.sharedController.NumberOfFriendsRequests > 0);
				receivingPlashka.GetComponent<UILabel>().text = LocalizationStore.Key_0348;
			}
			else if (_friendProfileController != null && _friendProfileController.FriendProfileGo != null && _friendProfileController.FriendProfileGo.activeInHierarchy)
			{
				receivingPlashka.SetActive(FriendsController.sharedController.NumberOffFullInfoRequests > 0);
				receivingPlashka.GetComponent<UILabel>().text = LocalizationStore.Key_0348;
			}
			else if (leaderboardsView != null && leaderboardsView.gameObject.activeInHierarchy)
			{
				receivingPlashka.SetActive(FriendsController.sharedController.NumberOfBestPlayersRequests > 0);
				receivingPlashka.GetComponent<UILabel>().text = LocalizationStore.Key_0348;
			}
			else
			{
				receivingPlashka.SetActive(false);
			}
		}
		friendsGrid.transform.parent.GetComponent<UIScrollView>().enabled = friendsGrid.transform.childCount > 4;
		if (friendsGrid.transform.childCount > 0 && friendsGrid.transform.childCount <= 4)
		{
			float num = 0f;
			foreach (Transform item in friendsGrid.transform)
			{
				num += item.localPosition.x;
			}
			num /= (float)friendsGrid.transform.childCount;
			Transform parent = friendsGrid.transform.parent;
			if (parent != null)
			{
				UIPanel component = parent.GetComponent<UIPanel>();
				if (component != null)
				{
					component.clipOffset = new Vector2(num, component.clipOffset.y);
					parent.localPosition = new Vector3(0f - num, parent.localPosition.y, parent.localPosition.z);
				}
			}
		}
		if (Time.realtimeSinceStartup - timeOfLastSort > 10f)
		{
			if (UpdaeOnlineEvent != null)
			{
				UpdaeOnlineEvent();
			}
			timeOfLastSort = Time.realtimeSinceStartup;
			_SortFriendPreviews();
		}
		newMEssage.SetActive(FriendsController.sharedController.invitesToUs.Count > 0 || FriendsController.sharedController.ClanInvites.Count > 0);
		canAddLAbel.SetActive(FriendsController.sharedController.friends.Count == 0);
	}

	private void OnDisable()
	{
		FriendsController.FriendsUpdated -= UpdateGUI;
	}

	private void OnDestroy()
	{
		FriendsController.sharedController.StopRefreshingOnline();
		_friendProfileController.Dispose();
		ShowProfile = false;
	}
}
