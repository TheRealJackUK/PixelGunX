using UnityEngine;

public class EveryplayFaceCamTest : MonoBehaviour
{
	private bool recordingPermissionGranted;

	private GameObject debugMessage;

	private void Awake()
	{
		Object.DontDestroyOnLoad(base.gameObject);
	}

	private void Start()
	{
		Everyplay.FaceCamRecordingPermission += CheckFaceCamRecordingPermission;
	}

	private void Destroy()
	{
		Everyplay.FaceCamRecordingPermission -= CheckFaceCamRecordingPermission;
	}

	private void CheckFaceCamRecordingPermission(bool granted)
	{
		recordingPermissionGranted = granted;
		if (granted || (bool)debugMessage)
		{
			return;
		}
		debugMessage = new GameObject("FaceCamDebugMessage", typeof(GUIText));
		debugMessage.transform.position = new Vector3(0.5f, 0.5f, 0f);
		if (debugMessage != null)
		{
			GUIText component = debugMessage.GetComponent<GUIText>();
			if ((bool)component)
			{
				component.text = "Microphone access denied. FaceCam requires access to the microphone.\nPlease enable Microphone access from Settings / Privacy / Microphone.";
				component.alignment = TextAlignment.Center;
				component.anchor = TextAnchor.MiddleCenter;
			}
		}
	}

	private void OnGUI()
	{
		if (recordingPermissionGranted)
		{
			if (GUI.Button(new Rect(Screen.width - 10 - 158, 10f, 158f, 48f), (!Everyplay.FaceCamIsSessionRunning()) ? "Start FaceCam session" : "Stop FaceCam session"))
			{
				if (Everyplay.FaceCamIsSessionRunning())
				{
					Everyplay.FaceCamStopSession();
				}
				else
				{
					Everyplay.FaceCamStartSession();
				}
			}
		}
		else if (GUI.Button(new Rect(Screen.width - 10 - 158, 10f, 158f, 48f), "Request REC permission"))
		{
			Everyplay.FaceCamRequestRecordingPermission();
		}
	}
}
