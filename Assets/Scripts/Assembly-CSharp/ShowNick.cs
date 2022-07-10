using UnityEngine;

public class ShowNick : MonoBehaviour
{
	public string nick;

	public bool isShowNick;

	public GUIStyle labelStyle;

	private float koofHeight;

	private void Start()
	{
		koofHeight = (float)Screen.height / 768f;
		labelStyle.fontSize = Mathf.RoundToInt(20f * koofHeight);
	}

	private void Update()
	{
	}

	private void OnGUI()
	{
	}
}
