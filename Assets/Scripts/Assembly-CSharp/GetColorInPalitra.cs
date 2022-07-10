using UnityEngine;

public class GetColorInPalitra : MonoBehaviour
{
	public UITexture canvasTexture;

	private bool isMouseDown;

	public UISprite newColor;

	public UIButton okColorInPalitraButton;

	private void Start()
	{
	}

	private void Update()
	{
		if (Input.GetMouseButtonUp(0))
		{
			isMouseDown = false;
		}
		if ((Input.touchCount <= 0 || Input.touches[0].phase == TouchPhase.Ended || Input.touches[0].phase == TouchPhase.Canceled) && !isMouseDown && !Input.GetMouseButtonDown(0))
		{
			return;
		}
		Vector2 pos = ((Input.touchCount <= 0) ? new Vector2(Input.mousePosition.x, Input.mousePosition.y) : new Vector2(Input.touches[0].position.x, Input.touches[0].position.y));
		if (IsCanvasConteinPosition(pos))
		{
			if (Input.GetMouseButtonDown(0))
			{
				isMouseDown = true;
			}
			Vector2 editPixelPos = GetEditPixelPos(pos);
			Color pixel = ((Texture2D)canvasTexture.mainTexture).GetPixel(Mathf.RoundToInt(editPixelPos.x), Mathf.RoundToInt(editPixelPos.y));
			newColor.color = pixel;
			okColorInPalitraButton.defaultColor = pixel;
			okColorInPalitraButton.pressed = pixel;
			okColorInPalitraButton.hover = pixel;
		}
	}

	private bool IsCanvasConteinPosition(Vector2 pos)
	{
		bool flag = false;
		float num = (float)Screen.height / 768f;
		Vector2 vector = new Vector2(((float)Screen.width - num * (float)canvasTexture.width) * 0.5f, ((float)Screen.height + num * (float)canvasTexture.height) * 0.5f);
		Vector2 vector2 = new Vector2(((float)Screen.width + num * (float)canvasTexture.width) * 0.5f, ((float)Screen.height - num * (float)canvasTexture.height) * 0.5f);
		if (pos.x > vector.x && pos.x < vector2.x && pos.y < vector.y && pos.y > vector2.y)
		{
			return true;
		}
		return false;
	}

	private Vector2 GetEditPixelPos(Vector2 pos)
	{
		float num = (float)Screen.height / 768f;
		return new Vector2(Mathf.FloorToInt((pos.x - ((float)Screen.width - (float)canvasTexture.width * num) * 0.5f) / ((float)canvasTexture.width * num) * (float)canvasTexture.mainTexture.width), Mathf.FloorToInt((pos.y - ((float)Screen.height - (float)canvasTexture.height * num) * 0.5f) / ((float)canvasTexture.height * num) * (float)canvasTexture.mainTexture.height));
	}
}
