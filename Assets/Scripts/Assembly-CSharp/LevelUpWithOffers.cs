using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

public class LevelUpWithOffers : MonoBehaviour
{
	public struct ItemDesc
	{
		public string tag;

		public ShopNGUIController.CategoryNames category;
	}

	public UIButton continueButton;

	public UIButton shopButton;

	public UILabel[] rewardGemsPriceLabel;

	public UILabel totalGemsLabel;

	public UILabel[] currentRankLabel;

	public UILabel[] rewardPriceLabel;

	public UILabel totalCoinsLabel;

	public NewAvailableItemInShop[] items;

	public UIGrid grid;

	public bool isTierLevelUp;

	public void SetCurrentRank(string currentRank)
	{
		for (int i = 0; i < currentRankLabel.Length; i++)
		{
			currentRankLabel[i].text = currentRank;
		}
	}

	public void SetRewardPrice(string rewardPrice)
	{
		for (int i = 0; i < rewardPriceLabel.Length; i++)
		{
			rewardPriceLabel[i].text = rewardPrice;
		}
	}

	public void SetGemsRewardPrice(string gemsReward)
	{
		for (int i = 0; i < rewardGemsPriceLabel.Length; i++)
		{
			rewardGemsPriceLabel[i].text = gemsReward;
		}
	}

	public void SetItems(List<string> itemTags)
	{
		for (int i = 0; i < items.Length; i++)
		{
			items[i].gameObject.SetActive(false);
		}
		for (int j = 0; j < itemTags.Count; j++)
		{
			items[j].gameObject.SetActive(true);
			string text = itemTags[j];
			int itemCategory = ItemDb.GetItemCategory(text);
			items[j].tag = text;
			items[j].category = (ShopNGUIController.CategoryNames)itemCategory;
			items[j].itemImage.mainTexture = ItemDb.GetItemIcon(text, (ShopNGUIController.CategoryNames)itemCategory, !isTierLevelUp);
			items[j].itemName.text = ItemDb.GetItemName(text, (ShopNGUIController.CategoryNames)itemCategory);
			items[j].GetComponent<UIButton>().isEnabled = !Defs.isHunger || text == null || ItemDb.GetByTag(text) == null;
		}
		grid.transform.localPosition = new Vector3((0f - grid.cellWidth * (float)itemTags.Count) / 2f + grid.cellWidth / 2f, grid.transform.localPosition.y, grid.transform.localPosition.z);
		grid.Reposition();
	}
}
