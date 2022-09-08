using UnityEngine;

public class ObjectLabel : MonoBehaviour
{
	public Transform target;
	public Vector3 offset;
	public bool clampToScreen;
	public float clampBorderSize;
	public bool useMainCamera;
	public Camera cameraToUse;
	public Camera cam;
	public float timeShow;
	public Vector3 posLabel;
	public bool isShow;
	public bool isMenu;
	public bool isShadow;
	public WeaponManager _weaponManager;
	public GUITexture clanTexture;
	public GUIText clanName;
}
