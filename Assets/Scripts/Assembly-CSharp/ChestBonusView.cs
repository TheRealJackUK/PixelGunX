using UnityEngine;

public class ChestBonusView : MonoBehaviour
{
	public UILabel[] title;

	public UILabel description;

	public ChestBonusItem[] bonusItems;

	public float cellWidth;

	public float startXPos;

	private void SetTitleText(string text)
	{
		for (int i = 0; i < title.Length; i++)
		{
			title[i].text = text;
		}
	}

	public void OnButtonOkClick()
	{
		base.gameObject.SetActive(false);
	}

	public void Show(ChestBonusData bonus)
	{
		if (bonus.items != null && bonus.items.Count != 0)
		{
			base.gameObject.SetActive(true);
			SetTitleText(LocalizationStore.Get("Key_1057"));
			description.text = LocalizationStore.Get("Key_1058");
			CreateBonusesItemsAndAlign(bonus);
		}
	}

	private void CreateBonusesItemsAndAlign(ChestBonusData bonus)
	{
		int num = 0;
		for (int i = 0; i < bonusItems.Length; i++)
		{
			if (i >= bonus.items.Count)
			{
				bonusItems[i].SetVisible(false);
				num++;
			}
			else
			{
				bonusItems[i].SetVisible(true);
				bonusItems[i].SetData(bonus.items[i]);
			}
		}
		CenterItems(num);
	}

	private void CenterItems(int countHideElements)
	{
		float num = (float)countHideElements / 2f;
		float num2 = cellWidth * num;
		int num3 = bonusItems.Length - countHideElements;
		for (int i = 0; i < num3; i++)
		{
			Vector3 localPosition = bonusItems[i].transform.localPosition;
			float x = startXPos + num2 + cellWidth * (float)i;
			bonusItems[i].transform.localPosition = new Vector3(x, localPosition.y, localPosition.z);
		}
	}
}
