using System;
using UnityEngine;

[Serializable]
public class Instantiate : MonoBehaviour
{
	public GameObject SpaceCraft;

	public virtual void Start()
	{
	}

	public virtual void Update()
	{
	}

	public virtual void OnNetworkLoadedLevel()
	{
		PhotonNetwork.Instantiate("SpaceCraft", transform.position, transform.rotation, 0);
		Debug.Log("Network.Instantiate");
	}

	public virtual void OnPlayerDisconnected(PhotonPlayer player)
	{
		PhotonNetwork.RemoveRPCs(player);
		PhotonNetwork.DestroyPlayerObjects(player);
	}

	public virtual void OnNetworkInstantiate(PhotonMessageInfo info)
	{
		PhotonView[] array = (PhotonView[])GetComponents(typeof(PhotonView));
		Debug.Log("New prefab network instantiated with views - ");
		int i = 0;
		PhotonView[] array2 = array;
		for (int length = array2.Length; i < length; i++)
		{
			Debug.Log("- " + array2[i].viewID);
		}
	}

	public virtual void Main()
	{
	}
}
