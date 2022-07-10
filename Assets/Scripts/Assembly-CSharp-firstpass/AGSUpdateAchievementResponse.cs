using System;
using System.Collections;

public class AGSUpdateAchievementResponse : AGSRequestResponse
{
	public string achievementId;

	public static AGSUpdateAchievementResponse FromJSON(string json)
	{
		//Discarded unreachable code: IL_00a5, IL_00cc
		try
		{
			AGSUpdateAchievementResponse aGSUpdateAchievementResponse = new AGSUpdateAchievementResponse();
			Hashtable hashtable = json.hashtableFromJson();
			aGSUpdateAchievementResponse.error = ((!hashtable.ContainsKey("error")) ? string.Empty : hashtable["error"].ToString());
			aGSUpdateAchievementResponse.userData = (hashtable.ContainsKey("userData") ? int.Parse(hashtable["userData"].ToString()) : 0);
			aGSUpdateAchievementResponse.achievementId = ((!hashtable.ContainsKey("achievementId")) ? string.Empty : hashtable["achievementId"].ToString());
			return aGSUpdateAchievementResponse;
		}
		catch (Exception ex)
		{
			AGSClient.LogGameCircleError(ex.ToString());
			return GetBlankResponseWithError("ERROR_PARSING_JSON", string.Empty);
		}
	}

	public static AGSUpdateAchievementResponse GetBlankResponseWithError(string error, string achievementId = "", int userData = 0)
	{
		AGSUpdateAchievementResponse aGSUpdateAchievementResponse = new AGSUpdateAchievementResponse();
		aGSUpdateAchievementResponse.error = error;
		aGSUpdateAchievementResponse.userData = userData;
		aGSUpdateAchievementResponse.achievementId = achievementId;
		return aGSUpdateAchievementResponse;
	}

	public static AGSUpdateAchievementResponse GetPlatformNotSupportedResponse(string achievementId, int userData)
	{
		return GetBlankResponseWithError("PLATFORM_NOT_SUPPORTED", achievementId, userData);
	}
}
