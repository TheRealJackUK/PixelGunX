using UnityEngine;

internal sealed class synchCamAndPlayer : MonoBehaviour
{
	private bool isMine;

	private PhotonView photonView;

	public Transform gameObjectPlayerTrasform;

	private bool isMulti;

	private bool isInet;

	private Transform myTransform;

	private void Start()
	{
		myTransform = base.transform;
		isMulti = Defs.isMulti;
		isInet = Defs.isInet;
		photonView = base.transform.parent.GetComponent<PhotonView>();
		if (isMulti)
		{
			if (!isInet)
			{
				isMine = base.transform.parent.GetComponent<NetworkView>().isMine;
			}
			else
			{
				isMine = photonView.isMine;
			}
		}
		if (!isMulti || isMine)
		{
			base.enabled = false;
		}
		else
		{
			SendMessage("SetActiveFalse");
		}
	}

	private void invokeStart()
	{
	}

	public void setSynh(bool _isActive)
	{
	}

	private void Update()
	{
		myTransform.rotation = gameObjectPlayerTrasform.rotation;
	}
}
