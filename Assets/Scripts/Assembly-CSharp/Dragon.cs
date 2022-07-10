using System.Collections;
using UnityEngine;

public class Dragon : MonoBehaviour
{
	public GameObject child;

	private AudioSource childSound;

	public GameObject wingsFirst;

	public GameObject wingsSecond;

	private void Start()
	{
		if (!(child == null) && !(wingsFirst == null) && !(wingsSecond == null))
		{
			childSound = child.GetComponent<AudioSource>();
			StartCoroutine(dragonfly());
		}
	}

	private IEnumerator dragonfly()
	{
		while (true)
		{
			yield return new WaitForSeconds(6.6666665f);
			if (Defs.isSoundFX)
			{
				wingsFirst.SetActive(true);
			}
			yield return new WaitForSeconds(3.2333333f);
			wingsFirst.SetActive(false);
			yield return new WaitForSeconds(6.6666665f);
			child.SetActive(true);
			childSound.enabled = Defs.isSoundFX;
			yield return new WaitForSeconds(5f);
			child.SetActive(false);
			if (Defs.isSoundFX)
			{
				wingsSecond.SetActive(true);
			}
			yield return new WaitForSeconds(4f);
			wingsSecond.SetActive(false);
			yield return new WaitForSeconds(23.71f);
		}
	}
}
