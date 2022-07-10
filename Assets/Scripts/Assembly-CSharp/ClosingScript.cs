using System.Collections;
using UnityEngine;
using UnityEngine.UI;

internal sealed class ClosingScript : MonoBehaviour
{
	public RawImage background;

	private IEnumerator Start()
	{
		Debug.LogWarning("Closing...");
		if (background != null)
		{
			yield return new WaitForSeconds(1f);
			RectTransform rectTransform = background.rectTransform;
			int startFrameIndex = Time.frameCount;
			float framerate = (Application.isEditor ? 300 : ((Application.targetFrameRate <= 0) ? 60 : Application.targetFrameRate));
			float minYScale = 2f / (float)Screen.height;
			while (true)
			{
				float alpha = (float)(Time.frameCount - startFrameIndex) / (0.5f * framerate);
				float yScale = Mathf.Lerp(1f, 0f, alpha);
				rectTransform.localScale = new Vector3(1f, Mathf.Max(minYScale, yScale), 1f);
				if (yScale < 0.01f)
				{
					break;
				}
				yield return null;
			}
			Color targetColor = new Color(background.color.r, background.color.g, background.color.b, 0.2f);
			while (true)
			{
				float relativeAlpha = 4f * Time.deltaTime;
				float xScale = Mathf.Lerp(rectTransform.localScale.x, 0f, relativeAlpha);
				rectTransform.localScale = new Vector3(xScale, rectTransform.localScale.y, rectTransform.localScale.z);
				background.color = Color.Lerp(background.color, targetColor, relativeAlpha);
				if (xScale < 0.001f)
				{
					break;
				}
				yield return null;
			}
		}
		Debug.LogWarning("Quitting intentionally...");
		if (!Application.isEditor)
		{
			Application.Quit();
		}
	}
}
