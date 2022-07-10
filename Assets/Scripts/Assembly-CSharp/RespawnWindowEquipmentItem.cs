using System;
using UnityEngine;

public class RespawnWindowEquipmentItem : MonoBehaviour
{
	public UITexture itemImage;

	public UISprite emptyImage;

	[NonSerialized]
	public string itemTag;

	[NonSerialized]
	public int itemCategory;

	public void SetItemTag(string itemTag, int itemCategory)
	{
		if (IsNoneEquipment(itemTag))
		{
			itemImage.gameObject.SetActive(false);
			emptyImage.gameObject.SetActive(true);
			this.itemTag = null;
			this.itemCategory = -1;
		}
		else
		{
			itemImage.gameObject.SetActive(true);
			emptyImage.gameObject.SetActive(false);
			this.itemTag = itemTag;
			this.itemCategory = itemCategory;
			itemImage.mainTexture = ItemDb.GetItemIcon(itemTag, (ShopNGUIController.CategoryNames)itemCategory);
		}
	}

	private static bool IsNoneEquipment(string itemTag)
	{
		return string.IsNullOrEmpty(itemTag) || itemTag == Defs.HatNoneEqupped || itemTag == Defs.ArmorNewNoneEqupped || itemTag == Defs.CapeNoneEqupped || itemTag == Defs.BootsNoneEqupped;
	}
}
