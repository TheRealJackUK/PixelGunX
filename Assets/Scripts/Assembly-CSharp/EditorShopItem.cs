using System.Text;
using UnityEngine;

public class EditorShopItem : MonoBehaviour
{
	public UILabel itemName;

	public UIToggle topCheckbox;

	public UIToggle newCheckbox;

	public UIInput discountInput;

	private EditorShopItemData _itemData;

	public string prefabName { get; private set; }

	public void SetData(EditorShopItemData data)
	{
		_itemData = data;
		StringBuilder stringBuilder = new StringBuilder();
		string byDefault = LocalizationStore.GetByDefault(data.localizeKey);
		stringBuilder.AppendLine(string.Format("Name: {0}", byDefault));
		if (!string.IsNullOrEmpty(data.prefabName))
		{
			prefabName = data.prefabName;
			stringBuilder.AppendLine(string.Format("Prefab: {0}", data.prefabName));
		}
		stringBuilder.Append(string.Format("Tag: {0}", data.tag));
		itemName.text = stringBuilder.ToString();
		topCheckbox.value = data.isTop;
		newCheckbox.value = data.isNew;
		discountInput.label.text = data.discount.ToString();
	}

	public void SetTopState()
	{
		_itemData.isTop = topCheckbox.value;
	}

	public void SetNewState()
	{
		_itemData.isNew = newCheckbox.value;
	}

	public void SetDiscount()
	{
		int.TryParse(discountInput.label.text, out _itemData.discount);
	}
}
