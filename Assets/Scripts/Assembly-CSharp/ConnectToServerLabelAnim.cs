using UnityEngine;

public class ConnectToServerLabelAnim : MonoBehaviour
{
	public UILabel myLabel;

	public string startText;

	private int stateLabel;

	private float timer;

	private float maxTimer = 1f;

	private void Start()
	{
		timer = maxTimer;
		startText = LocalizationStore.Key_0564;
		myLabel.text = startText;
	}

	private void Update()
	{
		timer -= Time.deltaTime;
		if (timer < 0f)
		{
			timer = maxTimer;
			stateLabel++;
			if (stateLabel > 3)
			{
				stateLabel = 0;
			}
			string text = string.Empty;
			for (int i = 0; i < stateLabel; i++)
			{
				text += ".";
			}
			myLabel.text = string.Format("{0} {1}", startText, text);
		}
	}
}
