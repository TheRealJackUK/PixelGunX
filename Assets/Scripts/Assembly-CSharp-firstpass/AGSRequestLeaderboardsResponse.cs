using System;
using System.Collections;
using System.Collections.Generic;

public class AGSRequestLeaderboardsResponse : AGSRequestResponse
{
	public List<AGSLeaderboard> leaderboards;

	public static AGSRequestLeaderboardsResponse FromJSON(string json)
	{
		//Discarded unreachable code: IL_00ee, IL_0113
		try
		{
			AGSRequestLeaderboardsResponse aGSRequestLeaderboardsResponse = new AGSRequestLeaderboardsResponse();
			Hashtable hashtable = json.hashtableFromJson();
			aGSRequestLeaderboardsResponse.error = ((!hashtable.ContainsKey("error")) ? string.Empty : hashtable["error"].ToString());
			aGSRequestLeaderboardsResponse.userData = (hashtable.ContainsKey("userData") ? int.Parse(hashtable["userData"].ToString()) : 0);
			aGSRequestLeaderboardsResponse.leaderboards = new List<AGSLeaderboard>();
			if (hashtable.ContainsKey("leaderboards"))
			{
				foreach (Hashtable item in hashtable["leaderboards"] as ArrayList)
				{
					aGSRequestLeaderboardsResponse.leaderboards.Add(AGSLeaderboard.fromHashtable(item));
				}
			}
			return aGSRequestLeaderboardsResponse;
		}
		catch (Exception ex)
		{
			AGSClient.LogGameCircleError(ex.ToString());
			return GetBlankResponseWithError("ERROR_PARSING_JSON");
		}
	}

	public static AGSRequestLeaderboardsResponse GetBlankResponseWithError(string error, int userData = 0)
	{
		AGSRequestLeaderboardsResponse aGSRequestLeaderboardsResponse = new AGSRequestLeaderboardsResponse();
		aGSRequestLeaderboardsResponse.error = error;
		aGSRequestLeaderboardsResponse.userData = userData;
		aGSRequestLeaderboardsResponse.leaderboards = new List<AGSLeaderboard>();
		return aGSRequestLeaderboardsResponse;
	}

	public static AGSRequestLeaderboardsResponse GetPlatformNotSupportedResponse(int userData)
	{
		return GetBlankResponseWithError("PLATFORM_NOT_SUPPORTED", userData);
	}
}
