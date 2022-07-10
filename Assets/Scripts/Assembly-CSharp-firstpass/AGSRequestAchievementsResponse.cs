using System;
using System.Collections;
using System.Collections.Generic;

public class AGSRequestAchievementsResponse : AGSRequestResponse
{
	public List<AGSAchievement> achievements;

	public static AGSRequestAchievementsResponse FromJSON(string json)
	{
		//Discarded unreachable code: IL_00ee, IL_0113
		try
		{
			AGSRequestAchievementsResponse aGSRequestAchievementsResponse = new AGSRequestAchievementsResponse();
			Hashtable hashtable = json.hashtableFromJson();
			aGSRequestAchievementsResponse.error = ((!hashtable.ContainsKey("error")) ? string.Empty : hashtable["error"].ToString());
			aGSRequestAchievementsResponse.userData = (hashtable.ContainsKey("userData") ? int.Parse(hashtable["userData"].ToString()) : 0);
			aGSRequestAchievementsResponse.achievements = new List<AGSAchievement>();
			if (hashtable.ContainsKey("achievements"))
			{
				foreach (Hashtable item in hashtable["achievements"] as ArrayList)
				{
					aGSRequestAchievementsResponse.achievements.Add(AGSAchievement.fromHashtable(item));
				}
			}
			return aGSRequestAchievementsResponse;
		}
		catch (Exception ex)
		{
			AGSClient.LogGameCircleError(ex.ToString());
			return GetBlankResponseWithError("ERROR_PARSING_JSON");
		}
	}

	public static AGSRequestAchievementsResponse GetBlankResponseWithError(string error, int userData = 0)
	{
		AGSRequestAchievementsResponse aGSRequestAchievementsResponse = new AGSRequestAchievementsResponse();
		aGSRequestAchievementsResponse.error = error;
		aGSRequestAchievementsResponse.userData = userData;
		aGSRequestAchievementsResponse.achievements = new List<AGSAchievement>();
		return aGSRequestAchievementsResponse;
	}

	public static AGSRequestAchievementsResponse GetPlatformNotSupportedResponse(int userData)
	{
		return GetBlankResponseWithError("PLATFORM_NOT_SUPPORTED", userData);
	}
}
