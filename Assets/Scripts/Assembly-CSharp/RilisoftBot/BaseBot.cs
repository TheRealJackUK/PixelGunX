using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

namespace RilisoftBot
{
	public class BaseBot : MonoBehaviour
	{
		protected class BotAnimationName
		{
			public string Walk = "Norm_Walk";

			public string Run = "Zombie_Walk";

			public string Stop = "Zombie_Off";

			public string Death = "Zombie_Dead";

			public string Attack = "Zombie_Attack";

			public string Idle = "Idle";
		}

		private enum RunNetworkAnimationType
		{
			ZombieWalk,
			ZombieAttackOrStop,
			None
		}

		public const string BaseNameBotGuard = "BossGuard";

		private const int ScoreForDamage = 5;

		private const int MultiplySmoothMove = 5;

		public string nameBot;

		[Header("Sound settings")]
		public AudioClip damageSound;

		public AudioClip voiceMobSoud;

		public AudioClip takeDamageSound;

		public AudioClip deathSound;

		[Header("Common damage settings")]
		public float notAttackingSpeed = 1f;

		public float attackingSpeed = 1f;

		public float health = 100f;

		public float attackDistance = 3f;

		public float detectRadius = 17f;

		public float damagePerHit = 1f;

		public int scorePerKill = 50;

		public float[] attackingSpeedRandomRange = new float[2] { -0.5f, 0.5f };

		public Texture flashDeadthTexture;

		[NonSerialized]
		public int indexMobPrefabForCoop;

		protected BotAiController botAiController;

		protected Transform mobModel;

		protected Animation animations;

		protected bool isMobChampion;

		protected BoxCollider modelCollider;

		protected BotAnimationName animationsName;

		private bool _isFlashing;

		private PhotonView _photonView;

		private bool _isMultiplayerMode;

		private BotChangeDamageMaterial[] _botMaterials;

		private bool _isPlayingDamageSound;

		private bool _isDeathAudioPlaying;

		[Header("Automatic animation speed settings")]
		public bool isAutomaticAnimationEnable;

		[Range(0.1f, 2f)]
		public float speedAnimationWalk = 1f;

		[Range(0.1f, 2f)]
		public float speedAnimationRun = 1f;

		[Range(0.1f, 2f)]
		public float speedAnimationAttack = 1f;

		[Header("Flying settings")]
		public bool isFlyingSpeedLimit;

		public float maxFlyingSpeed;

		[Header("Guard settings")]
		public GameObject[] guards;

		private bool _isWeaponCreated;

		private float _modMoveSpeedByDebuff = 1f;

		private List<BotDebuff> _botDebufs = new List<BotDebuff>();

		private Vector3 _botPosition;

		private Quaternion _botRotation;

		private RunNetworkAnimationType _currentRunNetworkAnimation = RunNetworkAnimationType.None;

		public bool IsDeath { get; private set; }

		public bool IsFalling { get; private set; }

		public bool needDestroyByMasterClient { get; private set; }

		private void Awake()
		{
			isMobChampion = false;
			Initialize();
		}

		protected virtual void Initialize()
		{
			animationsName = new BotAnimationName();
			AntiHackForCreateMobInInvalidGameMode();
			_photonView = GetComponent<PhotonView>();
			_isMultiplayerMode = _photonView != null && Defs.isCOOP;
			animations = GetComponentInChildren<Animation>();
			animations.Stop();
			botAiController = GetComponent<BotAiController>();
			modelCollider = GetComponentInChildren<BoxCollider>();
			UnityEngine.Random.seed = (int)DateTime.Now.Ticks & 0xFFFF;
			InitializeRandomAttackSpeed();
			ModifyParametrsForLocalMode();
			needDestroyByMasterClient = false;
		}

		private void Start()
		{
			if (_isMultiplayerMode && _photonView.isMine)
			{
				_photonView.RPC("SetBotHealthRPC", PhotonTargets.All, health);
			}
			if (!_isMultiplayerMode)
			{
				ZombieCreator.sharedCreator.NumOfLiveZombies++;
			}
			mobModel = modelCollider.transform.GetChild(0);
			_botMaterials = GetComponentsInChildren<BotChangeDamageMaterial>();
			InitNetworkStateData();
		}

		private Texture GetBotSkin()
		{
			Renderer[] componentsInChildren = GetComponentsInChildren<Renderer>(true);
			if (componentsInChildren.Length == 0)
			{
				return null;
			}
			return componentsInChildren[componentsInChildren.Length - 1].material.mainTexture;
		}

		private void AntiHackForCreateMobInInvalidGameMode()
		{
			if (Defs.isMulti && !Defs.isCOOP)
			{
				UnityEngine.Object.Destroy(base.gameObject);
			}
		}

		public void OrientToTarget(Vector3 targetPos)
		{
			base.transform.LookAt(targetPos);
		}

		[Obfuscation(Exclude = true)]
		public void PlayAnimationIdle()
		{
			animations.Stop();
			if ((bool)animations[animationsName.Idle])
			{
				animations.CrossFade(animationsName.Idle);
			}
		}

		public void PlayAnimationWalk()
		{
			animations.Stop();
			if ((bool)animations[animationsName.Walk])
			{
				animations.CrossFade(animationsName.Walk);
			}
			else
			{
				animations.CrossFade(animationsName.Run);
			}
		}

		private void PlayAnimationZombieWalk()
		{
			if ((bool)animations[animationsName.Run])
			{
				animations.CrossFade(animationsName.Run);
			}
		}

		private void PlayAnimationZombieAttackOrStop()
		{
			if ((bool)animations[animationsName.Attack])
			{
				animations.CrossFade(animationsName.Attack);
			}
			else if ((bool)animations[animationsName.Stop])
			{
				animations.CrossFade(animationsName.Stop);
			}
		}

		private void InitializeRandomAttackSpeed()
		{
			if (isAutomaticAnimationEnable)
			{
				float min = (attackingSpeed - attackingSpeedRandomRange[0]) / attackingSpeed;
				float max = (attackingSpeed + attackingSpeedRandomRange[1]) / attackingSpeed;
				speedAnimationRun = UnityEngine.Random.Range(min, max);
			}
			else
			{
				attackingSpeed += UnityEngine.Random.Range(0f - attackingSpeedRandomRange[0], attackingSpeedRandomRange[1]);
			}
		}

		private void SetRangeParametrs()
		{
			if (!isMobChampion && !IsBotGuard())
			{
				ZombieCreator.LastEnemy += IncreaseRange;
				if (ZombieCreator.sharedCreator.IsLasTMonsRemains)
				{
					IncreaseRange();
				}
			}
		}

		private void ModifyParametrsForLocalMode()
		{
			if (_isMultiplayerMode)
			{
				return;
			}
			float num = 0f;
			float num2 = 0f;
			if (isAutomaticAnimationEnable)
			{
				num = speedAnimationWalk;
				num2 = speedAnimationRun;
			}
			else
			{
				num = notAttackingSpeed;
				num2 = attackingSpeed;
			}
			if (!Defs.IsSurvival)
			{
				SetRangeParametrs();
				num2 *= Defs.DiffModif;
				health *= Defs.DiffModif;
				num *= Defs.DiffModif;
			}
			else if (Defs.IsSurvival && !Defs.isTrainingFlag)
			{
				int currentWave = ZombieCreator.sharedCreator.currentWave;
				if (currentWave == 0)
				{
					num *= 0.75f;
					num2 *= 0.75f;
					health *= 0.7f;
				}
				else if (currentWave == 1)
				{
					num *= 0.85f;
					num2 *= 0.85f;
					health *= 0.8f;
				}
				else if (currentWave == 2)
				{
					num *= 0.9f;
					num2 *= 0.9f;
					health *= 0.9f;
				}
				else if (currentWave >= 7)
				{
					num *= 1.25f;
					num2 *= 1.25f;
				}
				else if (currentWave >= 9)
				{
					health *= 1.25f;
				}
			}
			if (isAutomaticAnimationEnable)
			{
				speedAnimationWalk = num;
				speedAnimationRun = num2;
			}
			else
			{
				notAttackingSpeed = num;
				attackingSpeed = num2;
			}
		}

		private void IncreaseRange()
		{
			if (isAutomaticAnimationEnable)
			{
				speedAnimationRun = Mathf.Max(speedAnimationRun, 2f);
			}
			else
			{
				attackingSpeed = Mathf.Max(attackingSpeed, 3f);
			}
			detectRadius = 150f;
		}

		public float GetSquareAttackDistance()
		{
			return attackDistance * attackDistance;
		}

		public float GetSquareDetectRadius()
		{
			return detectRadius * detectRadius;
		}

		public void SetPositionForFallState()
		{
			base.transform.position = new Vector3(base.transform.position.x, base.transform.position.y - 7f * Time.deltaTime, base.transform.position.z);
		}

		public void TryPlayAudioClip(AudioClip audioClip)
		{
			try {
				if (Defs.isSoundFX && !(audioClip == null))
				{
					base.GetComponent<AudioSource>().PlayOneShot(audioClip);
				}
			} catch (Exception e) {
				
			}
		}

		public void PlayVoiceSound()
		{
			TryPlayAudioClip(voiceMobSoud);
		}

		public void TryPlayDeathSound(float delay)
		{
			try {
				if (Defs.isSoundFX && IsCanPlayDeathSound(delay))
				{
					base.GetComponent<AudioSource>().PlayOneShot(deathSound);
				}
			} catch (Exception e){

			}
		}

		public void TryPlayDamageSound(float delay)
		{
			try {
				if (Defs.isSoundFX && !_isPlayingDamageSound)
				{
					StartCoroutine(CheckCanPlayDamageAudio(delay));
					base.GetComponent<AudioSource>().PlayOneShot(damageSound);
				}
			} catch (Exception e){
				
			}
		}

		private IEnumerator CheckCanPlayDamageAudio(float timeOut)
		{
			_isPlayingDamageSound = true;
			yield return new WaitForSeconds(timeOut);
			_isPlayingDamageSound = false;
		}

		private IEnumerator ResetDeathAudio(float timeOut)
		{
			_isDeathAudioPlaying = true;
			yield return new WaitForSeconds(timeOut);
			_isDeathAudioPlaying = false;
		}

		private bool IsCanPlayDeathSound(float timeOut)
		{
			if (_isDeathAudioPlaying)
			{
				return false;
			}
			StartCoroutine(ResetDeathAudio(timeOut));
			return true;
		}

		[Obfuscation(Exclude = true)]
		public void PrepareDeath(bool isOwnerDamage = true)
		{
			if (!_isMultiplayerMode)
			{
				ZombieCreator.LastEnemy -= IncreaseRange;
			}
			botAiController.isDetectPlayer = false;
			botAiController.IsCanMove = false;
			IsDeath = true;
			float num = 0;
			try {
				num = deathSound.length;
				TryPlayDeathSound(num);
			}catch (Exception e){

			}
			animations.Stop();
			if ((bool)animations[animationsName.Death])
			{
				animations.Play(animationsName.Death);
				num = Mathf.Max(num, animations[animationsName.Death].length);
				StartCoroutine(DelayedSetFallState(animations[animationsName.Death].length * 1.25f));
			}
			else
			{
				IsFalling = true;
			}
			StartCoroutine(DelayedDestroySelf(num));
			modelCollider.enabled = false;
			if (isOwnerDamage)
			{
				GlobalGameController.Score += scorePerKill;
			}
			CheckForceKillGuards();
		}

		private IEnumerator DelayedSetFallState(float delay)
		{
			yield return new WaitForSeconds(delay);
			IsFalling = true;
		}

		private IEnumerator DelayedDestroySelf(float delay)
		{
			yield return new WaitForSeconds(delay);
			if (!_isMultiplayerMode && !IsBotGuard())
			{
				ZombieCreator.sharedCreator.NumOfDeadZombies++;
			}
			DestroyByNetworkType();
		}

		private void CheckForceKillGuards()
		{
			if (guards.Length == 0)
			{
				return;
			}
			ZombieCreator sharedCreator = ZombieCreator.sharedCreator;
			if (sharedCreator == null)
			{
				return;
			}
			for (int i = 0; i < sharedCreator.bossGuads.Length; i++)
			{
				GameObject gameObject = sharedCreator.bossGuads[i];
				if (!(gameObject.gameObject == null))
				{
					BaseBot botScriptForObject = GetBotScriptForObject(gameObject.transform);
					if (!botScriptForObject.IsDeath)
					{
						botScriptForObject.GetDamage(-2.1474836E+09f, null, false);
					}
				}
			}
		}

		protected virtual void OnBotDestroyEvent()
		{
		}

		private void OnDestroy()
		{
			OnBotDestroyEvent();
			if (!_isMultiplayerMode)
			{
				ZombieCreator.LastEnemy -= IncreaseRange;
			}
		}

		public static BaseBot GetBotScriptForObject(Transform obj)
		{
			BaseBot component = obj.GetComponent<MeleeBot>();
			if (component != null)
			{
				return component;
			}
			component = obj.GetComponent<ShootingBot>();
			if (component != null)
			{
				return component;
			}
			component = obj.GetComponent<FiringShotBot>();
			if (component != null)
			{
				return component;
			}
			component = obj.GetComponent<MeleeBossBot>();
			if (component != null)
			{
				return component;
			}
			return obj.GetComponent<ShootingBossBot>();
		}

		public virtual bool CheckEnemyInAttackZone(float distanceToEnemy)
		{
			return false;
		}

		public virtual Vector3 GetHeadPoint()
		{
			Vector3 position = base.transform.position;
			position.y += modelCollider.size.y * 0.75f;
			return position;
		}

		public virtual float GetMaxAttackDistance()
		{
			return GetMaxAttackDistance();
		}

		public static void LogDebugData(string message)
		{
			if (Application.isEditor)
			{
				string message2 = string.Format("<color=blue><size=14>{0}</size></color>", message);
				Debug.LogError(message2);
			}
			else
			{
				Debug.Log(message);
			}
		}

		private float CheckAnimationSpeedWalkMoveForBot(float modSpeed)
		{
			float num = speedAnimationWalk * modSpeed;
			animations[animationsName.Walk].speed = num;
			return num * attackingSpeed;
		}

		private float CheckAnimationSpeedRunMoveForBot(float modSpeed)
		{
			float num = speedAnimationRun * modSpeed;
			animations[animationsName.Run].speed = num;
			return num * notAttackingSpeed;
		}

		public float GetWalkSpeed()
		{
			if (isAutomaticAnimationEnable)
			{
				return CheckAnimationSpeedWalkMoveForBot(_modMoveSpeedByDebuff);
			}
			return notAttackingSpeed * _modMoveSpeedByDebuff;
		}

		public float GetAttackSpeedByCompleteLevel()
		{
			if (isAutomaticAnimationEnable)
			{
				return CheckAnimationSpeedRunMoveForBot(_modMoveSpeedByDebuff);
			}
			return attackingSpeed * _modMoveSpeedByDebuff;
		}

		public static Vector3 GetPositionSpawnGuard(Vector3 bossPosition)
		{
			float num = UnityEngine.Random.Range(1f, 3f);
			return bossPosition + new Vector3(num, num, num);
		}

		private bool IsBotGuard()
		{
			return base.gameObject.name.Contains("BossGuard");
		}

		private void ShowDamageTexture(bool isEnable)
		{
			if (_botMaterials == null || _botMaterials.Length == 0)
			{
				return;
			}
			for (int i = 0; i < _botMaterials.Length; i++)
			{
				if (isEnable)
				{
					_botMaterials[i].ShowDamageEffect();
				}
				else
				{
					_botMaterials[i].ResetMainMaterial();
				}
			}
		}

		private IEnumerator ShowDamageEffect()
		{
			_isFlashing = true;
			ShowDamageTexture(true);
			yield return new WaitForSeconds(0.125f);
			ShowDamageTexture(false);
			_isFlashing = false;
		}

		private void TakeBonusForKill()
		{
			if (isMobChampion && !_isWeaponCreated && LevelBox.weaponsFromBosses.ContainsKey(Application.loadedLevelName))
			{
				string weaponName = LevelBox.weaponsFromBosses[Application.loadedLevelName];
				Vector3 pos = base.gameObject.transform.position + new Vector3(0f, 0.25f, 0f);
				GameObject weaponBonus = ZombieCreator.sharedCreator.weaponBonus;
				GameObject gameObject = ((!(weaponBonus != null)) ? BonusCreator._CreateBonus(weaponName, pos) : BonusCreator._CreateBonusFromPrefab(weaponBonus, pos));
				gameObject.AddComponent<GotToNextLevel>();
				ZombieCreator.sharedCreator.weaponBonus = null;
				_isWeaponCreated = true;
			}
		}

		public void MakeDamage(Transform target, float damageValue)
		{
			bool flag = false;
			if (target.CompareTag("Player"))
			{
				flag = true;
				Player_move_c playerMoveC = target.GetComponent<SkinName>().playerMoveC;
				if (_isMultiplayerMode)
				{
					playerMoveC.minusLiveFromZombi(damageValue, base.transform.position);
				}
				else
				{
					playerMoveC.hit(damageValue, base.transform.position);
				}
			}
			else if (target.CompareTag("Turret"))
			{
				flag = true;
				target.GetComponent<TurretController>().MinusLive(damageValue);
			}
			else if (target.CompareTag("Enemy"))
			{
				flag = true;
				BaseBot botScriptForObject = GetBotScriptForObject(target);
				if (_isMultiplayerMode)
				{
					botScriptForObject.GetDamageForMultiplayer(damageValue, null);
				}
				else
				{
					botScriptForObject.GetDamage(damageValue, null, false);
				}
			}
			if (flag)
			{
				TryPlayAudioClip(takeDamageSound);
			}
		}

		public void MakeDamage(Transform target)
		{
			MakeDamage(target, damagePerHit);
		}

		public void GetDamage(float damage, Transform instigator, bool isOwnerDamage = true)
		{
			if (IsDeath)
			{
				return;
			}
			if (damage < 0f && !_isFlashing)
			{
				StartCoroutine(ShowDamageEffect());
			}
			health += damage;
			if (health < 0f)
			{
				health = 0f;
			}
			if (health == 0f)
			{
				PrepareDeath(isOwnerDamage);
				if (isOwnerDamage)
				{
					TakeBonusForKill();
				}
			}
			else if (isOwnerDamage)
			{
				GlobalGameController.Score += 5;
			}
			try {
				TryPlayDamageSound(damageSound.length);
			}catch (Exception e){

			}
			if (instigator != null && health > 0f)
			{
				botAiController.SetTargetForced(instigator);
			}
		}

		private BotDebuff GetDebuffByType(BotDebuffType type)
		{
			for (int i = 0; i < _botDebufs.Count; i++)
			{
				if (_botDebufs[i].type == type)
				{
					return _botDebufs[i];
				}
			}
			return null;
		}

		private void RunDebuff(BotDebuff debuff)
		{
			if (debuff.type == BotDebuffType.DecreaserSpeed)
			{
				float num = (_modMoveSpeedByDebuff = debuff.GetFloatParametr());
			}
		}

		private void StopDebuff(BotDebuff debuff)
		{
			if (debuff.type == BotDebuffType.DecreaserSpeed)
			{
				_modMoveSpeedByDebuff = 1f;
			}
		}

		public void ApplyDebuffByMode(BotDebuffType type, float timeLife, object parametrs)
		{
			if (!_isMultiplayerMode)
			{
				ApplyDebuff(type, timeLife, parametrs);
			}
			else
			{
				ApplyDebufForMultiplayer(type, timeLife, parametrs);
			}
		}

		private void ReplaceDebuff(BotDebuff oldDebuff, float newTimeLife, object newParametrs)
		{
			if (oldDebuff.type == BotDebuffType.DecreaserSpeed)
			{
				oldDebuff.ReplaceValues(newTimeLife, newParametrs);
				RunDebuff(oldDebuff);
			}
		}

		public void ApplyDebuff(BotDebuffType type, float timeLife, object parametrs)
		{
			BotDebuff debuffByType = GetDebuffByType(type);
			if (debuffByType == null)
			{
				BotDebuff botDebuff = new BotDebuff(type, timeLife, parametrs);
				botDebuff.OnRun += RunDebuff;
				botDebuff.OnStop += StopDebuff;
				_botDebufs.Add(botDebuff);
			}
			else
			{
				ReplaceDebuff(debuffByType, timeLife, parametrs);
			}
		}

		public void UpdateDebuffState()
		{
			if (_botDebufs.Count == 0)
			{
				return;
			}
			for (int i = 0; i < _botDebufs.Count; i++)
			{
				if (!_botDebufs[i].isRun)
				{
					_botDebufs[i].Run();
					continue;
				}
				_botDebufs[i].timeLife -= Time.deltaTime;
				if (_botDebufs[i].timeLife <= 0f)
				{
					_botDebufs[i].Stop();
					_botDebufs.Remove(_botDebufs[i]);
				}
			}
		}

		private void InitNetworkStateData()
		{
			_botPosition = base.transform.position;
			_botRotation = base.transform.rotation;
		}

		private void DisableMobForDeleteMasterClient()
		{
			modelCollider.gameObject.SetActive(false);
			MonoBehaviour[] components = GetComponents<MonoBehaviour>();
			for (int i = 0; i < components.Length; i++)
			{
				bool flag = components[i] as PhotonView != null;
				bool flag2 = components[i] as BaseBot != null;
				if (!flag && !flag2)
				{
					components[i].enabled = false;
				}
			}
		}

		public void DestroyByNetworkType()
		{
			if (!_isMultiplayerMode)
			{
				UnityEngine.Object.Destroy(base.gameObject);
				return;
			}
			if (PhotonNetwork.isMasterClient)
			{
				PhotonNetwork.Destroy(base.gameObject);
				return;
			}
			needDestroyByMasterClient = true;
			DisableMobForDeleteMasterClient();
		}

		public void OnPhotonSerializeView(PhotonStream stream, PhotonMessageInfo info)
		{
			if (_isMultiplayerMode)
			{
				if (stream.isWriting)
				{
					stream.SendNext(base.transform.position);
					stream.SendNext(base.transform.rotation);
				}
				else
				{
					_botPosition = (Vector3)stream.ReceiveNext();
					_botRotation = (Quaternion)stream.ReceiveNext();
				}
			}
		}

		private void Update()
		{
			UpdateDebuffState();
			if (_isMultiplayerMode)
			{
				if (PhotonNetwork.isMasterClient && needDestroyByMasterClient)
				{
					PhotonNetwork.Destroy(base.gameObject);
				}
				if (!_photonView.isMine && !needDestroyByMasterClient)
				{
					base.transform.position = Vector3.Lerp(base.transform.position, _botPosition, Time.deltaTime * 5f);
					base.transform.rotation = Quaternion.Lerp(base.transform.rotation, _botRotation, Time.deltaTime * 5f);
				}
			}
		}

		[PunRPC]
		public void SetBotHealthRPC(float botHealth)
		{
			health = botHealth;
		}

		[PunRPC]
		public void PlayZombieRunRPC()
		{
			PlayAnimationZombieWalk();
			_currentRunNetworkAnimation = RunNetworkAnimationType.ZombieWalk;
		}

		[PunRPC]
		public void PlayZombieAttackRPC()
		{
			PlayAnimationZombieAttackOrStop();
			_currentRunNetworkAnimation = RunNetworkAnimationType.ZombieAttackOrStop;
		}

		[PunRPC]
		public void GetDamageRPC(float damage, Transform instigator)
		{
			GetDamage(damage, instigator, false);
		}

		public void GetDamageForMultiplayer(float damage, Transform instigator)
		{
			GetDamage(damage, instigator);
			_photonView.RPC("GetDamageRPC", PhotonTargets.Others, damage, instigator);
		}

		[PunRPC]
		public void ApplyDebuffRPC(int typeDebuff, float timeLife, float parametr)
		{
			ApplyDebuff((BotDebuffType)typeDebuff, timeLife, parametr);
		}

		public void ApplyDebufForMultiplayer(BotDebuffType type, float timeLife, object parametrs)
		{
			ApplyDebuff(type, timeLife, parametrs);
			if (type == BotDebuffType.DecreaserSpeed)
			{
				_photonView.RPC("ApplyDebuffRPC", PhotonTargets.Others, (int)type, timeLife, (float)parametrs);
			}
		}

		public void PlayAnimZombieWalkByMode()
		{
			if (!_isMultiplayerMode)
			{
				PlayAnimationZombieWalk();
				return;
			}
			if (_currentRunNetworkAnimation != 0)
			{
				PlayAnimationZombieWalk();
				_photonView.RPC("PlayZombieRunRPC", PhotonTargets.Others);
			}
			_currentRunNetworkAnimation = RunNetworkAnimationType.ZombieWalk;
		}

		public void PlayAnimZombieAttackOrStopByMode()
		{
			if (!_isMultiplayerMode)
			{
				PlayAnimationZombieAttackOrStop();
				return;
			}
			if (_currentRunNetworkAnimation != RunNetworkAnimationType.ZombieAttackOrStop)
			{
				PlayAnimationZombieAttackOrStop();
				_photonView.RPC("PlayZombieAttackRPC", PhotonTargets.Others);
			}
			_currentRunNetworkAnimation = RunNetworkAnimationType.ZombieAttackOrStop;
		}
	}
}
