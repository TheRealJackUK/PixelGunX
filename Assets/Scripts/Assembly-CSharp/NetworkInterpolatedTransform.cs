using UnityEngine;

public sealed class NetworkInterpolatedTransform : MonoBehaviour
{
	private bool iskilled;

	private bool oldIsKilled;

	public Player_move_c playerMovec;

	public bool isStartAngel;

	public Vector3 correctPlayerPos;

	public Quaternion correctPlayerRot = Quaternion.identity;

	private Transform myTransform;

	private void Awake()
	{
		if (!Defs.isMulti || Defs.isInet)
		{
			base.enabled = false;
		}
		correctPlayerPos = new Vector3(0f, -10000f, 0f);
		myTransform = base.transform;
	}

	private void OnSerializeNetworkView(BitStream stream, NetworkMessageInfo info)
	{
		if (stream.isWriting)
		{
			Vector3 value = base.transform.localPosition;
			Quaternion value2 = base.transform.localRotation;
			stream.Serialize(ref value);
			stream.Serialize(ref value2);
			iskilled = playerMovec.isKilled;
			stream.Serialize(ref iskilled);
		}
		else
		{
			Vector3 value3 = Vector3.zero;
			Quaternion value4 = Quaternion.identity;
			stream.Serialize(ref value3);
			stream.Serialize(ref value4);
			correctPlayerPos = value3;
			correctPlayerRot = value4;
			oldIsKilled = iskilled;
			stream.Serialize(ref iskilled);
			playerMovec.isKilled = iskilled;
		}
	}

	public void StartAngel()
	{
		isStartAngel = true;
	}

	private void Update()
	{
		if (Defs.isInet || base.GetComponent<NetworkView>().isMine)
		{
			return;
		}
		if (iskilled)
		{
			if (!oldIsKilled)
			{
				oldIsKilled = iskilled;
				if (!isStartAngel)
				{
					StartAngel();
				}
				isStartAngel = false;
			}
			myTransform.position = new Vector3(0f, -1000f, 0f);
		}
		else if (!oldIsKilled)
		{
			if (Vector3.SqrMagnitude(myTransform.position - correctPlayerPos) > 0.04f)
			{
				myTransform.position = Vector3.Lerp(myTransform.position, correctPlayerPos, Time.deltaTime * 5f);
			}
			myTransform.rotation = Quaternion.Lerp(myTransform.rotation, correctPlayerRot, Time.deltaTime * 5f);
		}
		else
		{
			myTransform.position = correctPlayerPos;
			myTransform.rotation = correctPlayerRot;
		}
		if (isStartAngel)
		{
			myTransform.position = new Vector3(0f, -1000f, 0f);
		}
	}
}
