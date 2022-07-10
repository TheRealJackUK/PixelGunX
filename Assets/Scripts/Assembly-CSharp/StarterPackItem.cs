using UnityEngine;

public class StarterPackItem : MonoBehaviour
{
	public UITexture imageItem;

	public UILabel nameItem;

	public UILabel countItems;

	public UILabel realPriceItem;

	public void SetData(StarterPackItemData itemData)
	{
		bool flag = itemData.count > 1;
		countItems.gameObject.SetActive(flag);
		if (flag)
		{
			countItems.text = itemData.count.ToString();
		}
		string validTag = itemData.validTag;
		int num = 0;
		string text = validTag;
		bool flag2 = GearManager.IsItemGear(validTag);
		if (flag2)
		{
			text = GearManager.HolderQuantityForID(validTag);
			num = GearManager.CurrentNumberOfUphradesForGear(text);
		}
		if (flag2 && (text == GearManager.Turret || text == GearManager.Mech))
		{
			int? upgradeNum = num;
			imageItem.mainTexture = ItemDb.GetTextureItemByTag(text, upgradeNum);
		}
		else
		{
			imageItem.mainTexture = ItemDb.GetTextureItemByTag(text);
		}
		nameItem.text = ItemDb.GetItemNameByTag(validTag);
		string text2 = ItemDb.GetShopIdByTag(validTag);
		if (string.IsNullOrEmpty(text2))
		{
			text2 = ((!flag2) ? validTag : GearManager.OneItemIDForGear(text, num));
		}
		ItemPrice priceByShopId = ItemDb.GetPriceByShopId(text2);
		if (priceByShopId != null)
		{
			int num2 = priceByShopId.Price * itemData.count;
			string arg = ((!(priceByShopId.Currency == "Coins")) ? LocalizationStore.Get("Key_0771") : LocalizationStore.Get("Key_0936"));
			realPriceItem.text = string.Format("{0} {1}", num2, arg);
		}
	}
}
