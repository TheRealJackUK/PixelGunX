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
		Network.Instantiate(SpaceCraft, transform.position, transform.rotation, 0);
		Debug.Log("Network.Instantiate");
	}

	public virtual void OnPlayerDisconnected(NetworkPlayer player)
	{
		Network.RemoveRPCs(player, 0);
		Network.DestroyPlayerObjects(player);
	}

	public virtual void OnNetworkInstantiate(NetworkMessageInfo info)
	{
		NetworkView[] array = (NetworkView[])GetComponents(typeof(NetworkView));
		Debug.Log("New prefab network instantiated with views - ");
		int i = 0;
		NetworkView[] array2 = array;
		for (int length = array2.Length; i < length; i++)
		{
			Debug.Log("- " + array2[i].viewID);
		}
	}

	public virtual void Main()
	{
	}
}
