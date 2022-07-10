using System.Collections;
using UnityEngine;

public class EveryplayEarlyInitializer : MonoBehaviour
{
	private void Start()
	{
		StartCoroutine(InitializeEveryplay());
	}

	private IEnumerator InitializeEveryplay()
	{
		yield return 0;
		Everyplay.Initialize();
		Object.Destroy(base.gameObject);
	}
}
