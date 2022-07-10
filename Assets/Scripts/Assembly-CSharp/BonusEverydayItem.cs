using UnityEngine;

public class BonusEverydayItem : MonoBehaviour
{
	public UISprite checkTakedReward;

	public UITexture imageReward;

	public UILabel descriptionReward;

	public UILabel descriptionReward1;

	public UILabel descriptionReward2;

	public UILabel titleDayTakeReward;

	public UISprite background;

	public UISprite backgroundWeekly;

	public UIWidget hightlightWeeklyBonus;

	public BonusItemDetailInfo windowDetail;

	public UIWidget hightlightBonus;

	private BonusMarafonItem _bonusData;

	public void SetCheckForTakedReward()
	{
		checkTakedReward.gameObject.SetActive(true);
	}

	public void SetImageForReward(Texture2D image)
	{
		imageReward.mainTexture = image;
	}

	public void SetDescriptionItem(string text)
	{
		descriptionReward.text = text;
		if (descriptionReward1 != null)
		{
			descriptionReward1.text = text;
		}
		if (descriptionReward2 != null)
		{
			descriptionReward2.text = text;
		}
	}

	public void SetTitleItem(string text)
	{
		titleDayTakeReward.text = text;
	}

	public void FillData(int bonusIndex, int currentBonusIndex, bool isBonusWeekly)
	{
		SetTitleItem(string.Format("{0} {1}", LocalizationStore.Get("Key_0469"), bonusIndex + 1));
		if (bonusIndex < currentBonusIndex)
		{
			SetCheckForTakedReward();
		}
		bool flag = bonusIndex == currentBonusIndex;
		if (hightlightBonus != null && !isBonusWeekly)
		{
			hightlightBonus.alpha = ((!flag) ? 0f : 1f);
		}
		_bonusData = MarafonBonusController.Get.GetBonusForIndex(bonusIndex);
		if (_bonusData != null)
		{
			SetDescriptionItem(_bonusData.GetShortDescription());
			SetImageForReward(_bonusData.GetIcon());
		}
		if (isBonusWeekly && hightlightWeeklyBonus != null)
		{
			SetBackgroundForBonusWeek();
			hightlightWeeklyBonus.alpha = ((!flag) ? 0f : 1f);
		}
	}

	public void SetBackgroundForBonusWeek()
	{
		background.gameObject.SetActive(false);
		if (backgroundWeekly != null)
		{
			backgroundWeekly.gameObject.SetActive(true);
		}
	}

	private void OnClickDetailInfo()
	{
		if (_bonusData != null)
		{
			string shortDescription = _bonusData.GetShortDescription();
			string longDescription = _bonusData.GetLongDescription();
			Texture2D icon = _bonusData.GetIcon();
			windowDetail.SetTitle(shortDescription);
			windowDetail.SetDescription(longDescription);
			windowDetail.SetImage(icon);
			windowDetail.Show();
		}
	}

	private void OnClick()
	{
		OnClickDetailInfo();
	}
}
