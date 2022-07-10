using System.Collections;

public class AGSLeaderboard
{
	public string name;

	public string id;

	public string displayText;

	public string scoreFormat;

	public string imageUrl;

	public static AGSLeaderboard fromHashtable(Hashtable hashtable)
	{
		AGSLeaderboard aGSLeaderboard = new AGSLeaderboard();
		aGSLeaderboard.name = hashtable["leaderboardName"].ToString();
		aGSLeaderboard.id = hashtable["leaderboardId"].ToString();
		aGSLeaderboard.displayText = hashtable["leaderboardDisplayText"].ToString();
		aGSLeaderboard.scoreFormat = hashtable["leaderboardScoreFormat"].ToString();
		aGSLeaderboard.imageUrl = hashtable["leaderboardImageUrl"].ToString();
		return aGSLeaderboard;
	}

	public static AGSLeaderboard GetBlankLeaderboard()
	{
		AGSLeaderboard aGSLeaderboard = new AGSLeaderboard();
		aGSLeaderboard.name = string.Empty;
		aGSLeaderboard.id = string.Empty;
		aGSLeaderboard.displayText = string.Empty;
		aGSLeaderboard.scoreFormat = string.Empty;
		aGSLeaderboard.imageUrl = string.Empty;
		return aGSLeaderboard;
	}

	public override string ToString()
	{
		return string.Format("name: {0}, id: {1}, displayText: {2}, scoreFormat: {3}, imageUrl: {4}", name, id, displayText, scoreFormat, imageUrl);
	}
}
