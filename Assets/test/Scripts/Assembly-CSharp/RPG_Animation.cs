using UnityEngine;

public class RPG_Animation : MonoBehaviour
{
	public enum CharacterMoveDirection
	{
		None = 0,
		Forward = 1,
		Backward = 2,
		StrafeLeft = 3,
		StrafeRight = 4,
		StrafeForwardLeft = 5,
		StrafeForwardRight = 6,
		StrafeBackLeft = 7,
		StrafeBackRight = 8,
	}

	public enum CharacterState
	{
		Idle = 0,
		Walk = 1,
		WalkBack = 2,
		StrafeLeft = 3,
		StrafeRight = 4,
		Jump = 5,
	}

	public CharacterMoveDirection currentMoveDir;
	public CharacterState currentState;
}
