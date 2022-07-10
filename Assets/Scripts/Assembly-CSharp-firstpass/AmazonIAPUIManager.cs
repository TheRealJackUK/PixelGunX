using UnityEngine;

public class AmazonIAPUIManager : MonoBehaviour
{
	private const string pluginName = "Amazon IAP";

	private const string itemDataRequestButtonLabel = "Initiate Item Data Request";

	private const string amazonItemsAvailableLabel = "Amazon Items Available";

	private const string unavailableAmazonSkusLabel = "Unavailable Skus";

	private const string purchaseItemButtonlabel = "Initiate Purchase Request";

	private const string initializeUserIdRequestLabel = "Initialize User ID Request";

	private const string userIDLabel = "User ID {0}";

	private const string itemTitleLabel = "{0}";

	private const string itemSkuAndPriceLabel = "Sku: {0}, Price: {1}";

	private const string itemDescriptionLabel = "{0}";

	private const string itemTypeAndUrlLabel = "Type: {0}, Url: {1}";

	private string[] buttonClickerSkus = new string[5] { "com.amazon.buttonclicker.blue_button", "com.amazon.buttonclicker.green_button", "com.amazon.buttonclicker.purple_button", "com.amazon.buttonclicker.subscription.1mo", "com.amazon.buttonclicker.ten_clicks" };

	private Vector2 scroll = Vector2.zero;

	private bool uiInitialized;

	private void OnGUI()
	{
		InitializeUI();
		AmazonGUIHelpers.BeginMenuLayout();
		scroll = GUILayout.BeginScrollView(scroll);
		DisplayIAPMenuHeader();
		GUILayout.Label(GUIContent.none);
		DisplayAmazonItems();
		GUILayout.Label(GUIContent.none);
		DisplayAmazonUserID();
		GUILayout.EndScrollView();
		AmazonGUIHelpers.EndMenuLayout();
	}

	private void DisplayIAPMenuHeader()
	{
		AmazonGUIHelpers.BoxedCenteredLabel("Amazon IAP");
	}

	private void DisplayAmazonItems()
	{
		if (AmazonIAPEventListener.AvailableItems == null)
		{
			if (GUILayout.Button("Initiate Item Data Request"))
			{
				AmazonIAP.initiateItemDataRequest(buttonClickerSkus);
			}
			return;
		}
		AmazonGUIHelpers.CenteredLabel("Amazon Items Available");
		foreach (AmazonItem availableItem in AmazonIAPEventListener.AvailableItems)
		{
			DisplayAmazonItem(availableItem);
		}
		if (AmazonIAPEventListener.UnavailableSkus == null || AmazonIAPEventListener.UnavailableSkus.Count <= 0)
		{
			return;
		}
		AmazonGUIHelpers.CenteredLabel("Unavailable Skus");
		foreach (string unavailableSku in AmazonIAPEventListener.UnavailableSkus)
		{
			AmazonGUIHelpers.CenteredLabel(unavailableSku);
		}
	}

	private void DisplayAmazonItem(AmazonItem item)
	{
		GUILayout.BeginVertical(GUI.skin.box);
		AmazonGUIHelpers.CenteredLabel(string.Format("{0}", item.title));
		AmazonGUIHelpers.CenteredLabel(string.Format("Sku: {0}, Price: {1}", item.sku, item.price));
		AmazonGUIHelpers.CenteredLabel(string.Format("{0}", item.description));
		AmazonGUIHelpers.CenteredLabel(string.Format("Type: {0}, Url: {1}", item.type, item.smallIconUrl));
		if (GUILayout.Button("Initiate Purchase Request"))
		{
			AmazonIAP.initiatePurchaseRequest(item.sku);
		}
		GUILayout.EndVertical();
	}

	private void DisplayAmazonUserID()
	{
		if (string.IsNullOrEmpty(AmazonIAPEventListener.UserId))
		{
			if (GUILayout.Button("Initialize User ID Request"))
			{
				AmazonIAP.initiateGetUserIdRequest();
			}
		}
		else
		{
			AmazonGUIHelpers.CenteredLabel(string.Format("User ID {0}", AmazonIAPEventListener.UserId));
		}
	}

	private void InitializeUI()
	{
		if (!uiInitialized)
		{
			uiInitialized = true;
			AmazonGUIHelpers.SetGUISkinTouchFriendly(GUI.skin);
		}
	}
}
