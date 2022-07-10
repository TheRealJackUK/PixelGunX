using System;
using System.Collections.Generic;
using I2.Loc;
using Rilisoft;
using UnityEngine;
using UnityEngine.UI;

internal sealed class FreeAwardView : MonoBehaviour
{
	public GameObject backgroundPanel;

	public GameObject watchPanel;

	public GameObject waitingPanel;

	public GameObject connectionPanel;

	public GameObject awardPanel;

	public GameObject closePanel;

	public Button watchButton;

	public UIButton nguiWatchButton;

	public UIButton devSkipButton;

	public UILabel prizeMoneyLabel;

	public UISprite loadingSpinner;

	public UILabel awardOuterLabel;

	private FreeAwardController.State _currentState;

	internal FreeAwardController.State CurrentState
	{
		private get
		{
			return _currentState;
		}
		set
		{
			if (value != _currentState)
			{
				SetWatchButtonEnabled(value is FreeAwardController.WatchState);
				RefreshAwardLabel(value is FreeAwardController.WatchState);
			}
			if (backgroundPanel != null)
			{
				backgroundPanel.SetActive(!(value is FreeAwardController.IdleState));
			}
			if (watchPanel != null)
			{
				watchPanel.SetActive(value is FreeAwardController.WatchState);
			}
			if (waitingPanel != null)
			{
				waitingPanel.SetActive(value is FreeAwardController.WaitingState);
			}
			if (connectionPanel != null)
			{
				connectionPanel.SetActive(value is FreeAwardController.ConnectionState);
			}
			if (awardPanel != null)
			{
				awardPanel.SetActive(value is FreeAwardController.AwardState);
			}
			if (closePanel != null)
			{
				closePanel.SetActive(value is FreeAwardController.CloseState);
			}
			_currentState = value;
		}
	}

	private void RefreshAwardLabel(bool visible)
	{
		if (!visible || !(awardOuterLabel != null))
		{
			return;
		}
		string text = string.Format("{0} {1}", LocalizationStore.Get(ScriptLocalization.Key_0291), (PromoActionsManager.MobileAdvert == null) ? PromoActionsManager.MobileAdvert.AwardCoinsNonpaying : PromoActionsManager.MobileAdvert.AwardCoinsPaying);
		List<UILabel> list = new List<UILabel>(2);
		awardOuterLabel.gameObject.GetComponents(list);
		awardOuterLabel.gameObject.GetComponentsInChildren(true, list);
		foreach (UILabel item in list)
		{
			item.text = text;
		}
	}

	private void Start()
	{
		if (devSkipButton != null)
		{
			devSkipButton.gameObject.SetActive(Application.isEditor || (Defs.IsDeveloperBuild && BuildSettings.BuildTarget == BuildTarget.WP8Player));
		}
	}

	private void Update()
	{
		FreeAwardController.WaitingState waitingState = CurrentState as FreeAwardController.WaitingState;
		if (loadingSpinner != null && waitingState != null)
		{
			float num = Time.realtimeSinceStartup - waitingState.StartTime;
			int num2 = Convert.ToInt32(Mathf.Floor(num));
			loadingSpinner.invert = num2 % 2 == 0;
			loadingSpinner.fillAmount = ((!loadingSpinner.invert) ? (1f - num + (float)num2) : (num - (float)num2));
		}
	}

	private void SetWatchButtonEnabled(bool enabled)
	{
		if (watchButton != null)
		{
			watchButton.interactable = enabled;
		}
		if (nguiWatchButton != null)
		{
			nguiWatchButton.isEnabled = enabled;
		}
	}
}
