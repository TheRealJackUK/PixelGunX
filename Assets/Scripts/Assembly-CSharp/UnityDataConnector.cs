using System.Collections;
using LitJson;
using UnityEngine;

public class UnityDataConnector : MonoBehaviour
{
	public string webServiceUrl = string.Empty;

	public string spreadsheetId = string.Empty;

	public string worksheetName = string.Empty;

	public string password = string.Empty;

	public float maxWaitTime = 10f;

	public GameObject dataDestinationObject;

	public string statisticsWorksheetName = "Statistics";

	public bool debugMode;

	private bool updating;

	private string currentStatus;

	private JsonData[] ssObjects;

	private bool saveToGS;

	private Rect guiBoxRect;

	private Rect guiButtonRect;

	private Rect guiButtonRect2;

	private Rect guiButtonRect3;

	private void Start()
	{
		updating = false;
		currentStatus = "Offline";
		saveToGS = false;
		guiBoxRect = new Rect(10f, 10f, 310f, 140f);
		guiButtonRect = new Rect(30f, 40f, 270f, 30f);
		guiButtonRect2 = new Rect(30f, 75f, 270f, 30f);
		guiButtonRect3 = new Rect(30f, 110f, 270f, 30f);
	}

	private void OnGUI()
	{
		GUI.Box(guiBoxRect, currentStatus);
		if (GUI.Button(guiButtonRect, "Update From Google Spreadsheet"))
		{
			Connect();
		}
		saveToGS = GUI.Toggle(guiButtonRect2, saveToGS, "Save Stats To Google Spreadsheet");
		if (GUI.Button(guiButtonRect3, "Reset Balls values"))
		{
			dataDestinationObject.SendMessage("ResetBalls");
		}
	}

	private void Connect()
	{
		if (!updating)
		{
			updating = true;
			StartCoroutine(GetData());
		}
	}

	private IEnumerator GetData()
	{
		string connectionString = webServiceUrl + "?ssid=" + spreadsheetId + "&sheet=" + worksheetName + "&pass=" + password + "&action=GetData";
		if (debugMode)
		{
			Debug.Log("Connecting to webservice on " + connectionString);
		}
		WWW www = new WWW(connectionString);
		float elapsedTime = 0f;
		currentStatus = "Stablishing Connection... ";
		while (!www.isDone)
		{
			elapsedTime += Time.deltaTime;
			if (elapsedTime >= maxWaitTime)
			{
				currentStatus = "Max wait time reached, connection aborted.";
				Debug.Log(currentStatus);
				updating = false;
				break;
			}
			yield return null;
		}
		if (!www.isDone || !string.IsNullOrEmpty(www.error))
		{
			currentStatus = "Connection error after" + elapsedTime + "seconds: " + www.error;
			Debug.LogError(currentStatus);
			updating = false;
			yield break;
		}
		string response = www.text;
		Debug.Log(elapsedTime + " : " + response);
		currentStatus = "Connection stablished, parsing data...";
		if (response == "\"Incorrect Password.\"")
		{
			currentStatus = "Connection error: Incorrect Password.";
			Debug.LogError(currentStatus);
			updating = false;
			yield break;
		}
		try
		{
			ssObjects = JsonMapper.ToObject<JsonData[]>(response);
		}
		catch
		{
			currentStatus = "Data error: could not parse retrieved data as json.";
			Debug.LogError(currentStatus);
			updating = false;
			yield break;
		}
		currentStatus = "Data Successfully Retrieved!";
		updating = false;
		dataDestinationObject.SendMessage("DoSomethingWithTheData", ssObjects);
	}

	public void SaveDataOnTheCloud(string ballName, float collisionMagnitude)
	{
		if (saveToGS)
		{
			StartCoroutine(SendData(ballName, collisionMagnitude));
		}
	}

	private IEnumerator SendData(string ballName, float collisionMagnitude)
	{
		if (!saveToGS)
		{
			yield break;
		}
		string connectionString = webServiceUrl + "?ssid=" + spreadsheetId + "&sheet=" + statisticsWorksheetName + "&pass=" + password + "&val1=" + ballName + "&val2=" + collisionMagnitude + "&action=SetData";
		if (debugMode)
		{
			Debug.Log("Connection String: " + connectionString);
		}
		WWW www = new WWW(connectionString);
		float elapsedTime = 0f;
		while (!www.isDone)
		{
			elapsedTime += Time.deltaTime;
			if (elapsedTime >= maxWaitTime)
			{
				break;
			}
			yield return null;
		}
		if (www.isDone && string.IsNullOrEmpty(www.error))
		{
			string response = www.text;
			if (!response.Contains("Incorrect Password") && !response.Contains("RCVD OK"))
			{
			}
		}
	}
}
