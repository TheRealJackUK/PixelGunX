using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using UnityEngine;

internal sealed class DeveloperConsoleController : MonoBehaviour
{
	public DeveloperConsoleView view;

	public static bool isDebugGuiVisible;
	public static bool isPvpOff;

	private bool? _enemiesInCampaignDirty;

	private bool _backRequested;

	private bool _initialized;

	private bool _needsRestart;
	bool can = false;

	public void HandleBackButton()
	{

	}

	public void HandleClearKeychainAndPlayerPrefs()
	{

	}

	public void HandleForceError()
	{

	}

	public void HandleLevelMinusButton()
	{

	}

	public void HandleLevelPlusButton()
	{

	}

	public void HandleCoinsInputSubmit(UIInput input)
	{

	}

	public void HandleEnemyCountInSurvivalWaveInput(UIInput input)
	{

	}

	public void HandleEnemiesInCampaignChange()
	{

	}

	public void HandleEnemiesInCampaignInput(UIInput input)
	{

	}

	public void HandleTrainingCompleteChanged(UIToggle toggle)
	{

	}

	public void HandleSet60FpsChanged(UIToggle toggle)
	{

	}

	public void HandleMouseControlChanged(UIToggle toggle)
	{

	}

	public void HandleSpectatorMode(UIToggle toggle)
	{

	}

	public void HandleTempGunChanged(UIToggle toggle)
	{

	}

	public void HandleIpadMiniRetinaChanged(UIToggle toggle)
	{

	}

	public void HandleIsPayingChanged(UIToggle toggle)
	{

	}

	public void HandleIsDebugGuiVisibleChanged(UIToggle toggle)
	{

	}

	public void HandleIsPvpOffChanged(UIToggle toggle)
	{

	}

	public void HandleForcedEventX3Changed(UIToggle toggle)
	{

	}

	public void HandleAdIdCanged(UIToggle toggle)
	{

	}

	public void HandleClearPurchasesButton()
	{

	}

	public void HandleClearProgressButton()
	{

	}

	public void HandleFillProgressButton()
	{

	}

	public void HandleClearCloud()
	{

	}

	public void HandleUnbanUs(UIButton butt)
	{

	}

	public void HandleClearX3()
	{
		
	}

	private void RefreshExperience()
	{

	}

	private void RefreshFOV()
	{

	}

	private void RAUFOV()
	{

	}

	public void HandleExperienceSliderChanged()
	{

	}

	public void HandleFOVSliderChanged()
	{
		
	}

	public void HandleSignInOuButton(UILabel socialUsernameLabel)
	{

	}

	public void SetMarathonTestMode(UIToggle toggle)
	{
		
	}

	public void SetMarathonCurrentDay(UIInput input)
	{
		
	}

	public void SetOffGameGUIMode(UIToggle toggle)
	{
		
	}

	public void ClearStarterPackData()
	{
		
	}

	private void Refresh()
	{
		
	}

	private void Awake()
	{
		
	}

	private IEnumerator Start()
	{
		yield return null;
	}

	public void ChangePremiumAccountLiveTime(UIInput input)
	{
		
	}

	public void ClearAllPremiumAccounts()
	{

	}

	public void ClearCurrentPremiumAccont()
	{

	}

	private void HandleGemsInputSubmit(UIInput input)
	{

	}

	private void Update()
	{
		
	}

	private void LateUpdate()
	{
	
	}

	public void OnChangeStarterPackLive(UIInput inputField)
	{
		
	}

	public void OnChangeStarterPackCooldown(UIInput inputField)
	{
		
	}
}
