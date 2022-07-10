using System;
using UnityEngine;

public class BankViewItem : MonoBehaviour, IComparable
{
	public UILabel countLabel;

	public UILabel countX3Label;

	public UITexture icon;

	public UILabel priceLabel;

	public UISprite discountSprite;

	public UILabel discountPercentsLabel;

	public UIButton btnBuy;

	[NonSerialized]
	public PurchaseEventArgs purchaseInfo;

	public UISprite bestBuy;

	public ChestBonusButtonView bonusButtonView;

	private Animator _bestBuyAnimator;

	private Animator _discountAnimator;

	public int CompareTo(object obj)
	{
		BankViewItem bankViewItem = obj as BankViewItem;
		if (FlurryPluginWrapper.IsPayingUser())
		{
			return bankViewItem.purchaseInfo.Count.CompareTo(purchaseInfo.Count);
		}
		return purchaseInfo.Count.CompareTo(bankViewItem.purchaseInfo.Count);
	}

	private void Awake()
	{
		_bestBuyAnimator = ((!(bestBuy == null)) ? bestBuy.GetComponent<Animator>() : null);
		_discountAnimator = ((!(discountSprite == null)) ? discountSprite.GetComponent<Animator>() : null);
		bonusButtonView.Initialize();
		bonusButtonView.UpdateState(purchaseInfo);
		PromoActionsManager.BestBuyStateUpdate += UpdateViewBestBuy;
	}

	private void UpdateAnimationEventSprite(bool isEventActive)
	{
		PromoActionsManager sharedManager = PromoActionsManager.sharedManager;
		if (sharedManager != null && sharedManager.IsEventX3Active)
		{
			return;
		}
		bool flag = discountSprite != null && discountSprite.gameObject.activeSelf;
		if (flag)
		{
			if (isEventActive)
			{
				_discountAnimator.Play("DiscountAnimation");
			}
			else
			{
				_discountAnimator.Play("Idle");
			}
		}
		if (isEventActive)
		{
			if (flag)
			{
				_bestBuyAnimator.Play("BestBuyAnimation");
			}
			else
			{
				_bestBuyAnimator.Play("Idle");
			}
		}
	}

	public void UpdateViewBestBuy()
	{
		PromoActionsManager sharedManager = PromoActionsManager.sharedManager;
		bool isEventActive = !(sharedManager == null) && sharedManager.IsBankItemBestBuy(purchaseInfo);
		bestBuy.gameObject.SetActive(isEventActive);
		UpdateAnimationEventSprite(isEventActive);
	}

	private void OnEnable()
	{
		UpdateViewBestBuy();
	}

	private void OnDestroy()
	{
		bonusButtonView.Deinitialize();
		PromoActionsManager.BestBuyStateUpdate -= UpdateViewBestBuy;
	}
}
