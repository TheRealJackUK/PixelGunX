using UnityEngine;

public class BannerWindow : MonoBehaviour
{
	public UITexture Background;

	public UIButton ExitButton;

	public BannerWindowType type { get; set; }

	public void SetBackgroundImage(Texture2D image)
	{
		if (!(Background == null))
		{
			Background.mainTexture = image;
		}
	}

	public void SetEnableExitButton(bool enable)
	{
		if (!(ExitButton == null))
		{
			ExitButton.gameObject.SetActive(enable);
		}
	}

	public virtual void Show()
	{
		base.gameObject.SetActive(true);
		AdmobPerelivWindow component = GetComponent<AdmobPerelivWindow>();
		if (component != null)
		{
			component.Show();
		}
	}

	public void Hide()
	{
		AdmobPerelivWindow component = GetComponent<AdmobPerelivWindow>();
		if (component != null)
		{
			component.Hide();
		}
		else
		{
			base.gameObject.SetActive(false);
		}
	}

	internal virtual void Submit()
	{
	}
}
