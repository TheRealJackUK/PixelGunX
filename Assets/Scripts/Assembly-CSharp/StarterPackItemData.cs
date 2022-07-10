using System.Collections.Generic;

public class StarterPackItemData
{
	public List<string> variantTags = new List<string>();

	public int count;

	public string validTag
	{
		get
		{
			for (int i = 0; i < variantTags.Count; i++)
			{
				if (!ItemDb.IsItemInInventory(variantTags[i]) && !IsInvalidArmorTag(variantTags[i]))
				{
					return variantTags[i];
				}
			}
			return string.Empty;
		}
	}

	private bool IsInvalidArmorTag(string tag)
	{
		List<string> list = null;
		if (Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0].Contains(tag))
		{
			list = new List<string>();
			list.AddRange(Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0]);
		}
		else if (Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0].Contains(tag))
		{
			list = new List<string>();
			list.AddRange(Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0]);
		}
		if (list == null)
		{
			return false;
		}
		List<string> list2 = PromoActionsGUIController.FilterPurchases(list, true);
		foreach (string item in list2)
		{
			list.Remove(item);
		}
		if (list.Count == 0)
		{
			return true;
		}
		return list[0] != tag;
	}
}
