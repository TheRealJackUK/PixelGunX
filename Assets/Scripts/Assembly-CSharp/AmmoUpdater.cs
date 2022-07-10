using UnityEngine;

internal sealed class AmmoUpdater : MonoBehaviour
{
	private UILabel _label;

	public GameObject ammoSprite;

	private void Start()
	{
		_label = GetComponent<UILabel>();
	}

	private void Update()
	{
		if (WeaponManager.sharedManager != null && WeaponManager.sharedManager.currentWeaponSounds != null && (!((Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex]).weaponPrefab.GetComponent<WeaponSounds>().isMelee || ((Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex]).weaponPrefab.GetComponent<WeaponSounds>().isShotMelee) && _label != null)
		{
			Weapon weapon = (Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex];
			_label.text = ((!((Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex]).weaponPrefab.GetComponent<WeaponSounds>().isShotMelee) ? string.Format("{0}/{1}", weapon.currentAmmoInClip, weapon.currentAmmoInBackpack) : (weapon.currentAmmoInClip + weapon.currentAmmoInBackpack).ToString());
			if (ammoSprite != null && !ammoSprite.activeSelf)
			{
				ammoSprite.SetActive(true);
			}
		}
		else
		{
			_label.text = string.Empty;
			if (ammoSprite != null && ammoSprite.activeSelf)
			{
				ammoSprite.SetActive(false);
			}
		}
	}
}
