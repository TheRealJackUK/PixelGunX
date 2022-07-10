using System;
using UnityEngine;

[Serializable]
public class ExplosionAtPoint : MonoBehaviour
{
	public Transform explosionPrefab;

	public float rate;

	public float nextCopy;

	public virtual void Update()
	{
		if (Input.GetKeyDown("mouse 0"))
		{
			nextCopy = Time.time + rate;
			Ray ray = GetComponent<Camera>().ScreenPointToRay(Input.mousePosition);
			RaycastHit hitInfo = default(RaycastHit);
			if (Physics.Raycast(ray, out hitInfo))
			{
				Quaternion quaternion = Quaternion.FromToRotation(Vector3.up, hitInfo.normal);
				UnityEngine.Object.Instantiate(explosionPrefab, hitInfo.point, Quaternion.identity);
			}
		}
	}

	public virtual void Main()
	{
	}
}
