using Rilisoft;
using UnityEngine;

namespace RilisoftBot
{
	public class ShootingBot : BaseShootingBot
	{
		private const float offsetPointDamagePlayer = 0.5f;

		[Header("Explosion damage settings")]
		public bool isProjectileExplosion;

		public float damagePerHitMin;

		public GameObject effectExplosion;

		public float radiusExplosion;

		public float speedBullet = 10f;

		[Header("Automatic bullet speed settings")]
		public bool isCalculateSpeedBullet;

		[Header("Shooting sound settings")]
		public AudioClip shootingSound;

		private float _normalBulletSpeed;

		[Header("Physics shot settings")]
		public bool isMoveByPhysics;

		public float force = 5f;

		public float angle = -45f;

		protected override void Initialize()
		{
			base.Initialize();
			float length = animations[animationsName.Attack].length;
			_normalBulletSpeed = (attackDistance + rangeShootingDistance) / length;
		}

		protected override void InitializeShotsPool(int sizePool)
		{
			base.InitializeShotsPool(sizePool);
			float lifeTime = (attackDistance + rangeShootingDistance) / GetBulletSpeed();
			for (int i = 0; i < bulletsEffectPool.Length; i++)
			{
				BulletForBot component = bulletsEffectPool[i].GetComponent<BulletForBot>();
				if (component != null)
				{
					component.lifeTime = lifeTime;
					component.OnBulletDamage += MakeDamageTarget;
					component.needDestroyByStop = false;
				}
			}
		}

		private BulletForBot GetShotFromPool()
		{
			GameObject shotEffectFromPool = GetShotEffectFromPool();
			return shotEffectFromPool.GetComponent<BulletForBot>();
		}

		private float GetBulletSpeed()
		{
			if (isCalculateSpeedBullet)
			{
				speedBullet = _normalBulletSpeed * speedAnimationAttack;
			}
			return speedBullet;
		}

		private void MakeDamageTarget(GameObject target, Vector3 positionDamage)
		{
			if (isProjectileExplosion)
			{
				Collider[] array = Physics.OverlapSphere(positionDamage, radiusExplosion, Tools.AllAvailabelBotRaycastMask);
				if (array.Length == 0)
				{
					return;
				}
				float num = radiusExplosion * radiusExplosion;
				for (int i = 0; i < array.Length; i++)
				{
					if (array[i].gameObject == null)
					{
						continue;
					}
					Transform root = array[i].transform.root;
					if (!(root.gameObject == null) && !(base.transform.gameObject == null) && !root.Equals(base.transform))
					{
						float sqrMagnitude = (root.position - positionDamage).sqrMagnitude;
						if (!(sqrMagnitude > num) && (isFriendlyFire || !root.CompareTag("Enemy")))
						{
							float num2 = damagePerHitMin + (damagePerHit - damagePerHitMin) * ((num - sqrMagnitude) / num);
							Object.Instantiate(effectExplosion, positionDamage, Quaternion.identity);
							MakeDamage(array[i].transform.root.transform, (int)num2);
						}
					}
				}
			}
			else if (target != null)
			{
				MakeDamage(target.transform);
			}
		}

		protected override void Fire(Transform pointFire, GameObject target)
		{
			BulletForBot shotFromPool = GetShotFromPool();
			Vector3 position = target.transform.position;
			position.y += 0.5f;
			if (isCalculateSpeedBullet)
			{
				animations[animationsName.Attack].speed = speedAnimationAttack;
			}
			if (isMoveByPhysics)
			{
				Quaternion quaternion = Quaternion.AngleAxis(angle, base.transform.right);
				Vector3 forceVector = quaternion * base.transform.forward;
				shotFromPool.ApplyForceFroBullet(pointFire.position, position, isFriendlyFire, force, forceVector);
			}
			else
			{
				shotFromPool.StartBullet(pointFire.position, position, GetBulletSpeed(), isFriendlyFire);
			}
			TryPlayAudioClip(shootingSound);
		}

		protected override void OnBotDestroyEvent()
		{
			for (int i = 0; i < bulletsEffectPool.Length; i++)
			{
				if (bulletsEffectPool[i].gameObject == null)
				{
					continue;
				}
				BulletForBot component = bulletsEffectPool[i].GetComponent<BulletForBot>();
				if (component != null)
				{
					component.OnBulletDamage -= MakeDamageTarget;
					if (component.IsUse)
					{
						component.needDestroyByStop = true;
					}
					else
					{
						Object.Destroy(bulletsEffectPool[i]);
					}
				}
			}
		}
	}
}
