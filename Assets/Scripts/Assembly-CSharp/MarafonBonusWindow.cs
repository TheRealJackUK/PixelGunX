using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MarafonBonusWindow : BannerWindow
{
	public GameObject premiumInterface;

	public UIScrollView bonusScrollView;

	public UIGrid bonusScroll;

	public UILabel title;

	public GameObject bonusEverydayItem;

	public UIScrollView scrollView;

	public BonusEverydayItem[] superPrizes;

	private void FillBonusesForEveryday()
	{
		List<BonusMarafonItem> bonusItems = MarafonBonusController.Get.BonusItems;
		int currentBonusIndex = MarafonBonusController.Get.GetCurrentBonusIndex();
		BonusEverydayItem[] componentsInChildren = bonusScroll.GetComponentsInChildren<BonusEverydayItem>(true);
		bool flag = componentsInChildren.Length != 0;
		BonusEverydayItem bonusEverydayItem = null;
		GameObject gameObject = null;
		for (int i = 0; i < bonusItems.Count; i++)
		{
			if (!flag)
			{
				gameObject = Object.Instantiate(this.bonusEverydayItem) as GameObject;
				gameObject.name = string.Format("{0:00}", i);
			}
			bonusEverydayItem = ((!flag) ? gameObject.GetComponent<BonusEverydayItem>() : componentsInChildren[i]);
			if (bonusEverydayItem != null)
			{
				bool isBonusWeekly = (i + 1) % 7 == 0 || i == bonusItems.Count - 1;
				bonusEverydayItem.FillData(i, currentBonusIndex, isBonusWeekly);
			}
			if (!flag)
			{
				bonusScroll.AddChild(gameObject.transform);
				gameObject.gameObject.SetActive(true);
			}
			bonusEverydayItem.transform.localScale = new Vector3(0.9f, 0.9f, 0.9f);
		}
		bonusEverydayItem.SetBackgroundForBonusWeek();
		bonusScroll.Reposition();
	}

	private void FillPrizesForEveryweek()
	{
		List<BonusMarafonItem> bonusItems = MarafonBonusController.Get.BonusItems;
		int currentBonusIndex = MarafonBonusController.Get.GetCurrentBonusIndex();
		int num = 0;
		for (int i = 6; i < bonusItems.Count; i += 7)
		{
			BonusEverydayItem bonusEverydayItem = superPrizes[num];
			num++;
			if (bonusEverydayItem != null)
			{
				bonusEverydayItem.FillData(i, currentBonusIndex, false);
			}
		}
		int num2 = superPrizes.Length - 1;
		int bonusIndex = bonusItems.Count - 1;
		superPrizes[num2].FillData(bonusIndex, currentBonusIndex, false);
	}

	private void OnEnable()
	{
		StartCoroutine(StartCentralizeBonusItem());
	}

	public override void Show()
	{
		MarafonBonusController.Get.InitializeBonusItems();
		FillBonusesForEveryday();
		FillPrizesForEveryweek();
		base.Show();
	}

	public IEnumerator StartCentralizeBonusItem()
	{
		yield return null;
		CentralizeScrollByCurrentBonus();
	}

	private void ResetScrollPosition(GameObject centerElement)
	{
		bonusScroll.GetComponent<UICenterOnChild>().enabled = false;
		bonusScroll.Reposition();
	}

	public void OnGetRewardClick()
	{
		scrollView.ResetPosition();
		MarafonBonusController.Get.TakeMarafonBonus();
		BannerWindowController.SharedController.HideBannerWindow();
	}

	private void CentralizeScrollByCurrentBonus()
	{
		if (bonusScroll == null)
		{
			return;
		}
		int currentBonusIndex = MarafonBonusController.Get.GetCurrentBonusIndex();
		Transform child = bonusScroll.GetChild(currentBonusIndex);
		if (child != null)
		{
			if (currentBonusIndex > 2 && currentBonusIndex < 27)
			{
				bonusScroll.GetComponent<UICenterOnChild>().springStrength = 8f;
				bonusScroll.GetComponent<UICenterOnChild>().CenterOn(child);
			}
			else if (currentBonusIndex >= 27)
			{
				bonusScroll.GetComponent<UICenterOnChild>().springStrength = 8f;
				Transform child2 = bonusScroll.GetChild(27);
				if (child2 != null)
				{
					bonusScroll.GetComponent<UICenterOnChild>().CenterOn(child2);
				}
			}
			child.localScale = Vector3.one;
		}
		bonusScroll.GetComponent<UICenterOnChild>().onCenter = ResetScrollPosition;
	}

	internal sealed override void Submit()
	{
		OnGetRewardClick();
	}

	private void Update()
	{
		if (premiumInterface.activeSelf != (PremiumAccountController.Instance != null && PremiumAccountController.Instance.isAccountActive))
		{
			premiumInterface.SetActive(PremiumAccountController.Instance != null && PremiumAccountController.Instance.isAccountActive);
		}
	}
}
