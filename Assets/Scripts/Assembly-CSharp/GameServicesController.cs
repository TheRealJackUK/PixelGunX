using System.Collections;
using Rilisoft;
using UnityEngine;

internal sealed class GameServicesController : MonoBehaviour
{
	private static GameServicesController _instance;

	public static GameServicesController Instance
	{
		get
		{
			return _instance;
		}
	}

	public void WaitAuthenticationAndIncrementBeginnerAchievement()
	{
		using (new StopwatchLogger("WaitAuthenticationAndIncrementBeginnerAchievement()"))
		{
			StartCoroutine(WaitAndIncrementBeginnerAchievementCoroutine());
		}
	}

	private static IEnumerator WaitAndIncrementBeginnerAchievementCoroutine()
	{
		int oldGamesStartedCount = PlayerPrefs.GetInt("GamesStartedCount", 0);
		int newGamesStartedCount = oldGamesStartedCount + 1;
		PlayerPrefs.SetInt("GamesStartedCount", newGamesStartedCount);
		float step = 20f;
		switch (BuildSettings.BuildTarget)
		{
		case BuildTarget.Android:
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro)
			{
				Debug.Log("Social platform local user authenticated: " + Social.localUser.authenticated);
				while (!Social.localUser.authenticated)
				{
					yield return new WaitForSeconds(2f);
				}
				Debug.Log("Social platform local user authenticated: " + Social.localUser.userName + ",\t\tid: " + Social.localUser.id);
				Debug.Log("Trying to increment Beginner achievement...");
				Debug.Log("Achievement Beginner incremented: ");
			}
			else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
			{
				while (!AGSClient.IsServiceReady())
				{
					yield return new WaitForSeconds(2f);
				}
				Debug.Log("Social platform local user authenticated: " + Social.localUser.authenticated);
				while (!Social.localUser.authenticated)
				{
					yield return new WaitForSeconds(2f);
				}
				Debug.Log("Social platform local user authenticated: ");
				Debug.Log("Trying to increment Beginner achievement...");
				AGSAchievementsClient.UpdateAchievementProgress("beginner_id", (float)newGamesStartedCount * step);
			}
			break;
		case BuildTarget.iPhone:
			Debug.Log("Social platform local user authenticated: " + Social.localUser.authenticated);
			while (!Social.localUser.authenticated)
			{
				yield return new WaitForSeconds(2f);
			}
			Debug.Log("Social platform local user authenticated: " + Social.localUser.userName + ",\t\tid: " + Social.localUser.id);
			Debug.Log(string.Format("Trying to report {0} achievement...", "beginner_id"));
			Social.ReportProgress("beginner_id", (float)newGamesStartedCount * step, delegate(bool success)
			{
				Debug.Log(string.Format("Achievement {0} incremented: {1}", "beginner_id", success));
			});
			break;
		}
	}

	private void Awake()
	{
		if (_instance != null)
		{
			Debug.LogWarning(GetType().Name + " already exists.");
		}
		_instance = this;
		Object.DontDestroyOnLoad(base.gameObject);
	}
}
