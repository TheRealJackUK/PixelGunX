using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public sealed class PersConfigurator : MonoBehaviour
{
	public static PersConfigurator currentConfigurator;

	public Transform armorPoint;

	public Transform boots;

	public Transform cape;

	public Transform hat;

	public GameObject body;

	public GameObject gun;

	private GameObject weapon;

	private NickLabelController _label;

	private GameObject shadow;

	private AnimationClip profile;

	private void Awake()
	{
		currentConfigurator = this;
	}

	private IEnumerator Start()
	{
		WeaponManager weaponManager = WeaponManager.sharedManager;
		int maxCost = 0;
		GameObject pref = null;
		List<Weapon> boughtWeapons = new List<Weapon>();
		foreach (Weapon pw2 in weaponManager.allAvailablePlayerWeapons)
		{
			if (WeaponManager.tagToStoreIDMapping.ContainsKey(pw2.weaponPrefab.tag))
			{
				boughtWeapons.Add(pw2);
			}
		}
		if (boughtWeapons.Count == 0)
		{
			foreach (Weapon pw in weaponManager.allAvailablePlayerWeapons)
			{
				if (pw.weaponPrefab.tag.Equals(WeaponManager._initialWeaponName))
				{
					pref = pw.weaponPrefab;
					break;
				}
			}
		}
		else
		{
			pref = boughtWeapons[Random.Range(0, boughtWeapons.Count)].weaponPrefab;
		}
		if (pref == null)
		{
			Debug.LogWarning("pref == null");
		}
		else
		{
			Debug.Log("ProfileAnims/" + pref.name + "_Profile");
			profile = Resources.Load<AnimationClip>("ProfileAnimClips/" + pref.name + "_Profile");
			GameObject w = Object.Instantiate(pref) as GameObject;
			w.transform.parent = body.transform;
			weapon = w;
			weapon.transform.localPosition = Vector3.zero;
			weapon.transform.localRotation = Quaternion.identity;
			if (profile != null)
			{
				profile.wrapMode = WrapMode.Loop;
				weapon.GetComponent<WeaponSounds>().animationObject.GetComponent<Animation>().AddClip(profile, "Profile");
				weapon.GetComponent<WeaponSounds>().animationObject.GetComponent<Animation>().Play("Profile");
			}
			gun = w.GetComponent<WeaponSounds>().bonusPrefab;
		}
		GameObject[] gunflashes = Object.FindObjectsOfType<GameObject>();
		GameObject[] array = gunflashes;
		foreach (GameObject go in array)
		{
			if (go.name.Equals("GunFlash"))
			{
				go.SetActive(false);
			}
		}
		SetCurrentSkin();
		ShopNGUIController.sharedShop.onEquipSkinAction = delegate
		{
			SetCurrentSkin();
		}; 
		yield return new WaitForEndOfFrame();
		_AddCapeAndHat();
		
		ShopNGUIController.sharedShop.wearEquipAction = delegate
		{
			_AddCapeAndHat();
		};
		ShopNGUIController.sharedShop.wearUnequipAction = delegate
		{
			_AddCapeAndHat();
		};

		ShopNGUIController.ShowArmorChanged += HandleShowArmorChanged;
		while (NickLabelStack.sharedStack == null)
		{
			yield return null;
		}
		NickLabelController.currentCamera = Camera.main;
		_label = NickLabelStack.sharedStack.GetNextCurrentLabel();
		_label.target = base.transform;
		_label.isMenu = true;
		_label.isTurrerLabel = false;
		_label.StartShow();
	}

	private void HandleShowArmorChanged()
	{
		_AddCapeAndHat();
	}

	private void SetCurrentSkin()
	{
		Texture currentSkinForPers = SkinsController.currentSkinForPers;
		if (!(currentSkinForPers != null))
		{
			return;
		}
		currentSkinForPers.filterMode = FilterMode.Point;
		GameObject[] collection = new GameObject[5] { gun, cape.gameObject, hat.gameObject, boots.gameObject, armorPoint.gameObject };
		List<GameObject> list = new List<GameObject>(collection);
		if (weapon != null)
		{
			WeaponSounds component = weapon.GetComponent<WeaponSounds>();
			if (component.LeftArmorHand != null)
			{
				list.Add(component.LeftArmorHand.gameObject);
			}
			if (component.RightArmorHand != null)
			{
				list.Add(component.RightArmorHand.gameObject);
			}
			if (component.grenatePoint != null)
			{
				list.Add(component.grenatePoint.gameObject);
			}
		}
		Player_move_c.SetTextureRecursivelyFrom(base.gameObject, currentSkinForPers, list.ToArray());
	}

	public void _AddCapeAndHat()
	{
		List<Transform> list = new List<Transform>();
		for (int i = 0; i < cape.childCount; i++)
		{
			list.Add(cape.GetChild(i));
		}
		foreach (Transform item in list)
		{
			Object.Destroy(item.gameObject);
		}
		string @string = Storager.getString(Defs.CapeEquppedSN, false);
		if (!@string.Equals(Defs.CapeNoneEqupped))
		{
			GameObject gameObject = Resources.Load(ResPath.Combine(Defs.CapesDir, @string)) as GameObject;
			if (gameObject != null)
			{
				GameObject gameObject2 = Object.Instantiate(gameObject, Vector3.zero, Quaternion.identity) as GameObject;
				gameObject2.transform.parent = cape;
				gameObject2.transform.localPosition = new Vector3(0f, -0.8f, 0f);
				gameObject2.transform.localRotation = Quaternion.identity;
				gameObject2.GetComponent<Animation>().Play(Defs.CAnim(gameObject2,("Profile")));
			}
			else
			{
				Debug.LogWarning("capePrefab == null");
			}
		}
		list = new List<Transform>();
		for (int j = 0; j < hat.childCount; j++)
		{
			list.Add(hat.GetChild(j));
		}
		foreach (Transform item2 in list)
		{
			item2.parent = null;
			Object.Destroy(item2.gameObject);
		}
		string text = Storager.getString(Defs.HatEquppedSN, false);
		string string2 = Storager.getString(Defs.VisualHatArmor, false);
		if (!string.IsNullOrEmpty(string2) && Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0].IndexOf(text) >= 0 && Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0].IndexOf(text) < Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0].IndexOf(string2))
		{
			text = string2;
		}
		if (!text.Equals(Defs.HatNoneEqupped))
		{
			GameObject gameObject3 = Resources.Load(ResPath.Combine(Defs.HatsDir, text)) as GameObject;
			if (gameObject3 != null)
			{
				GameObject gameObject4 = Object.Instantiate(gameObject3, Vector3.zero, Quaternion.identity) as GameObject;
				gameObject4.transform.parent = hat;
				gameObject4.transform.localPosition = Vector3.zero;
				gameObject4.transform.localRotation = Quaternion.identity;
			}
			else
			{
				Debug.LogWarning("hatPrefab == null");
			}
		}
		list = new List<Transform>();
		for (int k = 0; k < boots.childCount; k++)
		{
			boots.GetChild(k).gameObject.SetActive(false);
		}
		string string3 = Storager.getString(Defs.BootsEquppedSN, false);
		if (!string3.Equals(Defs.BootsNoneEqupped))
		{
			foreach (Transform boot in boots)
			{
				if (boot.gameObject.name.Equals(string3))
				{
					boot.gameObject.SetActive(true);
				}
				else
				{
					boot.gameObject.SetActive(false);
				}
			}
		}
		list = new List<Transform>();
		for (int l = 0; l < armorPoint.childCount; l++)
		{
			list.Add(armorPoint.GetChild(l));
		}
		foreach (Transform item3 in list)
		{
			ArmorRefs component = item3.GetChild(0).GetComponent<ArmorRefs>();
			if (component != null)
			{
				if (component.leftBone != null)
				{
					component.leftBone.parent = item3.GetChild(0);
				}
				if (component.rightBone != null)
				{
					component.rightBone.parent = item3.GetChild(0);
				}
				item3.parent = null;
				Object.Destroy(item3.gameObject);
			}
		}
		string text2 = Storager.getString(Defs.ArmorNewEquppedSN, false);
		string string4 = Storager.getString(Defs.VisualArmor, false);
		if (!string.IsNullOrEmpty(string4) && Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0].IndexOf(text2) >= 0 && Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0].IndexOf(text2) < Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0].IndexOf(string4))
		{
			text2 = string4;
		}
		if (!text2.Equals(Defs.ArmorNewNoneEqupped))
		{
			GameObject gameObject5 = Resources.Load("Armor/" + text2) as GameObject;
			if (gameObject5 == null)
			{
				return;
			}
			GameObject gameObject6 = Object.Instantiate(gameObject5) as GameObject;
			ArmorRefs component2 = gameObject6.transform.GetChild(0).GetComponent<ArmorRefs>();
			if (component2 != null)
			{
				if (weapon != null)
				{
					WeaponSounds component3 = weapon.GetComponent<WeaponSounds>();
					if (component3 != null && component2.leftBone != null && component3.LeftArmorHand != null)
					{
						component2.leftBone.parent = component3.LeftArmorHand;
						component2.leftBone.localPosition = Vector3.zero;
						component2.leftBone.localRotation = Quaternion.identity;
						component2.leftBone.localScale = new Vector3(1f, 1f, 1f);
					}
					if (component3 != null && component2.rightBone != null && component3.RightArmorHand != null)
					{
						component2.rightBone.parent = component3.RightArmorHand;
						component2.rightBone.localPosition = Vector3.zero;
						component2.rightBone.localRotation = Quaternion.identity;
						component2.rightBone.localScale = new Vector3(1f, 1f, 1f);
					}
				}
				gameObject6.transform.parent = armorPoint.transform;
				gameObject6.transform.localPosition = Vector3.zero;
				gameObject6.transform.localRotation = Quaternion.identity;
				gameObject6.transform.localScale = new Vector3(1f, 1f, 1f);
			}
		}
		ShopNGUIController.SetPersHatVisible(hat);
		ShopNGUIController.SetPersArmorVisible(armorPoint);
	}

	private void Update()
	{
		if (!(Camera.main != null))
		{
			return;
		}
		Ray ray = Camera.main.ScreenPointToRay(new Vector3(Screen.width / 2, Screen.height / 2, 0f));
		Touch[] touches = Input.touches;
		foreach (Touch touch in touches)
		{
			RaycastHit hitInfo;
			if (touch.phase == TouchPhase.Began && Physics.Raycast(ray, out hitInfo, 1000f, -5) && hitInfo.collider.gameObject.name.Equals("MainMenu_Pers"))
			{
				PlayerPrefs.SetInt(Defs.ProfileEnteredFromMenu, 1);
				ConnectSceneNGUIController.GoToProfile();
				break;
			}
		}
	}

	private void OnDestroy()
	{
		if (ShopNGUIController.sharedShop != null)
		{
			ShopNGUIController.sharedShop.onEquipSkinAction = null;
			ShopNGUIController.sharedShop.wearEquipAction = null;
			ShopNGUIController.sharedShop.wearUnequipAction = null;
		}
		if (profile != null && Device.IsLoweMemoryDevice)
		{
			Resources.UnloadAsset(profile);
		}
		ShopNGUIController.ShowArmorChanged -= HandleShowArmorChanged;
		currentConfigurator = null;
	}
}
