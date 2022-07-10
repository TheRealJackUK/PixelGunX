using System.Collections;
using UnityEngine;

public class BlickButton : MonoBehaviour
{
	public float firstSdvig;

	public float blickPeriod = 3f;

	public float blickSpeed = 0.3f;

	public UISprite blickSprite;

	public UIButton baseButton;

	public string baseNameSprite;

	public int countFrame;

	private void Start()
	{
		blickSprite.gameObject.SetActive(false);
		StartCoroutine(Blink());
	}

	private IEnumerator Blink()
	{
		yield return StartCoroutine(MyWaitForSeconds(firstSdvig));
		while (true)
		{
			if (baseButton.state == UIButtonColor.State.Disabled)
			{
				yield return null;
				continue;
			}
			yield return StartCoroutine(MyWaitForSeconds(blickPeriod));
			blickSprite.gameObject.SetActive(true);
			for (int i = 0; i < countFrame; i++)
			{
				blickSprite.spriteName = baseNameSprite + i;
				yield return StartCoroutine(MyWaitForSeconds(blickSpeed));
			}
			blickSprite.gameObject.SetActive(false);
		}
	}

	public IEnumerator MyWaitForSeconds(float tm)
	{
		float startTime = Time.realtimeSinceStartup;
		do
		{
			yield return null;
		}
		while (Time.realtimeSinceStartup - startTime < tm);
	}

	private void Update()
	{
	}
}
