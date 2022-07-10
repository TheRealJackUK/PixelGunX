using System;
using System.Collections;
using System.Reflection;
using UnityEngine;

public sealed class BotMovement : MonoBehaviour
{
	public delegate void DelayedCallback();

	public static bool _deathAudioPlaying;

	private Transform target;

	private float timeToRemoveLive;

	public ZombieCreator _gameController;

	private bool Agression;

	private bool deaded;

	private Player_move_c healthDown;

	private GameObject player;

	private float CurLifeTime;

	private string idleAnim = "Idle";

	private string normWalkAnim = "Norm_Walk";

	private string zombieWalkAnim = "Zombie_Walk";

	private string offAnim = "Zombie_Off";

	private string deathAnim = "Zombie_Dead";

	private string onAnim = "Zombie_On";

	private string attackAnim = "Zombie_Attack";

	private string shootAnim;

	private GameObject _modelChild;

	private Sounds _soundClips;

	private bool falling;

	private UnityEngine.AI.NavMeshAgent _nma;

	private BoxCollider _modelChildCollider;

	private Transform myTransform;

	private IEnumerator resetDeathAudio(float tm)
	{
		_deathAudioPlaying = true;
		yield return new WaitForSeconds(tm);
		_deathAudioPlaying = false;
	}

	public bool RequestPlayDeath(float tm)
	{
		if (_deathAudioPlaying)
		{
			return false;
		}
		StartCoroutine(resetDeathAudio(tm));
		return true;
	}

	private void Awake()
	{
		if (Defs.isCOOP)
		{
			base.enabled = false;
			return;
		}
		IEnumerator enumerator = base.transform.GetEnumerator();
		try
		{
			if (enumerator.MoveNext())
			{
				Transform transform = (Transform)enumerator.Current;
				_modelChild = transform.gameObject;
			}
		}
		finally
		{
			IDisposable disposable = enumerator as IDisposable;
			if (disposable != null)
			{
				disposable.Dispose();
			}
		}
	}

	private void Start()
	{
		myTransform = base.transform;
		_nma = GetComponent<UnityEngine.AI.NavMeshAgent>();
		_modelChildCollider = _modelChild.GetComponent<BoxCollider>();
		shootAnim = offAnim;
		healthDown = GameObject.FindGameObjectWithTag("PlayerGun").GetComponent<Player_move_c>();
		player = GameObject.FindGameObjectWithTag("Player");
		_gameController = GameObject.FindGameObjectWithTag("GameController").GetComponent<ZombieCreator>();
		_gameController.NumOfLiveZombies++;
		_soundClips = _modelChild.GetComponent<Sounds>();
		timeToRemoveLive = _soundClips.timeToHit * Mathf.Pow(0.95f, GlobalGameController.AllLevelsCompleted);
		CurLifeTime = timeToRemoveLive;
		target = null;
		_modelChild.GetComponent<Animation>().Stop();
		Walk();
		_soundClips.attackingSpeed += UnityEngine.Random.Range(0f - _soundClips.attackingSpeedRandomRange[0], _soundClips.attackingSpeedRandomRange[1]);
		if (!Defs.IsSurvival)
		{
			_soundClips.attackingSpeed *= Defs.DiffModif;
			_soundClips.health *= Defs.DiffModif;
			_soundClips.notAttackingSpeed *= Defs.DiffModif;
		}
		if (!Defs.IsSurvival && !base.gameObject.name.Contains("Boss"))
		{
			ZombieCreator.LastEnemy += IncreaseRange;
			if (_gameController.IsLasTMonsRemains)
			{
				IncreaseRange();
			}
		}
	}

	private void IncreaseRange()
	{
		_modelChild.GetComponent<Sounds>().attackingSpeed = Mathf.Max(_modelChild.GetComponent<Sounds>().attackingSpeed, 3f);
		_modelChild.GetComponent<Sounds>().detectRadius = 150f;
	}

	public static float AngleSigned(Vector3 v1, Vector3 v2, Vector3 n)
	{
		return Mathf.Atan2(Vector3.Dot(n, Vector3.Cross(v1, v2)), Vector3.Dot(v1, v2)) * 57.29578f;
	}

	public void Slowdown(float coef)
	{
	}

	private void Update()
	{
		if (!deaded)
		{
			if (!(target != null))
			{
				return;
			}
			float num = Vector3.SqrMagnitude(target.position - myTransform.position);
			Vector3 vector = new Vector3(target.position.x, myTransform.position.y, target.position.z);
			if (num >= _soundClips.attackDistance * _soundClips.attackDistance)
			{
				_nma.SetDestination(vector);
				_nma.speed = _soundClips.attackingSpeed * Mathf.Pow(1.05f, GlobalGameController.AllLevelsCompleted);
				CurLifeTime = timeToRemoveLive;
				PlayZombieRun();
				return;
			}
			if (_nma.path != null)
			{
				_nma.ResetPath();
			}
			CurLifeTime -= Time.deltaTime;
			myTransform.LookAt(vector);
			if (CurLifeTime <= 0f)
			{
				if (target.CompareTag("Player"))
				{
					healthDown.hit(_soundClips.damagePerHit, myTransform.position);
				}
				if (target.CompareTag("Turret"))
				{
					target.GetComponent<TurretController>().MinusLive(_soundClips.damagePerHit);
				}
				CurLifeTime = timeToRemoveLive;
				if (Defs.isSoundFX)
				{
					base.GetComponent<AudioSource>().PlayOneShot(_soundClips.bite);
				}
			}
			if ((bool)_modelChild.GetComponent<Animation>()[attackAnim])
			{
				_modelChild.GetComponent<Animation>().CrossFade(attackAnim);
			}
			else if ((bool)_modelChild.GetComponent<Animation>()[shootAnim])
			{
				_modelChild.GetComponent<Animation>().CrossFade(shootAnim);
			}
		}
		else if (falling)
		{
			float num2 = 7f;
			myTransform.position = new Vector3(myTransform.position.x, myTransform.position.y - num2 * Time.deltaTime, myTransform.position.z);
		}
	}

	public void PlayZombieRun()
	{
		if ((bool)_modelChild.GetComponent<Animation>()[zombieWalkAnim])
		{
			_modelChild.GetComponent<Animation>().CrossFade(zombieWalkAnim);
		}
	}

	public void SetTarget(Transform _target, bool agression)
	{
		Agression = agression;
		if ((bool)_target && target != _target)
		{
			_nma.ResetPath();
			if (Defs.isSoundFX)
			{
				base.GetComponent<AudioSource>().PlayOneShot(_soundClips.voice);
			}
			PlayZombieRun();
		}
		else if (!_target && target != _target)
		{
			_nma.ResetPath();
			Walk();
		}
		target = _target;
		SpawnMonster component = GetComponent<SpawnMonster>();
		component.ShouldMove = _target == null;
	}

	private void Run()
	{
	}

	private void Stop()
	{
	}

	private void Attack()
	{
	}

	[Obfuscation(Exclude = true)]
	private void Death()
	{
		ZombieCreator.LastEnemy -= IncreaseRange;
		_nma.enabled = false;
		if (RequestPlayDeath(_soundClips.death.length) && Defs.isSoundFX)
		{
			base.GetComponent<AudioSource>().PlayOneShot(_soundClips.death);
		}
		float num = _soundClips.death.length;
		_modelChild.GetComponent<Animation>().Stop();
		if ((bool)_modelChild.GetComponent<Animation>()[deathAnim])
		{
			_modelChild.GetComponent<Animation>().Play(deathAnim);
			num = Mathf.Max(num, _modelChild.GetComponent<Animation>()[deathAnim].length);
			CodeAfterDelay(_modelChild.GetComponent<Animation>()[deathAnim].length * 1.25f, StartFall);
		}
		else
		{
			StartFall();
		}
		CodeAfterDelay(num, DestroySelf);
		_modelChild.GetComponent<BoxCollider>().enabled = false;
		deaded = true;
		SpawnMonster component = GetComponent<SpawnMonster>();
		component.ShouldMove = false;
		_gameController.NumOfDeadZombies++;
		GlobalGameController.Score += _soundClips.scorePerKill;
	}

	private void DestroySelf()
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}

	private void StartFall()
	{
		falling = true;
	}

	[Obfuscation(Exclude = true)]
	private void Walk()
	{
		_modelChild.GetComponent<Animation>().Stop();
		if ((bool)_modelChild.GetComponent<Animation>()[normWalkAnim])
		{
			_modelChild.GetComponent<Animation>().CrossFade(normWalkAnim);
		}
		else
		{
			_modelChild.GetComponent<Animation>().CrossFade(zombieWalkAnim);
		}
	}

	private void FixedUpdate()
	{
		if ((bool)base.GetComponent<Rigidbody>())
		{
			base.GetComponent<Rigidbody>().velocity = Vector3.zero;
			base.GetComponent<Rigidbody>().angularVelocity = Vector3.zero;
		}
	}

	public void CodeAfterDelay(float delay, DelayedCallback callback)
	{
		StartCoroutine(___DelayedCallback(delay, callback));
	}

	private IEnumerator ___DelayedCallback(float time, DelayedCallback callback)
	{
		yield return new WaitForSeconds(time);
		callback();
	}

	private void OnDestroy()
	{
		ZombieCreator.LastEnemy -= IncreaseRange;
	}
}
