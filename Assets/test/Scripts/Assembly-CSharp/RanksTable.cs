using UnityEngine;

public class RanksTable : MonoBehaviour
{
	public GameObject panelRanks;
	public GameObject panelRanksTeam;
	public GameObject tekPanel;
	public UILabel[] namesPlayers;
	public UILabel[] scorePlayers;
	public UILabel[] namesPlayers1;
	public UILabel[] scorePlayers1;
	public UILabel[] namesPlayers2;
	public UILabel[] scorePlayers2;
	public GameObject[] skulls;
	public UISprite[] ranks;
	public UISprite[] ranks1;
	public UISprite[] ranks2;
	public UITexture[] clansLogo;
	public UITexture[] clansLogo1;
	public UITexture[] clansLogo2;
	public AddFrendsButtonInTableRangs[] butsAdd;
	public AddFrendsButtonInTableRangs[] butsAdd1;
	public AddFrendsButtonInTableRangs[] butsAdd2;
	public ActionInTableButton[] playersBut;
	public UITexture fonTable;
	public UITexture fonTableTeam;
	public bool isShowRanks;
	public bool isShowTableStart;
	public bool isShowTableWin;
	public NetworkStartTable myNetworkStartTable;
	public UIWidget tableContainer;
	public UIWidget centerWidget;
	public UIWidget rightWidget;
}
