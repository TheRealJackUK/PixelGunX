using UnityEngine;

namespace RilisoftBot
{
	public class MeleeBot : BaseBot
	{
		[Header("Melee damage settings")]
		public float timeToTakeDamage = 2f;

		private float _animationAttackLength;

		protected override void Initialize()
		{
			base.Initialize();
			_animationAttackLength = animations[animationsName.Attack].length;
		}

		public float CheckTimeToTakeDamage()
		{
			if (!isAutomaticAnimationEnable)
			{
				return timeToTakeDamage * Mathf.Pow(0.95f, GlobalGameController.AllLevelsCompleted);
			}
			animations[animationsName.Attack].speed = speedAnimationAttack;
			float num = _animationAttackLength / speedAnimationAttack;
			return num * Mathf.Pow(0.95f, GlobalGameController.AllLevelsCompleted);
		}

		public override bool CheckEnemyInAttackZone(float distanceToEnemy)
		{
			return GetSquareAttackDistance() >= distanceToEnemy;
		}
	}
}
