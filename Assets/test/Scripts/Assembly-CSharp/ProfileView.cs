using UnityEngine;
using Rilisoft;

internal class ProfileView : MonoBehaviour
{
	public GameObject interfaceHolder;
	public UIRoot interfaceHolder2d;
	public GameObject worldHolder3d;
	public UILabel totalWeeklyWinsCount;
	public UILabel deathmatchWinCount;
	public UILabel teamBattleWinCount;
	public UILabel deadlyGamesWinCount;
	public UILabel flagCaptureWinCount;
	public UILabel totalWinCount;
	public UILabel coopTimeSurvivalPointCount;
	public UILabel waveCountLabel;
	public UILabel killedCountLabel;
	public UILabel survivalScoreLabel;
	public UILabel box1StarsLabel;
	public UILabel box2StarsLabel;
	public UILabel secretCoinsLabel;
	public UIInput nicknameInput;
	public UITexture clanLogo;
	public ButtonHandler backButton;
	public UIButton achievementsButton;
	public UIButton leaderboardsButton;
	public CharacterView characterView;
	public UILabel errorLabel;
}
