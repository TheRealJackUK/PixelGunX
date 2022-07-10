using UnityEngine;

public class BulletStackController : MonoBehaviour
{
	public static BulletStackController sharedController;

	public GameObject[] bullets;

	private int currentIndexBullet;

	private void Start()
	{
		sharedController = this;
		base.transform.position = Vector3.zero;
		bullets = GameObject.FindGameObjectsWithTag("Bullet");
	}

	public GameObject GetCurrentBullet()
	{
		currentIndexBullet++;
		if (currentIndexBullet >= bullets.Length)
		{
			currentIndexBullet = 0;
		}
		return bullets[currentIndexBullet];
	}

	private void OnDestroy()
	{
		sharedController = null;
	}
}
