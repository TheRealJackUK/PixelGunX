using System;
using UnityEngine;

[Serializable]
[RequireComponent(typeof(CharacterMotor))]
[AddComponentMenu("Character/Platform Input Controller")]
public class PlatformInputController : MonoBehaviour
{
	public bool autoRotate;

	public float maxRotationSpeed;

	private CharacterMotor motor;

	public PlatformInputController()
	{
		autoRotate = true;
		maxRotationSpeed = 360f;
	}

	public virtual void Awake()
	{
		motor = (CharacterMotor)GetComponent(typeof(CharacterMotor));
	}

	public virtual void Update()
	{
		Vector3 vector = new Vector3(Input.GetAxis("Horizontal"), Input.GetAxis("Vertical"), 0f);
		if (vector != Vector3.zero)
		{
			float magnitude = vector.magnitude;
			vector /= magnitude;
			magnitude = Mathf.Min(1f, magnitude);
			magnitude *= magnitude;
			vector *= magnitude;
		}
		vector = Camera.main.transform.rotation * vector;
		Quaternion quaternion = Quaternion.FromToRotation(-Camera.main.transform.forward, transform.up);
		vector = quaternion * vector;
		motor.inputMoveDirection = vector;
		motor.inputJump = Input.GetButton("Jump");
		if (autoRotate && !(vector.sqrMagnitude <= 0.01f))
		{
			Vector3 v = ConstantSlerp(transform.forward, vector, maxRotationSpeed * Time.deltaTime);
			v = ProjectOntoPlane(v, transform.up);
			transform.rotation = Quaternion.LookRotation(v, transform.up);
		}
	}

	public virtual Vector3 ProjectOntoPlane(Vector3 v, Vector3 normal)
	{
		return v - Vector3.Project(v, normal);
	}

	public virtual Vector3 ConstantSlerp(Vector3 from, Vector3 to, float angle)
	{
		float t = Mathf.Min(1f, angle / Vector3.Angle(from, to));
		return Vector3.Slerp(from, to, t);
	}

	public virtual void Main()
	{
	}
}
