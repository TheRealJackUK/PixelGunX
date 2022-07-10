using System.Collections;
using UnityEngine;

public class ECPNManager : MonoBehaviour
{
	public string GoogleCloudMessageProjectID = "339873998127";

	public string phpFilesLocation = "https://secure.pixelgunserver.com/ecpn";

	public string packageName = "com.pixel.gun3d";

	private string devToken;

	private AndroidJavaObject playerActivityContext;

	public void RequestDeviceToken()
	{
		if (!Application.isEditor)
		{
			if (playerActivityContext == null)
			{
				AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
				playerActivityContext = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
			}
			AndroidJavaClass androidJavaClass2 = new AndroidJavaClass(packageName + ".GCMRegistration");
			androidJavaClass2.CallStatic("RegisterDevice", playerActivityContext, GoogleCloudMessageProjectID);
		}
	}

	public void RequestUnregisterDevice()
	{
		if (playerActivityContext == null)
		{
			AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
			playerActivityContext = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
		}
		AndroidJavaClass androidJavaClass2 = new AndroidJavaClass(packageName + ".GCMRegistration");
		androidJavaClass2.CallStatic("UnregisterDevice", playerActivityContext);
	}

	public void SendMessageToAll()
	{
		StartCoroutine(SendECPNmessage());
	}

	public string GetDevToken()
	{
		return devToken;
	}

	public void RegisterAndroidDevice(string rID)
	{
		Debug.Log("DeviceToken: " + rID);
		StartCoroutine(StoreDeviceID(rID, "android"));
	}

	public void UnregisterDevice(string rID)
	{
		Debug.Log("Unregister DeviceToken: " + rID);
		StartCoroutine(DeleteDeviceFromServer(rID));
	}

	private IEnumerator StoreDeviceID(string rID, string os)
	{
		devToken = rID;
		WWWForm form = new WWWForm();
		form.AddField("user", SystemInfo.deviceUniqueIdentifier);
		form.AddField("OS", os);
		form.AddField("regID", devToken);
		WWW w = new WWW(phpFilesLocation + "/RegisterDeviceIDtoDB.php", form);
		yield return w;
		int errorCode2;
		if (w.error != null)
		{
			errorCode2 = -1;
			yield break;
		}
		string formText = w.text;
		w.Dispose();
		errorCode2 = int.Parse(formText);
	}

	private IEnumerator SendECPNmessage()
	{
		WWWForm form = new WWWForm();
		form.AddField("user", SystemInfo.deviceUniqueIdentifier);
		WWW w = new WWW(phpFilesLocation + "/SendECPNmessageAll.php", form);
		yield return w;
		if (w.error != null)
		{
			Debug.Log("Error while sending message to all: " + w.error);
			yield break;
		}
		string formText = w.text;
		Debug.Log(w.text);
		w.Dispose();
	}

	private IEnumerator DeleteDeviceFromServer(string rID)
	{
		WWWForm form = new WWWForm();
		form.AddField("regID", rID);
		WWW w = new WWW(phpFilesLocation + "/UnregisterDeviceIDfromDB.php", form);
		yield return w;
		int errorCode2;
		if (w.error != null)
		{
			errorCode2 = -1;
			yield break;
		}
		string formText = w.text;
		w.Dispose();
		errorCode2 = int.Parse(formText);
		devToken = string.Empty;
	}
}
