using UnityEngine;

public class DaysOfValorLabelActive : MonoBehaviour
{
	public UISprite coinsLabel;

	public UISprite expLabel;

	private void Awake()
	{
		UpdateLabels();
	}

	private void UpdateLabels()
	{
		if (PromoActionsManager.sharedManager.DayOfValorMultiplyerForExp > 1 && !expLabel.gameObject.activeSelf)
		{
			expLabel.gameObject.SetActive(true);
			expLabel.spriteName = PromoActionsManager.sharedManager.DayOfValorMultiplyerForExp + "x";
		}
		if (PromoActionsManager.sharedManager.DayOfValorMultiplyerForExp == 1 && expLabel.gameObject.activeSelf)
		{
			expLabel.gameObject.SetActive(false);
			coinsLabel.transform.localPosition = new Vector3(109f, coinsLabel.transform.localPosition.y, coinsLabel.transform.localPosition.z);
		}
		if (PromoActionsManager.sharedManager.DayOfValorMultiplyerForMoney > 1 && !coinsLabel.gameObject.activeSelf)
		{
			coinsLabel.gameObject.SetActive(true);
			coinsLabel.spriteName = PromoActionsManager.sharedManager.DayOfValorMultiplyerForMoney + "x";
			if (PromoActionsManager.sharedManager.DayOfValorMultiplyerForExp > 1)
			{
				coinsLabel.transform.localPosition = new Vector3(28f, coinsLabel.transform.localPosition.y, coinsLabel.transform.localPosition.z);
			}
		}
		if (PromoActionsManager.sharedManager.DayOfValorMultiplyerForMoney == 1 && coinsLabel.gameObject.activeSelf)
		{
			coinsLabel.gameObject.SetActive(false);
		}
	}

	private void Update()
	{
		UpdateLabels();
	}
}
