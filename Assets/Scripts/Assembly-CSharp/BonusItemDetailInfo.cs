using UnityEngine;

public class BonusItemDetailInfo : MonoBehaviour
{
	public UILabel title;

	public UILabel title1;

	public UILabel title2;

	public UILabel description;

	public UITexture imageHolder;

	public void SetTitle(string text)
	{
		title.text = text;
		title1.text = text;
		title2.text = text;
	}

	public void SetDescription(string text)
	{
		description.text = text;
	}

	public void SetImage(Texture2D image)
	{
		imageHolder.mainTexture = image;
	}

	public void Show()
	{
		base.gameObject.SetActive(true);
	}

	public void Hide()
	{
		base.gameObject.SetActive(false);
	}
}
