using System;
using System.Collections;

public class AGSAchievement
{
	public string title;

	public string id;

	public string description;

	public float progress;

	public int pointValue;

	public bool isHidden;

	public bool isUnlocked;

	public int position;

	public DateTime dateUnlocked;

	public static AGSAchievement fromHashtable(Hashtable hashtable)
	{
		//Discarded unreachable code: IL_00f6, IL_011c
		try
		{
			AGSAchievement aGSAchievement = new AGSAchievement();
			aGSAchievement.title = hashtable["achievementTitle"].ToString();
			aGSAchievement.id = hashtable["achievementId"].ToString();
			aGSAchievement.description = hashtable["achievementDescription"].ToString();
			aGSAchievement.progress = float.Parse(hashtable["achievementProgress"].ToString());
			aGSAchievement.pointValue = int.Parse(hashtable["achievementPointValue"].ToString());
			aGSAchievement.position = int.Parse(hashtable["achievementPosition"].ToString());
			aGSAchievement.isUnlocked = bool.Parse(hashtable["achievementUnlocked"].ToString());
			aGSAchievement.isHidden = bool.Parse(hashtable["achievementHidden"].ToString());
			aGSAchievement.dateUnlocked = getTimefromEpochTime(long.Parse(hashtable["achievementDateUnlocked"].ToString()));
			return aGSAchievement;
		}
		catch (Exception ex)
		{
			AGSClient.LogGameCircleError("Returning blank achievement due to exception getting achievement from hashtable: " + ex.ToString());
			return GetBlankAchievement();
		}
	}

	public static AGSAchievement GetBlankAchievement()
	{
		AGSAchievement aGSAchievement = new AGSAchievement();
		aGSAchievement.title = string.Empty;
		aGSAchievement.id = string.Empty;
		aGSAchievement.description = string.Empty;
		aGSAchievement.pointValue = 0;
		aGSAchievement.isHidden = false;
		aGSAchievement.isUnlocked = false;
		aGSAchievement.progress = 0f;
		aGSAchievement.position = 0;
		aGSAchievement.dateUnlocked = DateTime.MinValue;
		return aGSAchievement;
	}

	private static DateTime getTimefromEpochTime(long javaTimeStamp)
	{
		return new DateTime(1970, 1, 1, 0, 0, 0, 0).AddMilliseconds(javaTimeStamp).ToLocalTime();
	}

	public override string ToString()
	{
		return string.Format("title: {0}, id: {1}, pointValue: {2}, hidden: {3}, unlocked: {4}, progress: {5}, position: {6}, date: {7} ", title, id, pointValue, isHidden, isUnlocked, progress, position, dateUnlocked);
	}
}
