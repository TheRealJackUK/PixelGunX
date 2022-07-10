using UnityEngine;

namespace RilisoftBot
{
	public class BaseShootingBot : BaseBot
	{
		protected const int MaxCountShootEffectInPool = 4;

		[Header("Shooting damage settings")]
		public GameObject bulletPrefab;

		public bool isFriendlyFire;

		public Transform[] firePoints;

		public bool isSequentialShooting;

		[Header("Detect shot settings")]
		public float rangeShootingDistance = 10f;

		public Transform headPoint;

		protected GameObject[] bulletsEffectPool;

		private bool _isEnemyEnterInAttackZone;

		private int _nextShootEffectIndex;

		private int _nextFirePointIndex;

		protected override void Initialize()
		{
			base.Initialize();
			animationsName.Attack = GameNameShootingAnimation();
			BotAnimationEventHandler componentInChildren = GetComponentInChildren<BotAnimationEventHandler>();
			if (componentInChildren != null)
			{
				componentInChildren.OnDamageEvent += OnShoot;
			}
			animations[animationsName.Attack].speed = speedAnimationAttack;
			InitializeShotsPool(4);
			_isEnemyEnterInAttackZone = false;
		}

		private string GameNameShootingAnimation()
		{
			if (modelCollider == null)
			{
				return string.Empty;
			}
			string arg = modelCollider.gameObject.name;
			return string.Format("{0}_shooting", arg);
		}

		protected virtual void InitializeShotsPool(int sizePool)
		{
			int num = sizePool * firePoints.Length;
			bulletsEffectPool = new GameObject[num];
			for (int i = 0; i < num; i++)
			{
				GameObject gameObject = Object.Instantiate(bulletPrefab) as GameObject;
				bulletsEffectPool[i] = gameObject;
			}
		}

		protected virtual Transform GetFirePointForSequentialShot()
		{
			int nextFirePointIndex = _nextFirePointIndex;
			_nextFirePointIndex++;
			if (_nextFirePointIndex >= firePoints.Length)
			{
				_nextFirePointIndex = 0;
			}
			return firePoints[nextFirePointIndex];
		}

		private void MakeShot(GameObject target)
		{
			if (firePoints.Length == 1)
			{
				Fire(firePoints[0], target);
				return;
			}
			if (isSequentialShooting)
			{
				Transform firePointForSequentialShot = GetFirePointForSequentialShot();
				Fire(firePointForSequentialShot, target);
				return;
			}
			for (int i = 0; i < firePoints.Length; i++)
			{
				Fire(firePoints[i], target);
			}
		}

		protected virtual void Fire(Transform pointFire, GameObject target)
		{
		}

		protected GameObject GetShotEffectFromPool()
		{
			int nextShootEffectIndex = _nextShootEffectIndex;
			_nextShootEffectIndex++;
			if (_nextShootEffectIndex >= bulletsEffectPool.Length)
			{
				_nextShootEffectIndex = 0;
			}
			return bulletsEffectPool[nextShootEffectIndex];
		}

		private void OnShoot()
		{
			if (!(botAiController == null) && !(botAiController.currentTarget == null))
			{
				MakeShot(botAiController.currentTarget.gameObject);
			}
		}

		public override bool CheckEnemyInAttackZone(float distanceToEnemy)
		{
			float squareAttackDistance = GetSquareAttackDistance();
			if (distanceToEnemy < squareAttackDistance)
			{
				_isEnemyEnterInAttackZone = true;
				return true;
			}
			if (_isEnemyEnterInAttackZone)
			{
				squareAttackDistance += rangeShootingDistance * rangeShootingDistance;
				if (distanceToEnemy < squareAttackDistance)
				{
					return true;
				}
			}
			_isEnemyEnterInAttackZone = false;
			return false;
		}

		public override float GetMaxAttackDistance()
		{
			float num = rangeShootingDistance * rangeShootingDistance;
			return GetSquareAttackDistance() + num;
		}

		public override Vector3 GetHeadPoint()
		{
			if (headPoint != null)
			{
				return headPoint.position;
			}
			return base.GetHeadPoint();
		}
	}
}
