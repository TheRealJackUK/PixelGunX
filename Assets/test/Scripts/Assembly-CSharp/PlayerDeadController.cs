using UnityEngine;

public class PlayerDeadController : MonoBehaviour
{
	public bool isUseMine;
	public Animation myAnimation;
	public GameObject[] playerDeads;
	public DeadEnergyController deadEnergyController;
	public DeadExplosionController deadExplosionController;
}
