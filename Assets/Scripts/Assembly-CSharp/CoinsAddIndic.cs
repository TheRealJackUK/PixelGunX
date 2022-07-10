using System.Collections;
using UnityEngine;

public class CoinsAddIndic : MonoBehaviour
{
	private const float blinkR = 255f;

	private const float blinkG = 255f;

	private const float blinkB = 0f;

	private const float blinkA = 115f;

	private const float blinkGemsR = 0f;

	private const float blinkGemsG = 0f;

	private const float blinkGemsB = 255f;

	private const float blinkGemsA = 115f;

	public bool isGems;

	public bool isX3;

	private UISprite ind;

	private bool blinking;

	public AudioClip coinsAdded;

	private bool isSurvival;

	private Color BlinkColor
	{
		get
		{
			return (!isGems) ? new Color(1f, 1f, 0f, 23f / 51f) : new Color(0f, 0f, 1f, 23f / 51f);
		}
	}

	private void Start()
	{
		ind = GetComponent<UISprite>();
		isSurvival = Defs.IsSurvival;
	}

	private void OnEnable()
	{
		CoinsMessage.CoinsLabelDisappeared += IndicateCoinsAdd;
		if (ind != null)
		{
			ind.color = NormalColor();
		}
		if (blinking)
		{
			StartCoroutine(blink());
		}
	}

	private void OnDisable()
	{
		CoinsMessage.CoinsLabelDisappeared -= IndicateCoinsAdd;
	}

	private void IndicateCoinsAdd(bool gems)
	{
		if (gems == isGems)
		{
			if (!blinking)
			{
				StartCoroutine(blink());
			}
			if (!Defs.isMulti && !Defs.IsSurvival && !Defs.IsTraining)
			{
				PlaySoundNow();
			}
			else
			{
				StartCoroutine(PlaySound());
			}
		}
	}

	private Color NormalColor()
	{
		return (!isX3) ? new Color(0f, 0f, 0f, 23f / 51f) : new Color(0.5019608f, 4f / 85f, 4f / 85f, 1f);
	}

	private IEnumerator blink()
	{
		if (ind == null)
		{
			Debug.LogWarning("Indicator sprite is null.");
			yield return null;
		}
		blinking = true;
		try
		{
			for (int i = 0; i < 15; i++)
			{
				ind.color = BlinkColor;
				yield return null;
				yield return new WaitForSeconds(0.1f);
				ind.color = NormalColor();
				yield return new WaitForSeconds(0.1f);
			}
			ind.color = NormalColor();
		}
		finally
		{
			blinking = false;
		}
	}

	private IEnumerator PlaySound()
	{
		yield return new WaitForSeconds((!isSurvival) ? 0.11f : 0.11f);
		PlaySoundNow();
	}

	private void PlaySoundNow()
	{
		if (!Application.loadedLevelName.Equals("LevelComplete") && Defs.isSoundFX)
		{
			NGUITools.PlaySound(coinsAdded);
		}
	}
}
