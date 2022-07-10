using UnityEngine;

public class DamageCollider : MonoBehaviour
{
	public float damage;

	public float frequency;

	private bool _playerRegistered;

	private float _remainsTimeToHit;

	private Transform cachedTransform;

	public void RegisterPlayer()
	{
		_playerRegistered = true;
		_remainsTimeToHit = frequency;
		CauseDamage();
	}

	public void UnregisterPlayer()
	{
		_playerRegistered = false;
	}

	private void Start()
	{
		cachedTransform = base.transform;
	}

	private void CauseDamage()
	{
		if (!(WeaponManager.sharedManager != null) || !(WeaponManager.sharedManager.myPlayerMoveC != null))
		{
			return;
		}
		if (Defs.isSoundFX)
		{
			NGUITools.PlaySound(WeaponManager.sharedManager.myPlayerMoveC.damagePlayerSound);
		}
		if (WeaponManager.sharedManager.myPlayerMoveC.isMechActive)
		{
			WeaponManager.sharedManager.myPlayerMoveC.MinusMechHealth(damage);
		}
		else
		{
			if (WeaponManager.sharedManager.myPlayerMoveC.curArmor >= damage)
			{
				WeaponManager.sharedManager.myPlayerMoveC.curArmor -= damage;
			}
			else
			{
				WeaponManager.sharedManager.myPlayerMoveC.CurHealth -= damage - WeaponManager.sharedManager.myPlayerMoveC.curArmor;
				WeaponManager.sharedManager.myPlayerMoveC.curArmor = 0f;
				CurrentCampaignGame.withoutHits = false;
			}
			if (WeaponManager.sharedManager.myPlayerMoveC.CurHealth <= 0f && Defs.isMulti)
			{
				WeaponManager.sharedManager.myPlayer.GetComponent<SkinName>().ImSuicide();
			}
		}
		WeaponManager.sharedManager.myPlayerMoveC.StartFlash(WeaponManager.sharedManager.myPlayer);
	}

	private void Update()
	{
		if (_playerRegistered)
		{
			_remainsTimeToHit -= Time.deltaTime;
			if (_remainsTimeToHit <= 0f)
			{
				_remainsTimeToHit = frequency;
				CauseDamage();
			}
		}
	}
}
