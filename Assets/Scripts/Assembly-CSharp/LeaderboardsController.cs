using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

internal sealed class LeaderboardsController : MonoBehaviour
{
	private FriendsGUIController _friendsGuiController;

	private LeaderboardsView _leaderboardsView;

	private string _playerId = string.Empty;

	public LeaderboardsView LeaderboardsView
	{
		private get
		{
			return _leaderboardsView;
		}
		set
		{
			_leaderboardsView = value;
			if (_leaderboardsView != null)
			{
				_leaderboardsView.BackPressed += HandleBackPressed;
			}
		}
	}

	public FriendsGUIController FriendsGuiController
	{
		private get
		{
			return _friendsGuiController;
		}
		set
		{
			_friendsGuiController = value;
		}
	}

	public string PlayerId
	{
		private get
		{
			return _playerId;
		}
		set
		{
			_playerId = value ?? string.Empty;
		}
	}

	public void RequestLeaderboards()
	{
		if (!string.IsNullOrEmpty(_playerId))
		{
			StartCoroutine(GetLeaderboardsCoroutine(_playerId));
		}
		else
		{
			Debug.Log("Player id should not be empty.");
		}
	}

	internal static List<LeaderboardItemViewModel> ParseLeaderboardEntries(string entryId, string leaderboardName, Dictionary<string, object> response)
	{
		if (string.IsNullOrEmpty(leaderboardName))
		{
			throw new ArgumentException("Leaderbord should not be empty.", "leaderboardName");
		}
		if (response == null)
		{
			throw new ArgumentNullException("response");
		}
		List<LeaderboardItemViewModel> list = new List<LeaderboardItemViewModel>();
		object value;
		if (response.TryGetValue(leaderboardName, out value))
		{
			List<object> list2 = value as List<object>;
			if (list2 != null)
			{
				IEnumerable<Dictionary<string, object>> enumerable = list2.OfType<Dictionary<string, object>>();
				{
					foreach (Dictionary<string, object> item in enumerable)
					{
						LeaderboardItemViewModel leaderboardItemViewModel = new LeaderboardItemViewModel();
						object value2;
						if (item.TryGetValue("id", out value2))
						{
							leaderboardItemViewModel.Id = (value2 as string) ?? string.Empty;
							leaderboardItemViewModel.Highlight = !string.IsNullOrEmpty(leaderboardItemViewModel.Id) && leaderboardItemViewModel.Id.Equals(entryId);
						}
						object value3;
						int result;
						if (item.TryGetValue("rank", out value3) && int.TryParse(value3 as string, out result))
						{
							leaderboardItemViewModel.Rank = result;
						}
						object value4;
						if (item.TryGetValue("nick", out value4))
						{
							leaderboardItemViewModel.Nickname = (value4 as string) ?? string.Empty;
						}
						else if (item.TryGetValue("name", out value4))
						{
							leaderboardItemViewModel.Nickname = (value4 as string) ?? string.Empty;
						}
						object value5;
						int result2;
						if (item.TryGetValue("wins", out value5) && int.TryParse(value5 as string, out result2))
						{
							leaderboardItemViewModel.WinCount = result2;
						}
						else if (item.TryGetValue("win", out value5) && int.TryParse(value5 as string, out result2))
						{
							leaderboardItemViewModel.WinCount = result2;
						}
						object value6;
						if (item.TryGetValue("logo", out value6))
						{
							leaderboardItemViewModel.ClanLogo = (value6 as string) ?? string.Empty;
						}
						list.Add(leaderboardItemViewModel);
					}
					return list;
				}
			}
		}
		return list;
	}

	private void OnDestroy()
	{
		if (_leaderboardsView != null)
		{
			_leaderboardsView.BackPressed -= HandleBackPressed;
		}
	}

	private void Start()
	{
		RequestLeaderboards();
	}

	private IEnumerator GetLeaderboardsCoroutine(string playerId)
	{
		if (string.IsNullOrEmpty(playerId))
		{
			Debug.LogWarning("Player id should not be empty.");
			yield break;
		}
		Debug.Log("LeaderboardsController.GetLeaderboardsCoroutine(" + playerId + ")");
		WWWForm form = new WWWForm();
		form.AddField("action", "get_leaderboards");
		form.AddField("app_version", string.Format("{0}:{1}", ProtocolListGetter.CurrentPlatform, GlobalGameController.AppVersion));
		form.AddField("id", playerId);
		form.AddField("uniq_id", FriendsController.sharedController.id);
		form.AddField("auth", FriendsController.Hash("get_leaderboards"));
		if (FriendsController.sharedController.NumberOfBestPlayersRequests > 0)
		{
			Debug.Log("Waiting previous leaderboards request...");
			while (FriendsController.sharedController.NumberOfBestPlayersRequests > 0)
			{
				yield return null;
			}
		}
		FriendsController.sharedController.NumberOfBestPlayersRequests++;
		WWW request = new WWW(FriendsController.actionAddress, form);
		yield return request;
		FriendsController.sharedController.NumberOfBestPlayersRequests--;
		HandleRequestCompleted(request);
	}

	private void HandleBackPressed(object sender, EventArgs e)
	{
		if (Application.isEditor)
		{
			Debug.Log("Back pressed.");
		}
		if (_friendsGuiController != null)
		{
			_friendsGuiController.leaderboardsView.gameObject.SetActive(false);
			_friendsGuiController.friendsPanel.gameObject.SetActive(true);
		}
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
		Debug.LogWarning("Leaderboars response is " + text);
		Dictionary<string, object> dictionary = Json.Deserialize(text) as Dictionary<string, object>;
		if (dictionary == null)
		{
			Debug.LogWarning("Leaderboards response is ill-formed.");
			return;
		}
		if (!dictionary.Any())
		{
			Debug.LogWarning("Leaderboards response contains no elements.");
			return;
		}
		Func<IList<LeaderboardItemViewModel>, IList<LeaderboardItemViewModel>> func = delegate(IList<LeaderboardItemViewModel> items)
		{
			List<LeaderboardItemViewModel> list2 = new List<LeaderboardItemViewModel>();
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
					list2.Add(item2);
				}
				num += item.Count();
			}
			return list2;
		};
		List<LeaderboardItemViewModel> list = ParseLeaderboardEntries(_playerId, "friends", dictionary);
		list.Add(new LeaderboardItemViewModel
		{
			Id = _playerId,
			Nickname = Defs.GetPlayerNameOrDefault(),
			Rank = ExperienceController.sharedController.currentLevel,
			WinCount = PlayerPrefs.GetInt("TotalWinsForLeaderboards", 0),
			Highlight = true,
			ClanLogo = (FriendsController.sharedController.clanLogo ?? string.Empty)
		});
		IList<LeaderboardItemViewModel> friendsList = func(list);
		List<LeaderboardItemViewModel> arg = ParseLeaderboardEntries(_playerId, "best_players", dictionary);
		IList<LeaderboardItemViewModel> bestPlayersList = func(arg);
		List<LeaderboardItemViewModel> arg2 = ParseLeaderboardEntries(_playerId, "top_clans", dictionary);
		IList<LeaderboardItemViewModel> clansList = func(arg2);
		_leaderboardsView.FriendsList = friendsList;
		_leaderboardsView.BestPlayersList = bestPlayersList;
		_leaderboardsView.ClansList = clansList;
	}
}
