using System.Collections.Generic;
using UnityEngine;

public sealed class AmmoButtonInGamePanel : MonoBehaviour
{
	public GameObject fullLabel;

	public UIButton myButton;

	public UILabel priceLabel;

	public InGameGUI inGameGui;

	private void Start()
	{
		priceLabel.text = Defs.ammoInGamePanelPrice.ToString();
	}

	private void Update()
	{
		UpdateState(true);
	}

	private void UpdateState(bool isDelta = true)
	{
		/*
		Weapon weapon = (Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex];
		int currentAmmoInBackpack = weapon.currentAmmoInBackpack;
		WeaponSounds component = weapon.weaponPrefab.GetComponent<WeaponSounds>();
		int maxAmmoWithEffectApplied = component.MaxAmmoWithEffectApplied;
		bool flag = currentAmmoInBackpack == maxAmmoWithEffectApplied;
		if (flag == myButton.isEnabled || !isDelta)
		{
			fullLabel.SetActive(flag);
			myButton.isEnabled = !flag;
			priceLabel.gameObject.SetActive(!flag);
		}
		*/
	}

	private void OnEnable()
	{
		UpdateState(false);
	}

	private void OnClick()
	{
		if (ButtonClickSound.Instance != null)
		{
			ButtonClickSound.Instance.PlayClick();
		}
		if (Defs.IsTraining)
		{
			Weapon weapon = (Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex];
			WeaponSounds component = weapon.weaponPrefab.GetComponent<WeaponSounds>();
			weapon.currentAmmoInBackpack = component.MaxAmmoWithEffectApplied;
			return;
		}
		ShopNGUIController.TryToBuy(inGameGui.gameObject, new ItemPrice(Defs.ammoInGamePanelPrice, "Coins"), delegate
		{
			if (InGameGUI.sharedInGameGUI != null && InGameGUI.sharedInGameGUI.playerMoveC != null)
			{
				InGameGUI.sharedInGameGUI.playerMoveC.ShowBonuseParticle(Player_move_c.TypeBonuses.Ammo);
			}
			Weapon weapon2 = (Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex];
			WeaponSounds component2 = weapon2.weaponPrefab.GetComponent<WeaponSounds>();
			weapon2.currentAmmoInBackpack = component2.MaxAmmoWithEffectApplied;
			Dictionary<string, string> parameters2 = new Dictionary<string, string> { { "Succeeded", "Ammo" } };
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Fast Purchase", parameters2);
			FlurryPluginWrapper.LogFastPurchase("Ammo");
		}, delegate
		{
			JoystickController.leftJoystick.Reset();
			Dictionary<string, string> parameters = new Dictionary<string, string> { { "Failed", "Ammo" } };
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Fast Purchase", parameters);
		});
	}
}
