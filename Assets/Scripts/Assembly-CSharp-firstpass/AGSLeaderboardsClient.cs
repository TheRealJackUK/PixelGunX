using System;
using System.Collections.Generic;
using UnityEngine;

public class AGSLeaderboardsClient : MonoBehaviour
{
	private static AmazonJavaWrapper JavaObject;

	private static readonly string PROXY_CLASS_NAME;

	public static event Action<AGSSubmitScoreResponse> SubmitScoreCompleted;

	public static event Action<AGSRequestLeaderboardsResponse> RequestLeaderboardsCompleted;

	public static event Action<AGSRequestScoreResponse> RequestLocalPlayerScoreCompleted;

	public static event Action<AGSRequestScoreForPlayerResponse> RequestScoreForPlayerCompleted;

	public static event Action<AGSRequestScoresResponse> RequestScoresCompleted;

	public static event Action<AGSRequestPercentilesResponse> RequestPercentileRanksCompleted;

	public static event Action<AGSRequestPercentilesForPlayerResponse> RequestPercentileRanksForPlayerCompleted;

	[Obsolete("SubmitScoreFailedEvent is deprecated. Use SubmitScoreCompleted instead.")]
	public static event Action<string, string> SubmitScoreFailedEvent;

	[Obsolete("SubmitScoreSucceededEvent is deprecated. Use SubmitScoreCompleted instead.")]
	public static event Action<string> SubmitScoreSucceededEvent;

	[Obsolete("RequestLeaderboardsFailedEvent is deprecated. Use RequestLeaderboardsCompleted instead.")]
	public static event Action<string> RequestLeaderboardsFailedEvent;

	[Obsolete("RequestLeaderboardsSucceededEvent is deprecated. Use RequestLeaderboardsCompleted instead.")]
	public static event Action<List<AGSLeaderboard>> RequestLeaderboardsSucceededEvent;

	[Obsolete("RequestLocalPlayerScoreFailedEvent is deprecated. Use RequestLocalPlayerScoreCompleted instead.")]
	public static event Action<string, string> RequestLocalPlayerScoreFailedEvent;

	[Obsolete("RequestLocalPlayerScoreSucceededEvent is deprecated. Use RequestLocalPlayerScoreCompleted instead.")]
	public static event Action<string, int, long> RequestLocalPlayerScoreSucceededEvent;

	[Obsolete("RequestPercentileRanksFailedEvent is deprecated. Use RequestPercentileRanksCompleted instead.")]
	public static event Action<string, string> RequestPercentileRanksFailedEvent;

	[Obsolete("RequestPercentileRanksSucceededEvent is deprecated. Use RequestPercentileRanksCompleted instead.")]
	public static event Action<AGSLeaderboard, List<AGSLeaderboardPercentile>, int> RequestPercentileRanksSucceededEvent;

	static AGSLeaderboardsClient()
	{
		PROXY_CLASS_NAME = "com.amazon.ags.api.unity.LeaderboardsClientProxyImpl";
		JavaObject = new AmazonJavaWrapper();
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass(PROXY_CLASS_NAME))
		{
			if (androidJavaClass.GetRawClass() == IntPtr.Zero)
			{
				AGSClient.LogGameCircleWarning("No java class " + PROXY_CLASS_NAME + " present, can't use AGSLeaderboardsClient");
			}
			else
			{
				JavaObject.setAndroidJavaObject(androidJavaClass.CallStatic<AndroidJavaObject>("getInstance", new object[0]));
			}
		}
	}

	public static void SubmitScore(string leaderboardId, long score, int userData = 0)
	{
		JavaObject.Call("submitScore", leaderboardId, score, userData);
	}

	public static void ShowLeaderboardsOverlay()
	{
		JavaObject.Call("showLeaderboardsOverlay");
	}

	public static void RequestLeaderboards(int userData = 0)
	{
		JavaObject.Call("requestLeaderboards", 0);
	}

	public static void RequestLocalPlayerScore(string leaderboardId, LeaderboardScope scope, int userData = 0)
	{
		JavaObject.Call("requestLocalPlayerScore", leaderboardId, (int)scope, 0);
	}

	public static void RequestScoreForPlayer(string leaderboardId, string playerId, LeaderboardScope scope, int userData = 0)
	{
		JavaObject.Call("requestScoreForPlayer", leaderboardId, playerId, (int)scope, userData);
	}

	public static void RequestScores(string leaderboardId, LeaderboardScope scope, int userData = 0)
	{
		JavaObject.Call("requestScores", leaderboardId, (int)scope, userData);
	}

	public static void RequestPercentileRanks(string leaderboardId, LeaderboardScope scope, int userData = 0)
	{
		JavaObject.Call("requestPercentileRanks", leaderboardId, (int)scope, userData);
	}

	public static void RequestPercentileRanksForPlayer(string leaderboardId, string playerId, LeaderboardScope scope, int userData = 0)
	{
		JavaObject.Call("requestPercentileRanksForPlayer", leaderboardId, playerId, (int)scope, userData);
	}

	public static void SubmitScoreFailed(string json)
	{
		AGSSubmitScoreResponse aGSSubmitScoreResponse = AGSSubmitScoreResponse.FromJSON(json);
		if (aGSSubmitScoreResponse.IsError() && AGSLeaderboardsClient.SubmitScoreFailedEvent != null)
		{
			AGSLeaderboardsClient.SubmitScoreFailedEvent(aGSSubmitScoreResponse.leaderboardId, aGSSubmitScoreResponse.error);
		}
		if (AGSLeaderboardsClient.SubmitScoreCompleted != null)
		{
			AGSLeaderboardsClient.SubmitScoreCompleted(aGSSubmitScoreResponse);
		}
	}

	public static void SubmitScoreSucceeded(string json)
	{
		AGSSubmitScoreResponse aGSSubmitScoreResponse = AGSSubmitScoreResponse.FromJSON(json);
		if (!aGSSubmitScoreResponse.IsError() && AGSLeaderboardsClient.SubmitScoreSucceededEvent != null)
		{
			AGSLeaderboardsClient.SubmitScoreFailedEvent(aGSSubmitScoreResponse.leaderboardId, aGSSubmitScoreResponse.error);
		}
		if (AGSLeaderboardsClient.SubmitScoreCompleted != null)
		{
			AGSLeaderboardsClient.SubmitScoreCompleted(aGSSubmitScoreResponse);
		}
	}

	public static void RequestLeaderboardsFailed(string json)
	{
		AGSRequestLeaderboardsResponse aGSRequestLeaderboardsResponse = AGSRequestLeaderboardsResponse.FromJSON(json);
		if (aGSRequestLeaderboardsResponse.IsError() && AGSLeaderboardsClient.RequestLeaderboardsFailedEvent != null)
		{
			AGSLeaderboardsClient.RequestLeaderboardsFailedEvent(aGSRequestLeaderboardsResponse.error);
		}
		if (AGSLeaderboardsClient.RequestLeaderboardsCompleted != null)
		{
			AGSLeaderboardsClient.RequestLeaderboardsCompleted(aGSRequestLeaderboardsResponse);
		}
	}

	public static void RequestLeaderboardsSucceeded(string json)
	{
		AGSRequestLeaderboardsResponse aGSRequestLeaderboardsResponse = AGSRequestLeaderboardsResponse.FromJSON(json);
		if (!aGSRequestLeaderboardsResponse.IsError() && AGSLeaderboardsClient.RequestLeaderboardsSucceededEvent != null)
		{
			AGSLeaderboardsClient.RequestLeaderboardsSucceededEvent(aGSRequestLeaderboardsResponse.leaderboards);
		}
		if (AGSLeaderboardsClient.RequestLeaderboardsCompleted != null)
		{
			AGSLeaderboardsClient.RequestLeaderboardsCompleted(aGSRequestLeaderboardsResponse);
		}
	}

	public static void RequestLocalPlayerScoreFailed(string json)
	{
		AGSRequestScoreResponse aGSRequestScoreResponse = AGSRequestScoreResponse.FromJSON(json);
		if (aGSRequestScoreResponse.IsError() && AGSLeaderboardsClient.RequestLocalPlayerScoreFailedEvent != null)
		{
			AGSLeaderboardsClient.RequestLocalPlayerScoreFailedEvent(aGSRequestScoreResponse.leaderboardId, aGSRequestScoreResponse.error);
		}
		if (AGSLeaderboardsClient.RequestLocalPlayerScoreCompleted != null)
		{
			AGSLeaderboardsClient.RequestLocalPlayerScoreCompleted(aGSRequestScoreResponse);
		}
	}

	public static void RequestLocalPlayerScoreSucceeded(string json)
	{
		AGSRequestScoreResponse aGSRequestScoreResponse = AGSRequestScoreResponse.FromJSON(json);
		if (!aGSRequestScoreResponse.IsError() && AGSLeaderboardsClient.RequestLocalPlayerScoreSucceededEvent != null)
		{
			AGSLeaderboardsClient.RequestLocalPlayerScoreSucceededEvent(aGSRequestScoreResponse.leaderboardId, aGSRequestScoreResponse.rank, aGSRequestScoreResponse.score);
		}
		if (AGSLeaderboardsClient.RequestLocalPlayerScoreCompleted != null)
		{
			AGSLeaderboardsClient.RequestLocalPlayerScoreCompleted(aGSRequestScoreResponse);
		}
	}

	public static void RequestScoreForPlayerComplete(string json)
	{
		if (AGSLeaderboardsClient.RequestScoreForPlayerCompleted != null)
		{
			AGSLeaderboardsClient.RequestScoreForPlayerCompleted(AGSRequestScoreForPlayerResponse.FromJSON(json));
		}
	}

	public static void RequestScoresSucceeded(string json)
	{
		if (AGSLeaderboardsClient.RequestScoresCompleted != null)
		{
			AGSLeaderboardsClient.RequestScoresCompleted(AGSRequestScoresResponse.FromJSON(json));
		}
	}

	public static void RequestScoresFailed(string json)
	{
		if (AGSLeaderboardsClient.RequestScoresCompleted != null)
		{
			AGSLeaderboardsClient.RequestScoresCompleted(AGSRequestScoresResponse.FromJSON(json));
		}
	}

	public static void RequestPercentileRanksFailed(string json)
	{
		AGSRequestPercentilesResponse aGSRequestPercentilesResponse = AGSRequestPercentilesResponse.FromJSON(json);
		if (aGSRequestPercentilesResponse.IsError() && AGSLeaderboardsClient.RequestPercentileRanksFailedEvent != null)
		{
			AGSLeaderboardsClient.RequestPercentileRanksFailedEvent(aGSRequestPercentilesResponse.leaderboardId, aGSRequestPercentilesResponse.error);
		}
		if (AGSLeaderboardsClient.RequestPercentileRanksCompleted != null)
		{
			AGSLeaderboardsClient.RequestPercentileRanksCompleted(aGSRequestPercentilesResponse);
		}
	}

	public static void RequestPercentileRanksSucceeded(string json)
	{
		AGSRequestPercentilesResponse aGSRequestPercentilesResponse = AGSRequestPercentilesResponse.FromJSON(json);
		if (!aGSRequestPercentilesResponse.IsError() && AGSLeaderboardsClient.RequestPercentileRanksSucceededEvent != null)
		{
			AGSLeaderboardsClient.RequestPercentileRanksSucceededEvent(aGSRequestPercentilesResponse.leaderboard, aGSRequestPercentilesResponse.percentiles, aGSRequestPercentilesResponse.userIndex);
		}
		if (AGSLeaderboardsClient.RequestPercentileRanksCompleted != null)
		{
			AGSLeaderboardsClient.RequestPercentileRanksCompleted(aGSRequestPercentilesResponse);
		}
	}

	public static void RequestPercentileRanksForPlayerComplete(string json)
	{
		if (AGSLeaderboardsClient.RequestPercentileRanksForPlayerCompleted != null)
		{
			AGSLeaderboardsClient.RequestPercentileRanksForPlayerCompleted(AGSRequestPercentilesForPlayerResponse.FromJSON(json));
		}
	}
}
