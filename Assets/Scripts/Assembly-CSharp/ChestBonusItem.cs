using UnityEngine;

public class ChestBonusItem : MonoBehaviour
{
	public UILabel timeLifeLabel;

	public UILabel itemNameLabel;

	public UITexture itemImageHolder;

	public void SetData(ChestBonusItemData itemData)
	{
		string empty = string.Empty;
		empty = ((itemData.timeLife != -1) ? itemData.GetTimeLabel(false) : ((itemData.count <= 1) ? LocalizationStore.Get("Key_1059") : string.Format("{0} {1}", itemData.count, LocalizationStore.Get("Key_1230"))));
		timeLifeLabel.text = empty;
		itemImageHolder.mainTexture = ItemDb.GetTextureForShopItem(itemData.tag);
		itemNameLabel.text = ItemDb.GetItemNameByTag(itemData.tag);
	}

	public void SetVisible(bool visible)
	{
		base.gameObject.SetActive(visible);
	}
}
