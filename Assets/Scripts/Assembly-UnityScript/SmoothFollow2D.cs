using System;
using UnityEngine;

[Serializable]
public class SmoothFollow2D : MonoBehaviour
{
	public Transform target;

	public float smoothTime;

	private Transform thisTransform;

	private Vector2 velocity;

	public SmoothFollow2D()
	{
		smoothTime = 0.3f;
	}

	public virtual void Start()
	{
		thisTransform = transform;
	}

	public virtual void Update()
	{
		float x = Mathf.SmoothDamp(thisTransform.position.x, target.position.x, ref velocity.x, smoothTime);
		Vector3 position = thisTransform.position;
		float num = (position.x = x);
		Vector3 vector2 = (thisTransform.position = position);
		float y = Mathf.SmoothDamp(thisTransform.position.y, target.position.y, ref velocity.y, smoothTime);
		Vector3 position2 = thisTransform.position;
		float num2 = (position2.y = y);
		Vector3 vector4 = (thisTransform.position = position2);
	}

	public virtual void Main()
	{
	}
}
