using System.Collections;
using UnityEngine;

namespace RilisoftBot
{
	public class FiringShotBot : BaseShootingBot
	{
		[Header("Firing settings")]
		[Range(0.1f, 1f)]
		public float chanceMakeDamage = 1f;

		public float timeShowFireEffect = 2f;

		private bool _isEffectFireShow;

		protected override void InitializeShotsPool(int sizePool)
		{
			base.InitializeShotsPool(sizePool);
			Transform parent = ((firePoints.Length != 1) ? base.transform : firePoints[0]);
			for (int i = 0; i < bulletsEffectPool.Length; i++)
			{
				bulletsEffectPool[i].transform.parent = parent;
				bulletsEffectPool[i].transform.localPosition = Vector3.zero;
				bulletsEffectPool[i].transform.rotation = Quaternion.identity;
				bulletsEffectPool[i].GetComponent<ParticleSystem>().Stop();
			}
		}

		private ParticleSystem GetFireShotEffectFromPool()
		{
			GameObject shotEffectFromPool = GetShotEffectFromPool();
			return shotEffectFromPool.GetComponent<ParticleSystem>();
		}

		private IEnumerator ShowFireEffect(GameObject effect)
		{
			if (!_isEffectFireShow)
			{
				_isEffectFireShow = true;
				effect.SetActive(true);
				yield return new WaitForSeconds(timeShowFireEffect);
				effect.SetActive(false);
				_isEffectFireShow = false;
			}
		}

		private IEnumerator ShowFireEffect(ParticleSystem effect)
		{
			if (!_isEffectFireShow)
			{
				_isEffectFireShow = true;
				effect.Play();
				yield return new WaitForSeconds(timeShowFireEffect);
				effect.Stop();
				_isEffectFireShow = false;
			}
		}

		protected override void Fire(Transform pointFire, GameObject target)
		{
			ParticleSystem fireShotEffectFromPool = GetFireShotEffectFromPool();
			if (firePoints.Length == 1)
			{
				StartCoroutine(ShowFireEffect(fireShotEffectFromPool));
			}
			else
			{
				StartCoroutine(ShowFireEffect(pointFire, fireShotEffectFromPool));
			}
			if (chanceMakeDamage >= Random.value)
			{
				MakeDamage(target.transform);
			}
		}

		private IEnumerator ShowFireEffect(Transform pointFire, ParticleSystem effect)
		{
			if (!_isEffectFireShow)
			{
				_isEffectFireShow = true;
				effect.transform.position = pointFire.position;
				effect.transform.rotation = pointFire.rotation;
				effect.Play();
				yield return new WaitForSeconds(timeShowFireEffect);
				effect.Stop();
				_isEffectFireShow = false;
			}
		}
	}
}
