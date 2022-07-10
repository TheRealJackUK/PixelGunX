using System;
using System.Collections;

public class AGSSubmitScoreResponse : AGSRequestResponse
{
	public string leaderboardId;

	public static AGSSubmitScoreResponse FromJSON(string json)
	{
		//Discarded unreachable code: IL_00a5, IL_00cc
		try
		{
			AGSSubmitScoreResponse aGSSubmitScoreResponse = new AGSSubmitScoreResponse();
			Hashtable hashtable = json.hashtableFromJson();
			aGSSubmitScoreResponse.error = ((!hashtable.ContainsKey("error")) ? string.Empty : hashtable["error"].ToString());
			aGSSubmitScoreResponse.userData = (hashtable.ContainsKey("userData") ? int.Parse(hashtable["userData"].ToString()) : 0);
			aGSSubmitScoreResponse.leaderboardId = ((!hashtable.ContainsKey("leaderboardId")) ? string.Empty : hashtable["leaderboardId"].ToString());
			return aGSSubmitScoreResponse;
		}
		catch (Exception ex)
		{
			AGSClient.LogGameCircleError(ex.ToString());
			return GetBlankResponseWithError("ERROR_PARSING_JSON", string.Empty);
		}
	}

	public static AGSSubmitScoreResponse GetBlankResponseWithError(string error, string leaderboardId = "", int userData = 0)
	{
		AGSSubmitScoreResponse aGSSubmitScoreResponse = new AGSSubmitScoreResponse();
		aGSSubmitScoreResponse.error = error;
		aGSSubmitScoreResponse.userData = userData;
		aGSSubmitScoreResponse.leaderboardId = leaderboardId;
		return aGSSubmitScoreResponse;
	}

	public static AGSSubmitScoreResponse GetPlatformNotSupportedResponse(string leaderboardId, int userData)
	{
		return GetBlankResponseWithError("PLATFORM_NOT_SUPPORTED", leaderboardId, userData);
	}
}
