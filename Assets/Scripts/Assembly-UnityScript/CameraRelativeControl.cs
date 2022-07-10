using System;
using UnityEngine;

[Serializable]
[RequireComponent(typeof(CharacterController))]
public class CameraRelativeControl : MonoBehaviour
{
	public Joystick moveJoystick;

	public Joystick rotateJoystick;

	public Transform cameraPivot;

	public Transform cameraTransform;

	public float speed;

	public float jumpSpeed;

	public float inAirMultiplier;

	public Vector2 rotationSpeed;

	private Transform thisTransform;

	private CharacterController character;

	private Vector3 velocity;

	private bool canJump;

	public CameraRelativeControl()
	{
		speed = 5f;
		jumpSpeed = 8f;
		inAirMultiplier = 0.25f;
		rotationSpeed = new Vector2(50f, 25f);
		canJump = true;
	}

	public virtual void Start()
	{
		thisTransform = (Transform)GetComponent(typeof(Transform));
		character = (CharacterController)GetComponent(typeof(CharacterController));
		GameObject gameObject = GameObject.Find("PlayerSpawn");
		if ((bool)gameObject)
		{
			thisTransform.position = gameObject.transform.position;
		}
	}

	public virtual void FaceMovementDirection()
	{
		Vector3 vector = character.velocity;
		vector.y = 0f;
		if (!(vector.magnitude <= 0.1f))
		{
			thisTransform.forward = vector.normalized;
		}
	}

	public virtual void OnEndGame()
	{
		moveJoystick.Disable();
		rotateJoystick.Disable();
		enabled = false;
	}

	public virtual void Update()
	{
		Vector3 motion = cameraTransform.TransformDirection(new Vector3(moveJoystick.position.x, 0f, moveJoystick.position.y));
		motion.y = 0f;
		motion.Normalize();
		Vector2 vector = new Vector2(Mathf.Abs(moveJoystick.position.x), Mathf.Abs(moveJoystick.position.y));
		motion *= speed * ((vector.x <= vector.y) ? vector.y : vector.x);
		if (character.isGrounded)
		{
			if (!rotateJoystick.IsFingerDown())
			{
				canJump = true;
			}
			if (canJump && rotateJoystick.tapCount == 2)
			{
				velocity = character.velocity;
				velocity.y = jumpSpeed;
				canJump = false;
			}
		}
		else
		{
			velocity.y += Physics.gravity.y * Time.deltaTime;
			motion.x *= inAirMultiplier;
			motion.z *= inAirMultiplier;
		}
		motion += velocity;
		motion += Physics.gravity;
		motion *= Time.deltaTime;
		character.Move(motion);
		if (character.isGrounded)
		{
			velocity = Vector3.zero;
		}
		FaceMovementDirection();
		Vector2 position = rotateJoystick.position;
		position.x *= rotationSpeed.x;
		position.y *= rotationSpeed.y;
		position *= Time.deltaTime;
		cameraPivot.Rotate(0f, position.x, 0f, Space.World);
		cameraPivot.Rotate(position.y, 0f, 0f);
	}

	public virtual void Main()
	{
	}
}
