using System.Collections;
using System.Reflection;
using Rilisoft;
using UnityEngine;

[Obfuscation(Exclude = true)]
internal sealed class InAppInstancer : MonoBehaviour
{
	public GameObject inAppGameObjectPrefab;

	public GameObject amazonGameCircleManager;

	public GameObject amazonIapManagerPrefab;

	private bool _amazonGamecircleManagerInitialized;

	private bool _amazonIapManagerInitialized;

	private string _leaderboardId = string.Empty;

	private IEnumerator Start()
	{
		if (Launcher.UsingNewLauncher)
		{
			yield break;
		}
		if (!GameObject.FindGameObjectWithTag("InAppGameObject"))
		{
			Object.Instantiate(inAppGameObjectPrefab, Vector3.zero, Quaternion.identity);
			yield return null;
		}
		if (amazonIapManagerPrefab == null)
		{
			Debug.LogWarning("amazonIapManager == null");
		}
		else if (!_amazonIapManagerInitialized)
		{
			Object.Instantiate(amazonIapManagerPrefab, Vector3.zero, Quaternion.identity);
			_amazonIapManagerInitialized = true;
			yield return null;
		}
		if (Application.platform == RuntimePlatform.Android && Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			if (amazonGameCircleManager == null)
			{
				Debug.LogWarning("amazonGamecircleManager == null");
			}
			else if (!_amazonGamecircleManagerInitialized)
			{
				StartCoroutine(InitializeAmazonGamecircleManager());
				_amazonGamecircleManagerInitialized = true;
			}
		}
		else if (BuildSettings.BuildTarget == BuildTarget.iPhone)
		{
		}
	}

	private IEnumerator InitializeAmazonGamecircleManager()
	{
		Object.DontDestroyOnLoad(amazonGameCircleManager);
		yield return null;
		_leaderboardId = ((Defs.AndroidEdition != Defs.RuntimeAndroidEdition.GoogleLite) ? "best_survival_scores" : "CgkIr8rGkPIJEAIQCg");
		if (!AGSClient.IsServiceReady())
		{
			Debug.Log("Trying to initialize Amazon GameCircle service...");
			AGSClient.ServiceReadyEvent += HandleAmazonGamecircleServiceReady;
			AGSClient.ServiceNotReadyEvent += HandleAmazonGamecircleServiceNotReady;
			AGSClient.Init(true, true, true);
			AGSWhispersyncClient.OnNewCloudDataEvent += HandleAmazonPotentialProgressConflicts;
			AGSWhispersyncClient.OnDataUploadedToCloudEvent += HandleAmazonPotentialProgressConflicts;
			AGSWhispersyncClient.OnSyncFailedEvent += HandleAmazonSyncFailed;
			AGSWhispersyncClient.OnThrottledEvent += HandleAmazonThrottled;
		}
		else
		{
			Debug.Log("Amazon GameCircle was already initialized.");
			AGSLeaderboardsClient.SubmitScoreSucceededEvent += HandleSubmitScoreSucceeded;
			AGSLeaderboardsClient.SubmitScoreFailedEvent += HandleSubmitScoreFailed;
			AGSLeaderboardsClient.SubmitScore(_leaderboardId, PlayerPrefs.GetInt(Defs.SurvivalScoreSett, 0));
		}
	}

	private void HandleAmazonGamecircleServiceReady()
	{
		AGSClient.ServiceReadyEvent -= HandleAmazonGamecircleServiceReady;
		AGSClient.ServiceNotReadyEvent -= HandleAmazonGamecircleServiceNotReady;
		Debug.Log("Amazon GameCircle service is initialized.");
		AGSAchievementsClient.UpdateAchievementCompleted += HandleUpdateAchievementCompleted;
		AGSLeaderboardsClient.SubmitScoreSucceededEvent += HandleSubmitScoreSucceeded;
		AGSLeaderboardsClient.SubmitScoreFailedEvent += HandleSubmitScoreFailed;
		AGSLeaderboardsClient.SubmitScore(_leaderboardId, PlayerPrefs.GetInt(Defs.SurvivalScoreSett, 0));
	}

	private void HandleAmazonPotentialProgressConflicts()
	{
		Debug.Log("HandleAmazonPotentialProgressConflicts()");
	}

	private void HandleAmazonSyncFailed()
	{
		Debug.LogWarning("HandleAmazonSyncFailed(): " + AGSWhispersyncClient.failReason);
	}

	private void HandleAmazonThrottled()
	{
		Debug.LogWarning("HandleAmazonThrottled().");
	}

	private void HandleAmazonGamecircleServiceNotReady(string message)
	{
		Debug.LogError("Amazon GameCircle service is not ready:\n" + message);
	}

	private void HandleUpdateAchievementCompleted(AGSUpdateAchievementResponse response)
	{
		string message = ((!string.IsNullOrEmpty(response.error)) ? string.Format("Achievement {0} failed. {1}", response.achievementId, response.error) : string.Format("Achievement {0} succeeded.", response.achievementId));
		Debug.Log(message);
	}

	private void HandleSubmitScoreSucceeded(string leaderbordId)
	{
		AGSLeaderboardsClient.SubmitScoreSucceededEvent -= HandleSubmitScoreSucceeded;
		AGSLeaderboardsClient.SubmitScoreFailedEvent -= HandleSubmitScoreFailed;
		if (Debug.isDebugBuild)
		{
			Debug.Log("Submit score succeeded for leaderboard " + leaderbordId);
		}
	}

	private void HandleSubmitScoreFailed(string leaderbordId, string error)
	{
		AGSLeaderboardsClient.SubmitScoreSucceededEvent -= HandleSubmitScoreSucceeded;
		AGSLeaderboardsClient.SubmitScoreFailedEvent -= HandleSubmitScoreFailed;
		string message = string.Format("Submit score failed for leaderboard {0}:\n{1}", leaderbordId, error);
		Debug.LogError(message);
	}
}
