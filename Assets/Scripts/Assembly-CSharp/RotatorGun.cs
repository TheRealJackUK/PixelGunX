using UnityEngine;

public class RotatorGun : MonoBehaviour
{
	public GameObject playerGun;

	private void Update()
	{
		playerGun.transform.rotation = base.transform.rotation;
	}
}
