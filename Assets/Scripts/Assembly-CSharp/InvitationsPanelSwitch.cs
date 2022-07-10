using UnityEngine;

public class InvitationsPanelSwitch : MonoBehaviour
{
	public bool left = true;

	public bool Middle;

	public GameObject leftPanel;

	public GameObject MiddlePanel;

	public GameObject rightPanel;

	public GameObject[] anotherButtons;

	public GameObject[] anotherChekmarks;

	public GameObject chekmark;

	public GameObject butt;

	public GameObject[] anotherToggles;

	private void OnPress(bool isPress)
	{
		Debug.Log("press " + isPress);
		if (isPress)
		{
			GetComponent<UISprite>().spriteName = "trans_btn_n";
		}
		else
		{
			GetComponent<UISprite>().spriteName = "trans_btn";
		}
	}

	private void OnClick()
	{
		Debug.Log("OnClick");
		if (left)
		{
			leftPanel.SetActive(true);
			MiddlePanel.SetActive(false);
			rightPanel.SetActive(false);
		}
		else if (Middle)
		{
			leftPanel.SetActive(false);
			MiddlePanel.SetActive(true);
			rightPanel.SetActive(false);
		}
		else
		{
			leftPanel.SetActive(false);
			MiddlePanel.SetActive(false);
			rightPanel.SetActive(true);
		}
		GetComponent<UIButton>().enabled = false;
		butt.GetComponent<UILabel>().gameObject.SetActive(false);
		chekmark.SetActive(true);
		GetComponent<UISprite>().spriteName = "trans_btn_n";
		GameObject[] array = anotherButtons;
		foreach (GameObject gameObject in array)
		{
			gameObject.SetActive(true);
		}
		GameObject[] array2 = anotherToggles;
		foreach (GameObject gameObject2 in array2)
		{
			gameObject2.GetComponent<UIButton>().enabled = true;
			gameObject2.GetComponent<UISprite>().spriteName = "trans_btn";
		}
		GameObject[] array3 = anotherChekmarks;
		foreach (GameObject gameObject3 in array3)
		{
			gameObject3.SetActive(false);
		}
		ButtonClickSound.Instance.PlayClick();
	}
}
