using System;
using UnityEngine;

internal sealed class ZombiManagerSynch : MonoBehaviour
{
	private ThirdPersonCamera cameraScript;

	private ThirdPersonController controllerScript;

	private Vector3 correctPlayerPos = Vector3.zero;

	private Quaternion correctPlayerRot = Quaternion.identity;

	private void Awake()
	{
		//Discarded unreachable code: IL_0033
		try
		{
			if (!Defs.isMulti || !Defs.isInet)
			{
				base.enabled = false;
			}
		}
		catch (Exception exception)
		{
			Debug.LogError("Cooperative mode failure.");
			Debug.LogException(exception);
			throw;
		}
	}

	private void OnPhotonSerializeView(PhotonStream stream, PhotonMessageInfo info)
	{
		if (stream.isWriting)
		{
			stream.SendNext(base.transform.position);
		}
		else
		{
			correctPlayerPos = (Vector3)stream.ReceiveNext();
		}
	}
}
