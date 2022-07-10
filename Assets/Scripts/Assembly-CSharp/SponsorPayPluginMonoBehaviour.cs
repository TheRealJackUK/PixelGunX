using SponsorPay;
using UnityEngine;

public class SponsorPayPluginMonoBehaviour : MonoBehaviour
{
	public static SponsorPayPlugin PluginInstance;

	private void Awake()
	{
		if (PluginInstance == null)
		{
			PluginInstance = new SponsorPayPlugin(base.gameObject.name);
		}
	}

	private void OnSPOfferWallResultFromSDK(string message)
	{
		PluginInstance.HandleOfferWallResultFromSDK(message);
	}

	private void OnSPCurrencyDeltaOfCoinsMessageFromSDK(string message)
	{
		PluginInstance.HandleCurrencyDeltaOfCoinsMessageFromSDK(message);
	}

	private void OnSPBrandEngageStatusMessageFromSDK(string message)
	{
		PluginInstance.HandleBrandEngageStatusMessageFromSDK(message);
	}

	private void OnSPBrandEngageResultFromSDK(string message)
	{
		PluginInstance.HandleBrandEngageResultFromSDK(message);
	}

	private void OnSPInterstitialMessageFromSDK(string message)
	{
		PluginInstance.HandleInterstitialStatusMessageFromSDK(message);
	}

	private void OnSPInterstitialResultFromSDK(string message)
	{
		PluginInstance.HandleInterstitialResultFromSDK(message);
	}

	private void OnExceptionFromSDK(string message)
	{
		PluginInstance.HandleException(message);
	}
}
