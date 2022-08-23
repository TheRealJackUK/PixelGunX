using System.Collections.Generic;
using System.IO;
using Prime31;
using UnityEngine;

public class FacebookUIManager : MonoBehaviourGUI
{
	public static string screenshotFilename = "someScreenshot.png";

	private void completionHandler(string error, object result)
	{
		if (error != null)
		{
			Debug.LogError(error);
		}
		else
		{
			Utils.logObject(result);
		}
	}

	private void Start()
	{
		ScreenCapture.CaptureScreenshot(screenshotFilename);
	}

	private void OnGUI()
	{
		beginColumn();
		if (GUILayout.Button("Initialize Facebook"))
		{
			FacebookAndroid.init(true);
		}
		if (GUILayout.Button("Set Login Behavior to SUPPRESS_SSO"))
		{
			FacebookAndroid.setSessionLoginBehavior(FacebookSessionLoginBehavior.SUPPRESS_SSO);
		}
		if (GUILayout.Button("Login"))
		{
			FacebookAndroid.loginWithReadPermissions(new string[2] { "email", "user_birthday" });
		}
		if (GUILayout.Button("Reauthorize with Publish Permissions"))
		{
			FacebookAndroid.reauthorizeWithPublishPermissions(new string[2] { "publish_actions", "manage_friendlists" }, FacebookSessionDefaultAudience.Everyone);
		}
		if (GUILayout.Button("Logout"))
		{
			FacebookAndroid.logout();
		}
		if (GUILayout.Button("Is Session Valid?"))
		{
			bool flag = FacebookAndroid.isSessionValid();
			Debug.Log("Is session valid?: " + flag);
		}
		if (GUILayout.Button("Get Session Token"))
		{
			string accessToken = FacebookAndroid.getAccessToken();
			Debug.Log("session token: " + accessToken);
		}
		if (GUILayout.Button("Get Granted Permissions"))
		{
			List<object> sessionPermissions = FacebookAndroid.getSessionPermissions();
			Debug.Log("granted permissions: " + sessionPermissions.Count);
			Utils.logObject(sessionPermissions);
		}
		endColumn(true);
		if (GUILayout.Button("Post Image"))
		{
			string path = Application.persistentDataPath + "/" + screenshotFilename;
			byte[] image = File.ReadAllBytes(path);
			Facebook.instance.postImage(image, "im an image posted from Android", completionHandler);
		}
		if (GUILayout.Button("Graph Request (me)"))
		{
			Facebook.instance.graphRequest("me", completionHandler);
		}
		if (GUILayout.Button("Post Message"))
		{
			Facebook.instance.postMessage("im posting this from Unity: " + Time.deltaTime, completionHandler);
		}
		if (GUILayout.Button("Post Message & Extras"))
		{
			Facebook.instance.postMessageWithLinkAndLinkToImage("link post from Unity: " + Time.deltaTime, "http://prime31.com", "prime[31]", "http://prime31.com/assets/images/prime31logo.png", "Prime31 Logo", completionHandler);
		}
		if (GUILayout.Button("Show Share Dialog"))
		{
			Dictionary<string, object> dictionary = new Dictionary<string, object>();
			dictionary.Add("link", "http://prime31.com");
			dictionary.Add("name", "link name goes here");
			dictionary.Add("picture", "http://prime31.com/assets/images/prime31logo.png");
			dictionary.Add("caption", "the caption for the image is here");
			dictionary.Add("description", "description of what this share dialog is all about");
			Dictionary<string, object> parameters = dictionary;
			FacebookAndroid.showFacebookShareDialog(parameters);
		}
		if (GUILayout.Button("Show Post Dialog"))
		{
			Dictionary<string, string> dictionary2 = new Dictionary<string, string>();
			dictionary2.Add("link", "http://prime31.com");
			dictionary2.Add("name", "link name goes here");
			dictionary2.Add("picture", "http://prime31.com/assets/images/prime31logo.png");
			dictionary2.Add("caption", "the caption for the image is here");
			Dictionary<string, string> parameters2 = dictionary2;
			FacebookAndroid.showDialog("stream.publish", parameters2);
		}
		if (GUILayout.Button("Show Apprequests Dialog"))
		{
			Dictionary<string, string> dictionary2 = new Dictionary<string, string>();
			dictionary2.Add("message", "Come play my awesome game!");
			Dictionary<string, string> parameters3 = dictionary2;
			FacebookAndroid.showDialog("apprequests", parameters3);
		}
		if (GUILayout.Button("Get Friends"))
		{
			Facebook.instance.getFriends(completionHandler);
		}
		if (GUILayout.Button("Log App Event"))
		{
			Dictionary<string, object> dictionary = new Dictionary<string, object>();
			dictionary.Add("someKey", 55);
			dictionary.Add("anotherKey", "string value");
			Dictionary<string, object> parameters4 = dictionary;
			FacebookAndroid.logEvent("fb_mobile_add_to_cart", parameters4);
		}
		endColumn();
		if (bottomLeftButton("Twitter Scene"))
		{
			Application.LoadLevel("TwitterTestScene");
		}
	}
}
