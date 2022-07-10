using Rilisoft;
using UnityEngine;

public sealed class BonusMarafonItem
{
	private const string PathToBonusesIcons = "OfferIcons/Marathon/";

	public BonusItemType type;

	public SaltedInt count;

	public string iconPreviewFileName;

	public string tag;

	public BonusMarafonItem(BonusItemType elementType, int countElements, string iconPreviewName, string tagWeapon = null)
	{
		type = elementType;
		count = countElements;
		iconPreviewFileName = iconPreviewName;
		tag = tagWeapon;
	}

	public string GetShortDescription()
	{
		string text = string.Empty;
		switch (type)
		{
		case BonusItemType.Gold:
			text = LocalizationStore.Get("Key_0936");
			break;
		case BonusItemType.Real:
			text = LocalizationStore.Get("Key_0771");
			break;
		case BonusItemType.JetPack:
			text = LocalizationStore.Get("Key_0772");
			break;
		case BonusItemType.Turret:
			text = LocalizationStore.Get("Key_0773");
			break;
		case BonusItemType.Mech:
			text = LocalizationStore.Get("Key_0774");
			break;
		case BonusItemType.PotionInvisible:
			text = LocalizationStore.Get("Key_0775");
			break;
		case BonusItemType.Granade:
			text = LocalizationStore.Get("Key_0776");
			break;
		case BonusItemType.TemporaryWeapon:
			text = ItemDb.GetItemNameByTag(tag);
			break;
		}
		if (string.IsNullOrEmpty(text) || count.Value == 0)
		{
			return string.Empty;
		}
		if (count.Value > 1)
		{
			return string.Format("{0} {1}", count.Value, text);
		}
		return text;
	}

	public string GetLongDescription()
	{
		string result = string.Empty;
		switch (type)
		{
		case BonusItemType.JetPack:
			result = LocalizationStore.Get("Key_0850");
			break;
		case BonusItemType.Turret:
			result = LocalizationStore.Get("Key_0852");
			break;
		case BonusItemType.Mech:
			result = LocalizationStore.Get("Key_0849");
			break;
		case BonusItemType.PotionInvisible:
			result = LocalizationStore.Get("Key_0851");
			break;
		case BonusItemType.TemporaryWeapon:
			result = LocalizationStore.Get("Key_1200");
			break;
		}
		return result;
	}

	public Texture2D GetIcon()
	{
		if (type == BonusItemType.TemporaryWeapon)
		{
			ShopNGUIController.CategoryNames itemCategory = (ShopNGUIController.CategoryNames)ItemDb.GetItemCategory(tag);
			return ItemDb.GetItemIcon(tag, itemCategory, false) as Texture2D;
		}
		string path = "OfferIcons/Marathon/" + iconPreviewFileName;
		return Resources.Load<Texture2D>(path);
	}
}
