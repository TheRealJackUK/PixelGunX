using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Boo.Lang;
using UnityEngine;

[Serializable]
[RequireComponent(typeof(CharacterController))]
[AddComponentMenu("Character/Character Motor")]
public class CharacterMotor : MonoBehaviour
{
	[Serializable]
	[CompilerGenerated]
	internal sealed class _0024SubtractNewPlatformVelocity_002459 : GenericGenerator<object>
	{
		[Serializable]
		[CompilerGenerated]
		internal sealed class _0024 : GenericGeneratorEnumerator<object>, IEnumerator
		{
			internal Transform _0024platform_002460;

			internal CharacterMotor _0024self__002461;

			public _0024(CharacterMotor self_)
			{
				_0024self__002461 = self_;
			}

			public override bool MoveNext()
			{
				int result;
				switch (_state)
				{
				default:
					if (_0024self__002461.movingPlatform.enabled && (_0024self__002461.movingPlatform.movementTransfer == MovementTransferOnJump.InitTransfer || _0024self__002461.movingPlatform.movementTransfer == MovementTransferOnJump.PermaTransfer))
					{
						if (_0024self__002461.movingPlatform.newPlatform)
						{
							_0024platform_002460 = _0024self__002461.movingPlatform.activePlatform;
							result = (Yield(2, new WaitForFixedUpdate()) ? 1 : 0);
							break;
						}
						goto case 4;
					}
					goto IL_0124;
				case 2:
					result = (Yield(3, new WaitForFixedUpdate()) ? 1 : 0);
					break;
				case 3:
					if (_0024self__002461.grounded && _0024platform_002460 == _0024self__002461.movingPlatform.activePlatform)
					{
						result = (Yield(4, 1) ? 1 : 0);
						break;
					}
					goto case 4;
				case 4:
					_0024self__002461.movement.velocity = _0024self__002461.movement.velocity - _0024self__002461.movingPlatform.platformVelocity;
					goto IL_0124;
				case 1:
					{
						result = 0;
						break;
					}
					IL_0124:
					YieldDefault(1);
					goto case 1;
				}
				return (byte)result != 0;
			}
		}

		internal CharacterMotor _0024self__002462;

		public _0024SubtractNewPlatformVelocity_002459(CharacterMotor self_)
		{
			_0024self__002462 = self_;
		}

		public override IEnumerator<object> GetEnumerator()
		{
			return new _0024(_0024self__002462);
		}
	}

	public bool canControl;

	public bool useFixedUpdate;

	[NonSerialized]
	public Vector3 inputMoveDirection;

	[NonSerialized]
	public bool inputJump;

	public CharacterMotorMovement movement;

	public CharacterMotorJumping jumping;

	public CharacterMotorMovingPlatform movingPlatform;

	public CharacterMotorSliding sliding;

	[NonSerialized]
	public bool grounded;

	[NonSerialized]
	public Vector3 groundNormal;

	private Vector3 lastGroundNormal;

	private Transform tr;

	private CharacterController controller;

	public CharacterMotor()
	{
		canControl = true;
		useFixedUpdate = true;
		inputMoveDirection = Vector3.zero;
		movement = new CharacterMotorMovement();
		jumping = new CharacterMotorJumping();
		movingPlatform = new CharacterMotorMovingPlatform();
		sliding = new CharacterMotorSliding();
		grounded = true;
		groundNormal = Vector3.zero;
		lastGroundNormal = Vector3.zero;
	}

	public virtual void Awake()
	{
		controller = (CharacterController)GetComponent(typeof(CharacterController));
		tr = transform;
	}

	private void UpdateFunction()
	{
		Vector3 velocity = movement.velocity;
		velocity = ApplyInputVelocityChange(velocity);
		velocity = ApplyGravityAndJumping(velocity);
		Vector3 zero = Vector3.zero;
		if (MoveWithPlatform())
		{
			Vector3 vector = movingPlatform.activePlatform.TransformPoint(movingPlatform.activeLocalPoint);
			zero = vector - movingPlatform.activeGlobalPoint;
			if (zero != Vector3.zero)
			{
				controller.Move(zero);
			}
			Quaternion quaternion = movingPlatform.activePlatform.rotation * movingPlatform.activeLocalRotation;
			float y = (quaternion * Quaternion.Inverse(movingPlatform.activeGlobalRotation)).eulerAngles.y;
			if (y != 0f)
			{
				tr.Rotate(0f, y, 0f);
			}
		}
		Vector3 position = tr.position;
		Vector3 motion = velocity * Time.deltaTime;
		float num = Mathf.Max(controller.stepOffset, new Vector3(motion.x, 0f, motion.z).magnitude);
		if (grounded)
		{
			motion -= num * Vector3.up;
		}
		movingPlatform.hitPlatform = null;
		groundNormal = Vector3.zero;
		movement.collisionFlags = controller.Move(motion);
		movement.lastHitPoint = movement.hitPoint;
		lastGroundNormal = groundNormal;
		if (movingPlatform.enabled && movingPlatform.activePlatform != movingPlatform.hitPlatform && movingPlatform.hitPlatform != null)
		{
			movingPlatform.activePlatform = movingPlatform.hitPlatform;
			movingPlatform.lastMatrix = movingPlatform.hitPlatform.localToWorldMatrix;
			movingPlatform.newPlatform = true;
		}
		Vector3 vector2 = new Vector3(velocity.x, 0f, velocity.z);
		movement.velocity = (tr.position - position) / Time.deltaTime;
		Vector3 lhs = new Vector3(movement.velocity.x, 0f, movement.velocity.z);
		if (vector2 == Vector3.zero)
		{
			movement.velocity = new Vector3(0f, movement.velocity.y, 0f);
		}
		else
		{
			float value = Vector3.Dot(lhs, vector2) / vector2.sqrMagnitude;
			movement.velocity = vector2 * Mathf.Clamp01(value) + movement.velocity.y * Vector3.up;
		}
		if (!(movement.velocity.y >= velocity.y - 0.001f))
		{
			if (!(movement.velocity.y >= 0f))
			{
				movement.velocity.y = velocity.y;
			}
			else
			{
				jumping.holdingJumpButton = false;
			}
		}
		if (grounded && !IsGroundedTest())
		{
			grounded = false;
			if (movingPlatform.enabled && (movingPlatform.movementTransfer == MovementTransferOnJump.InitTransfer || movingPlatform.movementTransfer == MovementTransferOnJump.PermaTransfer))
			{
				movement.frameVelocity = movingPlatform.platformVelocity;
				movement.velocity += movingPlatform.platformVelocity;
			}
			SendMessage("OnFall", SendMessageOptions.DontRequireReceiver);
			tr.position += num * Vector3.up;
		}
		else if (!grounded && IsGroundedTest())
		{
			grounded = true;
			jumping.jumping = false;
			StartCoroutine(SubtractNewPlatformVelocity());
			SendMessage("OnLand", SendMessageOptions.DontRequireReceiver);
		}
		if (MoveWithPlatform())
		{
			movingPlatform.activeGlobalPoint = tr.position + Vector3.up * (controller.center.y - controller.height * 0.5f + controller.radius);
			movingPlatform.activeLocalPoint = movingPlatform.activePlatform.InverseTransformPoint(movingPlatform.activeGlobalPoint);
			movingPlatform.activeGlobalRotation = tr.rotation;
			movingPlatform.activeLocalRotation = Quaternion.Inverse(movingPlatform.activePlatform.rotation) * movingPlatform.activeGlobalRotation;
		}
	}

	public virtual void FixedUpdate()
	{
		if (movingPlatform.enabled)
		{
			if (movingPlatform.activePlatform != null)
			{
				if (!movingPlatform.newPlatform)
				{
					Vector3 platformVelocity = movingPlatform.platformVelocity;
					movingPlatform.platformVelocity = (movingPlatform.activePlatform.localToWorldMatrix.MultiplyPoint3x4(movingPlatform.activeLocalPoint) - movingPlatform.lastMatrix.MultiplyPoint3x4(movingPlatform.activeLocalPoint)) / Time.deltaTime;
				}
				movingPlatform.lastMatrix = movingPlatform.activePlatform.localToWorldMatrix;
				movingPlatform.newPlatform = false;
			}
			else
			{
				movingPlatform.platformVelocity = Vector3.zero;
			}
		}
		if (useFixedUpdate)
		{
			UpdateFunction();
		}
	}

	public virtual void Update()
	{
		if (!useFixedUpdate)
		{
			UpdateFunction();
		}
	}

	private Vector3 ApplyInputVelocityChange(Vector3 velocity)
	{
		if (!canControl)
		{
			inputMoveDirection = Vector3.zero;
		}
		Vector3 vector = default(Vector3);
		if (grounded && TooSteep())
		{
			vector = new Vector3(groundNormal.x, 0f, groundNormal.z).normalized;
			Vector3 vector2 = Vector3.Project(inputMoveDirection, vector);
			vector = vector + vector2 * sliding.speedControl + (inputMoveDirection - vector2) * sliding.sidewaysControl;
			vector *= sliding.slidingSpeed;
		}
		else
		{
			vector = GetDesiredHorizontalVelocity();
		}
		if (movingPlatform.enabled && movingPlatform.movementTransfer == MovementTransferOnJump.PermaTransfer)
		{
			vector += movement.frameVelocity;
			vector.y = 0f;
		}
		if (grounded)
		{
			vector = AdjustGroundVelocityToNormal(vector, groundNormal);
		}
		else
		{
			velocity.y = 0f;
		}
		float num = GetMaxAcceleration(grounded) * Time.deltaTime;
		Vector3 vector3 = vector - velocity;
		if (!(vector3.sqrMagnitude <= num * num))
		{
			vector3 = vector3.normalized * num;
		}
		if (grounded || canControl)
		{
			velocity += vector3;
		}
		if (grounded)
		{
			velocity.y = Mathf.Min(velocity.y, 0f);
		}
		return velocity;
	}

	private Vector3 ApplyGravityAndJumping(Vector3 velocity)
	{
		if (!inputJump || !canControl)
		{
			jumping.holdingJumpButton = false;
			jumping.lastButtonDownTime = -100f;
		}
		if (inputJump && !(jumping.lastButtonDownTime >= 0f) && canControl)
		{
			jumping.lastButtonDownTime = Time.time;
		}
		if (grounded)
		{
			velocity.y = Mathf.Min(0f, velocity.y) - movement.gravity * Time.deltaTime;
		}
		else
		{
			velocity.y = movement.velocity.y - movement.gravity * Time.deltaTime;
			if (jumping.jumping && jumping.holdingJumpButton && !(Time.time >= jumping.lastStartTime + jumping.extraHeight / CalculateJumpVerticalSpeed(jumping.baseHeight)))
			{
				velocity += jumping.jumpDir * movement.gravity * Time.deltaTime;
			}
			velocity.y = Mathf.Max(velocity.y, 0f - movement.maxFallSpeed);
		}
		if (grounded)
		{
			if (jumping.enabled && canControl && !(Time.time - jumping.lastButtonDownTime >= 0.2f))
			{
				grounded = false;
				jumping.jumping = true;
				jumping.lastStartTime = Time.time;
				jumping.lastButtonDownTime = -100f;
				jumping.holdingJumpButton = true;
				if (TooSteep())
				{
					jumping.jumpDir = Vector3.Slerp(Vector3.up, groundNormal, jumping.steepPerpAmount);
				}
				else
				{
					jumping.jumpDir = Vector3.Slerp(Vector3.up, groundNormal, jumping.perpAmount);
				}
				velocity.y = 0f;
				velocity += jumping.jumpDir * CalculateJumpVerticalSpeed(jumping.baseHeight);
				if (movingPlatform.enabled && (movingPlatform.movementTransfer == MovementTransferOnJump.InitTransfer || movingPlatform.movementTransfer == MovementTransferOnJump.PermaTransfer))
				{
					movement.frameVelocity = movingPlatform.platformVelocity;
					velocity += movingPlatform.platformVelocity;
				}
				SendMessage("OnJump", SendMessageOptions.DontRequireReceiver);
			}
			else
			{
				jumping.holdingJumpButton = false;
			}
		}
		return velocity;
	}

	public virtual void OnControllerColliderHit(ControllerColliderHit hit)
	{
		if (!(hit.normal.y <= 0f) && !(hit.normal.y <= groundNormal.y) && !(hit.moveDirection.y >= 0f))
		{
			if ((hit.point - movement.lastHitPoint).sqrMagnitude > 0.001f || lastGroundNormal == Vector3.zero)
			{
				groundNormal = hit.normal;
			}
			else
			{
				groundNormal = lastGroundNormal;
			}
			movingPlatform.hitPlatform = hit.collider.transform;
			movement.hitPoint = hit.point;
			movement.frameVelocity = Vector3.zero;
		}
	}

	private IEnumerator SubtractNewPlatformVelocity()
	{
		return new _0024SubtractNewPlatformVelocity_002459(this).GetEnumerator();
	}

	private bool MoveWithPlatform()
	{
		bool num = movingPlatform.enabled;
		if (num)
		{
			num = grounded;
			if (!num)
			{
				num = movingPlatform.movementTransfer == MovementTransferOnJump.PermaLocked;
			}
		}
		if (num)
		{
			num = movingPlatform.activePlatform != null;
		}
		return num;
	}

	private Vector3 GetDesiredHorizontalVelocity()
	{
		Vector3 vector = tr.InverseTransformDirection(inputMoveDirection);
		float num = MaxSpeedInDirection(vector);
		if (grounded)
		{
			float time = Mathf.Asin(movement.velocity.normalized.y) * 57.29578f;
			num *= movement.slopeSpeedMultiplier.Evaluate(time);
		}
		return tr.TransformDirection(vector * num);
	}

	private Vector3 AdjustGroundVelocityToNormal(Vector3 hVelocity, Vector3 groundNormal)
	{
		Vector3 lhs = Vector3.Cross(Vector3.up, hVelocity);
		return Vector3.Cross(lhs, groundNormal).normalized * hVelocity.magnitude;
	}

	private bool IsGroundedTest()
	{
		return groundNormal.y > 0.01f;
	}

	public virtual float GetMaxAcceleration(bool grounded)
	{
		return (!grounded) ? movement.maxAirAcceleration : movement.maxGroundAcceleration;
	}

	public virtual float CalculateJumpVerticalSpeed(float targetJumpHeight)
	{
		return Mathf.Sqrt(2f * targetJumpHeight * movement.gravity);
	}

	public virtual bool IsJumping()
	{
		return jumping.jumping;
	}

	public virtual bool IsSliding()
	{
		bool num = grounded;
		if (num)
		{
			num = sliding.enabled;
		}
		if (num)
		{
			num = TooSteep();
		}
		return num;
	}

	public virtual bool IsTouchingCeiling()
	{
		return (movement.collisionFlags & CollisionFlags.Above) != 0;
	}

	public virtual bool IsGrounded()
	{
		return grounded;
	}

	public virtual bool TooSteep()
	{
		return !(groundNormal.y > Mathf.Cos(controller.slopeLimit * ((float)Math.PI / 180f)));
	}

	public virtual Vector3 GetDirection()
	{
		return inputMoveDirection;
	}

	public virtual void SetControllable(bool controllable)
	{
		canControl = controllable;
	}

	public virtual float MaxSpeedInDirection(Vector3 desiredMovementDirection)
	{
		float result;
		if (desiredMovementDirection == Vector3.zero)
		{
			result = 0f;
		}
		else
		{
			float num = ((desiredMovementDirection.z <= 0f) ? movement.maxBackwardsSpeed : movement.maxForwardSpeed) / movement.maxSidewaysSpeed;
			Vector3 normalized = new Vector3(desiredMovementDirection.x, 0f, desiredMovementDirection.z / num).normalized;
			float num2 = new Vector3(normalized.x, 0f, normalized.z * num).magnitude * movement.maxSidewaysSpeed;
			result = num2;
		}
		return result;
	}

	public virtual void SetVelocity(Vector3 velocity)
	{
		grounded = false;
		movement.velocity = velocity;
		movement.frameVelocity = Vector3.zero;
		SendMessage("OnExternalVelocity");
	}

	public virtual void Main()
	{
	}
}
