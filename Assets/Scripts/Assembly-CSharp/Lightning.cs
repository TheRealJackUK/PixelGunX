using System.Collections;
using UnityEngine;

public class Lightning : MonoBehaviour
{
	public GameObject child;

	public GameObject sound;

	private void Start()
	{
		if (!(child == null))
		{
			if (sound != null)
			{
				sound.SetActive(false);
			}
			StartCoroutine(lightning());
		}
	}

	private IEnumerator lightning()
	{
		while (true)
		{
			yield return new WaitForSeconds(Random.Range(30f, 90f));
			child.SetActive(true);
			sound.SetActive(false);
			yield return new WaitForSeconds(0.1f);
			child.SetActive(false);
			if (Defs.isSoundFX)
			{
				sound.SetActive(true);
			}
			yield return new WaitForSeconds(Random.Range(0.1f, 0.1f));
			child.SetActive(true);
			yield return new WaitForSeconds(0.1f);
			child.SetActive(false);
		}
	}
}
