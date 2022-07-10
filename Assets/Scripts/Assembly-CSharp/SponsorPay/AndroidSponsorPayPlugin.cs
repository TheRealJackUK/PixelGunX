using System.IO;
using UnityEngine;

namespace SponsorPay
{
	public class AndroidSponsorPayPlugin : ISponsorPayPlugin
	{
		private AndroidJavaObject sponsorPayWrapper;

		private AndroidJavaObject spOfferWall;

		private AndroidJavaObject spCurrency;

		private AndroidJavaObject spBrandEngage;

		private AndroidJavaObject spInterstitial;

		private AndroidJavaObject spRewardedAction;

		private string CallbackGameObjectName { get; set; }

		private AndroidJavaObject SPOfferWall
		{
			get
			{
				if (spOfferWall == null)
				{
					spOfferWall = new AndroidJavaObject("com.sponsorpay.unity.SPUnityOfferWallWrapper", CallbackGameObjectName);
				}
				return spOfferWall;
			}
		}

		private AndroidJavaObject SPCurrency
		{
			get
			{
				if (spCurrency == null)
				{
					spCurrency = new AndroidJavaObject("com.sponsorpay.unity.SPUnityCurrencyWrapper", CallbackGameObjectName);
				}
				return spCurrency;
			}
		}

		private AndroidJavaObject SPWrapper
		{
			get
			{
				if (sponsorPayWrapper == null)
				{
					sponsorPayWrapper = new AndroidJavaObject("com.sponsorpay.unity.SPUnityWrapper", CallbackGameObjectName);
				}
				return sponsorPayWrapper;
			}
		}

		private AndroidJavaObject SPBrandEngage
		{
			get
			{
				if (spBrandEngage == null)
				{
					spBrandEngage = new AndroidJavaObject("com.sponsorpay.unity.SPUnityBrandEngageWrapper", CallbackGameObjectName);
				}
				return spBrandEngage;
			}
		}

		private AndroidJavaObject SPInterstitial
		{
			get
			{
				if (spInterstitial == null)
				{
					spInterstitial = new AndroidJavaObject("com.sponsorpay.unity.SPUnityInterstitialWrapper", CallbackGameObjectName);
				}
				return spInterstitial;
			}
		}

		private AndroidJavaObject SPRewardedAction
		{
			get
			{
				if (spRewardedAction == null)
				{
					spRewardedAction = new AndroidJavaObject("com.sponsorpay.unity.SPUnityRewardedActionWrapper", CallbackGameObjectName);
				}
				return spRewardedAction;
			}
		}

		public AndroidSponsorPayPlugin(string gameObjectName)
		{
			AndroidJNI.AttachCurrentThread();
			CallbackGameObjectName = gameObjectName;
			InitPlugin();
		}

		public string Start(string appId, string userId, string securityToken)
		{
			return SPWrapper.Call<string>("start", new object[3] { appId, userId, securityToken });
		}

		public void ReportActionCompletion(string credentialsToken, string actionId)
		{
			SPRewardedAction.Call("reportActionCompletion", credentialsToken, actionId);
		}

		public void LaunchOfferWall(string credentialsToken, string currencyName, string placementId)
		{
			SPOfferWall.Call("launchOfferWall", credentialsToken, currencyName, placementId);
		}

		public void RequestNewCoins(string credentialsToken, string currencyName, string currencyId)
		{
			SPCurrency.Call("requestNewCoins", credentialsToken, currencyName, currencyId);
		}

		public void ShowVCSNotifications(bool showNotification)
		{
			SPCurrency.Call("showVCSNotification", showNotification);
		}

		public void RequestBrandEngageOffers(string credentialsToken, string currencyName, bool queryVCS, string placementId, string currencyId)
		{
			SPBrandEngage.Call("requestOffers", credentialsToken, currencyName, queryVCS, placementId, currencyId);
		}

		public void StartBrandEngage()
		{
			SPBrandEngage.Call("startEngagement");
		}

		public void ShowBrandEngageRewardNotification(bool showNotification)
		{
			SPBrandEngage.Call("showRewardsNotification", showNotification);
		}

		public void RequestInterstitialAds(string credentialsToken, string placementId)
		{
			SPInterstitial.Call("requestAds", credentialsToken, placementId);
		}

		public void ShowInterstitialAd()
		{
			SPInterstitial.Call("showAd");
		}

		public void EnableLogging(bool shouldEnableLogging)
		{
			using (AndroidJavaObject androidJavaObject = new AndroidJavaObject("com.sponsorpay.unity.SPLoggerWrapper"))
			{
				androidJavaObject.Call("enableLogging", shouldEnableLogging);
			}
		}

		public void SetLogLevel(SPLogLevel logLevel)
		{
			SPUtils.printWarningMessage();
		}

		public void AddParameters(string json)
		{
			using (AndroidJavaObject androidJavaObject = new AndroidJavaObject("com.sponsorpay.unity.SPUnityParameterProvider"))
			{
				androidJavaObject.Call("addParameters", json);
			}
		}

		public void RemoveAllParameters()
		{
			using (AndroidJavaObject androidJavaObject = new AndroidJavaObject("com.sponsorpay.unity.SPUnityParameterProvider"))
			{
				androidJavaObject.Call("clear");
			}
		}

		public void VideoDownloadPause(bool pause)
		{
			using (AndroidJavaObject androidJavaObject = new AndroidJavaObject("com.sponsorpay.unity.SPCacheWrapper"))
			{
				androidJavaObject.Call("setPrecachingState", pause);
			}
		}

		private void InitPlugin()
		{
			using (AndroidJavaObject androidJavaObject = new AndroidJavaObject("com.sponsorpay.unity.SPUnityPlugin"))
			{
				androidJavaObject.Call("setPluginVersion", "7.2.2");
				string text = Path.Combine(Application.streamingAssetsPath, "adapters.info");
				string text2 = Path.Combine(Application.streamingAssetsPath, "adapters.config");
				androidJavaObject.Call("setAdaptersInfoLocation", text);
				androidJavaObject.Call("setAdaptersConfigLocation", text2);
			}
		}
	}
}
