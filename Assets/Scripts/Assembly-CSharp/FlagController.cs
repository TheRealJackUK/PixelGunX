using UnityEngine;


public class FlagController : MonoBehaviour
{
	public bool isBlue;

	public int masterServerID;

	private PhotonView photonView;

	public bool isCapture;

	private int idCapturePlayer;

	public bool isBaza;

	private GameObject myBaza;

	public GameObject ray;

	public float timerToBaza = 10f;

	private float maxTimerToBaza = 10f;

	public GameObject flagModel;

	public Transform targetTrasform;

	private InGameGUI inGameGui;

	public GameObject pointObjTexture;

	private GameObject _objBazaTexture;

	private GameObject _objFlagTexture;

	private void Awake()
	{
		GameObject original;
		if (isBlue)
		{
			myBaza = GameObject.FindGameObjectWithTag("BazaZoneCommand1");
			original = Resources.Load("BluePedestal") as GameObject;
		}
		else
		{
			myBaza = GameObject.FindGameObjectWithTag("BazaZoneCommand2");
			original = Resources.Load("RedPedestal") as GameObject;
		}
		GameObject gameObject = Object.Instantiate(original, myBaza.transform.position, myBaza.transform.rotation) as GameObject;
		_objBazaTexture = Object.Instantiate(Resources.Load("ObjectPictFlag") as GameObject, myBaza.transform.position, myBaza.transform.rotation) as GameObject;
		_objFlagTexture = Object.Instantiate(Resources.Load("ObjectPictFlag") as GameObject, myBaza.transform.position, myBaza.transform.rotation) as GameObject;
		_objBazaTexture.GetComponent<ObjectPictFlag>().target = gameObject.transform.GetChild(0);
		_objBazaTexture.GetComponent<ObjectPictFlag>().SetTexture(Resources.Load((!isBlue) ? "red_base" : "blue_base") as Texture2D);
		_objBazaTexture.GetComponent<ObjectPictFlag>().isBaza = true;
		_objBazaTexture.GetComponent<ObjectPictFlag>().myFlagController = this;
		_objFlagTexture.GetComponent<ObjectPictFlag>().target = pointObjTexture.transform;
		_objFlagTexture.GetComponent<ObjectPictFlag>().SetTexture(Resources.Load((!isBlue) ? "red_flag" : "blue_flag") as Texture2D);
	}

	private void Start()
	{
		photonView = GetComponent<PhotonView>();
		photonView.RPC("SetMasterSeverIDRPC", PhotonTargets.AllBuffered, photonView.viewID);
	}

	private void Update()
	{
		if (inGameGui == null && GameObject.FindGameObjectWithTag("InGameGUI") != null)
		{
			inGameGui = GameObject.FindGameObjectWithTag("InGameGUI").GetComponent<InGameGUI>();
		}
		if (ray.activeInHierarchy == isCapture)
		{
			ray.SetActive(!isCapture);
		}
		if (targetTrasform != null)
		{
			base.transform.position = targetTrasform.position;
			base.transform.rotation = targetTrasform.rotation;
		}
		else
		{
			isCapture = false;
		}
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		int num = 0;
		int num2 = 0;
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (gameObject != null && gameObject.GetComponent<SkinName>().playerMoveC != null)
			{
				int myCommand = gameObject.GetComponent<SkinName>().playerMoveC.myCommand;
				if (myCommand == 1)
				{
					num++;
				}
				if (myCommand == 2)
				{
					num2++;
				}
			}
		}
		if ((num == 0 || num2 == 0) && flagModel.activeSelf)
		{
			flagModel.SetActive(false);
		}
		if (inGameGui != null && (num == 0 || num2 == 0) && !inGameGui.message_wait.activeSelf)
		{
			inGameGui.message_wait.SetActive(true);
			inGameGui.timerShowNow = 0f;
		}
		if (inGameGui != null && num != 0 && num2 != 0 && inGameGui.message_wait.activeSelf)
		{
			inGameGui.message_wait.SetActive(false);
			inGameGui.timerShowNow = 3f;
		}
		if (num != 0 && num2 != 0 && !flagModel.activeSelf)
		{
			flagModel.SetActive(true);
		}
		if ((num == 0 || num2 == 0) && isCapture)
		{
			GameObject[] array3 = array;
			foreach (GameObject gameObject2 in array3)
			{
				if (idCapturePlayer == gameObject2.GetComponent<PhotonView>().ownerId)
				{
					gameObject2.GetComponent<SkinName>().playerMoveC.isCaptureFlag = false;
				}
				GoBaza();
			}
		}
		if (!PhotonNetwork.isMasterClient || isCapture || isBaza)
		{
			return;
		}
		timerToBaza -= Time.deltaTime;
		if (timerToBaza < 0f)
		{
			GoBaza();
			if (WeaponManager.sharedManager.myPlayer != null)
			{
				WeaponManager.sharedManager.myPlayerMoveC.SendSystemMessegeFromFlagReturned(isBlue);
			}
		}
	}

	public void GoBaza()
	{
		timerToBaza = maxTimerToBaza;
		photonView.RPC("GoBazaRPC", PhotonTargets.All);
	}

	[PunRPC]
	public void GoBazaRPC()
	{
		Debug.Log("GoBazaRPC");
		isBaza = true;
		isCapture = false;
		idCapturePlayer = -1;
		targetTrasform = null;
		base.transform.position = myBaza.transform.position;
		base.transform.rotation = myBaza.transform.rotation;
	}

	public void SetCapture(int _viewIdCapture)
	{
		photonView.RPC("SetCaptureRPC", PhotonTargets.All, _viewIdCapture);
	}

	[PunRPC]
	public void SetCaptureRPC(int _viewIdCapture)
	{
		isBaza = false;
		idCapturePlayer = _viewIdCapture;
		isCapture = true;
		GameObject[] array = GameObject.FindGameObjectsWithTag("Player");
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (gameObject.GetComponent<PhotonView>().ownerId == _viewIdCapture)
			{
				targetTrasform = gameObject.GetComponent<SkinName>().playerMoveC.flagPoint.transform;
				gameObject.GetComponent<SkinName>().playerMoveC.isCaptureFlag = true;
			}
		}
	}

	public void SetNOCapture(Vector3 pos, Quaternion rot)
	{
		photonView.RPC("SetNOCaptureRPC", PhotonTargets.All, pos, rot);
		timerToBaza = maxTimerToBaza;
	}

	[PunRPC]
	public void SetNOCaptureRPC(Vector3 pos, Quaternion rot)
	{
		isCapture = false;
		idCapturePlayer = -1;
		if (targetTrasform != null)
		{
			targetTrasform.parent.GetComponent<SkinName>().playerMoveC.isCaptureFlag = false;
		}
		targetTrasform = null;
	}

	[PunRPC]
	public void SetNOCaptureRPCNewPlayer(int idNewPlayer, Vector3 pos, Quaternion rot, bool _isBaza)
	{
		if (photonView == null)
		{
			photonView = GetComponent<PhotonView>();
		}
		if (photonView != null && photonView.ownerId == idNewPlayer)
		{
			isBaza = _isBaza;
			SetNOCaptureRPC(pos, rot);
		}
	}

	[PunRPC]
	public void SetCaptureRPCNewPlayer(int idNewPlayer, int _viewIdCapture)
	{
		if (photonView == null)
		{
			photonView = GetComponent<PhotonView>();
		}
		if (PhotonNetwork.player.ID == idNewPlayer)
		{
			SetCaptureRPC(_viewIdCapture);
		}
	}

	[PunRPC]
	public void SetMasterSeverIDRPC(int _id)
	{
		masterServerID = _id;
	}

	public void OnPhotonPlayerConnected(PhotonPlayer player)
	{
		if (photonView == null)
		{
			Debug.Log("FlagController.OnPhotonPlayerConnected():    photonView == null");
		}
		else if (isCapture)
		{
			photonView.RPC("SetCaptureRPCNewPlayer", PhotonTargets.All, player.ID, idCapturePlayer);
		}
		else
		{
			photonView.RPC("SetNOCaptureRPCNewPlayer", PhotonTargets.All, player.ID, base.transform.position, base.transform.rotation, isBaza);
		}
	}

	private void OnDestroy()
	{
		Object.Destroy(_objBazaTexture);
		Object.Destroy(_objFlagTexture);
	}
}
