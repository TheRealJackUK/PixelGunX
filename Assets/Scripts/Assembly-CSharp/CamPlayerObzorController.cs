using UnityEngine;

internal sealed class CamPlayerObzorController : MonoBehaviour
{
	private bool isMine;

	public GameObject playerGameObject;

	private void Start()
	{
		if (Defs.isMulti && Defs.isInet && !base.transform.parent.GetComponent<PhotonView>().isMine)
		{
			isMine = true;
		}
		if (isMine)
		{
			SendMessage("SetActiveFalse");
		}
		else
		{
			base.enabled = false;
		}
		playerGameObject = base.transform.parent.GetComponent<SkinName>().playerGameObject;
	}

	private void Update()
	{
		base.transform.rotation = Quaternion.Euler(new Vector3(playerGameObject.transform.rotation.x, base.transform.rotation.y, base.transform.rotation.z));
	}
}
