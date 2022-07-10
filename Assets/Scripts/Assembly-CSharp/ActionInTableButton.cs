using UnityEngine;

public sealed class ActionInTableButton : MonoBehaviour
{
	public UIButton buttonScript;

	public UISprite backgroundSprite;

	public UISprite rankSprite;

	public GameObject check;

	public UILabel namesPlayers;

	public UILabel scorePlayers;

	public UILabel countKillsPlayers;

	public UITexture clanTexture;

	public string pixelbookID;

	public string nickPlayer;

	public NetworkStartTableNGUIController networkStartTableNGUIController;

	public bool isMine;

	private void Start()
	{
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture)
		{
			float x = countKillsPlayers.transform.position.x;
			countKillsPlayers.transform.position = new Vector3(scorePlayers.transform.position.x, countKillsPlayers.transform.position.y, countKillsPlayers.transform.position.z);
			scorePlayers.transform.position = new Vector3(x, scorePlayers.transform.position.y, scorePlayers.transform.position.z);
		}
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TimeBattle)
		{
			scorePlayers.transform.position = new Vector3(countKillsPlayers.transform.position.x, scorePlayers.transform.position.y, scorePlayers.transform.position.z);
			countKillsPlayers.gameObject.SetActive(false);
		}
	}

	public void UpdateState(bool isActive, bool _isMine = false, int command = 0, string nick = "", string score = "", string countKills = "", int rank = 1, Texture clanLogo = null, string _pixelbookID = "")
	{
		pixelbookID = _pixelbookID;
		nickPlayer = nick;
		isMine = _isMine;
		if (!isActive)
		{
			base.gameObject.SetActive(false);
			return;
		}
		Color color;
		if (isMine)
		{
			if (buttonScript.enabled)
			{
				buttonScript.enabled = false;
				buttonScript.tweenTarget.SetActive(false);
				check.SetActive(false);
			}
			if (check.activeSelf)
			{
				check.SetActive(false);
			}
			color = new Color(1f, 1f, 0f, 1f);
		}
		else
		{
			if (!networkStartTableNGUIController.IsShowAdd(_pixelbookID))
			{
				if (string.IsNullOrEmpty(_pixelbookID) || _pixelbookID.Equals("0") || _pixelbookID.Equals("-1") || _pixelbookID.Equals(FriendsController.sharedController.id) || !Defs2.IsAvalibleAddFrends() || string.IsNullOrEmpty(FriendsController.sharedController.id))
				{
					if (buttonScript.enabled)
					{
						buttonScript.enabled = false;
						buttonScript.tweenTarget.SetActive(false);
						check.SetActive(false);
					}
					if (check.activeSelf)
					{
						check.SetActive(false);
					}
				}
				else
				{
					if (buttonScript.enabled)
					{
						buttonScript.enabled = false;
						buttonScript.tweenTarget.SetActive(false);
					}
					if (!check.activeSelf)
					{
						check.SetActive(true);
					}
				}
			}
			else
			{
				if (!buttonScript.enabled)
				{
					buttonScript.enabled = true;
					buttonScript.tweenTarget.SetActive(true);
					check.SetActive(true);
				}
				if (!check.activeSelf)
				{
					check.SetActive(true);
				}
			}
			switch (command)
			{
			case 0:
				color = new Color(1f, 1f, 1f, 1f);
				break;
			case 1:
				color = new Color(0f, 0.32f, 1f, 1f);
				break;
			default:
				color = new Color(1f, 0f, 0f, 1f);
				break;
			}
		}
		base.gameObject.SetActive(true);
		namesPlayers.text = nick;
		namesPlayers.color = color;
		scorePlayers.text = score;
		scorePlayers.color = color;
		countKillsPlayers.text = countKills;
		countKillsPlayers.color = color;
		rankSprite.spriteName = "Rank_" + rank;
		clanTexture.mainTexture = clanLogo;
	}

	private void OnClick()
	{
		if ((!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown) && !LoadingInAfterGame.isShowLoading && !ShopNGUIController.GuiActive && !ExperienceController.sharedController.isShowNextPlashka && !isMine)
		{
			if (ButtonClickSound.Instance != null)
			{
				ButtonClickSound.Instance.PlayClick();
			}
			networkStartTableNGUIController.ShowActionPanel(pixelbookID, nickPlayer);
		}
	}
}
