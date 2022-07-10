using System.Reflection;
using UnityEngine;

internal sealed class Bullet : MonoBehaviour
{
	private float LifeTime = 0.5f;

	private float RespawnTime;

	public float bulletSpeed = 200f;

	public float lifeS = 100f;

	public Vector3 startPos;

	public Vector3 endPos;

	public bool isUse;

	public bool isRedStone;

	public TrailRenderer myRender;

	public void StartBullet()
	{
		Invoke("RemoveSelf", LifeTime);
		base.transform.position = startPos;
		isUse = true;
		myRender.enabled = true;
	}

	[Obfuscation(Exclude = true)]
	private void RemoveSelf()
	{
		if (isRedStone)
		{
			Object.Destroy(base.gameObject);
		}
		else
		{
			base.transform.position = new Vector3(-10000f, -10000f, -10000f);
			myRender.enabled = false;
		}
		isUse = false;
	}

	private float GetDistance(Vector3 vectorA, Vector3 vectorB)
	{
		return Mathf.Sqrt((vectorA.x - vectorB.x) * (vectorA.x - vectorB.x) + (vectorA.y - vectorB.y) * (vectorA.y - vectorB.y) + (vectorA.z - vectorB.z) * (vectorA.z - vectorB.z));
	}

	private void Update()
	{
		if (isUse)
		{
			base.transform.position += (endPos - startPos).normalized * bulletSpeed * Time.deltaTime;
			if (Vector3.SqrMagnitude(startPos - base.transform.position) >= lifeS * lifeS)
			{
				RemoveSelf();
			}
		}
	}
}
