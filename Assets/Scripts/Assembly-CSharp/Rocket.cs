using System;
using System.Collections;
using System.Reflection;
using Rilisoft;
using RilisoftBot;
using UnityEngine;

public sealed class Rocket : MonoBehaviour
{
	private int _rocketNum;

	public string weaponName = string.Empty;

	public GameObject[] rockets;

	public WeaponSounds.TypeDead[] typeDead;

	public float damage;

	public float radiusDamage;

	public float radiusDamageSelf;

	public float radiusImpulse;

	public float multiplayerDamage;

	public Vector2 damageRange;

	public PhotonView photonView;

	private bool isMulti;

	private bool isInet;

	private bool isCompany;

	private bool isCOOP;

	public bool isMine;

	private WeaponManager _weaponManager;

	private bool isKilled;

	public Transform target;

	public bool isRun;

	private GameObject myPlayer;

	private bool isStartSynh;

	private Vector3 correctPos = Vector3.zero;

	public Transform myTransform;

	private bool isFirstPos = true;

	public bool dontExecStart;

	public RocketSettings currentRocketSettings;

	public float slowdownTime { get; set; }

	public float slowdownCoeff { get; set; }

	public bool isSlowdown { get; set; }

	public int rocketNum
	{
		get
		{
			return _rocketNum;
		}
		set
		{
			_rocketNum = value;
			currentRocketSettings = rockets[value].GetComponent<RocketSettings>();
		}
	}

	private void Awake()
	{
		isMulti = Defs.isMulti;
		isInet = Defs.isInet;
		isCompany = Defs.isCompany;
		isCOOP = Defs.isCOOP;
		photonView = PhotonView.Get(this);
		myTransform = base.transform;
		if (isMulti)
		{
			if (!isInet)
			{
				isMine = base.GetComponent<NetworkView>().isMine;
			}
			else
			{
				isMine = photonView.isMine;
			}
		}
		_weaponManager = WeaponManager.sharedManager;
	}

	public void SetRocketActiveSendRPC()
	{
		if (isMulti && isMine)
		{
			if (!isInet)
			{
				base.GetComponent<NetworkView>().RPC("SetRocketActive", RPCMode.AllBuffered, rocketNum, radiusImpulse);
			}
			else
			{
				photonView.RPC("SetRocketActive", PhotonTargets.AllBuffered, rocketNum, radiusImpulse);
			}
		}
		else if (!isMulti)
		{
			SetRocketActive(rocketNum, radiusImpulse);
		}
	}

	private IEnumerator Start()
	{
		if (dontExecStart)
		{
			yield break;
		}
		SetRocketActiveSendRPC();
		if (!isMulti || isMine)
		{
			myPlayer = WeaponManager.sharedManager.myPlayer;
			if (currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Bomb)
			{
				base.GetComponent<Rigidbody>().useGravity = true;
			}
			if (rocketNum != 10)
			{
				StartRocketRPC();
			}
		}
		else
		{
			base.transform.GetComponent<Rigidbody>().isKinematic = true;
		}
		if (!isRun)
		{
			if (!isMulti || isMine)
			{
				Player_move_c.SetLayerRecursively(base.gameObject, 9);
			}
			if (Defs.isMulti)
			{
				if (Defs.isInet)
				{
					GameObject[] players = GameObject.FindGameObjectsWithTag("Player");
					for (int i = 0; i < players.Length; i++)
					{
						PhotonView pv = players[i].GetComponent<PhotonView>();
						if (pv != null && photonView.ownerId == pv.ownerId)
						{
							myPlayer = players[i];
							break;
						}
					}
				}
			}
			else
			{
				myPlayer = GameObject.FindGameObjectWithTag("Player");
			}
		}
		while (myPlayer == null || myPlayer.GetComponent<SkinName>().playerMoveC.transform.childCount == 0 || myPlayer.GetComponent<SkinName>().playerMoveC.transform.GetChild(0).GetComponent<WeaponSounds>().grenatePoint == null)
		{
			yield return null;
		}
		base.transform.parent = myPlayer.GetComponent<SkinName>().playerMoveC.transform.GetChild(0).GetComponent<WeaponSounds>().grenatePoint;
		yield return null;
		base.transform.localPosition = Vector3.zero;
		base.transform.localRotation = Quaternion.identity;
		yield return null;
		rockets[10].transform.localPosition = Vector3.zero;
	}

	public void SendNetworkViewMyPlayer(NetworkViewID myId)
	{
		base.GetComponent<NetworkView>().RPC("SendNetworkViewMyPlayerRPC", RPCMode.AllBuffered, myId);
	}

	[RPC]
	public void SendNetworkViewMyPlayerRPC(NetworkViewID myId)
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		for (int i = 0; i < array.Length; i++)
		{
			if (myId.Equals(array[i].GetComponent<NetworkView>().viewID))
			{
				myPlayer = array[i];
				break;
			}
		}
	}

	public void StartRocket()
	{
		if (isMulti && isMine)
		{
			if (!isInet)
			{
				base.GetComponent<NetworkView>().RPC("StartRocketRPC", RPCMode.AllBuffered);
			}
			else
			{
				photonView.RPC("StartRocketRPC", PhotonTargets.AllBuffered);
			}
		}
		else if (!isMulti)
		{
			StartRocketRPC();
		}
		base.transform.GetComponent<Rigidbody>().isKinematic = false;
	}

	[RPC]
	public void StartRocketRPC()
	{
		if (isMulti && isInet && photonView != null)
		{
			photonView.synchronization = ViewSynchronization.Unreliable;
		}
		if (isMulti && !isInet)
		{
			base.GetComponent<NetworkView>().stateSynchronization = NetworkStateSynchronization.Unreliable;
		}
		base.transform.parent = null;
		Player_move_c.SetLayerRecursively(base.gameObject, LayerMask.NameToLayer("Default"));
		isRun = true;
		if (!isMulti || isMine)
		{
			Invoke("KillRocket", (rocketNum == 10) ? 1.8f : ((rocketNum != 24) ? 7f : 2f));
		}
	}

	[Obfuscation(Exclude = true)]
	private void Remove()
	{
		if (!isMulti)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
		else if (!isInet)
		{
			Network.RemoveRPCs(base.GetComponent<NetworkView>().viewID);
			Network.Destroy(base.gameObject);
		}
		else
		{
			PhotonNetwork.Destroy(base.gameObject);
		}
	}

	[RPC]
	public void SetRocketActive(int rn, float _radiusImpulse)
	{
		radiusImpulse = _radiusImpulse;
		if (rockets.Length != 0)
		{
			if (rn >= rockets.Length)
			{
				rn = 0;
			}
			rockets[rn].SetActive(true);
			GetComponent<BoxCollider>().size = rockets[rn].GetComponent<RocketSettings>().sizeBoxCollider;
			GetComponent<BoxCollider>().center = rockets[rn].transform.localPosition + default(Vector3);
		}
	}

	private void OnCollisionEnter(Collision other)
	{
		if (isRun && rocketNum != 10 && (!isMulti || isMine) && !other.gameObject.CompareTag("CapturePoint") && (isMulti || (!other.gameObject.tag.Equals("Player") && (!(other.transform.parent != null) || !other.transform.parent.gameObject.tag.Equals("Player")))) && (!isMulti || ((!other.gameObject.tag.Equals("Player") || !(other.gameObject == _weaponManager.myPlayer)) && (!(other.transform.parent != null) || !other.transform.parent.gameObject.tag.Equals("Player") || !(other.transform.parent.gameObject == _weaponManager.myPlayer)))) && !other.gameObject.name.Equals("DamageCollider") && (currentRocketSettings.typeFly != RocketSettings.TypeFlyRocket.Bomb || ((!(other.gameObject.transform.parent == null) || other.gameObject.transform.gameObject.CompareTag("Turret")) && (!(other.gameObject.transform.parent != null) || other.gameObject.transform.parent.gameObject.CompareTag("Player") || other.gameObject.transform.parent.gameObject.CompareTag("Enemy")))))
		{
			if (currentRocketSettings.typeFly != RocketSettings.TypeFlyRocket.MegaBullet || (other.gameObject.transform.parent != null && other.gameObject.transform.parent.gameObject.CompareTag("Untagged")) || (other.gameObject.transform.parent == null && other.gameObject.CompareTag("Untagged")))
			{
				KillRocket(other.gameObject);
			}
			else
			{
				Hit(other.gameObject);
			}
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		if (isRun && rocketNum != 10 && (!isMulti || isMine) && !other.gameObject.name.Equals("DamageCollider") && !other.gameObject.CompareTag("CapturePoint") && (isMulti || (!other.gameObject.tag.Equals("Player") && (!(other.transform.parent != null) || !other.transform.parent.gameObject.tag.Equals("Player")))) && (!isMulti || ((!other.gameObject.tag.Equals("Player") || !(other.gameObject == _weaponManager.myPlayer)) && (!(other.transform.parent != null) || !other.transform.parent.gameObject.tag.Equals("Player") || !(other.transform.parent.gameObject == _weaponManager.myPlayer)))) && (currentRocketSettings.typeFly != RocketSettings.TypeFlyRocket.Bomb || ((!(other.gameObject.transform.parent == null) || other.gameObject.transform.gameObject.CompareTag("Turret")) && (!(other.gameObject.transform.parent != null) || other.gameObject.transform.parent.gameObject.CompareTag("Player") || other.gameObject.transform.parent.gameObject.CompareTag("Enemy")))))
		{
			if (currentRocketSettings.typeFly != RocketSettings.TypeFlyRocket.MegaBullet || (other.gameObject.transform.parent != null && other.gameObject.transform.parent.gameObject.CompareTag("Untagged")) || (other.gameObject.transform.parent == null && other.gameObject.CompareTag("Untagged")))
			{
				KillRocket(other.gameObject);
			}
			else if (currentRocketSettings.typeFly != RocketSettings.TypeFlyRocket.MegaBullet)
			{
				Hit(other.gameObject);
			}
		}
	}

	[Obfuscation(Exclude = true)]
	private void KillRocket()
	{
		KillRocket(null);
	}

	public void KillRocket(GameObject _hitObject)
	{
		if (isKilled)
		{
			return;
		}
		Hit(_hitObject);
		isKilled = true;
		if (isMulti)
		{
			if (!isInet)
			{
				base.GetComponent<NetworkView>().RPC("Collide", RPCMode.All, weaponName);
			}
			else if (photonView != null)
			{
				photonView.RPC("Collide", PhotonTargets.All, weaponName);
			}
			else
			{
				Debug.Log("Rocket.KillRocket():    photonView == null");
			}
		}
		else
		{
			Collide(weaponName);
		}
	}

	[RPC]
	private void Collide(string _weaponName)
	{
		BazookaExplosion(_weaponName);
		if (!isMulti)
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
		else if (isMine)
		{
			Invoke("DestroyRocket", 0.1f);
		}
	}

	public void Hit(GameObject hitObject)
	{
		Vector3 position = base.transform.position;
		if ((isMulti && !isMine) || (isMulti && _weaponManager.myPlayer == null))
		{
			return;
		}
		GameObject[] array = GameObject.FindGameObjectsWithTag("Enemy");
		for (int i = 0; i < array.Length; i++)
		{
			bool flag = false;
			if (currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Grenade || currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Bomb || currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Rocket || currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Autoaim)
			{
				if ((array[i].transform.position - position).sqrMagnitude < radiusDamage * radiusDamage)
				{
					flag = true;
				}
			}
			else if (hitObject != null && (bool)hitObject.transform.parent && hitObject.transform.parent.gameObject.Equals(array[i]))
			{
				flag = true;
			}
			if (!flag)
			{
				continue;
			}
			BaseBot botScriptForObject = BaseBot.GetBotScriptForObject(array[i].transform);
			if (!isMulti)
			{
				if (isSlowdown)
				{
					botScriptForObject.ApplyDebuffByMode(BotDebuffType.DecreaserSpeed, slowdownTime, slowdownCoeff);
				}
				botScriptForObject.GetDamage(0f - damage + UnityEngine.Random.Range(damageRange.x, damageRange.y), WeaponManager.sharedManager.myPlayer.transform);
			}
			else if (!botScriptForObject.IsDeath)
			{
				if (isSlowdown)
				{
					botScriptForObject.ApplyDebuffByMode(BotDebuffType.DecreaserSpeed, slowdownTime, slowdownCoeff);
				}
				float num = damage + UnityEngine.Random.Range(damageRange.x, damageRange.y);
				botScriptForObject.GetDamageForMultiplayer(0f - num, null);
				_weaponManager.myNetworkStartTable.score = GlobalGameController.Score;
				_weaponManager.myNetworkStartTable.SynhScore();
			}
		}
		GameObject[] array2 = GameObject.FindGameObjectsWithTag("Turret");
		for (int j = 0; j < array2.Length; j++)
		{
			TurretController component = array2[j].GetComponent<TurretController>();
			bool flag2 = false;
			if (currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Grenade || currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Bomb || currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Rocket || currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Rocket)
			{
				if (component.isEnemyTurret && (array2[j].transform.position - position).sqrMagnitude < radiusDamage * radiusDamage)
				{
					flag2 = true;
				}
			}
			else if (hitObject != null && component.isEnemyTurret && hitObject.Equals(array2[j]))
			{
				flag2 = true;
			}
			if (flag2)
			{
				bool isExplosion = ((rocketNum >= typeDead.Length) ? WeaponSounds.TypeDead.explosion : typeDead[rocketNum]) == WeaponSounds.TypeDead.explosion;
				float num2 = multiplayerDamage * (1f + EffectsController.GrenadeExplosionDamageIncreaseCoef);
				_weaponManager.myPlayerMoveC.myScoreController.AddScoreOnEvent(PlayerEventScoreController.ScoreEvent.damageTurret, num2);
				if (Defs.isInet)
				{
					component.MinusLive(num2, isExplosion, WeaponManager.sharedManager.myPlayer.GetComponent<PhotonView>().viewID);
				}
				else
				{
					component.MinusLive(num2, isExplosion, Convert.ToInt32(WeaponManager.sharedManager.myPlayer.GetComponent<NetworkView>().viewID));
				}
			}
		}
		if (!isMulti)
		{
			return;
		}
		GameObject[] array3 = GameObject.FindGameObjectsWithTag("Player");
		GameObject[] array4 = array3;
		foreach (GameObject gameObject in array4)
		{
			bool flag3 = false;
			flag3 = (isInet ? gameObject.GetComponent<PhotonView>().isMine : gameObject.GetComponent<NetworkView>().isMine);
			Player_move_c playerMoveC = gameObject.GetComponent<SkinName>().playerMoveC;
			if ((!isCOOP || !flag3) && (isCOOP || (!flag3 && (isCompany || Defs.isFlag || Defs.isCapturePoints) && ((!isCompany && !Defs.isFlag && !Defs.isCapturePoints) || playerMoveC.myCommand == _weaponManager.myTable.GetComponent<NetworkStartTable>().myCommand))))
			{
				continue;
			}
			bool flag4 = false;
			bool flag5 = false;
			if (currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Grenade || currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Bomb || currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Rocket || currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Autoaim)
			{
				if ((gameObject.transform.position - position).sqrMagnitude < ((!flag3) ? (radiusDamage * radiusDamage) : (radiusDamageSelf * radiusDamageSelf)))
				{
					flag4 = true;
				}
			}
			else if (hitObject != null && hitObject.transform.parent != null && hitObject.transform.parent.gameObject.Equals(gameObject))
			{
				flag4 = true;
				flag5 = hitObject.CompareTag("HeadCollider");
			}
			if (!flag4)
			{
				continue;
			}
			if (!flag3)
			{
				GameObject label = playerMoveC._label;
				if (label != null)
				{
					label.GetComponent<NickLabelController>().ResetTimeShow();
				}
			}
			float num3 = 1f;
			if (flag5)
			{
				num3 = 2f + EffectsController.AddingForHeadshot(_weaponManager.currentWeaponSounds.categoryNabor - 1);
			}
			if (flag3)
			{
				float num4 = multiplayerDamage * EffectsController.SelfExplosionDamageDecreaseCoef * num3;
				float num5 = num4 - playerMoveC.curArmor;
				if (num5 < 0f)
				{
					playerMoveC.curArmor -= num4;
					num5 = 0f;
				}
				else
				{
					playerMoveC.curArmor = 0f;
				}
				if (playerMoveC.CurHealth > 0f)
				{
					playerMoveC.CurHealth -= num5;
					if (playerMoveC.CurHealth <= 0f)
					{
						playerMoveC.sendImDeath(gameObject.GetComponent<SkinName>().NickName);
					}
					else
					{
						playerMoveC.IndicateDamage();
					}
				}
				continue;
			}
			int typeWeapon = (int)((rocketNum >= typeDead.Length) ? WeaponSounds.TypeDead.explosion : typeDead[rocketNum]);
			Player_move_c.TypeKills typeKills = ((!flag5) ? currentRocketSettings.typeKilsIconChat : Player_move_c.TypeKills.headshot);
			float num6 = multiplayerDamage * (1f + EffectsController.GrenadeExplosionDamageIncreaseCoef) * num3;
			_weaponManager.myPlayerMoveC.myScoreController.AddScoreOnEvent(flag5 ? ((!playerMoveC.isMechActive) ? PlayerEventScoreController.ScoreEvent.damageHead : PlayerEventScoreController.ScoreEvent.damageMechHead) : ((currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Grenade) ? PlayerEventScoreController.ScoreEvent.damageGrenade : ((currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Rocket || currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Autoaim) ? PlayerEventScoreController.ScoreEvent.damageExplosion : (playerMoveC.isMechActive ? PlayerEventScoreController.ScoreEvent.damageMechBody : PlayerEventScoreController.ScoreEvent.damageBody))), num6);
			if (isSlowdown)
			{
				if (isInet)
				{
					playerMoveC.photonView.RPC("SlowdownRPC", PhotonTargets.All, slowdownCoeff, slowdownTime);
				}
				else
				{
					playerMoveC.GetComponent<NetworkView>().RPC("SlowdownRPC", RPCMode.All, slowdownCoeff, slowdownTime);
				}
			}
			if (!isInet)
			{
				playerMoveC.MinusLive(_weaponManager.myPlayer.GetComponent<NetworkView>().viewID, num6, typeKills, typeWeapon, (rocketNum != 10) ? weaponName : string.Empty);
			}
			else
			{
				playerMoveC.MinusLive(_weaponManager.myPlayer.GetComponent<PhotonView>().viewID, num6, typeKills, typeWeapon, (rocketNum != 10) ? weaponName : string.Empty);
			}
		}
	}

	[Obfuscation(Exclude = true)]
	private void DestroyRocket()
	{
		if (!isInet)
		{
			Network.RemoveRPCs(base.GetComponent<NetworkView>().viewID);
			Network.Destroy(base.gameObject);
		}
		else
		{
			PhotonNetwork.Destroy(base.gameObject);
		}
	}

	public void BazookaExplosion(string explosionName)
	{
		Vector3 position = base.transform.position;
		string path = ResPath.Combine("Explosions", explosionName);
		GameObject gameObject = Resources.Load(path) as GameObject;
		if (gameObject == null)
		{
			gameObject = Resources.Load(ResPath.Combine("Explosions", "Weapon75")) as GameObject;
		}
		if (gameObject != null)
		{
			GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject, position, Quaternion.identity) as GameObject;
			gameObject2.GetComponent<AudioSource>().enabled = Defs.isSoundFX;
		}
		GameObject gameObject3 = WeaponManager.sharedManager.myPlayer;
		if (gameObject3 != null)
		{
			ImpactReceiver impactReceiver = gameObject3.GetComponent<ImpactReceiver>();
			if (impactReceiver == null)
			{
				impactReceiver = gameObject3.AddComponent<ImpactReceiver>();
			}
			float num = 100f;
			if (radiusImpulse != 0f)
			{
				num = (gameObject3.transform.position - position).magnitude / radiusImpulse;
			}
			float num2 = Mathf.Max(0f, 1f - num);
			float force = 133.4f * num2;
			impactReceiver.AddImpact(gameObject3.transform.position - position, force);
			if ((!isMulti || isMine) && num2 > 0.01f)
			{
				WeaponManager.sharedManager.myPlayerMoveC.isRocketJump = true;
			}
		}
	}

	private void Update()
	{
		if ((!isMulti || isMine) && isRun && currentRocketSettings.typeFly == RocketSettings.TypeFlyRocket.Autoaim && WeaponManager.sharedManager.myPlayerMoveC != null && !WeaponManager.sharedManager.myPlayerMoveC.isKilled)
		{
			Ray ray = WeaponManager.sharedManager.myPlayerMoveC.myCamera.ScreenPointToRay(new Vector3((float)Screen.width * 0.5f, (float)Screen.height * 0.5f, 0f));
			RaycastHit hitInfo;
			if (Physics.Raycast(ray, out hitInfo, 300f, Tools.AllWithoutDamageCollidersMask) && !hitInfo.collider.gameObject.name.Equals("Rocket(Clone)"))
			{
				Vector3 point = hitInfo.point;
				Vector3 normalized = (point - myTransform.position).normalized;
				base.GetComponent<Rigidbody>().AddForce(normalized * 800f * Time.deltaTime);
				base.GetComponent<Rigidbody>().velocity = base.GetComponent<Rigidbody>().velocity.normalized * 15f;
			}
			else
			{
				Vector3 point2 = ray.GetPoint(Vector3.Magnitude(WeaponManager.sharedManager.myPlayerMoveC.myCamera.transform.position - myTransform.position));
				Vector3 normalized2 = (point2 - myTransform.position).normalized;
				base.GetComponent<Rigidbody>().AddForce(normalized2 * 200f * Time.deltaTime);
				base.GetComponent<Rigidbody>().velocity = base.GetComponent<Rigidbody>().velocity.normalized * 25f;
			}
			myTransform.rotation = Quaternion.LookRotation(base.GetComponent<Rigidbody>().velocity);
		}
		if (Defs.isMulti && isStartSynh && ((Defs.isInet && photonView != null && !photonView.isMine) || (!Defs.isInet && !base.GetComponent<NetworkView>().isMine)))
		{
			if (!Defs.isInet && Vector3.SqrMagnitude(base.transform.position - correctPos) > 300f)
			{
				base.transform.position = correctPos;
			}
			else
			{
				base.transform.position = Vector3.Lerp(base.transform.position, correctPos, Time.deltaTime * 5f);
			}
		}
	}

	private void OnPhotonSerializeView(PhotonStream stream, PhotonMessageInfo info)
	{
		isStartSynh = true;
		if (stream.isWriting)
		{
			stream.SendNext(myTransform.position);
			stream.SendNext(myTransform.rotation);
		}
		else
		{
			correctPos = (Vector3)stream.ReceiveNext();
			myTransform.rotation = (Quaternion)stream.ReceiveNext();
		}
	}

	private void OnSerializeNetworkView(BitStream stream, NetworkMessageInfo info)
	{
		isStartSynh = true;
		if (stream.isWriting)
		{
			Vector3 value = myTransform.position;
			Quaternion value2 = myTransform.rotation;
			stream.Serialize(ref value);
			stream.Serialize(ref value2);
			return;
		}
		Vector3 value3 = Vector3.zero;
		Quaternion value4 = Quaternion.identity;
		stream.Serialize(ref value3);
		stream.Serialize(ref value4);
		correctPos = value3;
		myTransform.rotation = value4;
		if (isFirstPos)
		{
			isFirstPos = false;
			myTransform.position = value3;
			myTransform.rotation = value4;
		}
	}
}
