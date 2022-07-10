using Rilisoft;
using UnityEngine;

public class SorryWeaponAndArmorBanner : BannerWindow
{
	public UILabel[] labelGoldCompensations;

	public UILabel[] labelGemsCompensations;

	public UIWidget goldContainer;

	public UIWidget gemsContainer;

	private SaltedInt _compensationGoldCount;

	private SaltedInt _compensationGemsCount;

	public override void Show()
	{
		_compensationGoldCount.Value = Storager.getInt(Defs.CoinsCountToCompensate, false);
		_compensationGemsCount.Value = Storager.getInt(Defs.GemsCountToCompensate, false);
		for (int i = 0; i < labelGoldCompensations.Length; i++)
		{
			labelGoldCompensations[i].text = _compensationGoldCount.Value.ToString();
		}
		for (int j = 0; j < labelGemsCompensations.Length; j++)
		{
			labelGemsCompensations[j].text = _compensationGemsCount.Value.ToString();
		}
		AligmentCompensationContainer();
		base.Show();
	}

	private void AligmentCompensationContainer()
	{
		if (_compensationGoldCount.Value > 0 && _compensationGemsCount.Value == 0)
		{
			goldContainer.gameObject.SetActive(true);
			gemsContainer.gameObject.SetActive(false);
		}
		else if (_compensationGoldCount.Value == 0 && _compensationGemsCount.Value > 0)
		{
			goldContainer.gameObject.SetActive(false);
			gemsContainer.gameObject.SetActive(true);
		}
		else if (_compensationGoldCount.Value > 0 && _compensationGemsCount.Value > 0)
		{
			Vector3 localPosition = goldContainer.transform.localPosition;
			goldContainer.transform.localPosition = new Vector3(localPosition.x, localPosition.y - (float)(goldContainer.height / 2), localPosition.z);
			localPosition = gemsContainer.transform.localPosition;
			gemsContainer.transform.localPosition = new Vector3(localPosition.x, localPosition.y + (float)(gemsContainer.height / 2), localPosition.z);
		}
	}

	public void SorryWeaponAndArmorExitClick()
	{
		if (_compensationGoldCount.Value > 0)
		{
			BankController.AddCoins(_compensationGoldCount.Value);
		}
		if (_compensationGemsCount.Value > 0)
		{
			BankController.AddGems(_compensationGemsCount.Value);
		}
		Storager.setInt(Defs.CoinsCountToCompensate, 0, false);
		Storager.setInt(Defs.GemsCountToCompensate, 0, false);
		Storager.setInt(Defs.ShowSorryWeaponAndArmor, 1, false);
		AudioClip audioClip = Resources.Load("coin_get") as AudioClip;
		if (Defs.isSoundFX && audioClip != null)
		{
			NGUITools.PlaySound(audioClip);
		}
		if (BannerWindowController.SharedController != null)
		{
			BannerWindowController.SharedController.HideBannerWindow();
		}
	}
}
