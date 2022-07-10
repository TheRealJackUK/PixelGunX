using System;
using UnityEngine;

[Serializable]
public class RotationConstraint : MonoBehaviour
{
	public ConstraintAxis axis;

	public float min;

	public float max;

	public GameObject playerGun;

	private Transform thisTransform;

	private Vector3 rotateAround;

	private Quaternion minQuaternion;

	private Quaternion maxQuaternion;

	private float range;

	public virtual void Start()
	{
		thisTransform = transform;
		switch (axis)
		{
		case ConstraintAxis.X:
			rotateAround = Vector3.right;
			break;
		case ConstraintAxis.Y:
			rotateAround = Vector3.up;
			break;
		case ConstraintAxis.Z:
			rotateAround = Vector3.forward;
			break;
		}
		Quaternion quaternion = Quaternion.AngleAxis(thisTransform.localRotation.eulerAngles[(int)axis], rotateAround);
		minQuaternion = quaternion * Quaternion.AngleAxis(min, rotateAround);
		maxQuaternion = quaternion * Quaternion.AngleAxis(max, rotateAround);
		range = max - min;
	}

	public virtual void SetActiveFalse()
	{
		enabled = false;
	}

	public virtual void LateUpdate()
	{
		Quaternion localRotation = thisTransform.localRotation;
		Quaternion a = Quaternion.AngleAxis(localRotation.eulerAngles[(int)axis], rotateAround);
		float num = Quaternion.Angle(a, minQuaternion);
		float num2 = Quaternion.Angle(a, maxQuaternion);
		if (!(num > range) && !(num2 > range))
		{
			playerGun.transform.rotation = thisTransform.rotation;
			return;
		}
		Vector3 eulerAngles = localRotation.eulerAngles;
		if (!(num <= num2))
		{
			eulerAngles[(int)axis] = maxQuaternion.eulerAngles[(int)axis];
		}
		else
		{
			eulerAngles[(int)axis] = minQuaternion.eulerAngles[(int)axis];
		}
		thisTransform.localEulerAngles = eulerAngles;
		playerGun.transform.rotation = thisTransform.rotation;
	}

	public virtual void Main()
	{
	}
}
