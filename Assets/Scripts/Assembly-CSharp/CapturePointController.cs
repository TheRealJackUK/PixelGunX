using ExitGames.Client.Photon;
using UnityEngine;

public class CapturePointController : MonoBehaviour
{
	public static CapturePointController sharedController;

	public PhotonView photonView;

	public float scoreBlue;

	public float scoreRed;

	private float speedScoreAdd = 3f;

	private float maxScoreCommands = 1000f;

	private bool isStartUpdateFromMasterClient;

	private float periodToSynch = 1f;

	private float timerToSynch;

	public BasePointController[] basePointControllers;

	private Transform myTransform;

	private void Start()
	{
		if (!Defs.isCapturePoints || !Defs.isMulti)
		{
			Object.Destroy(base.gameObject);
			return;
		}
		if (PhotonNetwork.room != null)
		{
			int num = (int)PhotonNetwork.room.customProperties["MaxKill"];
			if (num == 3)
			{
				speedScoreAdd = 3f;
			}
			if (num == 5)
			{
				speedScoreAdd = 2f;
			}
			if (num == 7)
			{
				speedScoreAdd = 1.5f;
			}
		}
		sharedController = this;
		myTransform = base.transform;
		basePointControllers = new BasePointController[myTransform.childCount];
		for (int i = 0; i < myTransform.childCount; i++)
		{
			basePointControllers[i] = myTransform.GetChild(i).GetComponent<BasePointController>();
		}
	}

	private void Update()
	{
		if (isStartUpdateFromMasterClient && !PhotonNetwork.connected)
		{
			isStartUpdateFromMasterClient = false;
		}
		if (Initializer.bluePlayers.Count == 0 || Initializer.redPlayers.Count == 0)
		{
			if (InGameGUI.sharedInGameGUI != null && !InGameGUI.sharedInGameGUI.message_wait.activeSelf)
			{
				InGameGUI.sharedInGameGUI.message_wait.SetActive(true);
			}
			for (int i = 0; i < basePointControllers.Length; i++)
			{
				basePointControllers[i].isBaseActive = false;
				if (basePointControllers[i].baseRender != null && basePointControllers[i].baseRender.activeSelf)
				{
					basePointControllers[i].baseRender.SetActive(false);
				}
			}
			return;
		}
		if (InGameGUI.sharedInGameGUI != null && InGameGUI.sharedInGameGUI.message_wait.activeSelf)
		{
			InGameGUI.sharedInGameGUI.message_wait.SetActive(false);
		}
		for (int j = 0; j < basePointControllers.Length; j++)
		{
			basePointControllers[j].isBaseActive = true;
			if (basePointControllers[j].baseRender != null && !basePointControllers[j].baseRender.activeSelf)
			{
				basePointControllers[j].baseRender.SetActive(true);
			}
		}
		int num = 0;
		int num2 = 0;
		for (int k = 0; k < basePointControllers.Length; k++)
		{
			if (basePointControllers[k].captureConmmand == BasePointController.TypeCapture.blue)
			{
				num++;
			}
			if (basePointControllers[k].captureConmmand == BasePointController.TypeCapture.red)
			{
				num2++;
			}
		}
		scoreBlue += Time.deltaTime * speedScoreAdd * (float)num;
		scoreRed += Time.deltaTime * speedScoreAdd * (float)num2;
		if (scoreBlue > maxScoreCommands)
		{
			scoreBlue = maxScoreCommands;
			EndMatch();
		}
		if (scoreRed > maxScoreCommands)
		{
			scoreRed = maxScoreCommands;
			EndMatch();
		}
		if (PhotonNetwork.isMasterClient)
		{
			timerToSynch -= Time.deltaTime;
			if (timerToSynch <= 0f)
			{
				timerToSynch = periodToSynch;
				photonView.RPC("SynchScoresCommandsRPC", PhotonTargets.All, scoreBlue, scoreRed);
			}
		}
	}

	public void OnPhotonPlayerConnected(PhotonPlayer player)
	{
		photonView.RPC("SynchScoresCommandsNewPlayerRPC", PhotonTargets.Others, player.ID, PhotonNetwork.isMasterClient, scoreBlue, scoreRed);
	}

	[PunRPC]
	public void SynchScoresCommandsNewPlayerRPC(int _viewId, bool isMaster, float _scoreBlue, float _scoreRed)
	{
		if (!isStartUpdateFromMasterClient && PhotonNetwork.player.ID == _viewId)
		{
			SynchScoresCommandsRPC(_scoreBlue, _scoreRed);
			isStartUpdateFromMasterClient = isMaster;
		}
	}

	[PunRPC]
	public void SynchScoresCommandsRPC(float _scoreBlue, float _scoreRed)
	{
		scoreBlue = _scoreBlue;
		scoreRed = _scoreRed;
	}

	public void EndMatch()
	{
		Debug.Log("EndMatch");
		TimeGameController.sharedController.isEndMatch = true;
		Hashtable hashtable = new Hashtable();
		hashtable["TimeMatchEnd"] = -9000000.0;
		PhotonNetwork.room.SetCustomProperties(hashtable);
		int commandWin = 0;
		if (scoreBlue > scoreRed)
		{
			commandWin = 1;
		}
		if (scoreRed > scoreBlue)
		{
			commandWin = 2;
		}
		if (WeaponManager.sharedManager.myTable != null)
		{
			WeaponManager.sharedManager.myNetworkStartTable.win(string.Empty, commandWin, Mathf.RoundToInt(scoreBlue), Mathf.RoundToInt(scoreRed));
		}
		scoreRed = 0f;
		scoreBlue = 0f;
		for (int i = 0; i < basePointControllers.Length; i++)
		{
			basePointControllers[i].OnEndMatch();
		}
	}

	private void OnDestroy()
	{
		sharedController = null;
	}
}
