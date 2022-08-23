using System;
using System.Collections;
using System.Reflection;
using System.Runtime.InteropServices;
using Rilisoft;
using RilisoftBot;
using UnityEngine;
using ZeichenKraftwerk;

public sealed class TurretController : MonoBehaviour
{
	public AudioClip turretActivSound;

	public AudioClip turretDeadSound;

	public SkinnedMeshRenderer turretRenderer;

	public SkinnedMeshRenderer turretExplosionRenderer;

	[NonSerialized]
	public int numUpdate;

	public Rotator rotator;

	private float maxSpeedRotator = -1000f;

	private float downSpeedRotator = 500f;

	public Material[] turretRunMaterials;

	public GameObject hitObj;

	public GameObject killedParticle;

	public GameObject explosionAnimObj;

	public GameObject turretObj;

	public float damage = 1f;

	public float[] damageMultyByTier = new float[5] { 0.1f, 0.3f, 0.5f, 0.7f, 1f };

	public float[] healthMultyByTier = new float[5] { 20f, 40f, 60f, 80f, 100f };

	public Transform tower;

	public Transform gun;

	public AudioClip shotClip;

	public ParticleSystem gunFlash1;

	public ParticleSystem gunFlash2;

	public float health = 10000000f;

	public float maxHealth = 10000000f;

	public bool isRunAvailable;

	public bool isRun;

	public GameObject myPlayer;

	private bool isStartSynh;

	public Transform myTransform;

	public PhotonView photonView;

	private bool isMine;

	public Transform spherePoint;

	public Transform rayGroundPoint;

	public BoxCollider myCollider;

	public Transform target;

	public GameObject isEnemySprite;

	public Transform shotPoint;

	public Transform shotPoint2;

	public bool isKilled;

	public bool isEnemyTurret;

	public int myCommand;

	public NickLabelController myLabel;

	private float speedRotateY = 220f;

	private float speedRotateX = 30f;

	private float speedFire = 3f;

	private float radiusZoneMeele = 10f;

	private float radiusZoneMeeleSyrvival = 4f;

	private float maxRadiusScanTarget = 30f;

	private float maxRadiusScanTargetSQR;

	private float idleAlphaY;

	private float idleAlphaX;

	private float idleRotateSpeedX = 20f;

	private float idleRotateSpeedY = 20f;

	private float maxDeltaRotateY = 60f;

	private float maxRotateX = 75f;

	private float minRotateX = -60f;

	private float timerScanTarget = -1f;

	private float maxTimerScanTarget = 1f;

	private float timerScanTargetIdle = -1f;

	private float maxTimerScanTargetIdle = 0.5f;

	private float timerShot;

	private float maxTimerShot = 0.1f;

	private float dissipation = 0.015f;

	public bool dontExecStart;

	public Transform targerI;

	public Transform hitGameobj;

	private void Awake()
	{
		photonView = PhotonView.Get(this);
		maxRadiusScanTargetSQR = maxRadiusScanTarget * maxRadiusScanTarget;
	}

	private IEnumerator Start()
	{
		if (dontExecStart)
		{
			yield break;
		}
		turretRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 1f));
		if (Defs.isMulti)
		{
			if (!Defs.isInet)
			{
				isMine = base.GetComponent<PhotonView>().isMine;
			}
			else
			{
				isMine = photonView.isMine;
			}
		}
		if (!Defs.isMulti || Defs.isCOOP)
		{
			health = 18f;
			radiusZoneMeele = radiusZoneMeeleSyrvival;
		}
		if (!Defs.isMulti || isMine)
		{
			numUpdate = GearManager.CurrentNumberOfUphradesForGear(GearManager.Turret);
			Player_move_c.SetLayerRecursively(base.gameObject, 9);
			if (Defs.isMulti)
			{
				if (!Defs.isInet)
				{
					base.GetComponent<PhotonView>().RPC("SynchNumUpdateRPC", PhotonTargets.AllBuffered, numUpdate);
				}
				else
				{
					photonView.RPC("SynchNumUpdateRPC", PhotonTargets.AllBuffered, numUpdate);
				}
			}
		}
		if (Defs.isMulti)
		{
			if (Defs.isInet)
			{
				GameObject[] players = GameObject.FindGameObjectsWithTag("Player");
				for (int i = 0; i < players.Length; i++)
				{
					if (photonView.ownerId == players[i].GetComponent<PhotonView>().ownerId)
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
		if (NickLabelStack.sharedStack != null)
		{
			myLabel = NickLabelStack.sharedStack.GetNextCurrentLabel();
			myLabel.target = base.transform;
			myLabel.isTurrerLabel = true;
			myLabel.StartShow();
		}
		if (!isRun)
		{
			while (myPlayer == null || myPlayer.GetComponent<SkinName>().playerMoveC.turretPoint == null)
			{
				yield return null;
			}
			base.transform.parent = myPlayer.GetComponent<SkinName>().playerMoveC.turretPoint.transform;
			yield return null;
			base.transform.localPosition = Vector3.zero;
			base.transform.localRotation = Quaternion.identity;
		}
	}

	private Transform ScanTarget()
	{
		GameObject[] array = null;
		GameObject[] array2;
		if ((Defs.isMulti && Defs.isCOOP) || !Defs.isMulti)
		{
			array2 = GameObject.FindGameObjectsWithTag("Enemy");
		}
		else
		{
			array2 = GameObject.FindGameObjectsWithTag("HeadCollider");
			array = GameObject.FindGameObjectsWithTag("Turret");
		}
		float num = 1000f;
		float num2 = 1000f;
		Transform transform = null;
		Transform transform2 = null;
		float num3 = 1E+09f;
		Transform result = null;
		int num4 = 0 + ((array2 != null) ? array2.Length : 0) + ((array != null) ? array.Length : 0);
		GameObject[] array3 = new GameObject[num4];
		if (array2 != null)
		{
			array2.CopyTo(array3, 0);
		}
		if (array != null)
		{
			array.CopyTo(array3, (array2 != null) ? array2.Length : 0);
		}
		for (int i = 0; i < array3.Length; i++)
		{
			if (Defs.isMulti && (!Defs.isMulti || !Defs.isCOOP) && (!(array3[i].transform.parent != null) || !array3[i].transform.parent.gameObject.CompareTag("Player") || array3[i].transform.parent.gameObject.Equals(WeaponManager.sharedManager.myPlayer) || ((ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints) && array3[i].transform.parent.GetComponent<SkinName>().playerMoveC.myCommand == WeaponManager.sharedManager.myPlayerMoveC.myCommand) || array3[i].transform.parent.GetComponent<SkinName>().playerMoveC.isKilled || !(array3[i].transform.position.y > -500f) || array3[i].transform.parent.GetComponent<SkinName>().playerMoveC.isInvisible) && (!array3[i].CompareTag("Turret") || !array3[i].GetComponent<TurretController>().isEnemyTurret))
			{
				continue;
			}
			Transform transform3 = array3[i].transform;
			float num5 = Vector3.SqrMagnitude(transform3.position - myTransform.position);
			if (num5 < maxRadiusScanTargetSQR && Mathf.Acos(Mathf.Sqrt((transform3.position.x - myTransform.position.x) * (transform3.position.x - myTransform.position.x) + (transform3.position.z - myTransform.position.z) * (transform3.position.z - myTransform.position.z)) / Vector3.Distance(transform3.position, myTransform.position)) * 180f / (float)Math.PI < maxRotateX)
			{
				Ray ray = new Ray(tower.position, transform3.position - tower.position);
				RaycastHit hitInfo;
				bool flag = Physics.Raycast(ray, out hitInfo, maxRadiusScanTarget, Tools.AllWithoutDamageCollidersMask);
				hitGameobj = hitInfo.transform;
				targerI = transform3;
				if (flag && (hitInfo.collider.gameObject.transform.Equals(transform3) || (hitInfo.collider.gameObject.transform.parent != null && (hitInfo.collider.gameObject.transform.parent.Equals(transform3) || hitInfo.collider.gameObject.transform.parent.Equals(transform3.parent)))))
				{
					num3 = num5;
					result = transform3;
				}
			}
		}
		return result;
	}

	private void Update()
	{
		if (dontExecStart)
		{
			return;
		}
		SetStateIsEnemyTurret();
		if (!isEnemyTurret && myLabel != null)
		{
			myLabel.ResetTimeShow();
		}
		if (rotator.eulersPerSecond.z < -200f)
		{
			rotator.eulersPerSecond = new Vector3(0f, 0f, rotator.eulersPerSecond.z + downSpeedRotator * Time.deltaTime);
		}
		if (Defs.isMulti && !isMine)
		{
			return;
		}
		if (Defs.isMulti && isMine && WeaponManager.sharedManager.myPlayer == null)
		{
			if (!Defs.isInet)
			{
				PhotonNetwork.Destroy(base.gameObject);
			}
			else
			{
				PhotonNetwork.Destroy(base.gameObject);
			}
			return;
		}
		if (!isRun)
		{
			bool flag = false;
			Ray ray = new Ray(rayGroundPoint.position, Vector3.down);
			RaycastHit hitInfo;
			if (Physics.Raycast(ray, out hitInfo, 1f, Tools.AllWithoutDamageCollidersMask) && hitInfo.distance > 0.05f && hitInfo.distance < 0.7f && !Physics.CheckSphere(spherePoint.position, 0.71f))
			{
				isRunAvailable = true;
				turretRenderer.materials[0].SetColor("_TintColor", new Color(1f, 1f, 1f, 0.08f));
				if (InGameGUI.sharedInGameGUI != null)
				{
					InGameGUI.sharedInGameGUI.runTurrelButton.GetComponent<UIButton>().isEnabled = true;
				}
			}
			else
			{
				isRunAvailable = false;
				turretRenderer.materials[0].SetColor("_TintColor", new Color(1f, 0f, 0f, 0.08f));
				if (InGameGUI.sharedInGameGUI != null)
				{
					InGameGUI.sharedInGameGUI.runTurrelButton.GetComponent<UIButton>().isEnabled = false;
				}
			}
			return;
		}
		if (isKilled)
		{
			if (gun.rotation.x > minRotateX)
			{
				gun.Rotate(speedRotateX * Time.deltaTime, 0f, 0f);
			}
			return;
		}
		if (target != null && (target.position.y < -500f || (target.CompareTag("Player") && target.GetComponent<SkinName>().playerMoveC.isInvisible)))
		{
			target = null;
		}
		if (target == null)
		{
			timerScanTargetIdle -= Time.deltaTime;
			if (timerScanTargetIdle < 0f)
			{
				timerScanTargetIdle = maxTimerScanTargetIdle;
				target = ScanTarget();
			}
			if (Mathf.Abs(idleAlphaY) < 0.5f)
			{
				idleAlphaY = UnityEngine.Random.Range(-1f * maxDeltaRotateY / 2f, maxDeltaRotateY / 2f);
			}
			else
			{
				float num = Time.deltaTime * idleRotateSpeedY * Mathf.Abs(idleAlphaY) / idleAlphaY;
				idleAlphaY -= num;
				tower.localRotation = Quaternion.Euler(new Vector3(0f, tower.localRotation.eulerAngles.y + num, 0f));
			}
			if (Mathf.Abs(gun.localRotation.eulerAngles.x) > 1f)
			{
				gun.Rotate((float)((!(gun.localRotation.eulerAngles.x < 180f)) ? 1 : (-1)) * speedRotateX * Time.deltaTime, 0f, 0f);
			}
			return;
		}
		bool flag2 = false;
		Vector2 to = new Vector2(target.position.x, target.position.z) - new Vector2(tower.position.x, tower.position.z);
		float deltaAngles = GetDeltaAngles(tower.rotation.eulerAngles.y, Mathf.Abs(to.x) / to.x * Vector2.Angle(Vector2.up, to));
		float num2 = (0f - speedRotateY) * Time.deltaTime * Mathf.Abs(deltaAngles) / deltaAngles;
		if (Mathf.Abs(deltaAngles) < 10f)
		{
			flag2 = true;
		}
		if (Mathf.Abs(num2) > Mathf.Abs(deltaAngles))
		{
			num2 = 0f - deltaAngles;
		}
		if (Mathf.Abs(num2) > 0.001f)
		{
			tower.Rotate(0f, num2, 0f);
		}
		Vector2 vector = new Vector2(target.position.x, target.position.y) - new Vector2(tower.position.x, tower.position.y);
		float angle = -180f * Mathf.Atan((target.position.y - tower.position.y) / Vector3.Distance(target.position, myTransform.position)) / (float)Math.PI;
		float deltaAngles2 = GetDeltaAngles(gun.rotation.eulerAngles.x, angle);
		num2 = (0f - speedRotateX) * Time.deltaTime * Mathf.Abs(deltaAngles2) / deltaAngles2;
		if (Mathf.Abs(num2) > Mathf.Abs(deltaAngles2))
		{
			num2 = 0f - deltaAngles2;
		}
		if (num2 > 0f && gun.rotation.x > maxRotateX)
		{
			num2 = 0f;
		}
		if (num2 < 0f && gun.rotation.x < minRotateX)
		{
			num2 = 0f;
		}
		if (Mathf.Abs(num2) > 0.001f)
		{
			gun.Rotate(num2, 0f, 0f);
		}
		if (flag2)
		{
			timerShot -= Time.deltaTime;
			if (timerShot < 0f)
			{
				if (!Defs.isMulti)
				{
					ShotRPC();
				}
				else if (!Defs.isInet)
				{
					base.GetComponent<PhotonView>().RPC("ShotRPC", PhotonTargets.All);
				}
				else
				{
					photonView.RPC("ShotRPC", PhotonTargets.All);
				}
				timerShot = maxTimerShot;
			}
		}
		timerScanTarget -= Time.deltaTime;
		if (timerScanTarget < 0f)
		{
			timerScanTarget = maxTimerScanTarget;
			target = ScanTarget();
		}
	}

	[PunRPC]
	public void SynchNumUpdateRPC(int _numUpdate)
	{
		numUpdate = _numUpdate;
		if (Defs.isMulti && !Defs.isCOOP)
		{
			health = healthMultyByTier[_numUpdate];
			maxHealth = health;
		}
	}

	private void SetStateIsEnemyTurret()
	{
		bool flag = isEnemyTurret;
		isEnemyTurret = false;
		if (Defs.isMulti && (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints))
		{
			if (myPlayer != null && WeaponManager.sharedManager.myPlayerMoveC != null && myPlayer.GetComponent<SkinName>().playerMoveC.myCommand != WeaponManager.sharedManager.myPlayerMoveC.myCommand)
			{
				isEnemyTurret = true;
			}
		}
		else if (Defs.isMulti && !isMine)
		{
			isEnemyTurret = true;
		}
		if (isEnemyTurret != flag)
		{
			myLabel.isEnemySprite.SetActive(isEnemyTurret);
		}
	}

	[PunRPC]
	public void ShotRPC()
	{
		rotator.eulersPerSecond = new Vector3(0f, 0f, maxSpeedRotator);
		if (Defs.isSoundFX)
		{
			base.GetComponent<AudioSource>().PlayOneShot(shotClip);
		}
		gunFlash1.enableEmission = true;
		CancelInvoke("StopGunFlash");
		Invoke("StopGunFlash", maxTimerShot * 1.1f);
		if (Defs.isMulti && !isMine)
		{
			return;
		}
		Vector3 direction = new Vector3(shotPoint2.position.x - shotPoint.position.x + UnityEngine.Random.Range(0f - dissipation, dissipation), shotPoint2.position.y - shotPoint.position.y + UnityEngine.Random.Range(0f - dissipation, dissipation), shotPoint2.position.z - shotPoint.position.z + UnityEngine.Random.Range(0f - dissipation, dissipation));
		Ray ray = new Ray(shotPoint.position, direction);
		RaycastHit hitInfo;
		if (!Physics.Raycast(ray, out hitInfo, 100f, Tools.AllWithoutDamageCollidersMask) || (Defs.isMulti && !(WeaponManager.sharedManager.myPlayer != null)))
		{
			return;
		}
		bool flag = false;
		if ((Defs.isMulti && Defs.isCOOP) || !Defs.isMulti)
		{
			hitObj = hitInfo.collider.gameObject;
			if (hitInfo.collider.gameObject.transform.parent != null && hitInfo.collider.gameObject.transform.parent.CompareTag("Enemy"))
			{
				HitZombie(hitInfo.collider.gameObject);
				flag = true;
			}
		}
		else
		{
			if (hitInfo.collider.gameObject.transform.parent != null && hitInfo.collider.gameObject.transform.parent.CompareTag("Player") && hitInfo.collider.gameObject.transform.parent.gameObject != WeaponManager.sharedManager.myPlayer)
			{
				Player_move_c playerMoveC = hitInfo.collider.gameObject.transform.parent.GetComponent<SkinName>().playerMoveC;
				float minus = damageMultyByTier[numUpdate];
				if (Defs.isInet)
				{
					playerMoveC.MinusLive(WeaponManager.sharedManager.myPlayer.GetComponent<PhotonView>().viewID, minus, Player_move_c.TypeKills.turret, 0, string.Empty, photonView.viewID);
				}
				else
				{
					playerMoveC.MinusLive(Convert.ToInt32(WeaponManager.sharedManager.myPlayer.GetComponent<PhotonView>().viewID), minus, Player_move_c.TypeKills.turret, 0, string.Empty, Convert.ToInt32(base.GetComponent<PhotonView>().viewID));
				}
				flag = true;
			}
			if (hitInfo.collider.gameObject != null && hitInfo.collider.gameObject.CompareTag("Turret"))
			{
				TurretController component = hitInfo.collider.gameObject.GetComponent<TurretController>();
				float dm = damageMultyByTier[numUpdate];
				if (Defs.isInet)
				{
					component.MinusLive(dm, WeaponManager.sharedManager.myPlayer.GetComponent<PhotonView>().viewID);
				}
				else
				{
					component.MinusLive(dm, Convert.ToInt32(WeaponManager.sharedManager.myPlayer.GetComponent<PhotonView>().viewID));
				}
				flag = true;
			}
		}
		if (Defs.isMulti)
		{
			if (!Defs.isInet)
			{
				WeaponManager.sharedManager.myPlayerMoveC.GetComponent<PhotonView>().RPC("HoleRPC", PhotonTargets.All, flag, hitInfo.point + hitInfo.normal * 0.001f, Quaternion.FromToRotation(Vector3.up, hitInfo.normal));
			}
			else
			{
				WeaponManager.sharedManager.myPlayerMoveC.photonView.RPC("HoleRPC", PhotonTargets.All, flag, hitInfo.point + hitInfo.normal * 0.001f, Quaternion.FromToRotation(Vector3.up, hitInfo.normal));
			}
		}
	}

	private void HitZombie(GameObject zmb)
	{
		BaseBot botScriptForObject = BaseBot.GetBotScriptForObject(zmb.transform.parent);
		if (!Defs.isMulti)
		{
			botScriptForObject.GetDamage(0f - damage, myTransform);
		}
		else if (Defs.isCOOP && !botScriptForObject.IsDeath)
		{
			botScriptForObject.GetDamageForMultiplayer(0f - damage, null);
			WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().score = GlobalGameController.Score;
			WeaponManager.sharedManager.myNetworkStartTable.SynhScore();
		}
	}

	[Obfuscation(Exclude = true)]
	private void StopGunFlash()
	{
		gunFlash1.enableEmission = false;
	}

	private float GetDeltaAngles(float angle1, float angle2)
	{
		if (angle1 < 0f)
		{
			angle1 += 360f;
		}
		if (angle2 < 0f)
		{
			angle2 += 360f;
		}
		float num = angle1 - angle2;
		if (Mathf.Abs(num) > 180f)
		{
			num = ((!(angle1 > angle2)) ? (num + 360f) : (num - 360f));
		}
		return num;
	}

	public void StartTurret()
	{
		if (Defs.isMulti && isMine)
		{
			if (!Defs.isInet)
			{
				base.GetComponent<PhotonView>().RPC("StartTurretRPC", PhotonTargets.AllBuffered);
			}
			else
			{
				photonView.RPC("StartTurretRPC", PhotonTargets.AllBuffered);
			}
		}
		else if (!Defs.isMulti)
		{
			StartTurretRPC();
		}
		myCollider.enabled = true;
		base.transform.GetComponent<Rigidbody>().isKinematic = false;
		base.transform.GetComponent<Rigidbody>().useGravity = true;
		Invoke("SetNoUseGravityInvoke", 5f);
	}

	[Obfuscation(Exclude = true)]
	private void SetNoUseGravityInvoke()
	{
		base.transform.GetComponent<Rigidbody>().useGravity = false;
		base.transform.GetComponent<Rigidbody>().isKinematic = true;
		base.transform.GetComponent<BoxCollider>().isTrigger = true;
	}

	private void OnPlayerConnected(PhotonPlayer player)
	{
		if (isMine)
		{
			base.GetComponent<PhotonView>().RPC("SynchHealth", PhotonTargets.Others, health);
		}
	}

	public void OnPhotonPlayerConnected(PhotonPlayer player)
	{
		if (isMine)
		{
			photonView.RPC("SynchHealth", PhotonTargets.Others, health);
		}
	}

	[PunRPC]
	public void SynchHealth(float _health)
	{
		if (health > _health)
		{
			health = _health;
		}
	}

	private IEnumerator FlashRed()
	{
		turretRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 1f));
		yield return null;
		turretRenderer.material.SetColor("_ColorRili", new Color(1f, 0f, 0f, 1f));
		yield return new WaitForSeconds(0.1f);
		turretRenderer.material.SetColor("_ColorRili", new Color(1f, 1f, 1f, 1f));
	}

	public void MinusLive(float dm, int idKillerPhoton = 0)
	{
		MinusLive(dm, false, idKillerPhoton);
	}

	public void MinusLive(float dm, bool isExplosion, int idKillerPhoton = 0)
	{
		if (!isRun)
		{
			return;
		}
		if (Defs.isMulti)
		{
			health -= dm;
			if (health < 0f)
			{
				ImKilledRPCWithExplosion(isExplosion);
				dm = 10000f;
			}
			if (!Defs.isInet)
			{
				base.GetComponent<PhotonView>().RPC("MinusLiveRPCLocal", PhotonTargets.All, dm, isExplosion);
			}
			else
			{
				photonView.RPC("MinusLiveRPC", PhotonTargets.All, dm, isExplosion, idKillerPhoton);
			}
		}
		else
		{
			MinusLiveReal(dm, isExplosion);
		}
	}

	[PunRPC]
	public void MinusLiveRPC(float dm, int idKillerPhoton)
	{
		MinusLiveReal(dm, false, idKillerPhoton);
	}

	[PunRPC]
	public void MinusLiveRPC(float dm, bool isExplosion, int idKillerPhoton)
	{
		MinusLiveReal(dm, isExplosion, idKillerPhoton);
	}

	[PunRPC]
	public void MinusLiveRPCLocal(float dm, bool isExplosion, PhotonView idKillerLocal)
	{
		MinusLiveReal(dm, isExplosion, 0);
	}

	public void MinusLiveReal(float dm, bool isExplosion, int idKillerPhoton = 0)
	{
		StopCoroutine(FlashRed());
		StartCoroutine(FlashRed());
		if (isKilled || (Defs.isMulti && !isMine))
		{
			return;
		}
		health -= dm;
		if (Defs.isMulti)
		{
			if (!Defs.isInet)
			{
				base.GetComponent<PhotonView>().RPC("SynchHealth", PhotonTargets.Others, health);
			}
			else
			{
				photonView.RPC("SynchHealth", PhotonTargets.Others, health);
			}
		}
		if (!(health < 0f))
		{
			return;
		}
		health = 0f;
		if (Defs.isMulti)
		{
			if (!Defs.isInet)
			{
				base.GetComponent<PhotonView>().RPC("ImKilledRPCWithExplosion", PhotonTargets.AllBuffered, isExplosion);
				base.GetComponent<PhotonView>().RPC("MeKillRPCLocal", PhotonTargets.All);
			}
			else
			{
				photonView.RPC("ImKilledRPCWithExplosion", PhotonTargets.AllBuffered, isExplosion);
				photonView.RPC("MeKillRPC", PhotonTargets.All, idKillerPhoton);
			}
		}
		else
		{
			ImKilledRPCWithExplosion(isExplosion);
		}
	}

	[PunRPC]
	public void MeKillRPC(int idKillerPhoton)
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		string nick = string.Empty;
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (gameObject.GetComponent<PhotonView>() != null && gameObject.GetComponent<PhotonView>().viewID == idKillerPhoton)
			{
				nick = gameObject.GetComponent<SkinName>().NickName;
				if (gameObject.Equals(WeaponManager.sharedManager.myPlayer))
				{
					WeaponManager.sharedManager.myPlayerMoveC.ImKill(idKillerPhoton, 9);
				}
				break;
			}
		}
		MeKill(nick);
	}

	[PunRPC]
	public void MeKillRPCLocal(PhotonView idKillerLocal)
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		string nick = string.Empty;
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (gameObject.GetComponent<PhotonView>() != null && gameObject.GetComponent<PhotonView>().viewID.Equals(idKillerLocal))
			{
				nick = gameObject.GetComponent<SkinName>().NickName;
				if (gameObject.Equals(WeaponManager.sharedManager.myPlayer))
				{
					WeaponManager.sharedManager.myPlayerMoveC.ImKill(idKillerLocal, 9);
				}
				break;
			}
		}
		MeKill(nick);
	}

	public void MeKill(string _nick)
	{
		if (WeaponManager.sharedManager.myPlayerMoveC != null && myPlayer != null)
		{
			WeaponManager.sharedManager.myPlayerMoveC.AddSystemMessage(_nick, 9, myPlayer.GetComponent<SkinName>().NickName);
		}
	}

	[PunRPC]
	public void ImKilledRPC()
	{
		ImKilledRPCWithExplosion(false);
	}

	[PunRPC]
	public void ImKilledRPCWithExplosion(bool isExplosion)
	{
		isKilled = true;
		isExplosion = true;
		if (Defs.isSoundFX)
		{
			base.GetComponent<AudioSource>().PlayOneShot(turretDeadSound);
		}
		if (isExplosion)
		{
			explosionAnimObj.SetActive(true);
			turretObj.SetActive(false);
		}
		else
		{
			killedParticle.SetActive(true);
		}
		Invoke("DestroyTurrel", 2f);
	}

	[Obfuscation(Exclude = true)]
	private void DestroyTurrel()
	{
		if (Defs.isMulti)
		{
			if (isMine)
			{
				if (!Defs.isInet)
				{
					PhotonNetwork.RemoveRPCs(base.GetComponent<PhotonView>());
					PhotonNetwork.Destroy(base.gameObject);
				}
				else
				{
					PhotonNetwork.Destroy(base.gameObject);
				}
			}
			else
			{
				base.transform.position = new Vector3(-1000f, -1000f, -1000f);
			}
		}
		else
		{
			UnityEngine.Object.Destroy(base.gameObject);
		}
	}

	[PunRPC]
	public void StartTurretRPC()
	{
		myCollider.enabled = true;
		base.transform.parent = null;
		if (Defs.isSoundFX)
		{
			base.GetComponent<AudioSource>().PlayOneShot(turretActivSound);
		}
		Player_move_c.SetLayerRecursively(base.gameObject, LayerMask.NameToLayer("Default"));
		if (Defs.isInet)
		{
			photonView.synchronization = ViewSynchronization.UnreliableOnChange;
		}
		else
		{
			base.GetComponent<PhotonView>().synchronization = ViewSynchronization.UnreliableOnChange;
		}
		isRun = true;
		turretRenderer.material = turretRunMaterials[numUpdate];
		turretExplosionRenderer.material = turretRunMaterials[numUpdate];
	}

	private void OnDestroy()
	{
		if (!Defs.isMulti || isMine)
		{
			PotionsController.sharedController.DeActivePotion(GearManager.Turret, null, false);
		}
	}

	public Vector3 GetHeadPoint()
	{
		Vector3 position = base.transform.position;
		position.y += myCollider.size.y - 0.5f;
		return position;
	}

	public void SendNetworkViewMyPlayer(PhotonView myId)
	{
		base.GetComponent<PhotonView>().RPC("SendNetworkViewMyPlayerRPC", PhotonTargets.AllBuffered, myId);
	}

	[PunRPC]
	public void SendNetworkViewMyPlayerRPC(PhotonView myId)
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		for (int i = 0; i < array.Length; i++)
		{
			if (myId.Equals(array[i].GetComponent<PhotonView>().viewID))
			{
				myPlayer = array[i];
				break;
			}
		}
	}
}
