using System;
using UnityEngine.SocialPlatforms;

public class AGSSocialLeaderboardScore : IScore
{
	private readonly AGSScore score;

	public string leaderboardID { get; set; }

	public long value { get; set; }

	public DateTime date
	{
		get
		{
			AGSClient.LogGameCircleError("IScore.date.get is not available for GameCircle");
			return DateTime.MinValue;
		}
	}

	public string formattedValue
	{
		get
		{
			if (score == null)
			{
				return null;
			}
			return score.scoreString;
		}
	}

	public string userID
	{
		get
		{
			if (score == null)
			{
				return null;
			}
			return score.player.alias;
		}
	}

	public int rank
	{
		get
		{
			if (score == null)
			{
				return 0;
			}
			return score.rank;
		}
	}

	public AGSSocialLeaderboardScore(AGSScore score, AGSLeaderboard leaderboard)
	{
		if (score == null)
		{
			AGSClient.LogGameCircleError("AGSSocialLeaderboardScore constructor \"score\" argument should not be null");
			return;
		}
		if (leaderboard == null)
		{
			AGSClient.LogGameCircleError("AGSSocialLeaderboardScore constructor \"leaderboard\" argument should not be null");
			return;
		}
		this.score = score;
		leaderboardID = leaderboard.id;
		value = score.scoreValue;
	}

	public AGSSocialLeaderboardScore()
	{
		score = null;
		leaderboardID = null;
	}

	public void ReportScore(Action<bool> callback)
	{
		GameCircleSocial.Instance.ReportScore(value, leaderboardID, callback);
		AGSLeaderboardsClient.SubmitScore(leaderboardID, value);
	}
}
