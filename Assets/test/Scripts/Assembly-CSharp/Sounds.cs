using UnityEngine;

public class Sounds : MonoBehaviour
{
	public AudioClip hurt;
	public AudioClip voice;
	public AudioClip bite;
	public AudioClip death;
	public float notAttackingSpeed;
	public float attackingSpeed;
	public float health;
	public float attackDistance;
	public float timeToHit;
	public float detectRadius;
	public int damagePerHit;
	public int scorePerKill;
	public float[] attackingSpeedRandomRange;
}
