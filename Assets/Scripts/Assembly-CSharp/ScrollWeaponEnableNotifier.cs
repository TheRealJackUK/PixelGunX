using UnityEngine;

public class ScrollWeaponEnableNotifier : MonoBehaviour
{
	public InGameGUI inGameGui;

	private void OnEnable()
	{
		inGameGui.StartCoroutine(inGameGui._DisableSwiping(0.5f));
	}
}
