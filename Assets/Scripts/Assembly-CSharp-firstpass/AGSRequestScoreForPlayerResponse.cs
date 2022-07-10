using System;
using System.Collections;

public class AGSRequestScoreForPlayerResponse : AGSRequestScoreResponse
{
	public string playerId;

	public new static AGSRequestScoreForPlayerResponse FromJSON(string json)
	{
		//Discarded unreachable code: IL_0162, IL_018f
		try
		{
			AGSRequestScoreForPlayerResponse aGSRequestScoreForPlayerResponse = new AGSRequestScoreForPlayerResponse();
			Hashtable hashtable = json.hashtableFromJson();
			aGSRequestScoreForPlayerResponse.error = ((!hashtable.ContainsKey("error")) ? string.Empty : hashtable["error"].ToString());
			aGSRequestScoreForPlayerResponse.userData = (hashtable.ContainsKey("userData") ? int.Parse(hashtable["userData"].ToString()) : 0);
			aGSRequestScoreForPlayerResponse.leaderboardId = ((!hashtable.ContainsKey("leaderboardId")) ? string.Empty : hashtable["leaderboardId"].ToString());
			aGSRequestScoreForPlayerResponse.rank = ((!hashtable.ContainsKey("rank")) ? (-1) : int.Parse(hashtable["rank"].ToString()));
			aGSRequestScoreForPlayerResponse.score = ((!hashtable.ContainsKey("score")) ? (-1) : long.Parse(hashtable["score"].ToString()));
			aGSRequestScoreForPlayerResponse.scope = (LeaderboardScope)(int)Enum.Parse(typeof(LeaderboardScope), hashtable["scope"].ToString());
			aGSRequestScoreForPlayerResponse.playerId = ((!hashtable.Contains("playerId")) ? string.Empty : hashtable["playerId"].ToString());
			return aGSRequestScoreForPlayerResponse;
		}
		catch (Exception ex)
		{
			AGSClient.LogGameCircleError(ex.ToString());
			return GetBlankResponseWithError("ERROR_PARSING_JSON", string.Empty, string.Empty);
		}
	}

	public static AGSRequestScoreForPlayerResponse GetBlankResponseWithError(string error, string leaderboardId = "", string playerId = "", LeaderboardScope scope = LeaderboardScope.GlobalAllTime, int userData = 0)
	{
		AGSRequestScoreForPlayerResponse aGSRequestScoreForPlayerResponse = new AGSRequestScoreForPlayerResponse();
		aGSRequestScoreForPlayerResponse.error = error;
		aGSRequestScoreForPlayerResponse.playerId = playerId;
		aGSRequestScoreForPlayerResponse.userData = userData;
		aGSRequestScoreForPlayerResponse.leaderboardId = leaderboardId;
		aGSRequestScoreForPlayerResponse.scope = scope;
		aGSRequestScoreForPlayerResponse.rank = -1;
		aGSRequestScoreForPlayerResponse.score = -1L;
		return aGSRequestScoreForPlayerResponse;
	}

	public static AGSRequestScoreForPlayerResponse GetPlatformNotSupportedResponse(string leaderboardId, string playerId, LeaderboardScope scope, int userData)
	{
		return GetBlankResponseWithError("PLATFORM_NOT_SUPPORTED", leaderboardId, playerId, scope, userData);
	}
}
