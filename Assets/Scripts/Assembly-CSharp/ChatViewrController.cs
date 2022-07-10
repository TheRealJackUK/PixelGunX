using Rilisoft;
using UnityEngine;

public sealed class ChatViewrController : MonoBehaviour
{
	public static ChatViewrController sharedController;

	public GameObject PlayerObject;

	private TouchScreenKeyboard mKeyboard;

	public GameObject[] labelChat;

	private string mText = string.Empty;

	public int maxChars = 40;

	public WeaponManager _weaponManager;

	public GameObject holdButton;

	public GameObject holdButtonOn;

	public static bool isHold;

	public AudioClip sendChatClip;

	public bool isClanMode;

	public UIWidget enterMessageController;

	public UIInput enterMessageInput;

	public GameObject chatLabelsHolder;

	public void clickButton(string nameButton)
	{
		Debug.Log(nameButton);
		if (nameButton.Equals("CloseChatButton"))
		{
			closeChat();
		}
		if (nameButton.Equals("HoldChatButton"))
		{
			Debug.Log("HoldChatButton");
			isHold = true;
			holdButton.SetActive(false);
			holdButtonOn.SetActive(true);
		}
		if (nameButton.Equals("HoldChatButtonOn"))
		{
			Debug.Log("HoldChatButtonOn");
			isHold = false;
			holdButton.SetActive(true);
			holdButtonOn.SetActive(false);
		}
		if (nameButton.Equals("KeyboardButton"))
		{
			Debug.Log("KeyboardButton");
			mKeyboard = TouchScreenKeyboard.Open(string.Empty, TouchScreenKeyboardType.Default, false, false);
		}
	}

	public void postChat(string _text)
	{
		if (Defs.isSoundFX)
		{
			NGUITools.PlaySound(sendChatClip);
		}
		PlayerObject.GetComponent<Player_move_c>().SendChat(_text, isClanMode);
	}

	public void closeChat()
	{
		if (Application.isEditor)
		{
			Player_move_c.isBlockKeybordControl = false;
		}
		mKeyboard.active = false;
		mKeyboard = null;
		Player_move_c component = PlayerObject.GetComponent<Player_move_c>();
		component.showChat = false;
		component.AddButtonHandlers();
		component.inGameGUI.gameObject.SetActive(true);
		if (component.isMechActive)
		{
			component.mechPoint.SetActive(true);
		}
		else
		{
			WeaponManager.sharedManager.currentWeaponSounds.gameObject.SetActive(true);
		}
		Object.Destroy(base.gameObject);
	}

	public void PostMessageByInput()
	{
		if ((Application.isEditor || Application.platform == RuntimePlatform.WP8Player) && enterMessageInput != null)
		{
			postChat(enterMessageInput.value);
			enterMessageInput.value = string.Empty;
		}
	}

	private void OnEnable()
	{
		if ((Application.isEditor || Application.platform == RuntimePlatform.WP8Player) && enterMessageInput != null)
		{
			enterMessageInput.isSelected = true;
		}
	}

	private void OnDestroy()
	{
		sharedController = null;
		if (mKeyboard != null)
		{
			mKeyboard.active = false;
			mKeyboard = null;
		}
	}

	private void Start()
	{
		isHold = false;
		sharedController = this;
		_weaponManager = WeaponManager.sharedManager;
		mKeyboard = TouchScreenKeyboard.Open(string.Empty, TouchScreenKeyboardType.Default, false, false);
		if (Application.isEditor || Application.platform == RuntimePlatform.WP8Player)
		{
			enterMessageController.gameObject.SetActive(true);
			Player_move_c.isBlockKeybordControl = true;
			if (chatLabelsHolder != null)
			{
				chatLabelsHolder.transform.localPosition -= new Vector3(0f, 100f, 0f);
			}
		}
	}

	private void Update()
	{
		if (PlayerObject == null)
		{
			return;
		}
		Player_move_c component = PlayerObject.GetComponent<Player_move_c>();
		int num = component.messages.Count - 1;
		if (num > 29)
		{
			num = 29;
		}
		int num2 = 0;
		for (int num3 = num; num3 >= 0; num3--)
		{
			string text = "[00FF26]";
			if ((!Defs.isInet && component.messages[num3].IDLocal == _weaponManager.myPlayer.GetComponent<NetworkView>().viewID) || (Defs.isInet && component.messages[num3].ID == _weaponManager.myPlayer.GetComponent<PhotonView>().viewID))
			{
				text = "[00FF26]";
			}
			else
			{
				if (component.messages[num3].command == 0)
				{
					text = "[FFFF26]";
				}
				if (component.messages[num3].command == 1)
				{
					text = "[0000FF]";
				}
				if (component.messages[num3].command == 2)
				{
					text = "[FF0000]";
				}
			}
			labelChat[num2].GetComponent<UILabel>().text = text + component.messages[num3].text;
			labelChat[num2].transform.GetChild(0).GetComponent<UITexture>().mainTexture = component.messages[num3].clanLogo;
			labelChat[num2].SetActive(true);
			num2++;
		}
		for (int i = num2; i < 30; i++)
		{
			labelChat[i].SetActive(false);
		}
		if (Application.isEditor || mKeyboard == null)
		{
			return;
		}
		string text2 = mKeyboard.text;
		if (mText != text2)
		{
			mText = string.Empty;
			foreach (char c in text2)
			{
				if (c != 0)
				{
					mText += c;
				}
			}
			if (maxChars > 0 && mKeyboard.text.Length > maxChars)
			{
				mKeyboard.text = mKeyboard.text.Substring(0, maxChars);
			}
			if (mText != text2)
			{
				mKeyboard.text = mText;
			}
		}
		if (mKeyboard.done && !mKeyboard.wasCanceled)
		{
			if (isHold)
			{
				if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
				{
					if (enterMessageInput != null)
					{
						enterMessageInput.isSelected = true;
					}
				}
				else
				{
					mKeyboard.active = true;
				}
			}
			else if (Application.platform != RuntimePlatform.Android && Application.platform != RuntimePlatform.WP8Player)
			{
				closeChat();
			}
			if (!string.IsNullOrEmpty(mText))
			{
				postChat(mText);
				mKeyboard.text = string.Empty;
			}
		}
		else if (mKeyboard.wasCanceled && !isHold && Application.platform != RuntimePlatform.Android && Application.platform != RuntimePlatform.WP8Player)
		{
			closeChat();
		}
	}
}
