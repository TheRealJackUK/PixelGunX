using System;
using UnityEngine;

[Serializable]
public class ThirdPersonCamera : MonoBehaviour
{
	public Transform cameraTransform;

	private Transform _target;

	public float distance;

	public float height;

	public float angularSmoothLag;

	public float angularMaxSpeed;

	public float heightSmoothLag;

	public float snapSmoothLag;

	public float snapMaxSpeed;

	public float clampHeadPositionScreenSpace;

	public float lockCameraTimeout;

	private Vector3 headOffset;

	private Vector3 centerOffset;

	private float heightVelocity;

	private float angleVelocity;

	private bool snap;

	private ThirdPersonController controller;

	private float targetHeight;

	public ThirdPersonCamera()
	{
		distance = 7f;
		height = 3f;
		angularSmoothLag = 0.3f;
		angularMaxSpeed = 15f;
		heightSmoothLag = 0.3f;
		snapSmoothLag = 0.2f;
		snapMaxSpeed = 720f;
		clampHeadPositionScreenSpace = 0.75f;
		lockCameraTimeout = 0.2f;
		headOffset = Vector3.zero;
		centerOffset = Vector3.zero;
		targetHeight = 100000f;
	}

	public virtual void Awake()
	{
		if (!cameraTransform && (bool)Camera.main)
		{
			cameraTransform = Camera.main.transform;
		}
		if (!cameraTransform)
		{
			Debug.Log("Please assign a camera to the ThirdPersonCamera script.");
			enabled = false;
		}
		_target = transform;
		if ((bool)_target)
		{
			controller = (ThirdPersonController)_target.GetComponent(typeof(ThirdPersonController));
		}
		if ((bool)controller)
		{
			CharacterController characterController = (CharacterController)_target.GetComponent<Collider>();
			centerOffset = characterController.bounds.center - _target.position;
			headOffset = centerOffset;
			headOffset.y = characterController.bounds.max.y - _target.position.y;
		}
		else
		{
			Debug.Log("Please assign a target to the camera that has a ThirdPersonController script attached.");
		}
		Cut(_target, centerOffset);
	}

	public virtual void DebugDrawStuff()
	{
		Debug.DrawLine(_target.position, _target.position + headOffset);
	}

	public virtual float AngleDistance(float a, float b)
	{
		a = Mathf.Repeat(a, 360f);
		b = Mathf.Repeat(b, 360f);
		return Mathf.Abs(b - a);
	}

	public virtual void Apply(Transform dummyTarget, Vector3 dummyCenter)
	{
		if (!controller)
		{
			return;
		}
		Vector3 vector = _target.position + centerOffset;
		Vector3 headPos = _target.position + headOffset;
		float y = _target.eulerAngles.y;
		float y2 = cameraTransform.eulerAngles.y;
		float num = y;
		if (Input.GetButton("Fire2"))
		{
			snap = true;
		}
		if (snap)
		{
			if (!(AngleDistance(y2, y) >= 3f))
			{
				snap = false;
			}
			y2 = Mathf.SmoothDampAngle(y2, num, ref angleVelocity, snapSmoothLag, snapMaxSpeed);
		}
		else
		{
			if (!(controller.GetLockCameraTimer() >= lockCameraTimeout))
			{
				num = y2;
			}
			if (!(AngleDistance(y2, num) <= 160f) && controller.IsMovingBackwards())
			{
				num += 180f;
			}
			y2 = Mathf.SmoothDampAngle(y2, num, ref angleVelocity, angularSmoothLag, angularMaxSpeed);
		}
		if (controller.IsJumping())
		{
			float num2 = vector.y + height;
			if (num2 < targetHeight || !(num2 - targetHeight <= 5f))
			{
				targetHeight = vector.y + height;
			}
		}
		else
		{
			targetHeight = vector.y + height;
		}
		float y3 = cameraTransform.position.y;
		y3 = Mathf.SmoothDamp(y3, targetHeight, ref heightVelocity, heightSmoothLag);
		Quaternion quaternion = Quaternion.Euler(0f, y2, 0f);
		cameraTransform.position = vector;
		cameraTransform.position += quaternion * Vector3.back * distance;
		float y4 = y3;
		Vector3 position = cameraTransform.position;
		float num3 = (position.y = y4);
		Vector3 vector3 = (cameraTransform.position = position);
		SetUpRotation(vector, headPos);
	}

	public virtual void LateUpdate()
	{
		Apply(transform, Vector3.zero);
	}

	public virtual void Cut(Transform dummyTarget, Vector3 dummyCenter)
	{
		float num = heightSmoothLag;
		float num2 = snapMaxSpeed;
		float num3 = snapSmoothLag;
		snapMaxSpeed = 10000f;
		snapSmoothLag = 0.001f;
		heightSmoothLag = 0.001f;
		snap = true;
		Apply(transform, Vector3.zero);
		heightSmoothLag = num;
		snapMaxSpeed = num2;
		snapSmoothLag = num3;
	}

	public virtual void SetUpRotation(Vector3 centerPos, Vector3 headPos)
	{
		Vector3 position = cameraTransform.position;
		Vector3 vector = centerPos - position;
		Quaternion quaternion = Quaternion.LookRotation(new Vector3(vector.x, 0f, vector.z));
		Vector3 forward = Vector3.forward * distance + Vector3.down * height;
		cameraTransform.rotation = quaternion * Quaternion.LookRotation(forward);
		Ray ray = cameraTransform.GetComponent<Camera>().ViewportPointToRay(new Vector3(0.5f, 0.5f, 1f));
		Ray ray2 = cameraTransform.GetComponent<Camera>().ViewportPointToRay(new Vector3(0.5f, clampHeadPositionScreenSpace, 1f));
		Vector3 point = ray.GetPoint(distance);
		Vector3 point2 = ray2.GetPoint(distance);
		float num = Vector3.Angle(ray.direction, ray2.direction);
		float num2 = num / (point.y - point2.y);
		float num3 = num2 * (point.y - centerPos.y);
		if (!(num3 >= num))
		{
			num3 = 0f;
			return;
		}
		num3 -= num;
		cameraTransform.rotation *= Quaternion.Euler(0f - num3, 0f, 0f);
	}

	public virtual Vector3 GetCenterOffset()
	{
		return centerOffset;
	}

	public virtual void Main()
	{
	}
}
