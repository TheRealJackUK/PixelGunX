using UnityEngine;

public class DestroyChecker : MonoBehaviour
{
	private void OnDestroy()
	{
		Debug.Log("Destroy");
	}
}
