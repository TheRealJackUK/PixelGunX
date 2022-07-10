using UnityEngine;

public class GoMapInEndGame : MonoBehaviour
{
	public int mapIndex;

	public UITexture mapTexture;

	public UILabel mapLabel;

	private float enableTime;

	private void OnEnable()
	{
		enableTime = Time.time;
	}

	private void Start()
	{
		if (!Defs.isInet)
		{
			base.gameObject.SetActive(false);
		}
	}

	public void SetMap(string _map)
	{
		mapIndex = Defs.levelNumsForMusicInMult[_map];
		mapTexture.mainTexture = Resources.Load<Texture>("LevelLoadingsSmall/Loading_" + _map);
		mapLabel.text = Defs2.mapNamesForUser[_map];
	}

	public void OnClick()
	{
		if (!(Time.time - enableTime < 2f) && (!(BankController.Instance != null) || !BankController.Instance.InterfaceEnabled) && (!(ExpController.Instance != null) || !ExpController.Instance.IsLevelUpShown))
		{
			Defs.typeDisconnectGame = Defs.DisconectGameType.SelectNewMap;
			Initializer.Instance.goMapName = Defs.levelNamesFromNums[mapIndex.ToString()];
			GlobalGameController.countKillsRed = 0;
			GlobalGameController.countKillsBlue = 0;
			PhotonNetwork.LeaveRoom();
		}
	}
}
