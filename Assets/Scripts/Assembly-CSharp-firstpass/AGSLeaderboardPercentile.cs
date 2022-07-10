using System;
using System.Collections;

public class AGSLeaderboardPercentile
{
	private const string percentileKey = "percentile";

	private const string scoreKey = "score";

	private const string playerKey = "player";

	public int percentile;

	public long score;

	public AGSPlayer player;

	public static AGSLeaderboardPercentile fromHashTable(Hashtable percentilesHashtable)
	{
		AGSLeaderboardPercentile aGSLeaderboardPercentile = new AGSLeaderboardPercentile();
		try
		{
			aGSLeaderboardPercentile.percentile = int.Parse(percentilesHashtable["percentile"].ToString());
			aGSLeaderboardPercentile.score = long.Parse(percentilesHashtable["score"].ToString());
		}
		catch (FormatException ex)
		{
			AGSClient.Log("Unable to parse percentile item " + ex.Message);
		}
		aGSLeaderboardPercentile.player = AGSPlayer.fromHashtable(percentilesHashtable["player"] as Hashtable);
		return aGSLeaderboardPercentile;
	}

	public override string ToString()
	{
		return string.Format("player: {0}, score: {1}, percentile: {2}", player.ToString(), score, percentile);
	}
}
