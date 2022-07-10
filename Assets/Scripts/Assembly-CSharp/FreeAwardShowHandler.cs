using System.Collections;
using UnityEngine;

public class FreeAwardShowHandler : MonoBehaviour
{
	public GameObject chestModel;

	public static FreeAwardShowHandler Instance;

	private Animation _animationSystem;

	private NickLabelController nickController;

	private bool clicked;

	private bool inside;

	public bool IsInteractable
	{
		get
		{
			return base.gameObject.GetComponent<Collider>() != null && base.gameObject.GetComponent<Collider>().enabled;
		}
		set
		{
			if (base.gameObject.GetComponent<Collider>() != null)
			{
				base.gameObject.GetComponent<Collider>().enabled = value;
			}
		}
	}

	private void Awake()
	{
		_animationSystem = GetComponent<Animation>();
		Instance = this;
	}

	private void OnDestroy()
	{
		Instance = null;
	}

	private NickLabelController GetNickController()
	{
		return (!(NickLabelStack.sharedStack != null)) ? null : NickLabelStack.sharedStack.GetCurrentLabel();
	}

	private bool IsSkipClick()
	{
		if (BankController.Instance != null && BankController.Instance.InterfaceEnabled)
		{
			return true;
		}
		if (ShopNGUIController.sharedShop != null && ShopNGUIController.GuiActive)
		{
			return true;
		}
		if (FreeAwardController.Instance != null && !FreeAwardController.Instance.IsInState<FreeAwardController.IdleState>())
		{
			return true;
		}
		if (BannerWindowController.SharedController != null && BannerWindowController.SharedController.IsAnyBannerShown)
		{
			return true;
		}
		MainMenuController sharedController = MainMenuController.sharedController;
		if (sharedController != null && ((sharedController.RentExpiredPoint != null && sharedController.RentExpiredPoint.childCount > 0) || sharedController.SettingsJoysticksPanel.activeSelf || sharedController.supportPanel.activeSelf || MainMenuController.sharedController.singleModePanel.activeSelf))
		{
			return true;
		}
		return false;
	}

	private void OnMouseDown()
	{
		clicked = true;
		inside = true;
	}

	private void OnMouseExit()
	{
		inside = false;
	}

	private void OnMouseEnter()
	{
		if (clicked)
		{
			inside = true;
		}
	}

	private void OnMouseUp()
	{
		clicked = false;
		if (!inside || IsSkipClick())
		{
			return;
		}
		inside = false;
		if (FreeAwardController.Instance.AdvertCountLessThanLimit())
		{
			if (ButtonClickSound.Instance != null)
			{
				ButtonClickSound.Instance.PlayClick();
			}
			FreeAwardController.Instance.SetWatchState();
		}
	}

	private void OnEnable()
	{
		StartCoroutine(ShowChestCoroutine());
	}

	private void PlayeAnimationTitle(bool isReverse, UILabel titleLabel)
	{
		UIPlayTween component = titleLabel.GetComponent<UIPlayTween>();
		component.resetOnPlay = true;
		component.tweenGroup = (isReverse ? 1 : 0);
		component.Play(true);
	}

	private void CheckShowFreeAwardTitle(bool isEnable, bool needExitAnim = false)
	{
		if (nickController == null)
		{
			nickController = GetNickController();
		}
		if (isEnable && nickController != null)
		{
			nickController.freeAwardTitle.gameObject.SetActive(true);
			PlayeAnimationTitle(false, nickController.freeAwardTitle);
		}
		else if (needExitAnim)
		{
			PlayeAnimationTitle(true, nickController.freeAwardTitle);
		}
	}

	private IEnumerator ShowChestCoroutine()
	{
		yield return null;
		PlayAnimationShowChest(false);
		chestModel.SetActive(true);
		CheckShowFreeAwardTitle(true);
	}

	private IEnumerator HideChestCoroutine()
	{
		PlayAnimationShowChest(true);
		CheckShowFreeAwardTitle(false, true);
		yield return new WaitForSeconds(_animationSystem["Animate"].length);
		base.gameObject.SetActive(false);
	}

	private void PlayAnimationShowChest(bool isReserse)
	{
		if (isReserse)
		{
			_animationSystem["Animate"].speed = -1f;
			_animationSystem["Animate"].time = _animationSystem["Animate"].length;
		}
		else
		{
			_animationSystem["Animate"].speed = 1f;
			_animationSystem["Animate"].time = 0f;
		}
		_animationSystem.Play();
	}

	public void HideChestWithAnimation()
	{
		StartCoroutine(HideChestCoroutine());
	}

	public void HideChestTitle()
	{
		if (!(nickController == null))
		{
			nickController.freeAwardTitle.gameObject.SetActive(false);
		}
	}

	public static void CheckShowChest(bool interfaceEnabled)
	{
		if (!(Instance == null) && interfaceEnabled && Instance.gameObject.activeSelf)
		{
			Instance.HideChestTitle();
			Instance.chestModel.transform.localScale = Vector3.zero;
			Instance.gameObject.SetActive(false);
		}
	}
}
