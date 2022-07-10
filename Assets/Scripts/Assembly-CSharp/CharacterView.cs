using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class CharacterView : MonoBehaviour
{
	public enum CharacterType
	{
		Player,
		Mech,
		Turret
	}

	public Transform character;

	public Transform mech;

	public SkinnedMeshRenderer mechBodyRenderer;

	public SkinnedMeshRenderer mechHandRenderer;

	public SkinnedMeshRenderer mechGunRenderer;

	public Material[] mechGunMaterials;

	public Material[] mechBodyMaterials;

	public Transform turret;

	public Transform hatPoint;

	public Transform capePoint;

	public Transform bootsPoint;

	public Transform armorPoint;

	public Transform body;

	private AnimationCoroutineRunner _animationRunner;

	private AnimationClip _profile;

	private GameObject _weapon;

	private AnimationCoroutineRunner AnimationRunner
	{
		get
		{
			if (_animationRunner == null)
			{
				_animationRunner = GetComponent<AnimationCoroutineRunner>();
			}
			return _animationRunner;
		}
	}

	public void ShowCharacterType(CharacterType characterType)
	{
		character.gameObject.SetActive(false);
		if (mech != null)
		{
			mech.gameObject.SetActive(false);
		}
		if (turret != null)
		{
			turret.gameObject.SetActive(false);
		}
		switch (characterType)
		{
		case CharacterType.Player:
			character.gameObject.SetActive(true);
			break;
		case CharacterType.Mech:
			mech.gameObject.SetActive(true);
			break;
		case CharacterType.Turret:
			turret.gameObject.SetActive(true);
			break;
		}
	}

	public void UpdateMech(int mechUpgrade)
	{
		mechBodyRenderer.material = mechBodyMaterials[mechUpgrade];
		mechHandRenderer.material = mechBodyMaterials[mechUpgrade];
		mechGunRenderer.material = mechGunMaterials[mechUpgrade];
		mechBodyRenderer.material.SetColor("_ColorRili", Color.white);
		mechHandRenderer.material.SetColor("_ColorRili", Color.white);
	}

	public void UpdateTurret(int turretUpgrade)
	{
		TurretController component = turret.GetComponent<TurretController>();
		component.turretRenderer.material = component.turretRunMaterials[turretUpgrade];
		component.turretRenderer.material.SetColor("_ColorRili", Color.white);
	}

	public void SetWeaponAndSkin(string tg, Texture skinForPers)
	{
		AnimationRunner.StopAllCoroutines();
		if (WeaponManager.sharedManager == null)
		{
			return;
		}
		if (armorPoint.childCount > 0)
		{
			ArmorRefs component = armorPoint.GetChild(0).GetChild(0).GetComponent<ArmorRefs>();
			if (component != null)
			{
				if (component.leftBone != null)
				{
					component.leftBone.parent = armorPoint.GetChild(0).GetChild(0);
				}
				if (component.rightBone != null)
				{
					component.rightBone.parent = armorPoint.GetChild(0).GetChild(0);
				}
			}
		}
		List<Transform> list = new List<Transform>();
		foreach (Transform item in body)
		{
			list.Add(item);
		}
		foreach (Transform item2 in list)
		{
			item2.parent = null;
			UnityEngine.Object.Destroy(item2.gameObject);
		}
		if (tg == null)
		{
			return;
		}
		if (_profile != null)
		{
			if (Device.IsLoweMemoryDevice)
			{
				Resources.UnloadAsset(_profile);
			}
			_profile = null;
		}
		GameObject gameObject = null;
		gameObject = ((!(tg == "WeaponGrenade")) ? WeaponManager.sharedManager.weaponsInGame.OfType<GameObject>().FirstOrDefault((GameObject wp) => wp.tag.Equals(tg)) : Resources.Load<GameObject>("WeaponGrenade"));
		if (gameObject == null)
		{
			Debug.Log("pref == null");
			return;
		}
		_profile = Resources.Load<AnimationClip>("ProfileAnimClips/" + gameObject.name + "_Profile");
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
		Player_move_c.PerformActionRecurs(gameObject2, delegate(Transform t)
		{
			MeshRenderer component4 = t.GetComponent<MeshRenderer>();
			SkinnedMeshRenderer component5 = t.GetComponent<SkinnedMeshRenderer>();
			if (component4 != null)
			{
				component4.useLightProbes = false;
			}
			if (component5 != null)
			{
				component5.useLightProbes = false;
			}
		});
		Player_move_c.SetLayerRecursively(gameObject2, base.gameObject.layer);
		gameObject2.transform.parent = body;
		_weapon = gameObject2;
		_weapon.transform.localScale = new Vector3(1f, 1f, 1f);
		_weapon.transform.position = body.transform.position;
		_weapon.transform.localPosition = Vector3.zero;
		_weapon.transform.localRotation = Quaternion.identity;
		WeaponSounds component2 = _weapon.GetComponent<WeaponSounds>();
		if (armorPoint.childCount > 0 && component2 != null)
		{
			ArmorRefs component3 = armorPoint.GetChild(0).GetChild(0).GetComponent<ArmorRefs>();
			if (component3 != null)
			{
				if (component3.leftBone != null && component2.LeftArmorHand != null)
				{
					component3.leftBone.parent = component2.LeftArmorHand;
					component3.leftBone.localPosition = Vector3.zero;
					component3.leftBone.localRotation = Quaternion.identity;
					component3.leftBone.localScale = new Vector3(1f, 1f, 1f);
				}
				if (component3.rightBone != null && component2.RightArmorHand != null)
				{
					component3.rightBone.parent = component2.RightArmorHand;
					component3.rightBone.localPosition = Vector3.zero;
					component3.rightBone.localRotation = Quaternion.identity;
					component3.rightBone.localScale = new Vector3(1f, 1f, 1f);
				}
			}
		}
		PlayWeaponAnimation();
		SetSkinTexture(skinForPers);
		if (tg == "WeaponGrenade")
		{
			SetupWeaponGrenade(gameObject2);
		}
	}

	public void SetupWeaponGrenade(GameObject weaponGrenade)
	{
		GameObject original = Resources.Load<GameObject>("Rocket");
		Rocket component = (UnityEngine.Object.Instantiate(original, Vector3.zero, Quaternion.identity) as GameObject).GetComponent<Rocket>();
		component.enabled = false;
		component.dontExecStart = true;
		component.GetComponent<Rigidbody>().useGravity = false;
		component.GetComponent<Rigidbody>().isKinematic = true;
		component.rockets[10].SetActive(true);
		Player_move_c.SetLayerRecursively(component.gameObject, base.gameObject.layer);
		component.transform.parent = weaponGrenade.GetComponent<WeaponSounds>().grenatePoint;
		component.transform.localPosition = Vector3.zero;
		component.transform.localRotation = Quaternion.identity;
		component.transform.localScale = Vector3.one;
	}

	public void SetSkinTexture(Texture skin)
	{
		if (!(skin == null))
		{
			GameObject gameObject = ((body.transform.childCount <= 0) ? null : body.transform.GetChild(0).GetComponent<WeaponSounds>().bonusPrefab);
			Player_move_c.SetTextureRecursivelyFrom(character.gameObject, skin, new GameObject[5] { capePoint.gameObject, hatPoint.gameObject, bootsPoint.gameObject, armorPoint.gameObject, gameObject });
		}
	}

	public void UpdateHat(string hat)
	{
		RemoveHat();
		string @string = Storager.getString(Defs.VisualHatArmor, false);
		if (!string.IsNullOrEmpty(@string) && Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0].IndexOf(hat) >= 0 && Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0].IndexOf(hat) < Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0].IndexOf(@string))
		{
			hat = @string;
		}
		GameObject gameObject = Resources.Load("Hats/" + hat) as GameObject;
		if (gameObject == null)
		{
			Debug.LogWarning("hatPrefab == null");
			return;
		}
		GameObject gameObject2 = (GameObject)UnityEngine.Object.Instantiate(gameObject);
		ShopNGUIController.DisableLightProbesRecursively(gameObject2);
		Transform transform = gameObject2.transform;
		gameObject2.transform.parent = hatPoint.transform;
		gameObject2.transform.localPosition = Vector3.zero;
		gameObject2.transform.localRotation = Quaternion.identity;
		gameObject2.transform.localScale = new Vector3(1f, 1f, 1f);
		Player_move_c.SetLayerRecursively(gameObject2, base.gameObject.layer);
	}

	public void RemoveHat()
	{
		List<Transform> list = new List<Transform>();
		for (int i = 0; i < hatPoint.childCount; i++)
		{
			list.Add(hatPoint.GetChild(i));
		}
		foreach (Transform item in list)
		{
			item.parent = null;
			UnityEngine.Object.Destroy(item.gameObject);
		}
	}

	public void UpdateCape(string cape, Texture capeTex = null)
	{
		RemoveCape();
		GameObject gameObject = Resources.Load("Capes/" + cape) as GameObject;
		if (gameObject == null)
		{
			Debug.LogWarning("capePrefab == null");
			return;
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
		ShopNGUIController.DisableLightProbesRecursively(gameObject2);
		gameObject2.transform.parent = capePoint.transform;
		gameObject2.transform.localPosition = new Vector3(0f, -0.8f, 0f);
		gameObject2.transform.localRotation = Quaternion.identity;
		gameObject2.transform.localScale = new Vector3(1f, 1f, 1f);
		Player_move_c.SetLayerRecursively(gameObject2, base.gameObject.layer);
		if (capeTex != null)
		{
			Player_move_c.SetTextureRecursivelyFrom(gameObject2, capeTex, new GameObject[0]);
		}
	}

	public void RemoveCape()
	{
		for (int i = 0; i < capePoint.transform.childCount; i++)
		{
			UnityEngine.Object.Destroy(capePoint.transform.GetChild(i).gameObject);
		}
	}

	public void UpdateBoots(string bs)
	{
		foreach (Transform item in bootsPoint.transform)
		{
			item.gameObject.SetActive(item.gameObject.name.Equals(bs));
		}
	}

	public void RemoveBoots()
	{
		foreach (Transform item in bootsPoint.transform)
		{
			item.gameObject.SetActive(false);
		}
	}

	public void UpdateArmor(string armor)
	{
		RemoveArmor();
		string @string = Storager.getString(Defs.VisualArmor, false);
		if (!string.IsNullOrEmpty(@string) && Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0].IndexOf(armor) >= 0 && Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0].IndexOf(armor) < Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0].IndexOf(@string))
		{
			armor = @string;
		}
		GameObject gameObject = Resources.Load("Armor/" + armor) as GameObject;
		if (gameObject == null)
		{
			Debug.LogWarning("armorPrefab == null");
			return;
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
		ShopNGUIController.DisableLightProbesRecursively(gameObject2);
		ArmorRefs component = gameObject2.transform.GetChild(0).GetComponent<ArmorRefs>();
		if (component != null && _weapon != null)
		{
			WeaponSounds component2 = _weapon.GetComponent<WeaponSounds>();
			if (component.leftBone != null && component2.LeftArmorHand != null)
			{
				component.leftBone.parent = component2.LeftArmorHand;
				component.leftBone.localPosition = Vector3.zero;
				component.leftBone.localRotation = Quaternion.identity;
				component.leftBone.localScale = new Vector3(1f, 1f, 1f);
			}
			if (component.rightBone != null && component2.RightArmorHand != null)
			{
				component.rightBone.parent = component2.RightArmorHand;
				component.rightBone.localPosition = Vector3.zero;
				component.rightBone.localRotation = Quaternion.identity;
				component.rightBone.localScale = new Vector3(1f, 1f, 1f);
			}
			gameObject2.transform.parent = armorPoint.transform;
			gameObject2.transform.localPosition = Vector3.zero;
			gameObject2.transform.localRotation = Quaternion.identity;
			gameObject2.transform.localScale = new Vector3(1f, 1f, 1f);
			Player_move_c.SetLayerRecursively(gameObject2, base.gameObject.layer);
		}
	}

	public void RemoveArmor()
	{
		if (armorPoint.childCount <= 0)
		{
			return;
		}
		Transform child = armorPoint.GetChild(0);
		ArmorRefs component = child.GetChild(0).GetComponent<ArmorRefs>();
		if (component != null)
		{
			if (component.leftBone != null)
			{
				component.leftBone.parent = child.GetChild(0);
			}
			if (component.rightBone != null)
			{
				component.rightBone.parent = child.GetChild(0);
			}
			child.parent = null;
			UnityEngine.Object.Destroy(child.gameObject);
		}
	}

	private void PlayWeaponAnimation()
	{
		if (_profile != null)
		{
			Animation animation = _weapon.GetComponent<WeaponSounds>().animationObject.GetComponent<Animation>();
			if (Time.timeScale != 0f)
			{
				if (animation.GetClip("Profile") == null)
				{
					animation.AddClip(_profile, "Profile");
				}
				else
				{
					Debug.LogWarning("Animation clip is null.");
				}
				animation.Play("Profile");
				return;
			}
			AnimationRunner.StopAllCoroutines();
			if (animation.GetClip("Profile") == null)
			{
				animation.AddClip(_profile, "Profile");
			}
			else
			{
				Debug.LogWarning("Animation clip is null.");
			}
			AnimationRunner.StartPlay(animation, "Profile", false, null);
		}
		else
		{
			Debug.LogWarning("_profile == null");
		}
	}

	public static Texture2D GetClanLogo(string logoBase64)
	{
		if (string.IsNullOrEmpty(logoBase64))
		{
			return null;
		}
		byte[] data = Convert.FromBase64String(logoBase64);
		Texture2D texture2D = new Texture2D(Defs.LogoWidth, Defs.LogoHeight, TextureFormat.ARGB32, false);
		texture2D.LoadImage(data);
		texture2D.filterMode = FilterMode.Point;
		texture2D.Apply();
		return texture2D;
	}
}
