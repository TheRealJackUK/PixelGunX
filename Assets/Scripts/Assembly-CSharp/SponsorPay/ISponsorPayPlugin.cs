namespace SponsorPay
{
	public interface ISponsorPayPlugin
	{
		string Start(string appId, string userId, string securityToken);

		void ReportActionCompletion(string credentialsToken, string actionId);

		void LaunchOfferWall(string credentialsToken, string currencyName, string placementId);

		void RequestNewCoins(string credentialsToken, string currencyName, string currencyId);

		void ShowVCSNotifications(bool showNotification);

		void RequestBrandEngageOffers(string credentialsToken, string currencyName, bool queryVCS, string currencyId, string placementId);

		void StartBrandEngage();

		void ShowBrandEngageRewardNotification(bool showNotification);

		void RequestInterstitialAds(string credentialsToken, string placementId);

		void ShowInterstitialAd();

		void VideoDownloadPause(bool pause);

		void EnableLogging(bool shouldEnableLogging);

		void SetLogLevel(SPLogLevel logLevel);

		void AddParameters(string json);

		void RemoveAllParameters();
	}
}
