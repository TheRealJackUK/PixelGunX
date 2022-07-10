using System;
using System.Collections;

public class AGSRequestScoreResponse : AGSRequestResponse
{
	public string leaderboardId;

	public LeaderboardScope scope;

	public int rank;

	public long score;

	public static AGSRequestScoreResponse FromJSON(string json)
	{
		//Discarded unreachable code: IL_0132, IL_015a
		try
		{
			AGSRequestScoreResponse aGSRequestScoreResponse = new AGSRequestScoreResponse();
			Hashtable hashtable = json.hashtableFromJson();
			aGSRequestScoreResponse.error = ((!hashtable.ContainsKey("error")) ? string.Empty : hashtable["error"].ToString());
			aGSRequestScoreResponse.userData = (hashtable.ContainsKey("userData") ? int.Parse(hashtable["userData"].ToString()) : 0);
			aGSRequestScoreResponse.leaderboardId = ((!hashtable.ContainsKey("leaderboardId")) ? string.Empty : hashtable["leaderboardId"].ToString());
			aGSRequestScoreResponse.rank = ((!hashtable.ContainsKey("rank")) ? (-1) : int.Parse(hashtable["rank"].ToString()));
			aGSRequestScoreResponse.score = ((!hashtable.ContainsKey("score")) ? (-1) : long.Parse(hashtable["score"].ToString()));
			aGSRequestScoreResponse.scope = (LeaderboardScope)(int)Enum.Parse(typeof(LeaderboardScope), hashtable["scope"].ToString());
			return aGSRequestScoreResponse;
		}
		catch (Exception ex)
		{
			AGSClient.LogGameCircleError(ex.ToString());
			return GetBlankResponseWithError("ERROR_PARSING_JSON", string.Empty);
		}
	}

	public static AGSRequestScoreResponse GetBlankResponseWithError(string error, string leaderboardId = "", LeaderboardScope scope = LeaderboardScope.GlobalAllTime, int userData = 0)
	{
		AGSRequestScoreResponse aGSRequestScoreResponse = new AGSRequestScoreResponse();
		aGSRequestScoreResponse.error = error;
		aGSRequestScoreResponse.userData = userData;
		aGSRequestScoreResponse.leaderboardId = leaderboardId;
		aGSRequestScoreResponse.scope = scope;
		aGSRequestScoreResponse.rank = -1;
		aGSRequestScoreResponse.score = -1L;
		return aGSRequestScoreResponse;
	}

	public static AGSRequestScoreResponse GetPlatformNotSupportedResponse(string leaderboardId, LeaderboardScope scope, int userData)
	{
		return GetBlankResponseWithError("PLATFORM_NOT_SUPPORTED", leaderboardId, scope, userData);
	}
}
