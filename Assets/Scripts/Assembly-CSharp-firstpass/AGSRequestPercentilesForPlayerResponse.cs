using System;
using System.Collections;
using System.Collections.Generic;

public class AGSRequestPercentilesForPlayerResponse : AGSRequestPercentilesResponse
{
	public string playerId;

	public new static AGSRequestPercentilesForPlayerResponse FromJSON(string json)
	{
		//Discarded unreachable code: IL_01e4, IL_0214
		try
		{
			AGSRequestPercentilesForPlayerResponse aGSRequestPercentilesForPlayerResponse = new AGSRequestPercentilesForPlayerResponse();
			Hashtable hashtable = json.hashtableFromJson();
			aGSRequestPercentilesForPlayerResponse.error = ((!hashtable.ContainsKey("error")) ? string.Empty : hashtable["error"].ToString());
			aGSRequestPercentilesForPlayerResponse.userData = (hashtable.ContainsKey("userData") ? int.Parse(hashtable["userData"].ToString()) : 0);
			aGSRequestPercentilesForPlayerResponse.leaderboardId = ((!hashtable.ContainsKey("leaderboardId")) ? string.Empty : hashtable["leaderboardId"].ToString());
			if (hashtable.ContainsKey("leaderboard"))
			{
				aGSRequestPercentilesForPlayerResponse.leaderboard = AGSLeaderboard.fromHashtable(hashtable["leaderboard"] as Hashtable);
			}
			else
			{
				aGSRequestPercentilesForPlayerResponse.leaderboard = AGSLeaderboard.GetBlankLeaderboard();
			}
			aGSRequestPercentilesForPlayerResponse.percentiles = new List<AGSLeaderboardPercentile>();
			if (hashtable.Contains("percentiles"))
			{
				foreach (Hashtable item in hashtable["percentiles"] as ArrayList)
				{
					aGSRequestPercentilesForPlayerResponse.percentiles.Add(AGSLeaderboardPercentile.fromHashTable(item));
				}
			}
			aGSRequestPercentilesForPlayerResponse.userIndex = ((!hashtable.ContainsKey("userIndex")) ? (-1) : int.Parse(hashtable["userIndex"].ToString()));
			aGSRequestPercentilesForPlayerResponse.scope = (LeaderboardScope)(int)Enum.Parse(typeof(LeaderboardScope), hashtable["scope"].ToString());
			aGSRequestPercentilesForPlayerResponse.playerId = ((!hashtable.ContainsKey("playerId")) ? string.Empty : hashtable["playerId"].ToString());
			return aGSRequestPercentilesForPlayerResponse;
		}
		catch (Exception ex)
		{
			AGSClient.LogGameCircleError(ex.ToString());
			return GetBlankResponseWithError("ERROR_PARSING_JSON", string.Empty, string.Empty);
		}
	}

	public static AGSRequestPercentilesForPlayerResponse GetBlankResponseWithError(string error, string leaderboardId = "", string playerId = "", LeaderboardScope scope = LeaderboardScope.GlobalAllTime, int userData = 0)
	{
		AGSRequestPercentilesForPlayerResponse aGSRequestPercentilesForPlayerResponse = new AGSRequestPercentilesForPlayerResponse();
		aGSRequestPercentilesForPlayerResponse.error = error;
		aGSRequestPercentilesForPlayerResponse.userData = userData;
		aGSRequestPercentilesForPlayerResponse.leaderboardId = leaderboardId;
		aGSRequestPercentilesForPlayerResponse.scope = scope;
		aGSRequestPercentilesForPlayerResponse.leaderboard = AGSLeaderboard.GetBlankLeaderboard();
		aGSRequestPercentilesForPlayerResponse.percentiles = new List<AGSLeaderboardPercentile>();
		aGSRequestPercentilesForPlayerResponse.userIndex = -1;
		aGSRequestPercentilesForPlayerResponse.scope = scope;
		aGSRequestPercentilesForPlayerResponse.playerId = playerId;
		return aGSRequestPercentilesForPlayerResponse;
	}

	public static AGSRequestPercentilesForPlayerResponse GetPlatformNotSupportedResponse(string leaderboardId, string playerId, LeaderboardScope scope, int userData)
	{
		return GetBlankResponseWithError("PLATFORM_NOT_SUPPORTED", leaderboardId, playerId, scope, userData);
	}
}
