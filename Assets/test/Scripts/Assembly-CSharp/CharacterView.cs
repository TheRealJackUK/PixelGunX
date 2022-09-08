using UnityEngine;

public class CharacterView : MonoBehaviour
{
	public Transform character;
	public Transform mech;
	public SkinnedMeshRenderer mechBodyRenderer;
	public SkinnedMeshRenderer mechHandRenderer;
	public SkinnedMeshRenderer mechGunRenderer;
	public Material[] mechGunMaterials;
	public Material[] mechBodyMaterials;
	public Transform turret;
	public Transform hatPoint;
	public Transform capePoint;
	public Transform bootsPoint;
	public Transform armorPoint;
	public Transform body;
}
