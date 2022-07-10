using UnityEngine;

public class WeaponAnimParticleEffects : MonoBehaviour
{
	public WeaponAnimEffectData[] effects;

	private WeaponAnimEffectData _currentEffect;

	private void Start()
	{
		for (int i = 0; i < effects.Length; i++)
		{
			InitiAnimatonEventForEffect(effects[i]);
		}
	}

	private void InitiAnimatonEventForEffect(WeaponAnimEffectData effectData)
	{
		AnimationClip clip = base.GetComponent<Animation>().GetClip(effectData.animationName);
		if (!(clip == null))
		{
			AnimationEvent animationEvent = new AnimationEvent();
			animationEvent.stringParameter = effectData.animationName;
			animationEvent.functionName = "OnStartAnimEffects";
			animationEvent.time = 0f;
			clip.AddEvent(animationEvent);
		}
	}

	private void SetActiveEffect(WeaponAnimEffectData effect, bool active)
	{
		if (effect.particleSystems.Length != 0)
		{
			for (int i = 0; i < effect.particleSystems.Length; i++)
			{
				ParticleSystem particleSystem = effect.particleSystems[i];
				particleSystem.gameObject.SetActive(active);
			}
		}
	}

	private WeaponAnimEffectData GetEffectData(string animationName)
	{
		for (int i = 0; i < effects.Length; i++)
		{
			if (effects[i].animationName == animationName)
			{
				return effects[i];
			}
		}
		return null;
	}

	private void OnStartAnimEffects(string animationName)
	{
		WeaponAnimEffectData effectData = GetEffectData(animationName);
		if (_currentEffect != null)
		{
			SetActiveEffect(_currentEffect, false);
		}
		_currentEffect = effectData;
		SetActiveEffect(effectData, true);
	}
}
