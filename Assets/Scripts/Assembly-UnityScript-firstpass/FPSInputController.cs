using System;
using UnityEngine;

[Serializable]
[RequireComponent(typeof(CharacterMotor))]
[AddComponentMenu("Character/FPS Input Controller")]
public class FPSInputController : MonoBehaviour
{
	private CharacterMotor motor;

	public virtual void Awake()
	{
		motor = (CharacterMotor)GetComponent(typeof(CharacterMotor));
	}

	public virtual void Update()
	{
		Vector3 vector = new Vector3(Input.GetAxis("Horizontal"), 0f, Input.GetAxis("Vertical"));
		if (vector != Vector3.zero)
		{
			float magnitude = vector.magnitude;
			vector /= magnitude;
			magnitude = Mathf.Min(1f, magnitude);
			magnitude *= magnitude;
			vector *= magnitude;
		}
		motor.inputMoveDirection = transform.rotation * vector;
		motor.inputJump = Input.GetButton("Jump");
	}

	public virtual void Main()
	{
	}
}
