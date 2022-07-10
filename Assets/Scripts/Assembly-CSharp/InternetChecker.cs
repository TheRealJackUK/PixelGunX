using System.IO;
using System.Net;
using UnityEngine;

internal sealed class InternetChecker : MonoBehaviour
{
	public static bool InternetAvailable;

	public GameObject consolePrefab;

	private void Start()
	{
		Object.DontDestroyOnLoad(base.gameObject);
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
