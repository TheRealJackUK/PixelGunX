using UnityEngine;

public class RotationWeaponGameObject : MonoBehaviour
{
	public enum ConstraintAxis
	{
		X = 0,
		Y = 1,
		Z = 2,
	}

	public ConstraintAxis axis;
	public float min;
	public float max;
	public Transform playerGun;
	public Transform mechGun;
	public Player_move_c player_move_c;
}
