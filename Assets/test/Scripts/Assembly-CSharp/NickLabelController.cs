using UnityEngine;

public class NickLabelController : MonoBehaviour
{
	public GameObject nickObj;
	public GameObject isEnemySprite;
	public GameObject placeMarker;
	public Camera _currentCamera;
	public Transform target;
	public Player_move_c playerScript;
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
	public UITexture clanTexture;
	public UILabel clanName;
	public GameObject healthObj;
	public UISprite healthSprite;
	public UISprite multyKill;
	public float timerShowMyltyKill;
	public float maxTimerShowMultyKill;
	public UILabel nickLabel;
	public Color nickColor;
	public UITexture rankTexture;
	public bool isVisible;
	public UILabel freeAwardTitle;
	public bool inShop;
	public bool isUse;
	public bool isSetInfo;
	public LobbyUserInfoController userInfoController;
	public UISprite adminIcon;
	public bool isAdmin;
	public bool isTurrerLabel;
	public float minScale;
	public float minDist;
	public float maxDist;
}
