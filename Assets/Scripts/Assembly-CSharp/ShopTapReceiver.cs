using System;
using UnityEngine;

public class ShopTapReceiver : MonoBehaviour
{
	private bool blinkShop;

	private float lastTimeBlink;

	private UISprite sp;

	public static event Action ShopClicked;

	private void Start()
	{
		sp = GetComponentInChildren<UISprite>();
		if (!Defs.IsTraining)
		{
		}
	}

	private void HandleStopBlinkShop()
	{
		GetComponentInChildren<UISprite>().spriteName = "green_btn";
		blinkShop = false;
	}

	private void HandleStartBlinkShop()
	{
		blinkShop = true;
		lastTimeBlink = Time.realtimeSinceStartup;
	}

	private void Update()
	{
		if (blinkShop && Time.realtimeSinceStartup - lastTimeBlink > 0.16f)
		{
			lastTimeBlink = Time.realtimeSinceStartup;
			sp.spriteName = ((!sp.spriteName.Equals("green_btn")) ? "green_btn" : "green_btn_n");
		}
	}

	public static void AddClickHndIfNotExist(Action handler)
	{
		if (ShopTapReceiver.ShopClicked == null || Array.IndexOf(ShopTapReceiver.ShopClicked.GetInvocationList(), handler) < 0)
		{
			ShopTapReceiver.ShopClicked = (Action)Delegate.Combine(ShopTapReceiver.ShopClicked, handler);
		}
	}

	private void OnClick()
	{
		if (!LoadingInAfterGame.isShowLoading && (!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown))
		{
			if (JoystickController.leftJoystick != null)
			{
				JoystickController.leftJoystick.Reset();
			}
			if (ShopTapReceiver.ShopClicked != null)
			{
				ShopTapReceiver.ShopClicked();
			}
			else
			{
				Debug.Log("ShopClicked == null");
			}
		}
	}

	private void OnDestroy()
	{
	}
}
