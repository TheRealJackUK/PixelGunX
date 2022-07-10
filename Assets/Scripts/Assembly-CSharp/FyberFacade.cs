using System;
using System.Collections.Generic;
using Rilisoft;
using SponsorPay;
using UnityEngine;

internal sealed class FyberFacade
{
	private readonly Queue<Future<bool>> _requests = new Queue<Future<bool>>();

	private static readonly Rilisoft.Lazy<FyberFacade> _instance = new Rilisoft.Lazy<FyberFacade>(() => new FyberFacade());

	private static readonly Rilisoft.Lazy<SponsorPayPlugin> _sponsorPayPlugin = new Rilisoft.Lazy<SponsorPayPlugin>(InitializeSponsorPayPlugin);

	public static FyberFacade Instance
	{
		get
		{
			return _instance.Value;
		}
	}

	public Queue<Future<bool>> Requests
	{
		get
		{
			return _requests;
		}
	}

	private static SponsorPayPlugin SponsorPayPlugin
	{
		get
		{
			return _sponsorPayPlugin.Value;
		}
	}

	private FyberFacade()
	{
	}

	public Future<bool> RequestImageInterstitial(string callerName = null)
	{
		if (callerName == null)
		{
			callerName = string.Empty;
		}
		Promise<bool> promise = new Promise<bool>();
		return RequestImageInterstitialCore(promise, callerName);
	}

	private Future<bool> RequestImageInterstitialCore(Promise<bool> promise, string callerName)
	{
		int attemptCount = 0;
		InterstitialRequestResponseReceivedHandler receivedHandler = null;
		InterstitialRequestErrorReceivedHandler errorHandler = null;
		receivedHandler = delegate(bool offersAvailable)
		{
			if (Defs.IsDeveloperBuild)
			{
				string message3 = string.Format("InterstitialRequestResponseReceivedHandler ({0}). Offers available: {1}", callerName, offersAvailable);
				Debug.Log(message3);
			}
			if (offersAvailable)
			{
				promise.SetResult(true);
				SponsorPayPlugin.OnInterstitialRequestResponseReceived -= receivedHandler;
				SponsorPayPlugin.OnInterstitialRequestErrorReceived -= errorHandler;
			}
			else if (++attemptCount < 1)
			{
				RequestInterstitialAds();
			}
			else
			{
				promise.SetResult(false);
				SponsorPayPlugin.OnInterstitialRequestResponseReceived -= receivedHandler;
				SponsorPayPlugin.OnInterstitialRequestErrorReceived -= errorHandler;
			}
		};
		errorHandler = delegate(string message)
		{
			string message2 = string.Format("OnInterstitialRequestErrorReceived ({0}, {1}). Message: {2}", callerName, attemptCount, message);
			Debug.Log(message2);
			if (++attemptCount < 1)
			{
				RequestInterstitialAds();
			}
			else
			{
				promise.SetResult(false);
				SponsorPayPlugin.OnInterstitialRequestResponseReceived -= receivedHandler;
				SponsorPayPlugin.OnInterstitialRequestErrorReceived -= errorHandler;
			}
		};
		SponsorPayPlugin.OnInterstitialRequestResponseReceived += receivedHandler;
		SponsorPayPlugin.OnInterstitialRequestErrorReceived += errorHandler;
		if (Defs.IsDeveloperBuild)
		{
			Debug.Log("Requesting Fyber interstitial...");
		}
		RequestInterstitialAds();
		return promise.Future;
	}

	public Future<InterstitialResult> ShowInterstitial(string callerName = null)
	{
		if (callerName == null)
		{
			callerName = string.Empty;
		}
		Promise<InterstitialResult> promise = new Promise<InterstitialResult>();
		InterstitialStatusCloseHandler closeHandler = null;
		InterstitialStatusErrorHandler errorHandler = null;
		closeHandler = delegate(string closeReason)
		{
			if (Defs.IsDeveloperBuild)
			{
				string message2 = string.Format("InterstitialStatusCloseHandler ({0}). Close reason: {1}", callerName, closeReason);
				Debug.Log(message2);
			}
			Dictionary<string, string> parameters = new Dictionary<string, string> { 
			{
				"Fyber - Interstitial",
				"Impression: " + closeReason
			} };
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Ads Show Stats - Total", parameters);
			SponsorPayPlugin.OnInterstitialStatusCloseReceived -= closeHandler;
			SponsorPayPlugin.OnInterstitialStatusErrorReceived -= errorHandler;
			promise.SetResult(InterstitialResult.FromCloseReason(closeReason));
		};
		errorHandler = delegate(string message)
		{
			SponsorPayPlugin.OnInterstitialStatusCloseReceived -= closeHandler;
			SponsorPayPlugin.OnInterstitialStatusErrorReceived -= errorHandler;
			promise.SetResult(InterstitialResult.FromErrorMessage(message));
		};
		SponsorPayPlugin.OnInterstitialStatusCloseReceived += closeHandler;
		SponsorPayPlugin.OnInterstitialStatusErrorReceived += errorHandler;
		SponsorPayPlugin.ShowInterstitialAd();
		return promise.Future;
	}

	private static void RequestInterstitialAds()
	{
		SponsorPayPlugin.RequestInterstitialAds();
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		dictionary.Add("Fyber - Interstitial", "Request");
		Dictionary<string, string> parameters = dictionary;
		FlurryPluginWrapper.LogEventAndDublicateToConsole("Ads Show Stats - Total", parameters);
	}

	private static SponsorPayPlugin InitializeSponsorPayPlugin()
	{
		SponsorPayPlugin pluginInstance = SponsorPayPluginMonoBehaviour.PluginInstance;
		if (pluginInstance == null)
		{
			throw new InvalidOperationException("FyberFacade: SponsorPay plugin is not initialized.");
		}
		return pluginInstance;
	}
}
