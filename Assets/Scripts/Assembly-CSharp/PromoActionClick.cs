using System;
using UnityEngine;

public class PromoActionClick : MonoBehaviour
{
	public static event Action<string> Click;

	private void OnPress(bool down)
	{
		if (down)
		{
			if (base.transform.parent.GetComponent<PromoActionPreview>().pressed != null)
			{
				base.transform.parent.GetComponent<PromoActionPreview>().icon.mainTexture = base.transform.parent.GetComponent<PromoActionPreview>().pressed;
			}
		}
		else if (base.transform.parent.GetComponent<PromoActionPreview>().unpressed != null)
		{
			base.transform.parent.GetComponent<PromoActionPreview>().icon.mainTexture = base.transform.parent.GetComponent<PromoActionPreview>().unpressed;
		}
	}

	private void OnClick()
	{
		if (PromoActionClick.Click != null)
		{
			PromoActionClick.Click(base.transform.parent.GetComponent<PromoActionPreview>().tg);
		}
		Debug.Log("Click");
	}
}
