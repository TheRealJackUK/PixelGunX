using UnityEngine;

public class StartPlayerButton : MonoBehaviour
{
	public int command;

	public BlueRedButtonController buttonController;

	private float timeEnable;

	private void Awake()
	{
		if ((ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.TeamFight && ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.FlagCapture && ConnectSceneNGUIController.regim != ConnectSceneNGUIController.RegimGame.CapturePoints && command != 0) || ((ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.TeamFight || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture || ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.CapturePoints) && command == 0) || Defs.isHunger)
		{
			base.gameObject.SetActive(false);
		}
	}

	private void Start()
	{
		if (command == 3 && Defs.isRegimVidosDebug)
		{
			base.gameObject.SetActive(false);
			GetComponent<UIButton>().enabled = false;
		}
	}

	private void OnEnable()
	{
		timeEnable = Time.realtimeSinceStartup;
	}

	private void OnClick()
	{
		if (Time.time - NotificationController.timeStartApp < 3f || (Defs.isCapturePoints && Time.realtimeSinceStartup - timeEnable < 1.5f) || (BankController.Instance != null && BankController.Instance.InterfaceEnabled) || LoadingInAfterGame.isShowLoading || (ExpController.Instance != null && ExpController.Instance.IsLevelUpShown) || ShopNGUIController.GuiActive || ExperienceController.sharedController.isShowNextPlashka)
		{
			return;
		}
		ButtonClickSound.Instance.PlayClick();
		if (WeaponManager.sharedManager.myTable != null)
		{
			int num = command;
			if (command == 3 && buttonController != null)
			{
				num = ((!buttonController.isBlueAvalible && buttonController.isRedAvalible) ? 2 : ((buttonController.isBlueAvalible && !buttonController.isRedAvalible) ? 1 : Random.Range(1, 3)));
			}
			WeaponManager.sharedManager.myTable.GetComponent<NetworkStartTable>().StartPlayerButtonClick(num);
		}
	}
}
