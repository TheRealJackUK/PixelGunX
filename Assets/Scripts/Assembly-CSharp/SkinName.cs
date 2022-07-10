using System;
using System.Collections;
using Rilisoft;
using UnityEngine;

public sealed class SkinName : MonoBehaviour
{
	[NonSerialized]
	public string currentHat;

	[NonSerialized]
	public string currentArmor;

	[NonSerialized]
	public string currentCape;

	[NonSerialized]
	public Texture currentCapeTex;

	[NonSerialized]
	public string currentBoots;

	public Transform onGroundEffectsPoint;

	public GameObject playerGameObject;

	public Player_move_c playerMoveC;

	public string skinName;

	public GameObject hatsPoint;

	public GameObject capesPoint;

	public GameObject bootsPoint;

	public GameObject armorPoint;

	public string NickName;

	public GameObject camPlayer;

	public GameObject headObj;

	public GameObject bodyLayer;

	public CharacterController character;

	public PhotonView photonView;

	public int typeAnim;

	public WeaponManager _weaponManager;

	public bool isInet;

	public bool isLocal;

	public bool isMine;

	public bool isMulti;

	public AudioClip walkAudio;

	public AudioClip jumpAudio;

	public AudioClip jumpDownAudio;

	public AudioClip walkMech;

	public bool isPlayDownSound;

	public GameObject FPSplayerObject;

	public ThirdPersonNetwork1 interpolateScript;

	private bool _impactedByTramp;

	private ImpactReceiverTrampoline _irt;

	private bool _armorPopularityCacheIsDirty;

	public void sendAnimJump()
	{
		int num = ((!character.isGrounded) ? 2 : 0);
		if (interpolateScript.myAnim != num)
		{
			if (Defs.isSoundFX && num == 2)
			{
				NGUITools.PlaySound(jumpAudio);
			}
			interpolateScript.myAnim = num;
			interpolateScript.weAreSteals = EffectsController.WeAreStealth;
			if (isMulti)
			{
				SetAnim(num, EffectsController.WeAreStealth);
			}
		}
	}

	[RPC]
	public void SetAnim(int _typeAnim, bool stealth)
	{
		string text = "Idle";
		switch (_typeAnim)
		{
		case 0:
			text = "Idle";
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Stop();
			}
			break;
		case 1:
			text = "Walk";
			base.GetComponent<AudioSource>().loop = true;
			base.GetComponent<AudioSource>().clip = ((!playerMoveC.isMechActive) ? walkAudio : walkMech);
			if (!stealth && Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Play();
			}
			break;
		case 2:
			text = "Jump";
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Stop();
			}
			break;
		case 4:
			text = "Walk_Back";
			base.GetComponent<AudioSource>().loop = true;
			base.GetComponent<AudioSource>().clip = ((!playerMoveC.isMechActive) ? walkAudio : walkMech);
			if (!stealth && Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Play();
			}
			break;
		case 5:
			text = "Walk_Left";
			base.GetComponent<AudioSource>().loop = true;
			base.GetComponent<AudioSource>().clip = ((!playerMoveC.isMechActive) ? walkAudio : walkMech);
			if (!stealth && Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Play();
			}
			break;
		case 6:
			text = "Walk_Right";
			base.GetComponent<AudioSource>().loop = true;
			base.GetComponent<AudioSource>().clip = ((!playerMoveC.isMechActive) ? walkAudio : walkMech);
			if (!stealth && Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Play();
			}
			break;
		}
		if (_typeAnim == 7)
		{
			text = "Jetpack_Run_Front";
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Stop();
			}
		}
		if (_typeAnim == 8)
		{
			text = "Jetpack_Run_Back";
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Stop();
			}
		}
		if (_typeAnim == 9)
		{
			text = "Jetpack_Run_Left";
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Stop();
			}
		}
		if (_typeAnim == 10)
		{
			text = "Jetpack_Run_Righte";
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Stop();
			}
		}
		if (_typeAnim == 11)
		{
			text = "Jetpack_Idle";
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Stop();
			}
		}
		if (playerMoveC.isMechActive)
		{
			playerMoveC.mechBodyAnimation.Play(text);
		}
		FPSplayerObject.GetComponent<Animation>().Play(text);
		if (capesPoint.transform.childCount > 0 && capesPoint.transform.GetChild(0).GetComponent<Animation>().GetClip(text) != null)
		{
			capesPoint.transform.GetChild(0).GetComponent<Animation>().Play(text);
		}
	}

	[RPC]
	private void SetAnim(int _typeAnim)
	{
		SetAnim(_typeAnim, true);
	}

	[RPC]
	private void setCapeCustomRPC(string str)
	{
		if (capesPoint.transform.childCount > 0)
		{
			for (int i = 0; i < capesPoint.transform.childCount; i++)
			{
				UnityEngine.Object.Destroy(capesPoint.transform.GetChild(i).gameObject);
			}
		}
		byte[] data = Convert.FromBase64String(str);
		Texture2D texture2D = new Texture2D(12, 16, TextureFormat.ARGB32, false);
		texture2D.LoadImage(data);
		texture2D.filterMode = FilterMode.Point;
		texture2D.Apply();
		UnityEngine.Object @object = Resources.Load("Capes/" + Wear.cape_Custom);
		if (!(@object == null))
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(@object) as GameObject;
			Transform transform = gameObject.transform;
			gameObject.GetComponent<CustomCapePicker>().shouldLoadTexture = false;
			transform.parent = capesPoint.transform;
			transform.localPosition = Vector3.zero;
			transform.localRotation = Quaternion.identity;
			Player_move_c.SetTextureRecursivelyFrom(gameObject, texture2D, new GameObject[0]);
			currentCapeTex = texture2D;
			currentCape = Wear.cape_Custom;
		}
	}

	[RPC]
	private void setCapeRPC(string _currentCape)
	{
		if (capesPoint.transform.childCount > 0)
		{
			for (int i = 0; i < capesPoint.transform.childCount; i++)
			{
				UnityEngine.Object.Destroy(capesPoint.transform.GetChild(i).gameObject);
			}
		}
		GameObject gameObject = Resources.Load("Capes/" + _currentCape) as GameObject;
		if (!(gameObject == null))
		{
			GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
			Transform transform = gameObject2.transform;
			transform.parent = capesPoint.transform;
			transform.localPosition = Vector3.zero;
			transform.localRotation = Quaternion.identity;
			currentCapeTex = null;
			currentCape = _currentCape;
		}
	}

	[RPC]
	private void setArmorRPC(string _currentArmor)
	{
		SetArmorVisInvisibleRPC(_currentArmor, false);
	}

	[RPC]
	private void SetArmorVisInvisibleRPC(string _currentArmor, bool _isInviseble)
	{
		if (armorPoint.transform.childCount > 0)
		{
			for (int i = 0; i < armorPoint.transform.childCount; i++)
			{
				UnityEngine.Object.Destroy(armorPoint.transform.GetChild(i).gameObject);
			}
		}
		currentArmor = _currentArmor;
		GameObject gameObject = Resources.Load("Armor/" + _currentArmor) as GameObject;
		if (gameObject == null)
		{
			return;
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
		Transform transform = gameObject2.transform;
		if (_isInviseble)
		{
			ShopNGUIController.SetRenderersVisibleFromPoint(transform, false);
		}
		ArmorRefs component = transform.GetChild(0).GetComponent<ArmorRefs>();
		if (component != null)
		{
			if (playerMoveC != null && playerMoveC.transform.childCount > 0)
			{
				WeaponSounds component2 = playerMoveC.transform.GetChild(0).GetComponent<WeaponSounds>();
				component.leftBone.GetComponent<SetPosInArmor>().target = component2.LeftArmorHand;
				component.rightBone.GetComponent<SetPosInArmor>().target = component2.RightArmorHand;
			}
			transform.parent = armorPoint.transform;
			transform.localPosition = Vector3.zero;
			transform.localRotation = Quaternion.identity;
			transform.localScale = new Vector3(1f, 1f, 1f);
		}
	}

	[RPC]
	private void setBootsRPC(string _currentBoots)
	{
		for (int i = 0; i < bootsPoint.transform.childCount; i++)
		{
			Transform child = bootsPoint.transform.GetChild(i);
			if (child.gameObject.name.Equals(_currentBoots))
			{
				child.gameObject.SetActive(true);
			}
			else
			{
				child.gameObject.SetActive(false);
			}
		}
		currentBoots = _currentBoots;
	}

	[RPC]
	private void setHatRPC(string _currentHat)
	{
		SetHatWithInvisebleRPC(_currentHat, false);
	}

	[RPC]
	private void SetHatWithInvisebleRPC(string _currentHat, bool _isHatInviseble)
	{
		if (hatsPoint.transform.childCount > 0)
		{
			for (int i = 0; i < hatsPoint.transform.childCount; i++)
			{
				UnityEngine.Object.Destroy(hatsPoint.transform.GetChild(i).gameObject);
			}
		}
		currentHat = _currentHat;
		GameObject gameObject = Resources.Load("Hats/" + _currentHat) as GameObject;
		if (!(gameObject == null))
		{
			GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
			Transform transform = gameObject2.transform;
			if (_isHatInviseble)
			{
				ShopNGUIController.SetRenderersVisibleFromPoint(transform, false);
			}
			transform.parent = hatsPoint.transform;
			transform.localPosition = Vector3.zero;
			transform.localRotation = Quaternion.identity;
		}
	}

	private void Awake()
	{
		isLocal = !Defs.isInet;
	}

	private void Start()
	{
		_weaponManager = WeaponManager.sharedManager;
		playerMoveC = playerGameObject.GetComponent<Player_move_c>();
		character = base.transform.GetComponent<CharacterController>();
		isMulti = Defs.isMulti;
		photonView = PhotonView.Get(this);
		isInet = Defs.isInet;
		if (!isInet)
		{
			isMine = base.GetComponent<NetworkView>().isMine;
		}
		else
		{
			isMine = photonView.isMine;
		}
		if (((!Defs.isInet && !base.GetComponent<NetworkView>().isMine) || (Defs.isInet && !photonView.isMine)) && Defs.isMulti)
		{
			camPlayer.active = false;
			character.enabled = false;
		}
		else
		{
			FPSplayerObject.SetActive(false);
		}
		if (!Defs.isMulti || (!Defs.isInet && base.GetComponent<NetworkView>().isMine) || (Defs.isInet && photonView.isMine))
		{
			base.gameObject.layer = 11;
			bodyLayer.layer = 11;
			headObj.layer = 11;
		}
		if (isMulti && isMine)
		{
			SetCape();
			SetHat();
			SetBoots();
			SetArmor();
		}
	}

	private void OnDestroy()
	{
		if (_armorPopularityCacheIsDirty)
		{
			Statistics.Instance.SaveArmorPopularity();
			_armorPopularityCacheIsDirty = false;
		}
	}

	public void SetCape()
	{
		string @string = Storager.getString(Defs.CapeEquppedSN, false);
		if (!@string.Equals(Wear.cape_Custom))
		{
			if (isInet)
			{
				photonView.RPC("setCapeRPC", PhotonTargets.Others, @string);
			}
			else
			{
				base.GetComponent<NetworkView>().RPC("setCapeRPC", RPCMode.OthersBuffered, @string);
			}
		}
		else if (@string.Equals(Wear.cape_Custom))
		{
			Texture2D capeUserTexture = SkinsController.capeUserTexture;
			byte[] inArray = capeUserTexture.EncodeToPNG();
			string text = Convert.ToBase64String(inArray);
			if (isInet)
			{
				photonView.RPC("setCapeCustomRPC", PhotonTargets.Others, text);
			}
			else
			{
				base.GetComponent<NetworkView>().RPC("setCapeCustomRPC", RPCMode.OthersBuffered, text);
			}
		}
	}

	public void SetArmor()
	{
		if (!Defs.isHunger)
		{
			string @string = Storager.getString(Defs.ArmorNewEquppedSN, false);
			bool flag = !ShopNGUIController.ShowArmor;
			if (isInet)
			{
				photonView.RPC("SetArmorVisInvisibleRPC", PhotonTargets.Others, @string, flag);
			}
			else
			{
				base.GetComponent<NetworkView>().RPC("SetArmorVisInvisibleRPC", RPCMode.Others, @string, flag);
			}
			IncrementArmorPopularity(@string);
		}
	}

	public void SetBoots()
	{
		string @string = Storager.getString(Defs.BootsEquppedSN, false);
		if (isInet)
		{
			photonView.RPC("setBootsRPC", PhotonTargets.Others, @string);
		}
		else
		{
			base.GetComponent<NetworkView>().RPC("setBootsRPC", RPCMode.OthersBuffered, @string);
		}
	}

	public void OnPhotonPlayerConnected(PhotonPlayer player)
	{
		if ((bool)photonView && photonView.isMine)
		{
			SetHat();
			SetCape();
			SetBoots();
			SetArmor();
		}
	}

	private void OnPlayerConnected(NetworkPlayer player)
	{
		if (base.GetComponent<NetworkView>().isMine)
		{
			SetHat();
			SetCape();
			SetBoots();
			SetArmor();
		}
	}

	public void SetHat()
	{
		string @string = Storager.getString(Defs.HatEquppedSN, false);
		if (@string == null || !Defs.isHunger || Wear.NonArmorHat(@string))
		{
			bool flag = !ShopNGUIController.ShowHat && !Wear.NonArmorHat(@string);
			if (isInet)
			{
				photonView.RPC("SetHatWithInvisebleRPC", PhotonTargets.Others, @string, flag);
			}
			else
			{
				base.GetComponent<NetworkView>().RPC("SetHatWithInvisebleRPC", RPCMode.Others, @string, flag);
			}
		}
	}

	private void Update()
	{
		if ((!isMulti || !isMine) && isMulti)
		{
			return;
		}
		if (playerMoveC.isKilled)
		{
			isPlayDownSound = false;
		}
		int num = 0;
		if ((character.velocity.y > 0.01f || character.velocity.y < -0.01f) && !character.isGrounded && !Defs.isJetpackEnabled)
		{
			num = 2;
		}
		else if (character.velocity.x != 0f || character.velocity.z != 0f)
		{
			if (character.isGrounded)
			{
				float x = JoystickController.leftJoystick.value.x;
				float y = JoystickController.leftJoystick.value.y;
				num = ((Mathf.Abs(y) >= Mathf.Abs(x)) ? ((y >= 0f) ? 1 : 4) : ((!(x >= 0f)) ? 5 : 6));
			}
			else if (Defs.isJetpackEnabled)
			{
				float x2 = JoystickController.leftJoystick.value.x;
				float y2 = JoystickController.leftJoystick.value.y;
				num = ((Mathf.Abs(y2) >= Mathf.Abs(x2)) ? ((!(y2 >= 0f)) ? 8 : 7) : ((!(x2 >= 0f)) ? 9 : 10));
			}
		}
		else if (Defs.isJetpackEnabled && !character.isGrounded)
		{
			num = 11;
		}
		if (character.velocity.y < -2.5f && !character.isGrounded)
		{
			isPlayDownSound = true;
		}
		if (isPlayDownSound && character.isGrounded)
		{
			if (Defs.isSoundFX)
			{
				NGUITools.PlaySound(jumpDownAudio);
			}
			isPlayDownSound = false;
		}
		if (num == typeAnim)
		{
			return;
		}
		typeAnim = num;
		if (((isMulti && isMine) || !isMulti) && typeAnim != 2)
		{
			interpolateScript.myAnim = typeAnim;
			interpolateScript.weAreSteals = EffectsController.WeAreStealth;
			if (isMulti)
			{
				SetAnim(typeAnim, EffectsController.WeAreStealth);
			}
		}
		if (isMulti)
		{
			return;
		}
		if (typeAnim != 1)
		{
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().Stop();
			}
			return;
		}
		base.GetComponent<AudioSource>().loop = true;
		base.GetComponent<AudioSource>().clip = walkAudio;
		if (Defs.isSoundFX)
		{
			base.GetComponent<AudioSource>().Play();
		}
	}

	public IEnumerator _SetAndResetImpactedByTrampoline()
	{
		_impactedByTramp = true;
		yield return new WaitForSeconds(0.1f);
		_impactedByTramp = false;
	}

	private void OnControllerColliderHit(ControllerColliderHit col)
	{
		if ((!isMulti || isMine) && _irt != null && !_impactedByTramp)
		{
			UnityEngine.Object.Destroy(_irt);
			_irt = null;
		}
		if (!isMulti && col.gameObject.name.Equals("DeadCollider"))
		{
			isPlayDownSound = false;
			if (playerMoveC.CurHealth > 0f)
			{
				playerMoveC.CurHealth = 0f;
				playerMoveC.curArmor = 0f;
				playerMoveC.StartFlash(base.gameObject);
			}
			return;
		}
		if (!_impactedByTramp && col.gameObject.CompareTag("Trampoline") && (!isMulti || isMine))
		{
			if (_irt == null)
			{
				_irt = base.gameObject.AddComponent<ImpactReceiverTrampoline>();
			}
			bool flag = base.transform.up.Equals(col.transform.up);
			float force = ((!flag) ? 45 : 45);
			Vector3 dir = ((!flag) ? (-character.velocity.normalized + col.transform.up) : (new Vector3(character.velocity.normalized.x, Mathf.Abs(character.velocity.normalized.y), character.velocity.normalized.z) + col.transform.up));
			_irt.AddImpact(dir, force);
			StartCoroutine(_SetAndResetImpactedByTrampoline());
			return;
		}
		bool flag2 = (isLocal && base.GetComponent<NetworkView>().isMine) || (isInet && (bool)photonView && photonView.isMine);
		if (isMulti && flag2 && col.gameObject.name.Equals("DeadCollider"))
		{
			isPlayDownSound = false;
			if (playerMoveC.CurHealth > 0f)
			{
				playerMoveC.curArmor = 0f;
				playerMoveC.CurHealth = 0f;
				ImSuicide();
			}
			playerMoveC.SendImKilled();
		}
	}

	public void ImSuicide()
	{
		if (playerMoveC.countKills > 0)
		{
			GlobalGameController.CountKills = playerMoveC.countKills;
		}
		_weaponManager.myNetworkStartTable.CountKills = playerGameObject.GetComponent<Player_move_c>().countKills;
		_weaponManager.myNetworkStartTable.SynhCountKills();
		playerMoveC.sendImDeath(NickName);
		if (Defs.isFlag && playerMoveC.isCaptureFlag)
		{
			playerMoveC.enemyFlag.GoBaza();
			playerMoveC.isCaptureFlag = false;
			playerMoveC.SendSystemMessegeFromFlagReturned(playerMoveC.enemyFlag.isBlue);
		}
	}

	private void OnTriggerEnter(Collider col)
	{
		if ((!isMulti || isMine) && col.gameObject.name.Equals("DamageCollider"))
		{
			col.gameObject.GetComponent<DamageCollider>().RegisterPlayer();
		}
	}

	private void OnTriggerExit(Collider col)
	{
		if ((!isMulti || isMine) && col.gameObject.name.Equals("DamageCollider"))
		{
			col.gameObject.GetComponent<DamageCollider>().UnregisterPlayer();
		}
	}

	private void IncrementArmorPopularity(string currentArmor)
	{
		if (isInet && isMulti && isMine)
		{
			string key = "None";
			if (currentArmor != Defs.ArmorNewNoneEqupped)
			{
				key = ItemDb.GetItemNameNonLocalized(currentArmor, currentArmor, ShopNGUIController.CategoryNames.ArmorCategory, "Unknown");
			}
			Statistics.Instance.IncrementArmorPopularity(key);
			_armorPopularityCacheIsDirty = true;
		}
	}
}
