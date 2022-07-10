using UnityEngine;

public class EventX3Banner : BannerWindow
{
	public GameObject amazonEventObject;

	private void OnEnable()
	{
		bool isAmazonEventX3Active = PromoActionsManager.sharedManager.IsAmazonEventX3Active;
		amazonEventObject.SetActive(isAmazonEventX3Active);
		PromoActionsManager.EventAmazonX3Updated += OnAmazonEventUpdated;
	}

	private void OnDisable()
	{
		PromoActionsManager.EventAmazonX3Updated -= OnAmazonEventUpdated;
	}

	private void OnAmazonEventUpdated()
	{
		amazonEventObject.SetActive(PromoActionsManager.sharedManager.IsAmazonEventX3Active);
	}
}
