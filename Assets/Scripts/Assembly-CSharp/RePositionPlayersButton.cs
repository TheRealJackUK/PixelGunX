using UnityEngine;

public class RePositionPlayersButton : MonoBehaviour
{
	public Vector3 positionInCommand;

	private void Start()
	{
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints)
		{
			base.transform.localPosition = positionInCommand;
		}
	}
}
