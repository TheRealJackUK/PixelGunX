using System;
using System.Collections;
using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

internal sealed class LeaderboardsExample : MonoBehaviour
{
	public LeaderboardsView leaderboardsView;

	public MenuLeaderboardsView menuLeaderboardsView;

	private void Start()
	{
		StartCoroutine(PopulateLeaderboards());
	}

	private IEnumerator PopulateLeaderboards()
	{
		if (menuLeaderboardsView == null)
		{
			Debug.LogError("menuLeaderboardsView == null");
			yield break;
		}
		yield return null;
		System.Random prng = new System.Random();
		IList<LeaderboardItemViewModel> bestPlayersList = new List<LeaderboardItemViewModel>();
		for (int l = 0; l != 42; l++)
		{
			LeaderboardItemViewModel vm = new LeaderboardItemViewModel
			{
				Rank = (1000 - l) % 13,
				Nickname = "Player_" + prng.Next(100),
				WinCount = prng.Next(1000),
				Place = l + 1,
				Highlight = (l > 11 && l % 7 == 3)
			};
			bestPlayersList.Add(vm);
		}
		for (int k = bestPlayersList.Count; k < MenuLeaderboardsView.PageSize; k++)
		{
			bestPlayersList.Add(LeaderboardItemViewModel.Empty);
		}
		menuLeaderboardsView.BestPlayersList = bestPlayersList;
		IList<LeaderboardItemViewModel> friendsList = new List<LeaderboardItemViewModel>();
		for (int j = 0; j != 7; j++)
		{
			LeaderboardItemViewModel vm2 = new LeaderboardItemViewModel
			{
				Rank = (100 - j) % 13,
				Nickname = "Player_" + j * 13 + 2,
				WinCount = 190 + 3 * j,
				Place = 5 * j + 3,
				Highlight = (j % 6 == 2)
			};
			friendsList.Add(vm2);
		}
		for (int i = friendsList.Count; i < MenuLeaderboardsView.PageSize; i++)
		{
			friendsList.Add(LeaderboardItemViewModel.Empty);
		}
		menuLeaderboardsView.FriendsList = friendsList;
	}
}
