using UnityEngine;

public class SkinName : MonoBehaviour
{
	public GameObject playerGameObject;
	public Player_move_c playerMoveC;
	public string skinName;
	public GameObject hatsPoint;
	public GameObject capesPoint;
	public GameObject bootsPoint;
	public GameObject armorPoint;
	public string NickName;
	public GameObject camPlayer;
	public GameObject headObj;
	public GameObject bodyLayer;
	public CharacterController character;
	public PhotonView photonView;
	public int typeAnim;
	public WeaponManager _weaponManager;
	public bool isInet;
	public bool isLocal;
	public bool isMine;
	public bool isMulti;
	public AudioClip walkAudio;
	public AudioClip jumpAudio;
	public AudioClip jumpDownAudio;
	public bool isPlayDownSound;
	public GameObject FPSplayerObject;
	public ThirdPersonNetwork1 interpolateScript;
}
