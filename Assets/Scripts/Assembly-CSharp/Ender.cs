using System.Collections;
using UnityEngine;

[ExecuteInEditMode]
public class Ender : MonoBehaviour
{
	public GUIStyle buttonStyle;

	public GameObject enderPers;

	public GameObject cam;

	public GameObject[] clouds;

	public GameObject text;

	private Camera _camera;

	private GUIText _text;

	private readonly float _pauseBeforeClouds = 1f;

	private readonly float _pauseBetweenClouds = 0.1f;

	private readonly float _pauseBetweenTexts = 3f;

	private IEnumerator Start()
	{
		MainMenu.BlockInterface = true;
		_camera = cam.GetComponent<Camera>();
		_text = text.GetComponent<GUIText>();
		float animLength = enderPers.GetComponent<Animation>().GetComponent<Animation>()["Ender_AD"].length;
		yield return new WaitForSeconds(_pauseBeforeClouds);
		for (int i = 0; i < clouds.Length; i++)
		{
			clouds[i].SetActive(true);
			if (i == clouds.Length - 1)
			{
				text.SetActive(true);
			}
			yield return new WaitForSeconds(_pauseBetweenClouds);
		}
		yield return new WaitForSeconds(_pauseBetweenTexts);
		text.transform.localPosition = new Vector3(0.375f, text.transform.localPosition.y, text.transform.localPosition.z);
		_text.text = "See you!\nYou can\nfind me in\nFree Coins!";
		yield return new WaitForSeconds(animLength - _pauseBeforeClouds - (float)clouds.Length * _pauseBetweenClouds - _pauseBetweenTexts);
		MainMenu.BlockInterface = false;
		Object.Destroy(base.gameObject);
	}

	private void OnGUI()
	{
		if (!(MainMenuController.sharedController != null) || !MainMenuController.sharedController.stubLoading.activeSelf)
		{
			GUI.enabled = true;
			GUI.depth = -10000;
			Rect position = new Rect(0f, (float)Screen.height - (float)_camera.targetTexture.height * Defs.Coef, (float)_camera.targetTexture.width * Defs.Coef, (float)_camera.targetTexture.height * Defs.Coef);
			GUI.DrawTexture(position, _camera.targetTexture);
			position.width /= 2f;
			if (GUI.Button(position, string.Empty, buttonStyle))
			{
				MainMenu.BlockInterface = false;
				FlurryPluginWrapper.LogEvent("Ender3D");
				Object.Destroy(base.gameObject);
				Application.OpenURL(MainMenu.GetEndermanUrl());
			}
		}
	}
}
