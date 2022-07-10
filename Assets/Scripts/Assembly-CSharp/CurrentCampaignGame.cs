public sealed class CurrentCampaignGame
{
	public static string boXName = string.Empty;

	public static string levelSceneName = string.Empty;

	public static float _levelStartedAtTime;

	public static bool withoutHits;

	public static bool completeInTime;

	public static int currentLevel
	{
		get
		{
			if (Switcher.sceneNameToGameNum.ContainsKey(levelSceneName))
			{
				return Switcher.sceneNameToGameNum[levelSceneName];
			}
			return 0;
		}
	}

	public static void ResetConditionParameters()
	{
		withoutHits = true;
		completeInTime = true;
	}
}
