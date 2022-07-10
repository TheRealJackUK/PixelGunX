using UnityEngine;

public class FlashFire : MonoBehaviour
{
	public GameObject gunFlashObj;

	public float timeFireAction = 0.2f;

	private float activeTime;

	private void Start()
	{
		if (gunFlashObj == null)
		{
			foreach (Transform item in base.transform)
			{
				bool flag = false;
				if (item.gameObject.name.Equals("BulletSpawnPoint"))
				{
					foreach (Transform item2 in item)
					{
						if (item2.gameObject.name.Equals("GunFlash"))
						{
							flag = true;
							gunFlashObj = item2.gameObject;
							break;
						}
					}
				}
				if (flag)
				{
					break;
				}
			}
		}
		WeaponManager.SetGunFlashActive(gunFlashObj, false);
	}

	private void Update()
	{
		if (activeTime > 0f)
		{
			activeTime -= Time.deltaTime;
			if (activeTime <= 0f)
			{
				WeaponManager.SetGunFlashActive(gunFlashObj, false);
			}
		}
	}

	public void fire()
	{
		WeaponManager.SetGunFlashActive(gunFlashObj, true);
		activeTime = timeFireAction;
		WeaponSounds component = GetComponent<WeaponSounds>();
		if (component != null && component.railgun && gunFlashObj != null)
		{
			WeaponManager.AddRay(gunFlashObj.transform.parent.position, gunFlashObj.transform.parent.parent.forward, base.gameObject.name.Replace("(Clone)", string.Empty));
		}
	}
}
