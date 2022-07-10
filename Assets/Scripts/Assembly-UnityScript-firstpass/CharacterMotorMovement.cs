using System;
using UnityEngine;

[Serializable]
public class CharacterMotorMovement
{
	public float maxForwardSpeed;

	public float maxSidewaysSpeed;

	public float maxBackwardsSpeed;

	public AnimationCurve slopeSpeedMultiplier;

	public float maxGroundAcceleration;

	public float maxAirAcceleration;

	public float gravity;

	public float maxFallSpeed;

	[NonSerialized]
	public CollisionFlags collisionFlags;

	[NonSerialized]
	public Vector3 velocity;

	[NonSerialized]
	public Vector3 frameVelocity;

	[NonSerialized]
	public Vector3 hitPoint;

	[NonSerialized]
	public Vector3 lastHitPoint;

	public CharacterMotorMovement()
	{
		maxForwardSpeed = 10f;
		maxSidewaysSpeed = 10f;
		maxBackwardsSpeed = 10f;
		slopeSpeedMultiplier = new AnimationCurve(new Keyframe(-90f, 1f), new Keyframe(0f, 1f), new Keyframe(90f, 0f));
		maxGroundAcceleration = 30f;
		maxAirAcceleration = 20f;
		gravity = 10f;
		maxFallSpeed = 20f;
		frameVelocity = Vector3.zero;
		hitPoint = Vector3.zero;
		lastHitPoint = new Vector3(float.PositiveInfinity, 0f, 0f);
	}
}
