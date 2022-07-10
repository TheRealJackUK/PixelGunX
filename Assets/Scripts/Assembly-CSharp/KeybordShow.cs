using UnityEngine;

public class KeybordShow : MonoBehaviour
{
	private TouchScreenKeyboard mKeyboard;

	public bool mKeybordHold = true;

	public int maxChars = 20;

	public GameObject CF;

	public UILabel _Uil;

	private string mText = string.Empty;

	private void Start()
	{
		_Uil = CF.GetComponent<UILabel>();
		Vector3 position = CF.transform.position;
		CF.transform.position = new Vector3(posNGUI.getPosX(0f), posNGUI.getPosY(0f), position.z);
		_Uil.lineWidth = Screen.width;
		mKeyboard = TouchScreenKeyboard.Open(string.Empty, TouchScreenKeyboardType.Default, false, false);
	}

	private void Update()
	{
		if (mKeyboard == null)
		{
			return;
		}
		string text = mKeyboard.text;
		if (mText != text)
		{
			mText = string.Empty;
			foreach (char c in text)
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
			if (mText != text)
			{
				mKeyboard.text = mText;
			}
			SendMessage("OnInputChanged", this, SendMessageOptions.DontRequireReceiver);
		}
		mKeyboard.active = true;
		if (mKeyboard.done)
		{
			mKeyboard.active = true;
			if (string.IsNullOrEmpty(mText))
			{
				_Uil.text = mText + '\n' + _Uil.text;
				mText = string.Empty;
			}
			if (!mKeybordHold)
			{
				mKeyboard.active = false;
				mKeyboard = null;
			}
		}
		else if (mKeyboard.wasCanceled)
		{
			mKeyboard.active = false;
			mKeyboard = null;
		}
	}

	private void OnClick()
	{
		mKeyboard = TouchScreenKeyboard.Open(mText, TouchScreenKeyboardType.Default, false);
	}
}
