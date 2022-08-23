using UnityEngine;

public class NetworkInterpolationGameObject : MonoBehaviour
{
	private Quaternion correctPlayerRot = Quaternion.identity;

	private void Awake()
	{
		if (!Defs.isMulti || Defs.isInet)
		{
			base.enabled = false;
		}
	}

	private void OnSerializeNetworkView(PhotonStream stream, PhotonMessageInfo info)
	{
		if (stream.isWriting)
		{
			Quaternion value = base.transform.localRotation;
			stream.Serialize(ref value);
		}
		else
		{
			Quaternion value2 = Quaternion.identity;
			stream.Serialize(ref value2);
			correctPlayerRot = value2;
		}
	}

	private void Update()
	{
		if (!base.GetComponent<PhotonView>().isMine)
		{
			base.transform.localRotation = correctPlayerRot;
		}
	}
}
