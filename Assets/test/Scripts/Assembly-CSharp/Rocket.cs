using UnityEngine;

public class Rocket : MonoBehaviour
{
	public string weaponName;
	public GameObject[] rockets;
	public WeaponSounds.TypeDead[] typeDead;
	public float damage;
	public float radiusDamage;
	public float radiusDamageSelf;
	public float radiusImpulse;
	public float multiplayerDamage;
	public Vector2 damageRange;
	public PhotonView photonView;
	public Transform target;
	public bool isRun;
	public Transform myTransform;
	public bool dontExecStart;
	public RocketSettings currentRocketSettings;
}
