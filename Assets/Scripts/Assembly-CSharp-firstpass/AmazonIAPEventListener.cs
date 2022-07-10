using System.Collections.Generic;
using UnityEngine;

public class AmazonIAPEventListener : MonoBehaviour
{
	private static List<AmazonItem> availableItems;

	private static List<string> unavailableSkus;

	private static string userId;

	public static List<AmazonItem> AvailableItems
	{
		get
		{
			return availableItems;
		}
	}

	public static List<string> UnavailableSkus
	{
		get
		{
			return unavailableSkus;
		}
	}

	public static string UserId
	{
		get
		{
			return userId;
		}
	}

	private void OnEnable()
	{
		AmazonIAPManager.itemDataRequestFailedEvent += itemDataRequestFailedEvent;
		AmazonIAPManager.itemDataRequestFinishedEvent += itemDataRequestFinishedEvent;
		AmazonIAPManager.purchaseFailedEvent += purchaseFailedEvent;
		AmazonIAPManager.purchaseSuccessfulEvent += purchaseSuccessfulEvent;
		AmazonIAPManager.purchaseUpdatesRequestFailedEvent += purchaseUpdatesRequestFailedEvent;
		AmazonIAPManager.purchaseUpdatesRequestSuccessfulEvent += purchaseUpdatesRequestSuccessfulEvent;
		AmazonIAPManager.onSdkAvailableEvent += onSdkAvailableEvent;
		AmazonIAPManager.onGetUserIdResponseEvent += onGetUserIdResponseEvent;
	}

	private void OnDisable()
	{
		AmazonIAPManager.itemDataRequestFailedEvent -= itemDataRequestFailedEvent;
		AmazonIAPManager.itemDataRequestFinishedEvent -= itemDataRequestFinishedEvent;
		AmazonIAPManager.purchaseFailedEvent -= purchaseFailedEvent;
		AmazonIAPManager.purchaseSuccessfulEvent -= purchaseSuccessfulEvent;
		AmazonIAPManager.purchaseUpdatesRequestFailedEvent -= purchaseUpdatesRequestFailedEvent;
		AmazonIAPManager.purchaseUpdatesRequestSuccessfulEvent -= purchaseUpdatesRequestSuccessfulEvent;
		AmazonIAPManager.onSdkAvailableEvent -= onSdkAvailableEvent;
		AmazonIAPManager.onGetUserIdResponseEvent -= onGetUserIdResponseEvent;
	}

	private void itemDataRequestFailedEvent()
	{
		AmazonIAP.Log("itemDataRequestFailedEvent");
	}

	private void itemDataRequestFinishedEvent(List<string> unavailableSkus, List<AmazonItem> availableItems)
	{
		AmazonIAPEventListener.availableItems = availableItems;
		AmazonIAPEventListener.unavailableSkus = unavailableSkus;
		AmazonIAP.Log("itemDataRequestFinishedEvent. unavailable skus: " + unavailableSkus.Count + ", avaiable items: " + availableItems.Count);
	}

	private void purchaseFailedEvent(string reason)
	{
		AmazonIAP.Log("purchaseFailedEvent: " + reason);
	}

	private void purchaseSuccessfulEvent(AmazonReceipt receipt)
	{
		AmazonIAP.Log("purchaseSuccessfulEvent: " + receipt);
	}

	private void purchaseUpdatesRequestFailedEvent()
	{
		AmazonIAP.Log("purchaseUpdatesRequestFailedEvent");
	}

	private void purchaseUpdatesRequestSuccessfulEvent(List<string> revokedSkus, List<AmazonReceipt> receipts)
	{
		AmazonIAP.Log("purchaseUpdatesRequestSuccessfulEvent. revoked skus: " + revokedSkus.Count);
		foreach (AmazonReceipt receipt in receipts)
		{
			AmazonIAP.Log(receipt.ToString());
		}
	}

	private void onSdkAvailableEvent(bool isTestMode)
	{
		AmazonIAP.Log("onSdkAvailableEvent. isTestMode: " + isTestMode);
	}

	private void onGetUserIdResponseEvent(string userId)
	{
		AmazonIAPEventListener.userId = userId;
		AmazonIAP.Log("onGetUserIdResponseEvent: " + userId);
	}
}
