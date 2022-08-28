using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

internal sealed class MenuLeaderboardsController : MonoBehaviour
{
	private const string MenuLeaderboardsResponseCache = "MenuLeaderboardsFriendsCache";

	public static MenuLeaderboardsController sharedController;

	private MenuLeaderboardsView _menuLeaderboardsView;

	private string _playerId = string.Empty;

	public bool IsOpened
	{
		get
		{
			return menuLeaderboardsView.opened.activeSelf;
		}
	}

	public MenuLeaderboardsView menuLeaderboardsView
	{
		get
		{
			return _menuLeaderboardsView;
		}
	}

	public void RefreshWithCache()
	{
		if (PlayerPrefs.HasKey("MenuLeaderboardsFriendsCache"))
		{
			string @string = PlayerPrefs.GetString("MenuLeaderboardsFriendsCache");
			FillListsWithResponseText(@string);
		}
	}

	private IEnumerator Start()
	{
		sharedController = this;
		using (new StopwatchLogger("MenuLeaderboardsController.Start()"))
		{
			_menuLeaderboardsView = GetComponent<MenuLeaderboardsView>();
			_playerId = PlayerPrefs.GetString("AccountCreated");
			if (PlayerPrefs.HasKey("MenuLeaderboardsFriendsCache"))
			{
				string responseText = PlayerPrefs.GetString("MenuLeaderboardsFriendsCache");
				foreach (float item in FillListsWithResponseTextAsync(responseText))
				{
					float _ = item;
					yield return null;
				}
			}
			else
			{
				TransitToFallbackState();
			}
			if (!string.IsNullOrEmpty(_playerId))
			{
				do
				{
					StartCoroutine(GetLeaderboardsCoroutine(_playerId));
					yield return new WaitForSeconds(30f);
				}
				while (!PlayerPrefs.HasKey("MenuLeaderboardsFriendsCache"));
			}
		}
	}

	private void OnDestroy()
	{
		sharedController = null;
	}

	private void TransitToFallbackState()
	{
		LeaderboardItemViewModel leaderboardItemViewModel = new LeaderboardItemViewModel();
		leaderboardItemViewModel.Id = _playerId;
		leaderboardItemViewModel.Nickname = Defs.GetPlayerNameOrDefault();
		leaderboardItemViewModel.WinCount = PlayerPrefs.GetInt("TotalWinsForLeaderboards", 0);
		leaderboardItemViewModel.Place = 1;
		leaderboardItemViewModel.Highlight = true;
		LeaderboardItemViewModel item = leaderboardItemViewModel;
		List<LeaderboardItemViewModel> list = new List<LeaderboardItemViewModel>(MenuLeaderboardsView.PageSize);
		list.Add(item);
		IList<LeaderboardItemViewModel> list2 = list;
		for (int i = 0; i < MenuLeaderboardsView.PageSize - 1; i++)
		{
			list2.Add(LeaderboardItemViewModel.Empty);
		}
		_menuLeaderboardsView.FriendsList = list2;
	}

	private void FillListsWithResponseText(string responseText)
	{
		foreach (float item in FillListsWithResponseTextAsync(responseText))
		{
			float num = item;
		}
	}

	private IEnumerable<float> FillListsWithResponseTextAsync(string responseText)
	{
		Dictionary<string, object> response = Json.Deserialize(responseText) as Dictionary<string, object>;
		if (response == null)
		{
			Debug.LogWarning("Leaderboards response is ill-formed.");
			yield break;
		}
		if (!response.Any())
		{
			Debug.LogWarning("Leaderboards response contains no elements.");
			yield break;
		}
		Debug.Log("Menu Leaderboards response:    " + responseText);
		LeaderboardItemViewModel selfStats = new LeaderboardItemViewModel
		{
			Id = _playerId,
			Nickname = Defs.GetPlayerNameOrDefault(),
			WinCount = PlayerPrefs.GetInt("TotalWinsForLeaderboards", 0),
			Highlight = true
		};
		Func<IList<LeaderboardItemViewModel>, IList<LeaderboardItemViewModel>> groupAndOrder = delegate(IList<LeaderboardItemViewModel> items)
		{
			List<LeaderboardItemViewModel> list = new List<LeaderboardItemViewModel>();
			IOrderedEnumerable<IGrouping<int, LeaderboardItemViewModel>> orderedEnumerable = from vm in items
				group vm by vm.WinCount into g
				orderby g.Key descending
				select g;
			int num = 1;
			foreach (IGrouping<int, LeaderboardItemViewModel> item in orderedEnumerable)
			{
				IOrderedEnumerable<LeaderboardItemViewModel> orderedEnumerable2 = item.OrderByDescending((LeaderboardItemViewModel vm) => vm.Rank);
				foreach (LeaderboardItemViewModel item2 in orderedEnumerable2)
				{
					item2.Place = num;
					list.Add(item2);
				}
				num += item.Count();
			}
			return list;
		};
		if (string.IsNullOrEmpty(_playerId))
		{
			Debug.LogWarning("Player id should not be empty.");
			yield break;
		}
		List<LeaderboardItemViewModel> rawFriendsList = LeaderboardsController.ParseLeaderboardEntries(_playerId, "friends", response);
		rawFriendsList.Add(selfStats);
		IList<LeaderboardItemViewModel> orderedFriendsList = groupAndOrder(rawFriendsList);
		for (int k = orderedFriendsList.Count; k < MenuLeaderboardsView.PageSize; k++)
		{
			orderedFriendsList.Add(LeaderboardItemViewModel.Empty);
		}
		yield return 0.2f;
		List<LeaderboardItemViewModel> rawBestPlayersList = LeaderboardsController.ParseLeaderboardEntries(_playerId, "best_players", response);
		IList<LeaderboardItemViewModel> orderedBestPlayersList = groupAndOrder(rawBestPlayersList);
		for (int j = orderedBestPlayersList.Count; j < MenuLeaderboardsView.PageSize; j++)
		{
			orderedBestPlayersList.Add(LeaderboardItemViewModel.Empty);
		}
		yield return 0.4f;
		List<LeaderboardItemViewModel> rawClansList = LeaderboardsController.ParseLeaderboardEntries(FriendsController.sharedController.ClanID, "top_clans", response);
		IList<LeaderboardItemViewModel> orderedClansList = groupAndOrder(rawClansList);
		for (int i = orderedClansList.Count; i < MenuLeaderboardsView.PageSize; i++)
		{
			orderedClansList.Add(LeaderboardItemViewModel.Empty);
		}
		yield return 0.6f;
		if (_menuLeaderboardsView != null)
		{
			LeaderboardItemViewModel selfInTop = orderedBestPlayersList.FirstOrDefault((LeaderboardItemViewModel item) => item.Id == _playerId);
			bool weAreInTop = selfInTop != null;
			if (Application.isEditor)
			{
				Debug.Log("We are in top: " + weAreInTop);
			}
			_menuLeaderboardsView.FriendsList = orderedFriendsList;
			_menuLeaderboardsView.BestPlayersList = orderedBestPlayersList;
			_menuLeaderboardsView.ClansList = orderedClansList;
			_menuLeaderboardsView.SelfStats = ((!weAreInTop) ? FulfillSelfStats(selfStats, response) : LeaderboardItemViewModel.Empty);
			object myClanObject;
			if (response.TryGetValue("my_clan", out myClanObject))
			{
				Dictionary<string, object> myClanDictionary = myClanObject as Dictionary<string, object>;
				if (Application.isEditor)
				{
					Debug.Log("My Clan: " + Json.Serialize(myClanObject));
				}
				if (myClanDictionary == null)
				{
					Debug.Log("myClanDictionary == null    Result type: " + myClanObject.GetType());
				}
				else
				{
					LeaderboardItemViewModel selfClanStats;
					if (myClanDictionary.ContainsKey("place"))
					{
						selfClanStats = LeaderboardItemViewModel.Empty;
					}
					else
					{
						selfClanStats = new LeaderboardItemViewModel
						{
							Id = (FriendsController.sharedController.ClanID ?? string.Empty),
							Nickname = (FriendsController.sharedController.clanName ?? string.Empty),
							WinCount = int.MinValue,
							Place = int.MinValue,
							Highlight = true
						};
						object clanNameObject;
						if (myClanDictionary.TryGetValue("name", out clanNameObject))
						{
							selfClanStats.Nickname = Convert.ToString(clanNameObject);
						}
						object clanPlace;
						if (myClanDictionary.TryGetValue("place", out clanPlace))
						{
							selfClanStats.Place = Convert.ToInt32(clanPlace);
						}
						object clanWinCount;
						if (myClanDictionary.TryGetValue("wins", out clanWinCount))
						{
							selfClanStats.WinCount = Convert.ToInt32(clanWinCount);
						}
					}
					_menuLeaderboardsView.SelfClanStats = selfClanStats;
				}
			}
			else
			{
				_menuLeaderboardsView.SelfClanStats = LeaderboardItemViewModel.Empty;
			}
		}
		else
		{
			Debug.LogError("_menuLeaderboardsView == null");
		}
		yield return 1f;
	}

	private static LeaderboardItemViewModel FulfillSelfStats(LeaderboardItemViewModel selfStats, Dictionary<string, object> response)
	{
		LeaderboardItemViewModel leaderboardItemViewModel = new LeaderboardItemViewModel();
		leaderboardItemViewModel.Id = selfStats.Id;
		leaderboardItemViewModel.Nickname = selfStats.Nickname;
		leaderboardItemViewModel.WinCount = selfStats.WinCount;
		leaderboardItemViewModel.Place = int.MinValue;
		leaderboardItemViewModel.Highlight = true;
		LeaderboardItemViewModel leaderboardItemViewModel2 = leaderboardItemViewModel;
		object value;
		if (response.TryGetValue("me", out value))
		{
			Dictionary<string, object> dictionary = value as Dictionary<string, object>;
			if (dictionary != null)
			{
				try
				{
					leaderboardItemViewModel2.WinCount = Convert.ToInt32(dictionary["wins"]);
					return leaderboardItemViewModel2;
				}
				catch (Exception exception)
				{
					Debug.LogException(exception);
					return leaderboardItemViewModel2;
				}
			}
		}
		return leaderboardItemViewModel2;
	}

	private IEnumerator GetLeaderboardsCoroutine(string playerId)
	{
		if (string.IsNullOrEmpty(playerId))
		{
			Debug.LogWarning("Player id should not be empty.");
			yield break;
		}
		Debug.Log("MenuLeaderboardsController.GetLeaderboardsCoroutine(" + playerId + ")");
		WWWForm form = new WWWForm();
		form.AddField("action", "get_menu_leaderboards");
		form.AddField("app_version", string.Format("{0}:{1}", ProtocolListGetter.CurrentPlatform, GlobalGameController.AppVersion));
		form.AddField("id", playerId);
		form.AddField("uniq_id", FriendsController.sharedController.id);
		form.AddField("auth", FriendsController.Hash("get_menu_leaderboards"));
		if (FriendsController.sharedController != null)
		{
			FriendsController.sharedController.NumberOfBestPlayersRequests++;
		}
		WWW request = new WWW(FriendsController.actionAddress, form);
		yield return request;
		if (FriendsController.sharedController != null)
		{
			FriendsController.sharedController.NumberOfBestPlayersRequests--;
		}
		HandleRequestCompleted(request);
	}

	private void HandleRequestCompleted(WWW request)
	{
		if (Application.isEditor)
		{
			Debug.Log("HandleRequestCompleted()");
		}
		if (!string.IsNullOrEmpty(request.error))
		{
			Debug.LogWarning(request.error);
			return;
		}
		string text = URLs.Sanitize(request);
		if (string.IsNullOrEmpty(text))
		{
			Debug.LogWarning("Leaderboars response is empty.");
			return;
		}
		PlayerPrefs.SetString("MenuLeaderboardsFriendsCache", text);
		FillListsWithResponseText(text);
	}

	public void OnBtnLeaderboardsOnClick()
	{
		if (_menuLeaderboardsView.opened.activeSelf)
		{
			PlayerPrefs.SetInt("Leaderboards.opened", 0);
			_menuLeaderboardsView.Show(false, true);
			MainMenuController.sharedController.rotateCamera.OnMainMenuCloseLeaderboards();
		}
	}

	public void OnBtnLeaderboardsOffClick()
	{
		if (!_menuLeaderboardsView.opened.activeSelf)
		{
			PlayerPrefs.SetInt("Leaderboards.opened", 1);
			_menuLeaderboardsView.Show(true, true);
			MainMenuController.sharedController.rotateCamera.OnMainMenuOpenLeaderboards();
		}
	}
}
