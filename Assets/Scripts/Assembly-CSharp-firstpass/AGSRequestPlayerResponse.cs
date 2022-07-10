using System;
using System.Collections;

public class AGSRequestPlayerResponse : AGSRequestResponse
{
	public AGSPlayer player;

	public static AGSRequestPlayerResponse FromJSON(string json)
	{
		//Discarded unreachable code: IL_00aa, IL_00cc
		try
		{
			AGSRequestPlayerResponse aGSRequestPlayerResponse = new AGSRequestPlayerResponse();
			Hashtable hashtable = json.hashtableFromJson();
			aGSRequestPlayerResponse.error = ((!hashtable.ContainsKey("error")) ? string.Empty : hashtable["error"].ToString());
			aGSRequestPlayerResponse.userData = (hashtable.ContainsKey("userData") ? int.Parse(hashtable["userData"].ToString()) : 0);
			aGSRequestPlayerResponse.player = ((!hashtable.ContainsKey("player")) ? AGSPlayer.GetBlankPlayer() : AGSPlayer.fromHashtable(hashtable["player"] as Hashtable));
			return aGSRequestPlayerResponse;
		}
		catch (Exception ex)
		{
			AGSClient.LogGameCircleError(ex.ToString());
			return GetBlankResponseWithError("ERROR_PARSING_JSON");
		}
	}

	public static AGSRequestPlayerResponse GetBlankResponseWithError(string error, int userData = 0)
	{
		AGSRequestPlayerResponse aGSRequestPlayerResponse = new AGSRequestPlayerResponse();
		aGSRequestPlayerResponse.error = error;
		aGSRequestPlayerResponse.userData = userData;
		aGSRequestPlayerResponse.player = AGSPlayer.GetBlankPlayer();
		return aGSRequestPlayerResponse;
	}

	public static AGSRequestPlayerResponse GetPlatformNotSupportedResponse(int userData)
	{
		return GetBlankResponseWithError("PLATFORM_NOT_SUPPORTED", userData);
	}
}
