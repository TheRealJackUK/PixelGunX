using System.Collections;
using UnityEngine;

public class EveryplayTest : MonoBehaviour
{
	public bool showUploadStatus = true;

	private bool isRecording;

	private bool isPaused;

	private bool isRecordingFinished;

	private GUIText uploadStatusLabel;

	private Texture2D previousThumbnail;

	private void Awake()
	{
		if (base.enabled && showUploadStatus)
		{
			CreateUploadStatusLabel();
		}
		Object.DontDestroyOnLoad(base.gameObject);
	}

	private void Start()
	{
		if (uploadStatusLabel != null)
		{
			Everyplay.UploadDidStart += UploadDidStart;
			Everyplay.UploadDidProgress += UploadDidProgress;
			Everyplay.UploadDidComplete += UploadDidComplete;
		}
		Everyplay.RecordingStarted += RecordingStarted;
		Everyplay.RecordingStopped += RecordingStopped;
		Everyplay.ThumbnailReadyAtFilePath += ThumbnailReadyAtFilePath;
	}

	private void Destroy()
	{
		if (uploadStatusLabel != null)
		{
			Everyplay.UploadDidStart -= UploadDidStart;
			Everyplay.UploadDidProgress -= UploadDidProgress;
			Everyplay.UploadDidComplete -= UploadDidComplete;
		}
		Everyplay.RecordingStarted -= RecordingStarted;
		Everyplay.RecordingStopped -= RecordingStopped;
		Everyplay.ThumbnailReadyAtFilePath -= ThumbnailReadyAtFilePath;
	}

	private void RecordingStarted()
	{
		isRecording = true;
		isPaused = false;
		isRecordingFinished = false;
	}

	private void RecordingStopped()
	{
		isRecording = false;
		isRecordingFinished = true;
	}

	private void CreateUploadStatusLabel()
	{
		GameObject gameObject = new GameObject("UploadStatus", typeof(GUIText));
		if ((bool)gameObject)
		{
			gameObject.transform.parent = base.transform;
			uploadStatusLabel = gameObject.GetComponent<GUIText>();
			if (uploadStatusLabel != null)
			{
				uploadStatusLabel.anchor = TextAnchor.LowerLeft;
				uploadStatusLabel.alignment = TextAlignment.Left;
				uploadStatusLabel.text = "Not uploading";
			}
		}
	}

	private void UploadDidStart(int videoId)
	{
		uploadStatusLabel.text = "Upload " + videoId + " started.";
	}

	private void UploadDidProgress(int videoId, float progress)
	{
		uploadStatusLabel.text = "Upload " + videoId + " is " + Mathf.RoundToInt(progress * 100f) + "% completed.";
	}

	private void UploadDidComplete(int videoId)
	{
		uploadStatusLabel.text = "Upload " + videoId + " completed.";
		StartCoroutine(ResetUploadStatusAfterDelay(2f));
	}

	private IEnumerator ResetUploadStatusAfterDelay(float time)
	{
		yield return new WaitForSeconds(time);
		uploadStatusLabel.text = "Not uploading";
	}

	private void ThumbnailReadyAtFilePath(string path)
	{
		Everyplay.LoadThumbnailFromFilePath(path, ThumbnailSuccess, ThumbnailError);
	}

	private void ThumbnailSuccess(Texture2D texture)
	{
		if (texture != null)
		{
			previousThumbnail = texture;
		}
	}

	private void ThumbnailError(string error)
	{
		Debug.Log("Thumbnail loading failed: " + error);
	}

	private void OnGUI()
	{
		if (GUI.Button(new Rect(10f, 10f, 138f, 48f), "Everyplay"))
		{
			Everyplay.Show();
		}
		if (isRecording && GUI.Button(new Rect(10f, 64f, 138f, 48f), "Stop Recording"))
		{
			Everyplay.StopRecording();
		}
		else if (!isRecording && GUI.Button(new Rect(10f, 64f, 138f, 48f), "Start Recording"))
		{
			Everyplay.StartRecording();
		}
		if (isRecording)
		{
			if (!isPaused && GUI.Button(new Rect(160f, 64f, 138f, 48f), "Pause Recording"))
			{
				Everyplay.PauseRecording();
				isPaused = true;
			}
			else if (isPaused && GUI.Button(new Rect(160f, 64f, 138f, 48f), "Resume Recording"))
			{
				Everyplay.ResumeRecording();
				isPaused = false;
			}
		}
		if (isRecordingFinished && GUI.Button(new Rect(10f, 118f, 138f, 48f), "Play Last Recording"))
		{
			Everyplay.PlayLastRecording();
		}
		if (isRecording && GUI.Button(new Rect(10f, 118f, 138f, 48f), "Take Thumbnail"))
		{
			Everyplay.TakeThumbnail();
		}
		if (isRecordingFinished && GUI.Button(new Rect(10f, 172f, 138f, 48f), "Show sharing modal"))
		{
			Everyplay.ShowSharingModal();
		}
		if (previousThumbnail != null)
		{
			int num = Screen.width - previousThumbnail.width - 10;
			int num2 = Screen.height - previousThumbnail.height - 10;
			GUI.DrawTexture(new Rect(num, num2, previousThumbnail.width, previousThumbnail.height), previousThumbnail, ScaleMode.ScaleToFit, false, 0f);
		}
	}
}
