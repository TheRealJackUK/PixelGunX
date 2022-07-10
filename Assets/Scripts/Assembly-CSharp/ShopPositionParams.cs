using UnityEngine;

public class ShopPositionParams : MonoBehaviour
{
	public int tier = 10;

	public float scaleShop = 150f;

	public Vector3 positionShop;

	public Vector3 rotationShop;

	public string localizeKey;

	public string shopName
	{
		get
		{
			return LocalizationStore.Get(localizeKey);
		}
	}

	public string shopNameNonLocalized
	{
		get
		{
			return LocalizationStore.GetByDefault(localizeKey);
		}
	}
}
