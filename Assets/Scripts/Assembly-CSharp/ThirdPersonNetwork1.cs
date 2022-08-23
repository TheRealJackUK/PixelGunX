using Photon;
using UnityEngine;

public class ThirdPersonNetwork1 : Photon.MonoBehaviour
{
	private struct MovementHistoryEntry
	{
		public Vector3 playerPos;

		public Quaternion playerRot;

		public int anim;

		public bool weAreSteals;

		public double timeStamp;
	}

	private ThirdPersonCamera cameraScript;

	private ThirdPersonController controllerScript;

	private bool iskilled;

	private bool oldIsKilled;

	public bool sglajEnabled;

	public bool sglajEnabledVidos;

	private Vector3 correctPlayerPos;

	private double correctPlayerTime;

	private Quaternion correctPlayerRot = Quaternion.identity;

	public Player_move_c playerMovec;

	public bool isStartAngel;

	private Transform myTransform;

	private double myTime;

	private MovementHistoryEntry[] movementHistory;

	private int historyLengh = 5;

	private bool isHitoryClear = true;

	public int myAnim;

	private int myAnimOld;

	public SkinName skinName;

	public bool weAreSteals;

	private bool isFirstSnapshot = true;

	private bool isMine;

	private bool isFirstHistoryFull;

	private void Awake()
	{
		if (!Defs.isMulti)
		{
			base.enabled = false;
		}
		myTransform = base.transform;
		correctPlayerPos = new Vector3(0f, -10000f, 0f);
		movementHistory = new MovementHistoryEntry[historyLengh];
		for (int i = 0; i < historyLengh; i++)
		{
			movementHistory[i].timeStamp = 0.0;
		}
		myTime = 1.0;
	}

	private void Start()
	{
		if ((Defs.isInet && base.photonView.isMine) || (!Defs.isInet && GetComponent<PhotonView>().isMine))
		{
			isMine = true;
		}
	}

	private void OnPhotonSerializeView(PhotonStream stream, PhotonMessageInfo info)
	{
		if (stream.isWriting)
		{
			iskilled = playerMovec.isKilled;
			if (playerMovec.CurHealth <= 0f)
			{
				iskilled = true;
			}
			stream.SendNext(myTransform.position);
			stream.SendNext(myTransform.rotation);
			stream.SendNext(iskilled);
			stream.SendNext(PhotonNetwork.time);
			stream.SendNext(myAnim);
			stream.SendNext(EffectsController.WeAreStealth);
			stream.SendNext(playerMovec.isImmortality);
		}
		else if (!isFirstSnapshot)
		{
			correctPlayerPos = (Vector3)stream.ReceiveNext();
			correctPlayerRot = (Quaternion)stream.ReceiveNext();
			oldIsKilled = iskilled;
			iskilled = (bool)stream.ReceiveNext();
			playerMovec.isKilled = iskilled;
			int num = 0;
			bool flag = false;
			correctPlayerTime = (double)stream.ReceiveNext();
			if (iskilled || Mathf.Abs((float)myTime - (float)correctPlayerTime) > 1000f)
			{
				isHitoryClear = true;
				myTime = correctPlayerTime;
			}
			num = (int)stream.ReceiveNext();
			flag = (bool)stream.ReceiveNext();
			playerMovec.isImmortality = (bool)stream.ReceiveNext();
			AddNewSnapshot(correctPlayerPos, correctPlayerRot, correctPlayerTime, num, flag);
		}
		else
		{
			isFirstSnapshot = false;
		}
	}

	private void OnSerializeNetworkView(PhotonStream stream, PhotonMessageInfo info)
	{
		if (stream.isWriting)
		{
			Vector3 value = myTransform.position;
			Quaternion value2 = myTransform.rotation;
			stream.Serialize(ref value);
			stream.Serialize(ref value2);
			iskilled = playerMovec.isKilled;
			stream.Serialize(ref iskilled);
			float value3 = (float)PhotonNetwork.time;
			stream.Serialize(ref value3);
			int value4 = myAnim;
			stream.Serialize(ref value4);
			bool value5 = EffectsController.WeAreStealth;
			stream.Serialize(ref value5);
			bool value6 = playerMovec.isImmortality;
			stream.Serialize(ref value6);
			return;
		}
		Vector3 value7 = Vector3.zero;
		Quaternion value8 = Quaternion.identity;
		float value9 = 0f;
		stream.Serialize(ref value7);
		stream.Serialize(ref value8);
		correctPlayerPos = value7;
		correctPlayerRot = value8;
		oldIsKilled = iskilled;
		stream.Serialize(ref iskilled);
		playerMovec.isKilled = iskilled;
		stream.Serialize(ref value9);
		correctPlayerTime = value9;
		if (iskilled)
		{
			isHitoryClear = true;
			myTime = correctPlayerTime;
		}
		int value10 = 0;
		stream.Serialize(ref value10);
		bool value11 = false;
		stream.Serialize(ref value11);
		bool value12 = false;
		stream.Serialize(ref value12);
		playerMovec.isImmortality = value12;
		AddNewSnapshot(correctPlayerPos, correctPlayerRot, correctPlayerTime, value10, value11);
	}

	public void StartAngel()
	{
		isStartAngel = true;
	}

	private void Update()
	{
		if (isMine)
		{
			return;
		}
		if (!playerMovec.isWeaponSet)
		{
			myTransform.position = new Vector3(0f, -10000f, 0f);
			return;
		}
		if (iskilled)
		{
			if (!oldIsKilled)
			{
				oldIsKilled = iskilled;
				isStartAngel = false;
			}
			myTransform.position = new Vector3(0f, -10000f, 0f);
		}
		else if (!oldIsKilled && !isHitoryClear && (sglajEnabled || sglajEnabledVidos || playerMovec.isInvisible))
		{
			double num = ((!(myTime + (double)Time.deltaTime < movementHistory[movementHistory.Length - 1].timeStamp)) ? (myTime + (double)Time.deltaTime) : (myTime + (double)(Time.deltaTime * 1.5f)));
			int num2 = 0;
			for (int i = 0; i < movementHistory.Length && movementHistory[i].timeStamp > myTime; i++)
			{
				num2 = i;
			}
			if (num2 == 0)
			{
				isHitoryClear = true;
			}
			if (movementHistory[num2].timeStamp - myTime > 4.0 && num2 > 0)
			{
				num2--;
				myTransform.position = movementHistory[num2].playerPos;
				myTransform.rotation = movementHistory[num2].playerRot;
				myTime = movementHistory[num2].timeStamp;
			}
			else
			{
				float t = (float)((num - myTime) / (movementHistory[num2].timeStamp - myTime));
				myTransform.position = Vector3.Lerp(myTransform.position, movementHistory[num2].playerPos, t);
				myTransform.rotation = Quaternion.Lerp(myTransform.rotation, movementHistory[num2].playerRot, t);
				myTime = num;
				if (myAnim != movementHistory[num2].anim)
				{
					skinName.SetAnim(movementHistory[num2].anim, movementHistory[num2].weAreSteals);
					myAnim = movementHistory[num2].anim;
				}
			}
		}
		else if (!isHitoryClear)
		{
			myTransform.position = movementHistory[movementHistory.Length - 1].playerPos;
			myTransform.rotation = movementHistory[movementHistory.Length - 1].playerRot;
			myTime = movementHistory[movementHistory.Length - 1].timeStamp;
		}
		if (isStartAngel)
		{
			myTransform.position = new Vector3(0f, -10000f, 0f);
		}
	}

	private void AddNewSnapshot(Vector3 playerPos, Quaternion playerRot, double timeStamp, int _anim, bool _weAreSteals)
	{
		for (int num = movementHistory.Length - 1; num > 0; num--)
		{
			movementHistory[num] = movementHistory[num - 1];
		}
		movementHistory[0].playerPos = playerPos;
		movementHistory[0].playerRot = playerRot;
		movementHistory[0].timeStamp = timeStamp;
		movementHistory[0].anim = _anim;
		movementHistory[0].weAreSteals = _weAreSteals;
		if (isHitoryClear && movementHistory[movementHistory.Length - 1].timeStamp > myTime)
		{
			isHitoryClear = false;
			myTime = movementHistory[movementHistory.Length - 1].timeStamp;
			if (!isFirstHistoryFull)
			{
				myTransform.position = movementHistory[movementHistory.Length - 1].playerPos;
				myTransform.rotation = movementHistory[movementHistory.Length - 1].playerRot;
				isFirstHistoryFull = true;
			}
		}
	}
}
