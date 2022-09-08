using UnityEngine;

internal class MenuLeaderboardsView : MonoBehaviour
{
	public UIGrid friendsGrid;
	public UIGrid bestPlayersGrid;
	public UIGrid clansGrid;
	public UIButton friendsButton;
	public UIButton bestPlayersButton;
	public UIButton clansButton;
	public UIDragScrollView friendsPanel;
	public UIDragScrollView bestPlayersPanel;
	public UIDragScrollView clansPanel;
	public UIScrollView friendsScroll;
	public UIScrollView bestPlayersScroll;
	public UIScrollView clansScroll;
	public LeaderboardItemView footer;
	public LeaderboardItemView clanFooter;
	public UISprite temporaryBackground;
	public UISprite bestPlayersDefaultSprite;
	public UISprite clansDefaultSprite;
	public UILabel nickOrClanName;
	public ToggleButton btnLeaderboards;
	public GameObject opened;
}
