using System;
using UnityEngine;
using ExitGames.Client.Photon;
using System.Collections.Generic;

[Serializable]
public class ServerSettings : ScriptableObject
{
	public enum HostingOption
	{
		NotSet = 0,
		PhotonCloud = 1,
		SelfHosted = 2,
		OfflineMode = 3,
		BestRegion = 4,
	}

	public HostingOption HostType;
	public ConnectionProtocol Protocol;
	public string ServerAddress;
	public int ServerPort;
	public CloudRegionCode PreferredRegion;
	public string AppID;
	public bool PingCloudServersOnAwake;
	public List<string> RpcList;
	public bool bool_0;
}
