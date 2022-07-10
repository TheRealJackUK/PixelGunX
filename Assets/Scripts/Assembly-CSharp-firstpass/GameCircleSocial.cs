using System;
using System.Collections.Generic;
using UnityEngine.SocialPlatforms;

public class GameCircleSocial
{
	private AGSSocialLocalUser gameCircleLocalUser = new AGSSocialLocalUser();

	private int requestID;

	private Action<bool> authenticationCallback;

	private Dictionary<int, Action<bool>> simpleCallbacks;

	private Dictionary<int, Action<IAchievementDescription[]>> loadAchievementDescriptionsCallbacks;

	private Dictionary<int, Action<IAchievement[]>> loadAchievementsCallbacks;

	private Dictionary<int, AGSSocialLeaderboard> leaderboardForRequest;

	private Dictionary<int, Action<IScore[]>> loadScoresCallbacks;

	private static GameCircleSocial socialInstance = new GameCircleSocial();

	public static GameCircleSocial Instance
	{
		get
		{
			return socialInstance;
		}
	}

	private GameCircleSocial()
	{
		requestID = 1;
		simpleCallbacks = new Dictionary<int, Action<bool>>();
		loadAchievementDescriptionsCallbacks = new Dictionary<int, Action<IAchievementDescription[]>>();
		loadAchievementsCallbacks = new Dictionary<int, Action<IAchievement[]>>();
		leaderboardForRequest = new Dictionary<int, AGSSocialLeaderboard>();
		loadScoresCallbacks = new Dictionary<int, Action<IScore[]>>();
		AGSClient.ServiceReadyEvent += OnServiceReady;
		AGSClient.ServiceNotReadyEvent += OnServiceNotReady;
		AGSAchievementsClient.UpdateAchievementCompleted += OnUpdateAchievementCompleted;
		AGSAchievementsClient.RequestAchievementsCompleted += OnRequestAchievementsCompleted;
		AGSLeaderboardsClient.SubmitScoreCompleted += OnSubmitScoreCompleted;
		AGSLeaderboardsClient.RequestScoresCompleted += OnRequestScoresCompleted;
		AGSLeaderboardsClient.RequestLocalPlayerScoreCompleted += OnRequestLocalPlayerScoreCompleted;
		AGSPlayerClient.RequestLocalPlayerCompleted += OnRequestPlayerCompleted;
		AGSPlayerClient.RequestFriendIdsCompleted += OnRequestFriendIdsCompleted;
		AGSPlayerClient.RequestBatchFriendsCompleted += OnRequestBatchFriendsCompleted;
	}

	public void LoadUsers(string[] userIDs, Action<IUserProfile[]> callback)
	{
		AGSClient.LogGameCircleError("ISocialPlatform.LoadUsers is not available for GameCircle");
	}

	public void ReportProgress(string achievementID, double progress, Action<bool> callback)
	{
		simpleCallbacks.Add(requestID, callback);
		AGSAchievementsClient.UpdateAchievementProgress(achievementID, (float)progress, requestID++);
	}

	public void LoadAchievementDescriptions(Action<IAchievementDescription[]> callback)
	{
		if (callback == null)
		{
			AGSClient.LogGameCircleError("LoadAchievementDescriptions \"callback\" argument should not be null");
			return;
		}
		loadAchievementDescriptionsCallbacks.Add(requestID, callback);
		AGSAchievementsClient.RequestAchievements(requestID++);
	}

	public void LoadAchievements(Action<IAchievement[]> callback)
	{
		if (callback == null)
		{
			AGSClient.LogGameCircleError("LoadAchievements \"callback\" argument should not be null");
			return;
		}
		loadAchievementsCallbacks.Add(requestID, callback);
		AGSAchievementsClient.RequestAchievements(requestID++);
	}

	public IAchievement CreateAchievement()
	{
		return new AGSSocialAchievement();
	}

	public void ReportScore(long score, string board, Action<bool> callback)
	{
		simpleCallbacks.Add(requestID, callback);
		AGSLeaderboardsClient.SubmitScore(board, score, requestID++);
	}

	public void LoadScores(string leaderboardID, Action<IScore[]> callback)
	{
		loadScoresCallbacks.Add(requestID, callback);
		AGSLeaderboardsClient.RequestLeaderboards(requestID++);
	}

	public ILeaderboard CreateLeaderboard()
	{
		return new AGSSocialLeaderboard();
	}

	public void ShowAchievementsUI()
	{
		AGSAchievementsClient.ShowAchievementsOverlay();
	}

	public void ShowLeaderboardUI()
	{
		AGSLeaderboardsClient.ShowLeaderboardsOverlay();
	}

	public void Authenticate(ILocalUser user, Action<bool> callback)
	{
		authenticationCallback = callback;
		AGSClient.Init(true, true, false);
	}

	public void LoadFriends(ILocalUser user, Action<bool> callback)
	{
		if (user == null)
		{
			AGSClient.LogGameCircleError("LoadFriends \"user\" argument should not be null");
		}
		else
		{
			user.LoadFriends(callback);
		}
	}

	public void LoadScores(ILeaderboard board, Action<bool> callback)
	{
		if (board == null)
		{
			AGSClient.LogGameCircleError("LoadScores \"board\" argument should not be null");
		}
		else
		{
			board.LoadScores(callback);
		}
	}

	public bool GetLoading(ILeaderboard board)
	{
		if (board == null)
		{
			AGSClient.LogGameCircleError("GetLoading \"board\" argument should not be null");
			return false;
		}
		return board.loading;
	}

	public void RequestScores(AGSSocialLeaderboard leaderboard, Action<bool> callback)
	{
		leaderboardForRequest.Add(requestID, leaderboard);
		simpleCallbacks.Add(requestID, callback);
		AGSLeaderboardsClient.RequestScores(leaderboard.id, fromTimeScope(leaderboard.timeScope), requestID++);
	}

	public void RequestLocalUserScore(AGSSocialLeaderboard leaderboard)
	{
		leaderboardForRequest.Add(requestID, leaderboard);
		AGSLeaderboardsClient.RequestScores(leaderboard.id, fromTimeScope(leaderboard.timeScope), requestID++);
	}

	public void RequestLocalPlayer(Action<bool> callback)
	{
		simpleCallbacks.Add(requestID, callback);
		AGSPlayerClient.RequestLocalPlayer(requestID++);
	}

	public void RequestFriends(Action<bool> callback)
	{
		simpleCallbacks.Add(requestID, callback);
		AGSPlayerClient.RequestFriendIds(requestID++);
	}

	private void OnServiceReady()
	{
		if (authenticationCallback != null)
		{
			authenticationCallback(true);
		}
	}

	private void OnServiceNotReady(string error)
	{
		if (authenticationCallback != null)
		{
			authenticationCallback(false);
		}
	}

	private void OnUpdateAchievementCompleted(AGSUpdateAchievementResponse response)
	{
		Action<bool> action = ((!simpleCallbacks.ContainsKey(response.userData)) ? null : simpleCallbacks[response.userData]);
		if (action != null)
		{
			action(!response.IsError());
		}
		simpleCallbacks.Remove(response.userData);
	}

	private void OnRequestAchievementsCompleted(AGSRequestAchievementsResponse response)
	{
		if (loadAchievementDescriptionsCallbacks.ContainsKey(response.userData))
		{
			Action<IAchievementDescription[]> action = ((!loadAchievementDescriptionsCallbacks.ContainsKey(response.userData)) ? null : loadAchievementDescriptionsCallbacks[response.userData]);
			if (action != null)
			{
				AGSSocialAchievement[] array = new AGSSocialAchievement[response.achievements.Count];
				for (int i = 0; i < response.achievements.Count; i++)
				{
					array[i] = new AGSSocialAchievement(response.achievements[i]);
				}
				action(array);
			}
		}
		if (loadAchievementsCallbacks.ContainsKey(response.userData))
		{
			Action<IAchievement[]> action2 = ((!loadAchievementsCallbacks.ContainsKey(response.userData)) ? null : loadAchievementsCallbacks[response.userData]);
			if (action2 != null)
			{
				AGSSocialAchievement[] array2 = new AGSSocialAchievement[response.achievements.Count];
				for (int j = 0; j < response.achievements.Count; j++)
				{
					array2[j] = new AGSSocialAchievement(response.achievements[j]);
				}
				action2(array2);
			}
		}
		loadAchievementDescriptionsCallbacks.Remove(response.userData);
	}

	private void OnSubmitScoreCompleted(AGSSubmitScoreResponse response)
	{
		Action<bool> action = ((!simpleCallbacks.ContainsKey(response.userData)) ? null : simpleCallbacks[response.userData]);
		if (action != null)
		{
			action(!response.IsError());
		}
		simpleCallbacks.Remove(response.userData);
	}

	private void OnRequestScoresCompleted(AGSRequestScoresResponse response)
	{
		AGSSocialLeaderboard aGSSocialLeaderboard = ((!leaderboardForRequest.ContainsKey(response.userData)) ? null : leaderboardForRequest[response.userData]);
		if (aGSSocialLeaderboard != null && !response.IsError())
		{
			aGSSocialLeaderboard.scores = new IScore[response.scores.Count];
			for (int i = 0; i < response.scores.Count; i++)
			{
				aGSSocialLeaderboard.scores[i] = new AGSSocialLeaderboardScore(response.scores[i], response.leaderboard);
			}
		}
		Action<bool> action = ((!simpleCallbacks.ContainsKey(response.userData)) ? null : simpleCallbacks[response.userData]);
		if (action != null)
		{
			action(!response.IsError());
		}
		Action<IScore[]> action2 = ((!loadScoresCallbacks.ContainsKey(response.userData)) ? null : loadScoresCallbacks[response.userData]);
		if (action2 != null)
		{
			IScore[] array = new IScore[response.scores.Count];
			for (int j = 0; j < response.scores.Count; j++)
			{
				array[j] = new AGSSocialLeaderboardScore(response.scores[j], response.leaderboard);
			}
			action2(array);
		}
		leaderboardForRequest.Remove(response.userData);
		simpleCallbacks.Remove(response.userData);
	}

	private void OnRequestLocalPlayerScoreCompleted(AGSRequestScoreResponse response)
	{
		AGSSocialLeaderboard aGSSocialLeaderboard = ((!leaderboardForRequest.ContainsKey(response.userData)) ? null : leaderboardForRequest[response.userData]);
		if (aGSSocialLeaderboard != null)
		{
			aGSSocialLeaderboard.localPlayerScore = response.score;
			aGSSocialLeaderboard.localPlayerRank = response.rank;
		}
		leaderboardForRequest.Remove(response.userData);
	}

	private void OnRequestPlayerCompleted(AGSRequestPlayerResponse response)
	{
		AGSSocialLocalUser.player = response.player;
		Action<bool> action = ((!simpleCallbacks.ContainsKey(response.userData)) ? null : simpleCallbacks[response.userData]);
		if (action != null)
		{
			action(!response.IsError());
		}
		simpleCallbacks.Remove(response.userData);
	}

	private void OnRequestFriendIdsCompleted(AGSRequestFriendIdsResponse response)
	{
		if (response.IsError())
		{
			Action<bool> action = ((!simpleCallbacks.ContainsKey(response.userData)) ? null : simpleCallbacks[response.userData]);
			if (action != null)
			{
				action(false);
			}
			simpleCallbacks.Remove(response.userData);
		}
		else
		{
			AGSPlayerClient.RequestBatchFriends(response.friendIds, response.userData);
		}
	}

	private void OnRequestBatchFriendsCompleted(AGSRequestBatchFriendsResponse response)
	{
		if (!response.IsError())
		{
			AGSSocialLocalUser.friendList = new List<AGSSocialUser>();
			foreach (AGSPlayer friend in response.friends)
			{
				AGSSocialLocalUser.friendList.Add(new AGSSocialUser(friend));
			}
		}
		Action<bool> action = ((!simpleCallbacks.ContainsKey(response.userData)) ? null : simpleCallbacks[response.userData]);
		if (action != null)
		{
			action(!response.IsError());
		}
		simpleCallbacks.Remove(response.userData);
	}

	private LeaderboardScope fromTimeScope(TimeScope scope)
	{
		switch (scope)
		{
		case TimeScope.Today:
			return LeaderboardScope.GlobalDay;
		case TimeScope.Week:
			return LeaderboardScope.GlobalWeek;
		case TimeScope.AllTime:
			return LeaderboardScope.GlobalAllTime;
		default:
			return LeaderboardScope.GlobalAllTime;
		}
	}
}
