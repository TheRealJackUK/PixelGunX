using UnityEngine;

public class CoinsShopButton : MonoBehaviour
{
	public GameObject eventX3;

	private void Start()
	{
		PromoActionsManager.EventX3Updated += OnEventX3Updated;
		OnEventX3Updated();
	}

	private void OnEnable()
	{
		OnEventX3Updated();
	}

	private void OnDestroy()
	{
		PromoActionsManager.EventX3Updated -= OnEventX3Updated;
	}

	private void OnEventX3Updated()
	{
		bool isEventX3Active = PromoActionsManager.sharedManager.IsEventX3Active;
		if (eventX3 != null && eventX3.activeSelf != isEventX3Active)
		{
			eventX3.SetActive(isEventX3Active);
		}
	}
}
