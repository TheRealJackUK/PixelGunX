using System.Collections;
using System.Reflection;
using Rilisoft;
using UnityEngine;

[AddComponentMenu("Utilities/HUDFPS")]
public class HUDFPS : MonoBehaviour
{
	private Rect startRect = new Rect((float)Screen.width * 0.2f, (float)Screen.height - 55f * Defs.Coef, 150f * Defs.Coef, 55f * Defs.Coef);

	public bool updateColor = true;

	public bool allowDrag = true;

	public float frequency = 0.5f;

	public int nbDecimal = 1;

	private float accum;

	private int frames;

	private Color color = Color.white;

	private string sFPS = string.Empty;

	private GUIStyle style;

	private string maxFPS = "0.0";

	private string minFPS = "300.0";

	private string middleFPS = "0.0";

	private float updateTime = 5f;

	private ArrayList fpsArray;

	private float sumFps;

	private int countFps;

	private void Start()
	{
		sumFps = 0f;
		countFps = 0;
		InvokeRepeating("updateMidFPS", 5f, updateTime);
		fpsArray = new ArrayList();
		StartCoroutine(FPS());
	}

	[Obfuscation(Exclude = true)]
	private void updateMidFPS()
	{
		if (BuildSettings.BuildTarget == BuildTarget.WP8Player || fpsArray == null)
		{
			return;
		}
		float num = 0f;
		foreach (float item in fpsArray)
		{
			if (item > 0f)
			{
				num += item;
			}
		}
		middleFPS = (num / (float)fpsArray.Count).ToString("f" + Mathf.Clamp(nbDecimal, 0, 10));
	}

	private void Update()
	{
		accum += Time.timeScale / Time.deltaTime;
		frames++;
	}

	private IEnumerator FPS()
	{
		while (true)
		{
			float fps = accum / (float)frames;
			sumFps += fps;
			countFps++;
			if (fps > 0f)
			{
				fpsArray.Add(fps);
				if (fpsArray.Count > 320)
				{
					fpsArray.RemoveAt(0);
				}
			}
			float maxFPSFloat;
			if (float.TryParse(maxFPS, out maxFPSFloat) && fps > maxFPSFloat)
			{
				maxFPS = fps.ToString("f" + Mathf.Clamp(nbDecimal, 0, 10));
			}
			float minFPSFloat;
			if (float.TryParse(minFPS, out minFPSFloat) && fps < minFPSFloat)
			{
				minFPS = fps.ToString("f" + Mathf.Clamp(nbDecimal, 0, 10));
			}
			sFPS = fps.ToString("f" + Mathf.Clamp(nbDecimal, 0, 10));
			color = ((fps >= 30f) ? Color.green : ((!(fps > 10f)) ? Color.yellow : Color.red));
			accum = 0f;
			frames = 0;
			yield return new WaitForSeconds(frequency);
		}
	}

	private void OnGUI()
	{
		if (DeveloperConsoleController.isDebugGuiVisible)
		{
			if (PhotonNetwork.connected && GUI.Button(new Rect(10f, 5f, 100f, 100f), "DISCONNECT"))
			{
				PhotonNetwork.Disconnect();
			}
			if (style == null)
			{
				style = new GUIStyle(GUI.skin.label);
				style.normal.textColor = Color.white;
				style.alignment = TextAnchor.UpperCenter;
				style.fontSize = Mathf.RoundToInt(12f * Defs.Coef);
			}
			GUI.color = ((!updateColor) ? Color.white : color);
			startRect = GUI.Window(1, startRect, DoMyWindow, string.Empty);
		}
	}

	private void DoMyWindow(int windowID)
	{
		GUI.Label(new Rect(0f, 2f * Defs.Coef, startRect.width / 2f, startRect.height), sFPS + " FPS", style);
		GUI.Label(new Rect(0f, 17f * Defs.Coef, startRect.width / 2f, startRect.height), maxFPS + " MAX", style);
		GUI.Label(new Rect(startRect.width / 2f, 17f * Defs.Coef, startRect.width / 2f, startRect.height), minFPS + " MIN", style);
		GUI.Label(new Rect(startRect.width / 2f, 2f * Defs.Coef, startRect.width / 2f, startRect.height), middleFPS + " MID", style);
		GUI.Label(new Rect(0f, 32f * Defs.Coef, startRect.width / 2f, startRect.height), PhotonNetwork.GetPing() + " PNG", style);
		GUI.Label(new Rect(startRect.width / 2f, 32f * Defs.Coef, startRect.width / 2f, startRect.height), Mathf.RoundToInt(sumFps / (float)countFps) + " MidTime", style);
		if (GUI.Button(new Rect(10f, 5f * Defs.Coef, startRect.width - 20f, startRect.height - 10f), string.Empty, style))
		{
			sumFps = 0f;
			countFps = 0;
			maxFPS = "0.0";
			minFPS = "300.0";
		}
	}
}
