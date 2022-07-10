using UnityEngine;

public class ShowNoJoinConnectFromRanks : MonoBehaviour
{
	public float showTimer;

	public UILabel label;

	public GameObject panelMessage;

	public static ShowNoJoinConnectFromRanks sharedController;

	private void Start()
	{
		sharedController = this;
	}

	private void Update()
	{
		if (showTimer > 0f)
		{
			showTimer -= Time.deltaTime;
			if (showTimer <= 0f)
			{
				panelMessage.SetActive(false);
			}
		}
	}

	public void resetShow(int rank)
	{
		label.text = "Reach rank " + rank + "  to play this mode!";
		panelMessage.SetActive(true);
		showTimer = 3f;
	}

	private void OnDestroy()
	{
		sharedController = null;
	}
}
