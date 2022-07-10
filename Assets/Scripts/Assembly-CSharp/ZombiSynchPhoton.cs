using System;
using UnityEngine;

internal sealed class ZombiSynchPhoton : MonoBehaviour
{
	private ThirdPersonCamera cameraScript;

	private ThirdPersonController controllerScript;

	private PhotonView photonView;

	public int сountUpdate;

	private Vector3 correctPlayerPos = Vector3.zero;

	private Quaternion correctPlayerRot = Quaternion.identity;

	private Transform myTransform;

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

	private void Start()
	{
		//Discarded unreachable code: IL_0052
		try
		{
			myTransform = base.transform;
			photonView = PhotonView.Get(this);
			correctPlayerPos = myTransform.position;
			correctPlayerRot = myTransform.rotation;
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
			stream.SendNext(myTransform.position);
			stream.SendNext(myTransform.rotation);
		}
		else
		{
			correctPlayerPos = (Vector3)stream.ReceiveNext();
			correctPlayerRot = (Quaternion)stream.ReceiveNext();
		}
	}

	private void Update()
	{
		//Discarded unreachable code: IL_009b
		try
		{
			if (!photonView.isMine)
			{
				myTransform.position = Vector3.Lerp(myTransform.position, correctPlayerPos, Time.deltaTime * 5f);
				myTransform.rotation = Quaternion.Lerp(myTransform.rotation, correctPlayerRot, Time.deltaTime * 5f);
				if (сountUpdate < 10)
				{
					сountUpdate++;
				}
			}
		}
		catch (Exception exception)
		{
			Debug.LogError("Cooperative mode failure.");
			Debug.LogException(exception);
			throw;
		}
	}
}
