using System.Collections;
using UnityEngine;

public class TestPreviewSkinController : MonoBehaviour
{
	public UIGrid grid;

	public GameObject previewPrefab;

	private IEnumerator Start()
	{
		yield return null;
		Skins();
	}

	private void Skins()
	{
		for (int i = 0; i < SkinsController.baseSkinsForPersInString.Length; i++)
		{
			Texture2D texture = SkinsController.TextureFromString(SkinsController.baseSkinsForPersInString[i]);
			Texture2D texture2D = new Texture2D(16, 32, TextureFormat.ARGB32, false);
			for (int j = 0; j < 16; j++)
			{
				for (int k = 0; k < 32; k++)
				{
					texture2D.SetPixel(j, k, Color.clear);
				}
			}
			texture2D.SetPixels(4, 24, 8, 8, GetPixelsByRect(texture, new Rect(8f, 16f, 8f, 8f)));
			texture2D.SetPixels(4, 12, 8, 12, GetPixelsByRect(texture, new Rect(20f, 0f, 8f, 12f)));
			texture2D.SetPixels(0, 12, 4, 12, GetPixelsByRect(texture, new Rect(44f, 0f, 4f, 12f)));
			texture2D.SetPixels(12, 12, 4, 12, GetPixelsByRect(texture, new Rect(44f, 0f, 4f, 12f)));
			texture2D.SetPixels(4, 0, 4, 12, GetPixelsByRect(texture, new Rect(4f, 0f, 4f, 12f)));
			texture2D.SetPixels(8, 0, 4, 12, GetPixelsByRect(texture, new Rect(4f, 0f, 4f, 12f)));
			texture2D.anisoLevel = 1;
			texture2D.mipMapBias = -0.5f;
			texture2D.Apply();
			texture2D.filterMode = FilterMode.Point;
			texture2D.Apply();
			GameObject gameObject = Object.Instantiate(previewPrefab) as GameObject;
			gameObject.transform.parent = grid.transform;
			gameObject.transform.localPosition = new Vector3(160 * i, 0f, 0f);
			gameObject.transform.localScale = new Vector3(1f, 1f, 1f);
			gameObject.GetComponent<SetTestSkinPreview>().texture.mainTexture = texture2D;
			gameObject.GetComponent<SetTestSkinPreview>().nameLabel.text = i.ToString();
			gameObject.GetComponent<SetTestSkinPreview>().keyLabel.text = ((!SkinsController.shopKeyFromNameSkin.ContainsKey(i.ToString())) ? string.Empty : SkinsController.shopKeyFromNameSkin[i.ToString()]);
			gameObject.name = i.ToString();
		}
		string text = string.Empty;
		for (int l = 1; l <= 1; l++)
		{
			text = text + "\"" + SkinsController.StringFromTexture(Resources.Load("Multiplayer Skins/multi_skin_" + l) as Texture2D) + "\",\n";
		}
		Debug.Log(text);
	}

	private Color[] GetPixelsByRect(Texture2D texture, Rect rect)
	{
		Color[] pixels = texture.GetPixels((int)rect.x, (int)rect.y, (int)rect.width, (int)rect.height);
		Texture2D texture2D = new Texture2D((int)rect.width, (int)rect.height);
		texture2D.filterMode = FilterMode.Point;
		texture2D.SetPixels(pixels);
		texture2D.Apply();
		Color[] pixels2 = texture2D.GetPixels();
		Object.Destroy(texture2D);
		return pixels2;
	}

	private void Update()
	{
	}
}
