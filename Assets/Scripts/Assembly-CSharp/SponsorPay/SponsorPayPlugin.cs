using System;
using System.Collections;
using System.Collections.Generic;
using LitJson;

namespace SponsorPay
{
	public class SponsorPayPlugin
	{
		public const string PluginVersion = "7.2.2";

		private ISponsorPayPlugin plugin;

		private SPUser SPUserInstance;

		public SPUser SPUser
		{
			get
			{
				if (SPUserInstance == null)
				{
					SPUserInstance = new AndroidSPUser();
				}
				return SPUserInstance;
			}
		}

		public event DeltaOfCoinsResponseReceivedHandler OnDeltaOfCoinsReceived;

		public event SuccessfulCurrencyResponseReceivedHandler OnSuccessfulCurrencyRequestReceived;

		public event ErrorHandler OnDeltaOfCoinsRequestFailed;

		public event OfferWallResultHandler OnOfferWallResultReceived;

		public event BrandEngageRequestResponseReceivedHandler OnBrandEngageRequestResponseReceived;

		public event BrandEngageRequestErrorReceivedHandler OnBrandEngageRequestErrorReceived;

		public event BrandEngageResultHandler OnBrandEngageResultReceived;

		public event InterstitialRequestResponseReceivedHandler OnInterstitialRequestResponseReceived;

		public event InterstitialRequestErrorReceivedHandler OnInterstitialRequestErrorReceived;

		public event InterstitialStatusCloseHandler OnInterstitialStatusCloseReceived;

		public event InterstitialStatusErrorHandler OnInterstitialStatusErrorReceived;

		public event NativeExceptionHandler OnNativeExceptionReceived;

		public SponsorPayPlugin(string gameObjectName)
		{
			plugin = new AndroidSponsorPayPlugin(gameObjectName);
		}

		public string Start(string appId, string userId, string securityToken)
		{
			//Discarded unreachable code: IL_0032
			try
			{
				CheckRequiredParameters(new string[1] { appId }, new string[1] { "appId" });
				return plugin.Start(appId, userId, securityToken);
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
			return null;
		}

		public void ReportActionCompletion(string actionId)
		{
			ReportActionCompletion(null, actionId);
		}

		public void ReportActionCompletion(string credentialsToken, string actionId)
		{
			try
			{
				CheckRequiredParameters(new string[1] { actionId }, new string[1] { "actionId" });
				plugin.ReportActionCompletion(credentialsToken, actionId);
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void LaunchOfferWall(string currencyName)
		{
			LaunchOfferWall(null, currencyName, null);
		}

		public void LaunchOfferWall(string credentialsToken, string currencyName)
		{
			LaunchOfferWall(credentialsToken, currencyName, null);
		}

		public void LaunchOfferWall(string credentialsToken, string currencyName, string placementId)
		{
			try
			{
				plugin.LaunchOfferWall(credentialsToken, currencyName, placementId);
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void RequestNewCoins()
		{
			RequestNewCoins(null);
		}

		public void RequestNewCoins(string currencyName)
		{
			RequestNewCoins(null, currencyName);
		}

		public void RequestNewCoins(string credentialsToken, string currencyName)
		{
			RequestNewCoins(credentialsToken, currencyName, null);
		}

		public void RequestNewCoins(string credentialsToken, string currencyName, string currencyId)
		{
			try
			{
				plugin.RequestNewCoins(credentialsToken, currencyName, currencyId);
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void ShowVCSNotifications(bool showNotification)
		{
			try
			{
				plugin.ShowVCSNotifications(showNotification);
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void HandleException(string message)
		{
			if (this.OnNativeExceptionReceived != null)
			{
				this.OnNativeExceptionReceived(message);
			}
		}

		public void RequestBrandEngageOffers(string currencyName, bool queryVCS)
		{
			RequestBrandEngageOffers(null, currencyName, queryVCS);
		}

		public void RequestBrandEngageOffers(string credentialsToken, string currencyName, bool queryVCS)
		{
			RequestBrandEngageOffers(credentialsToken, currencyName, queryVCS, null, null);
		}

		public void RequestBrandEngageOffers(string credentialsToken, string currencyName, bool queryVCS, string currencyId, string placementId)
		{
			try
			{
				plugin.RequestBrandEngageOffers(credentialsToken, currencyName, queryVCS, currencyId, placementId);
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void StartBrandEngage()
		{
			try
			{
				plugin.StartBrandEngage();
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void ShowBrandEngageRewardNotification(bool showNotification)
		{
			try
			{
				plugin.ShowBrandEngageRewardNotification(showNotification);
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void RequestInterstitialAds()
		{
			RequestInterstitialAds(null);
		}

		public void RequestInterstitialAds(string credentialsToken)
		{
			plugin.RequestInterstitialAds(credentialsToken, null);
		}

		public void RequestInterstitialAds(string credentialsToken, string placementId)
		{
			try
			{
				plugin.RequestInterstitialAds(credentialsToken, placementId);
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void ShowInterstitialAd()
		{
			try
			{
				plugin.ShowInterstitialAd();
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void VideoDownloadPause(bool pause)
		{
			plugin.VideoDownloadPause(pause);
		}

		public void EnableLogging(bool shouldEnableLogging)
		{
			try
			{
				plugin.EnableLogging(shouldEnableLogging);
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void SetLogLevel(SPLogLevel logLevel)
		{
			try
			{
				plugin.SetLogLevel(logLevel);
			}
			catch (Exception ex)
			{
				HandleException(ex.Message);
			}
		}

		public void AddParameters(Dictionary<string, string> parameters)
		{
			string text = JsonMapper.ToJson(parameters);
			if (!string.IsNullOrEmpty(text))
			{
				plugin.AddParameters(text);
			}
		}

		public void RemoveAllParameters()
		{
			plugin.RemoveAllParameters();
		}

		public void HandleOfferWallResultFromSDK(string message)
		{
			if (this.OnOfferWallResultReceived != null)
			{
				this.OnOfferWallResultReceived(message);
			}
		}

		public void HandleCurrencyDeltaOfCoinsMessageFromSDK(string message)
		{
			VCSResponse vCSResponse = JsonMapper.ToObject<VCSResponse>(message);
			if (vCSResponse.success)
			{
				SuccessfulCurrencyResponse transaction = vCSResponse.transaction;
				if (this.OnDeltaOfCoinsReceived != null)
				{
					this.OnDeltaOfCoinsReceived(transaction.DeltaOfCoins, transaction.LatestTransactionId);
				}
				if (this.OnSuccessfulCurrencyRequestReceived != null)
				{
					this.OnSuccessfulCurrencyRequestReceived(transaction);
				}
			}
			else if (this.OnDeltaOfCoinsRequestFailed != null)
			{
				this.OnDeltaOfCoinsRequestFailed(vCSResponse.error);
			}
		}

		public void HandleBrandEngageStatusMessageFromSDK(string message)
		{
			BrandEngageResponse brandEngageResponse = JsonMapper.ToObject<BrandEngageResponse>(message);
			if (brandEngageResponse.success)
			{
				if (this.OnBrandEngageRequestResponseReceived != null)
				{
					this.OnBrandEngageRequestResponseReceived(brandEngageResponse.offersAvailable);
				}
			}
			else if (this.OnBrandEngageRequestErrorReceived != null)
			{
				this.OnBrandEngageRequestErrorReceived(brandEngageResponse.error);
			}
		}

		public void HandleBrandEngageResultFromSDK(string message)
		{
			if (this.OnBrandEngageResultReceived != null)
			{
				this.OnBrandEngageResultReceived(message);
			}
		}

		public void HandleInterstitialStatusMessageFromSDK(string message)
		{
			InterstitialResponse interstitialResponse = JsonMapper.ToObject<InterstitialResponse>(message);
			if (interstitialResponse.success)
			{
				if (this.OnInterstitialRequestResponseReceived != null)
				{
					this.OnInterstitialRequestResponseReceived(interstitialResponse.adsAvailable);
				}
			}
			else if (this.OnInterstitialRequestErrorReceived != null)
			{
				this.OnInterstitialRequestErrorReceived(interstitialResponse.error);
			}
		}

		public void HandleInterstitialResultFromSDK(string message)
		{
			InterstitialAdStatus interstitialAdStatus = JsonMapper.ToObject<InterstitialAdStatus>(message);
			if (interstitialAdStatus.success)
			{
				if (this.OnInterstitialStatusCloseReceived != null)
				{
					this.OnInterstitialStatusCloseReceived(interstitialAdStatus.closeReason);
				}
			}
			else if (this.OnInterstitialRequestErrorReceived != null)
			{
				this.OnInterstitialStatusErrorReceived(interstitialAdStatus.error);
			}
		}

		private void CheckRequiredParameters(string[] values, string[] names)
		{
			ArrayList arrayList = new ArrayList();
			for (int i = 0; i < values.Length; i++)
			{
				string value = values[i];
				if (string.IsNullOrEmpty(value))
				{
					arrayList.Add(names[i]);
				}
			}
			if (arrayList.Count > 0)
			{
				string text = string.Join(",", (string[])arrayList.ToArray(Type.GetType("System.String")));
				throw new ArgumentException("Parameter cannot be null:\n" + text);
			}
		}
	}
}
