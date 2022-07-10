using UnityEngine;

public class CreateClanButton : MonoBehaviour
{
	private void OnClick()
	{
		NGUITools.GetRoot(base.gameObject).GetComponent<ClansGUIController>().CreateClanPanel.SetActive(true);
	}
}
