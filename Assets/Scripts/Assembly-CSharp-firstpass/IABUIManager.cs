using Prime31;
using UnityEngine;

public class IABUIManager : MonoBehaviourGUI
{
	private void OnGUI()
	{
		beginColumn();
		if (GUILayout.Button("Initialize IAB"))
		{
			string text = "your public key from the Android developer portal here";
			text = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoTzMTaqsFhaywvCFKawFwL5KM+djLJfOCT/rbGQRfHmHYmOY2sBMgDWsA/67Szx6EVTZPVlFzHMgkAq1TwdL/A5aYGpGzaCX7o96cyp8R6wSF+xCuj++LAkTaDnLW0veI2bke3EVHu3At9xgM46e+VDucRUqQLvf6SQRb15nuflY5i08xKnewgX7I4U2H0RvAZDyoip+qZPmI4ZvaufAfc0jwZbw7XGiV41zibY3LU0N57mYKk51Wx+tOaJ7Tkc9Rl1qVCTjb+bwXshTqhVXVP6r4kabLWw/8OJUh0Sm69lbps6amP7vPy571XjscCTMLfXQan1959rHbNgkb2mLLQIDAQAB";
			GoogleIAB.init(text);
		}
		if (GUILayout.Button("Query Inventory"))
		{
			string[] skus = new string[4] { "com.prime31.testproduct", "android.test.purchased", "com.prime31.managedproduct", "com.prime31.testsubscription" };
			GoogleIAB.queryInventory(skus);
		}
		if (GUILayout.Button("Are subscriptions supported?"))
		{
			Debug.Log("subscriptions supported: " + GoogleIAB.areSubscriptionsSupported());
		}
		if (GUILayout.Button("Purchase Test Product"))
		{
			GoogleIAB.purchaseProduct("android.test.purchased");
		}
		if (GUILayout.Button("Consume Test Purchase"))
		{
			GoogleIAB.consumeProduct("android.test.purchased");
		}
		if (GUILayout.Button("Test Unavailable Item"))
		{
			GoogleIAB.purchaseProduct("android.test.item_unavailable");
		}
		endColumn(true);
		if (GUILayout.Button("Purchase Real Product"))
		{
			GoogleIAB.purchaseProduct("com.prime31.testproduct", "payload that gets stored and returned");
		}
		if (GUILayout.Button("Purchase Real Subscription"))
		{
			GoogleIAB.purchaseProduct("com.prime31.testsubscription", "subscription payload");
		}
		if (GUILayout.Button("Consume Real Purchase"))
		{
			GoogleIAB.consumeProduct("com.prime31.testproduct");
		}
		if (GUILayout.Button("Enable High Details Logs"))
		{
			GoogleIAB.enableLogging(true);
		}
		if (GUILayout.Button("Consume Multiple Purchases"))
		{
			string[] skus2 = new string[2] { "com.prime31.testproduct", "android.test.purchased" };
			GoogleIAB.consumeProducts(skus2);
		}
		endColumn();
	}
}
