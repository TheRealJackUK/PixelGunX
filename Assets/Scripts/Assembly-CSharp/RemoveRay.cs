using System.Collections;
using UnityEngine;

public class RemoveRay : MonoBehaviour
{
	public float lifetime = 0.7f;

	public float length = 100f;

	private IEnumerator Start()
	{
		yield return new WaitForSeconds(lifetime);
		Object.Destroy(base.gameObject);
	}
}
