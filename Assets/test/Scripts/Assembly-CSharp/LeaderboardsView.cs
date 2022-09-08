using UnityEngine;
using Rilisoft;

public class LeaderboardsView : MonoBehaviour
{
	public UIGrid clansGrid;
	public UIGrid friendsGrid;
	public UIGrid bestPlayersGrid;
	public ButtonHandler backButton;
	public UIButton clansButton;
	public UIButton friendsButton;
	public UIButton bestPlayersButton;
	public UIDragScrollView clansPanel;
	public UIDragScrollView friendsPanel;
	public UIDragScrollView bestPlayersPanel;
	public UIScrollView clansScroll;
	public UIScrollView friendsScroll;
	public UIScrollView bestPlayersScroll;
	public GameObject defaultTableHeader;
	public GameObject clansTableHeader;
}
