using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using UnityEngine;

public sealed class LeaderboardsView : MonoBehaviour
{
	public enum State
	{
		Clans,
		Friends,
		BestPlayers
	}

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

	private bool _escapePressed;

	private State _currentState;

	public IList<LeaderboardItemViewModel> ClansList
	{
		set
		{
			StartCoroutine(SetGrid(clansGrid, value, "Leaderboards/LeaderboardClanItem"));
		}
	}

	public IList<LeaderboardItemViewModel> FriendsList
	{
		set
		{
			StartCoroutine(SetGrid(friendsGrid, value, "Leaderboards/LeaderboardItem"));
		}
	}

	public IList<LeaderboardItemViewModel> BestPlayersList
	{
		set
		{
			StartCoroutine(SetGrid(bestPlayersGrid, value, "Leaderboards/LeaderboardItem"));
		}
	}

	public State CurrentState
	{
		get
		{
			return _currentState;
		}
		set
		{
			if (clansButton != null)
			{
				clansButton.isEnabled = value != State.Clans;
				Transform transform = clansButton.gameObject.transform.Find("SpriteLabel");
				if (transform != null)
				{
					transform.gameObject.SetActive(value != State.Clans);
				}
				Transform transform2 = clansButton.gameObject.transform.Find("ChekmarkLabel");
				if (transform2 != null)
				{
					transform2.gameObject.SetActive(value == State.Clans);
				}
			}
			if (friendsButton != null)
			{
				friendsButton.isEnabled = value != State.Friends;
				Transform transform3 = friendsButton.gameObject.transform.Find("SpriteLabel");
				if (transform3 != null)
				{
					transform3.gameObject.SetActive(value != State.Friends);
				}
				Transform transform4 = friendsButton.gameObject.transform.Find("ChekmarkLabel");
				if (transform4 != null)
				{
					transform4.gameObject.SetActive(value == State.Friends);
				}
			}
			if (bestPlayersButton != null)
			{
				bestPlayersButton.isEnabled = value != State.BestPlayers;
				Transform transform5 = bestPlayersButton.gameObject.transform.Find("SpriteLabel");
				if (transform5 != null)
				{
					transform5.gameObject.SetActive(value != State.BestPlayers);
				}
				Transform transform6 = bestPlayersButton.gameObject.transform.Find("ChekmarkLabel");
				if (transform6 != null)
				{
					transform6.gameObject.SetActive(value == State.BestPlayers);
				}
			}
			Vector3 vector = new Vector3(0f, -21f, 0f);
			Vector3 vector2 = new Vector3(9000f, -21f, 0f);
			if (clansPanel != null)
			{
				clansPanel.transform.localPosition = ((value != 0) ? vector2 : vector);
			}
			if (friendsPanel != null)
			{
				friendsPanel.transform.localPosition = ((value != State.Friends) ? vector2 : vector);
			}
			if (bestPlayersPanel != null)
			{
				bestPlayersPanel.transform.localPosition = ((value != State.BestPlayers) ? vector2 : vector);
			}
			if (defaultTableHeader != null)
			{
				defaultTableHeader.SetActive(value != State.Clans);
			}
			if (clansTableHeader != null)
			{
				clansTableHeader.SetActive(value == State.Clans);
			}
			_currentState = value;
		}
	}

	public event EventHandler BackPressed;

	private void HandleTabPressed(object sender, EventArgs e)
	{
		GameObject gameObject = ((ButtonHandler)sender).gameObject;
		if (clansButton != null && gameObject == clansButton.gameObject)
		{
			CurrentState = State.Clans;
		}
		else if (friendsButton != null && gameObject == friendsButton.gameObject)
		{
			CurrentState = State.Friends;
		}
		else if (bestPlayersButton != null && gameObject == bestPlayersButton.gameObject)
		{
			CurrentState = State.BestPlayers;
		}
	}

	private void RaiseBackPressed(object sender, EventArgs e)
	{
		EventHandler backPressed = this.BackPressed;
		if (backPressed != null)
		{
			backPressed(sender, e);
		}
	}

	private static IEnumerator SetGrid(UIGrid grid, IList<LeaderboardItemViewModel> value, string itemPrefabPath)
	{
		if (string.IsNullOrEmpty(itemPrefabPath))
		{
			throw new ArgumentException("itemPrefabPath");
		}
		if (!(grid != null))
		{
			yield break;
		}
		while (!grid.gameObject.activeInHierarchy)
		{
			yield return null;
		}
		IEnumerable<LeaderboardItemViewModel> enumerable2;
		if (value == null)
		{
			IEnumerable<LeaderboardItemViewModel> enumerable = new List<LeaderboardItemViewModel>();
			enumerable2 = enumerable;
		}
		else
		{
			enumerable2 = value.Where((LeaderboardItemViewModel it) => it != null);
		}
		IEnumerable<LeaderboardItemViewModel> filteredList = enumerable2;
		List<Transform> list = grid.GetChildList();
		for (int i = 0; i != list.Count; i++)
		{
			UnityEngine.Object.Destroy(list[i].gameObject);
		}
		list.Clear();
		grid.Reposition();
		foreach (LeaderboardItemViewModel item in filteredList)
		{
			GameObject o = UnityEngine.Object.Instantiate(Resources.Load(itemPrefabPath)) as GameObject;
			if (o != null)
			{
				LeaderboardItemView liv = o.GetComponent<LeaderboardItemView>();
				if (liv != null)
				{
					liv.Reset(item);
					o.transform.parent = grid.transform;
					grid.AddChild(o.transform);
					o.transform.localScale = Vector3.one;
				}
			}
		}
		grid.Reposition();
		UIScrollView scrollView = grid.transform.parent.gameObject.GetComponent<UIScrollView>();
		if (scrollView != null)
		{
			scrollView.enabled = true;
			yield return null;
			scrollView.ResetPosition();
			scrollView.UpdatePosition();
			yield return null;
			scrollView.enabled = value.Count >= 10;
		}
	}

	private IEnumerator UpdateGridsAndScrollers()
	{
		IEnumerable<UIGrid> grids = new UIGrid[3] { clansGrid, friendsGrid, bestPlayersGrid }.Where((UIGrid g) => g != null);
		foreach (UIGrid g2 in grids)
		{
			g2.Reposition();
		}
		yield return null;
		IEnumerable<UIScrollView> scrolls = new UIScrollView[3] { clansScroll, friendsScroll, bestPlayersScroll }.Where((UIScrollView s) => s != null);
		foreach (UIScrollView s2 in scrolls)
		{
			s2.ResetPosition();
			s2.UpdatePosition();
		}
	}

	private void OnDestroy()
	{
		if (backButton != null)
		{
			backButton.Clicked -= RaiseBackPressed;
		}
	}

	private void OnEnable()
	{
		StartCoroutine(UpdateGridsAndScrollers());
	}

	private void Start()
	{
		IEnumerable<UIButton> enumerable = new UIButton[3] { clansButton, friendsButton, bestPlayersButton }.Where((UIButton b) => b != null);
		foreach (UIButton item in enumerable)
		{
			ButtonHandler component = item.GetComponent<ButtonHandler>();
			if (component != null)
			{
				component.Clicked += HandleTabPressed;
			}
		}
		if (backButton != null)
		{
			backButton.Clicked += RaiseBackPressed;
		}
		IEnumerable<UIScrollView> enumerable2 = new UIScrollView[3] { clansScroll, friendsScroll, bestPlayersScroll }.Where((UIScrollView s) => s != null);
		foreach (UIScrollView item2 in enumerable2)
		{
			item2.ResetPosition();
		}
		CurrentState = State.Friends;
	}

	private void Update()
	{
		if (_escapePressed)
		{
			_escapePressed = false;
			RaiseBackPressed(this, EventArgs.Empty);
		}
		else if (Input.GetKeyUp(KeyCode.Escape))
		{
			_escapePressed = true;
		}
	}
}
