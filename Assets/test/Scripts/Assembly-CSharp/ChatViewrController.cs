using UnityEngine;

public class ChatViewrController : MonoBehaviour
{
	public GameObject PlayerObject;
	public GameObject[] labelChat;
	public int maxChars;
	public WeaponManager _weaponManager;
	public GameObject holdButton;
	public GameObject holdButtonOn;
	public AudioClip sendChatClip;
	public bool isClanMode;
	public UIWidget enterMessageController;
	public UIInput enterMessageInput;
	public GameObject chatLabelsHolder;
	public BattleChat battleChat;
}
