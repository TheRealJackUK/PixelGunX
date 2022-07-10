using System;
using System.Collections;
using Rilisoft;
using UnityEngine;

internal sealed class LevelCompleteLoader : MonoBehaviour
{
	public static Action action;

	public static string sceneName = string.Empty;

	private Texture fon;

	private Texture loadingNote;

	private void Start()
	{
		if (StoreKitEventListener.purchaseActivityInd != null)
		{
			StoreKitEventListener.purchaseActivityInd.SetActive(true);
		}
		if (!sceneName.Equals("LevelComplete"))
		{
			string path = ConnectSceneNGUIController.MainLoadingTexture();
			fon = Resources.Load<Texture>(path);
		}
		else
		{
			string path2 = ((!MemoryLimit.OptOut()) ? ("LevelLoadings" + ((!Device.isRetinaAndStrong) ? string.Empty : "/Hi") + "/LevelComplete_back") : ("LevelLoadings" + ((!Device.isRetinaAndStrong) ? string.Empty : "/Hi") + "/LevelComplete_back-low"));
			if (Defs.IsSurvival)
			{
				path2 = "GameOver_Coliseum";
			}
			fon = Resources.Load<Texture>(path2);
		}
		StartCoroutine(loadNext());
		CampaignProgress.SaveCampaignProgress();
		PlayerPrefs.Save();
	}

	private IEnumerator loadNext()
	{
		yield return new WaitForSeconds(0.25f);
		Application.LoadLevel(sceneName);
	}

	private void OnGUI()
	{
		Rect position = new Rect((float)Screen.width / 2f - 1366f * Defs.Coef / 2f, 0f, 1366f * Defs.Coef, 768f * Defs.Coef);
		GUI.DrawTexture(position, fon);
		if (!sceneName.Equals("LevelComplete"))
		{
			if (loadingNote == null)
			{
				loadingNote = Resources.Load<Texture>("LevelLoadings" + ((!Device.isRetinaAndStrong) ? string.Empty : "/Hi") + "/Loading");
			}
			if (!(loadingNote != null))
			{
			}
		}
	}
}
