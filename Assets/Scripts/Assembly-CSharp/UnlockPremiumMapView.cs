using System;
using Rilisoft;
using UnityEngine;

internal sealed class UnlockPremiumMapView : MonoBehaviour
{
	public ButtonHandler closeButton;

	public ButtonHandler unlockButton;

	public UISprite priceSprite;

	public UILabel[] priceLabel;

	private int _price = 15;

	public int Price
	{
		get
		{
			return _price;
		}
		set
		{
			_price = value;
			if (priceSprite != null)
			{
				priceSprite.spriteName = string.Format("premium_baner_{0}", value);
			}
		}
	}

	public event EventHandler ClosePressed;

	public event EventHandler UnlockPressed;

	private void OnDestroy()
	{
		if (closeButton != null)
		{
			closeButton.Clicked -= RaiseClosePressed;
		}
		if (unlockButton != null)
		{
			unlockButton.Clicked -= RaiseUnlockPressed;
		}
	}

	private void Start()
	{
		if (closeButton != null)
		{
			closeButton.Clicked += RaiseClosePressed;
		}
		if (unlockButton != null)
		{
			unlockButton.Clicked += RaiseUnlockPressed;
		}
		if (priceSprite != null)
		{
			priceSprite.spriteName = string.Format("premium_baner_{0}", _price);
		}
		SetLabelPrice();
	}

	private void SetLabelPrice()
	{
		if (priceLabel != null && priceLabel.Length != 0)
		{
			string text = string.Format("{0} {1}", _price, LocalizationStore.Get("Key_1041"));
			for (int i = 0; i < priceLabel.Length; i++)
			{
				priceLabel[i].text = text;
			}
		}
	}

	private void RaiseClosePressed(object sender, EventArgs e)
	{
		if (Application.isEditor)
		{
			Debug.Log("Close event raised.");
		}
		EventHandler closePressed = this.ClosePressed;
		if (closePressed != null)
		{
			closePressed(sender, e);
		}
	}

	private void RaiseUnlockPressed(object sender, EventArgs e)
	{
		if (Application.isEditor)
		{
			Debug.Log("Unlock event raised.");
		}
		EventHandler unlockPressed = this.UnlockPressed;
		if (unlockPressed != null)
		{
			unlockPressed(sender, e);
		}
	}
}
