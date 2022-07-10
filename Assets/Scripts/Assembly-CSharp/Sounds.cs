using UnityEngine;

public class Sounds : MonoBehaviour
{
	public AudioClip hurt;

	public AudioClip voice;

	public AudioClip bite;

	public AudioClip death;

	public float notAttackingSpeed = 1f;

	public float attackingSpeed = 1f;

	public float health = 100f;

	public float attackDistance = 3f;

	public float timeToHit = 2f;

	public float detectRadius = 17f;

	public int damagePerHit = 1;

	public int scorePerKill = 50;

	public float[] attackingSpeedRandomRange = new float[2] { -0.5f, 0.5f };
}
