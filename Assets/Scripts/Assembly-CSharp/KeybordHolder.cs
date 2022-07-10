using UnityEngine;

public class KeybordHolder : MonoBehaviour
{
	public KeybordShow _tk;

	private void OnClick()
	{
		if (_tk.mKeybordHold)
		{
			_tk.mKeybordHold = false;
		}
		else
		{
			_tk.mKeybordHold = true;
		}
	}
}
