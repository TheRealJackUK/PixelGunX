using UnityEngine;
using ZeichenKraftwerk;

public class TurretController : MonoBehaviour
{
	public SkinnedMeshRenderer turretRenderer;
	public SkinnedMeshRenderer turretExplosionRenderer;
	public Rotator rotator;
	public Material[] turretRunMaterials;
	public GameObject hitObj;
	public GameObject killedParticle;
	public GameObject explosionAnimObj;
	public GameObject turretObj;
	public float damage;
	public float[] damageMultyByTier;
	public float[] healthMultyByTier;
	public Transform tower;
	public Transform gun;
	public AudioClip shotClip;
	public ParticleSystem gunFlash1;
	public ParticleSystem gunFlash2;
	public float health;
	public float maxHealth;
	public bool isRunAvailable;
	public bool isRun;
	public GameObject myPlayer;
	public Transform myTransform;
	public PhotonView photonView;
	public Transform spherePoint;
	public Transform rayGroundPoint;
	public BoxCollider myCollider;
	public Transform target;
	public GameObject isEnemySprite;
	public Transform shotPoint;
	public Transform shotPoint2;
	public bool isKilled;
	public bool isEnemyTurret;
	public int myCommand;
	public NickLabelController myLabel;
	public bool dontExecStart;
	public Transform targerI;
	public Transform hitGameobj;
}
