using Rilisoft;
using UnityEngine;

public class Weapon
{
	public GameObject weaponPrefab;

	private SaltedInt _currentAmmoInBackpack = new SaltedInt(901269156);

	private SaltedInt _currentAmmoInClip = new SaltedInt(384354114);

	public int currentAmmoInBackpack
	{
		get
		{
			return _currentAmmoInBackpack.Value;
		}
		set
		{
			_currentAmmoInBackpack.Value = value;
		}
	}

	public int currentAmmoInClip
	{
		get
		{
			return _currentAmmoInClip.Value;
		}
		set
		{
			_currentAmmoInClip.Value = value;
		}
	}
}
