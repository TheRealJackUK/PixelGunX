using System.Collections;
using UnityEngine;

public class PlaySoundRepeatedly : MonoBehaviour
{
	public float Delay;

	public int Repeats = 3;

	public float Between = 1f;

	public float Interval = 60f;

	private void OnEnable()
	{
		StartCoroutine(SoundCoroutine());
	}

	private IEnumerator SoundCoroutine()
	{
		yield return new WaitForSeconds(Delay);
		while (true)
		{
			for (int i = 0; i < Repeats; i++)
			{
				if (Defs.isSoundFX)
				{
					base.GetComponent<AudioSource>().Play();
				}
				yield return new WaitForSeconds(Between);
			}
			yield return new WaitForSeconds(Mathf.Max(0f, Interval - Between * (float)Repeats));
		}
	}
}
