using System.IO;
using System.Net;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

internal sealed class InternetChecker : MonoBehaviour
{
	public static bool InternetAvailable;

	public GameObject consolePrefab;


	public void OnGUI()
	{
		string input11 = string.Empty;
	    if (Application.loadedLevelName == "DeveloperConsole") {
	        input11 = GUI.TextField(new Rect(10, 120, 100, 20), input11, 25);
	        if (GUI.Button(new Rect(10, 140, 80, 20), "load scene")) {
	            Application.LoadLevel(input11);
	        }
	    }
	}
	private void Start()
	{
		Object.DontDestroyOnLoad(base.gameObject);
		if (Storager.getInt("camerafov", false) == 0 || Storager.getInt("camerafov", false) == null || Storager.getInt("camerafov", false) == 180)
    	{
    	    Storager.setInt("camerafov", 44, false);
    	}
    	Storager.setInt(Defs.ShownLobbyLevelSN, 31, false);
    	PhotonNetwork.PhotonServerSettings.AppID = "c844400a-3502-4117-85cd-a2a3b7b7bcf8";
    	PhotonNetwork.PhotonServerSettings.HostType = ServerSettings.HostingOption.PhotonCloud; 
	}

	public void Update()
	{
		if (Application.loadedLevelName.StartsWith("Menu_") || Application.loadedLevelName == "ConnectScene")
		{
			Cursor.visible = true;
			Cursor.lockState = CursorLockMode.None;
		}
		if (Application.isMobilePlatform && GameObject.Find("Main Camera").GetComponent<PostProcessLayer>() != null)
		{
		    PostProcessLayer renderer = GameObject.Find("Main Camera").GetComponent<PostProcessLayer>();
		    if (renderer != null && renderer.enabled != false && Application.isMobilePlatform && GameObject.Find("Pers_Main_Point").GetComponent<PostProcessVolume>() != null && GameObject.Find("Pers_Main_Point").GetComponent<PostProcessVolume>().enabled)
		    {
		           Destroy(renderer);
		        Destroy(GameObject.Find("Pers_Main_Point").GetComponent<PostProcessVolume>());
		    }
		}
	}

	public static void CheckForInternetConn()
	{
		string htmlFromUri = GetHtmlFromUri("http://google.com");
		if (htmlFromUri == string.Empty)
		{
			InternetAvailable = false;
		}
		else if (!htmlFromUri.Contains("schema.org/WebPage"))
		{
			InternetAvailable = false;
		}
		else
		{
			InternetAvailable = true;
		}
	}

	public static string GetHtmlFromUri(string resource)
	{
		//Discarded unreachable code: IL_00e1
		string text = string.Empty;
		HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(resource);
		try
		{
			using (HttpWebResponse httpWebResponse = (HttpWebResponse)httpWebRequest.GetResponse())
			{
				if (httpWebResponse.StatusCode < (HttpStatusCode)299 && httpWebResponse.StatusCode >= HttpStatusCode.OK)
				{
					Debug.Log("Trying to check internet");
					using (StreamReader streamReader = new StreamReader(httpWebResponse.GetResponseStream()))
					{
						char[] array = new char[80];
						streamReader.Read(array, 0, array.Length);
						char[] array2 = array;
						foreach (char c in array2)
						{
							text += c;
						}
						return text;
					}
				}
				return text;
			}
		}
		catch
		{
			return string.Empty;
		}
	}
}
