using UnityEngine;

public class Initializer : MonoBehaviour
{
	public GameObject _purchaseActivityIndicator;
	public GameObject tc;
	public GameObject tempCam;
	public bool isDisconnect;
	public int countConnectToRoom;
	public float timerShowNotConnectToRoom;
	public UIButton buttonCancel;
	public UILabel descriptionLabel;
	public GUIStyle back;
	public bool isCancelReConnect;
	public bool isNotConnectRoom;
	public WeaponManager _weaponManager;
	public float timerShow;
	public Transform playerPrefab;
	public Texture fonLoadingScene;
	public string goMapName;
	public LoadingNGUIController _loadingNGUIController;
}
