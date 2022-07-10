using System;
using System.Reflection;
using ExitGames.Client.Photon;
using UnityEngine;

public class TimeGameController : MonoBehaviour
{
	public static TimeGameController sharedController;

	public double timeEndMatch;

	public double timerToEndMatch;

	public double networkTime;

	public PhotonView photonView;

	public double timeLocalServer;

	public string ipServera;

	public bool isEndMatch = true;

	private void Awake()
	{
		if (!Defs.isMulti || Defs.isHunger)
		{
			base.enabled = false;
		}
	}

	private void Start()
	{
		sharedController = this;
		if (Defs.isMulti && !Defs.isInet && Network.isServer)
		{
			InvokeRepeating("SinchServerTimeInvoke", 0.1f, 2f);
			Debug.Log("TimeGameController: Start synch server time");
		}
	}

	[Obfuscation(Exclude = true)]
	public void SinchServerTimeInvoke()
	{
		base.GetComponent<NetworkView>().RPC("SynchTimeServer", RPCMode.Others, (float)Network.time);
	}

	public void StartMatch()
	{
		bool flag = false;
		if (Defs.isCapturePoints || Defs.isFlag)
		{
			double num = Convert.ToDouble(PhotonNetwork.room.customProperties["TimeMatchEnd"]);
			if (num < -5000000.0)
			{
				flag = true;
			}
		}
		if (Defs.isInet && ((timeEndMatch < PhotonNetwork.time && !Defs.isFlag) || GameObject.FindGameObjectsWithTag("Player").Length == 0 || ((Defs.isFlag || Defs.isCapturePoints) && flag)))
		{
			Hashtable hashtable = new Hashtable();
			double num2 = PhotonNetwork.time + (double)(((!Defs.isCOOP) ? ((int)PhotonNetwork.room.customProperties["MaxKill"]) : 4) * 60);
			if (num2 > 4294967.0 && PhotonNetwork.time < 4294967.0)
			{
				num2 = 4294967.0;
			}
			hashtable["TimeMatchEnd"] = num2;
			PhotonNetwork.room.SetCustomProperties(hashtable);
		}
		if (!Defs.isInet && (timeEndMatch < networkTime || GameObject.FindGameObjectsWithTag("Player").Length == 0))
		{
			timeEndMatch = networkTime + (double)((PlayerPrefs.GetString("MaxKill", "9").Equals(string.Empty) ? 5 : int.Parse(PlayerPrefs.GetString("MaxKill", "5"))) * 60);
			base.GetComponent<NetworkView>().RPC("SynchTimeEnd", RPCMode.Others, (float)timeEndMatch);
		}
	}

	private void Update()
	{
		ipServera = PhotonNetwork.ServerAddress;
		if (Defs.isInet && PhotonNetwork.room != null && PhotonNetwork.room.customProperties["TimeMatchEnd"] != null)
		{
			networkTime = PhotonNetwork.time;
			if (networkTime < 0.1)
			{
				return;
			}
			timeEndMatch = Convert.ToDouble(PhotonNetwork.room.customProperties["TimeMatchEnd"]);
			if (timeEndMatch > 4290000.0 && networkTime < 2000000.0)
			{
				Hashtable hashtable = new Hashtable();
				double num = networkTime + 60.0;
				hashtable["TimeMatchEnd"] = num;
				PhotonNetwork.room.SetCustomProperties(hashtable);
			}
			if (timeEndMatch > 0.0)
			{
				timerToEndMatch = timeEndMatch - networkTime;
			}
			else
			{
				timerToEndMatch = -1.0;
			}
		}
		if (!Defs.isInet)
		{
			if (Network.isServer)
			{
				networkTime = Network.time;
			}
			else
			{
				networkTime += Time.deltaTime;
			}
			timerToEndMatch = timeEndMatch - networkTime;
		}
		if (timerToEndMatch < 0.0 && !Defs.isFlag)
		{
			if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints)
			{
				if (CapturePointController.sharedController != null && !isEndMatch)
				{
					CapturePointController.sharedController.EndMatch();
					isEndMatch = true;
				}
			}
			else if (WeaponManager.sharedManager.myPlayer != null)
			{
				WeaponManager.sharedManager.myPlayerMoveC.WinFromTimer();
			}
			else
			{
				GlobalGameController.countKillsRed = 0;
				GlobalGameController.countKillsBlue = 0;
			}
		}
		else
		{
			isEndMatch = false;
		}
	}

	private void OnPlayerConnected(NetworkPlayer player)
	{
		if (Network.isServer)
		{
			base.GetComponent<NetworkView>().RPC("SynchTimeEnd", RPCMode.Others, (float)timeEndMatch);
			base.GetComponent<NetworkView>().RPC("SynchTimeServer", RPCMode.Others, (float)Network.time);
		}
	}

	public void OnPhotonPlayerConnected(PhotonPlayer player)
	{
	}

	[RPC]
	private void SynchTimeEnd(float synchTime)
	{
		timeEndMatch = synchTime;
	}

	[RPC]
	private void SynchTimeServer(float synchTime)
	{
		if (networkTime < (double)synchTime)
		{
			networkTime = synchTime;
		}
	}

	private void OnDestroy()
	{
		sharedController = null;
	}
}
