using System;
using Rilisoft;
using UnityEngine;

public class ControlsSettingsBase : MonoBehaviour
{
	public GameObject settingsPanel;

	public GameObject savePosJoystikButton;

	public GameObject defaultPosJoystikButton;

	public GameObject cancelPosJoystikButton;

	public GameObject SettingsJoysticksPanel;

	public GameObject zoomButton;

	public GameObject reloadButton;

	public GameObject jumpButton;

	public GameObject fireButton;

	public GameObject joystick;

	public GameObject grenadeButton;

	public GameObject fireButtonInJoystick;

	public UIAnchor BottomLeftControlsAnchor;

	public UIAnchor BottomRightControlsAnchor;

	public Transform BottomLeft;

	public Transform TopLeft;

	public Transform BottomRight;

	public Transform TopRight;

	public static string JoystickSett = "JoystickSettSettSett";

	protected bool _isCancellationRequested;

	public static event Action ControlsChanged;

	protected void HandleControlsClicked()
	{
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining("Controls", TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		Debug.Log("HandleControlsClicked " + GlobalGameController.LeftHanded);
		if (GlobalGameController.LeftHanded)
		{
			BottomRight.localPosition = new Vector3(0f, 0f, 0f);
			TopRight.localPosition = new Vector3(-512f, 450f, 0f);
			TopLeft.localPosition = new Vector3(0f, 450f, 0f);
			BottomLeft.localPosition = new Vector3(512f, 0f, 0f);
			BottomLeftControlsAnchor.side = UIAnchor.Side.BottomLeft;
			BottomRightControlsAnchor.side = UIAnchor.Side.BottomRight;
		}
		else
		{
			BottomRight.localPosition = new Vector3(512f, 0f, 0f);
			TopRight.localPosition = new Vector3(0f, 450f, 0f);
			TopLeft.localPosition = new Vector3(-512f, 450f, 0f);
			BottomLeft.localPosition = new Vector3(0f, 0f, 0f);
			BottomLeftControlsAnchor.side = UIAnchor.Side.BottomRight;
			BottomRightControlsAnchor.side = UIAnchor.Side.BottomLeft;
		}
		SetControlsCoords();
	}

	private void SetControlsCoords()
	{
		float num = ((!GlobalGameController.LeftHanded) ? (-1f) : 1f);
		Debug.Log("SetControlsCoords " + num);
		Vector3[] array = Load.LoadVector3Array(JoystickSett);
		if (array == null || array.Length < 7)
		{
			Defs.InitCoordsIphone();
			zoomButton.transform.localPosition = new Vector3((float)Defs.ZoomButtonX * num, Defs.ZoomButtonY, zoomButton.transform.localPosition.z);
			reloadButton.transform.localPosition = new Vector3((float)Defs.ReloadButtonX * num, Defs.ReloadButtonY, reloadButton.transform.localPosition.z);
			jumpButton.transform.localPosition = new Vector3((float)Defs.JumpButtonX * num, Defs.JumpButtonY, jumpButton.transform.localPosition.z);
			fireButton.transform.localPosition = new Vector3((float)Defs.FireButtonX * num, Defs.FireButtonY, fireButton.transform.localPosition.z);
			grenadeButton.transform.localPosition = new Vector3((float)Defs.GrenadeX * num, Defs.GrenadeY, grenadeButton.transform.localPosition.z);
			joystick.transform.localPosition = new Vector3((float)Defs.JoyStickX * num, Defs.JoyStickY, joystick.transform.localPosition.z);
			fireButtonInJoystick.transform.localPosition = new Vector3((float)Defs.FireButton2X * num, Defs.FireButton2Y, fireButtonInJoystick.transform.localPosition.z);
			return;
		}
		for (int i = 0; i < array.Length; i++)
		{
			array[i].x *= num;
		}
		zoomButton.transform.localPosition = array[0];
		reloadButton.transform.localPosition = array[1];
		jumpButton.transform.localPosition = array[2];
		fireButton.transform.localPosition = array[3];
		joystick.transform.localPosition = array[4];
		grenadeButton.transform.localPosition = array[5];
		fireButtonInJoystick.transform.localPosition = array[6];
	}

	protected void OnEnable()
	{
		if (ExperienceController.sharedController != null && !ShopNGUIController.GuiActive)
		{
			ExperienceController.sharedController.isShowRanks = false;
		}
		if (ExpController.Instance != null)
		{
			ExpController.Instance.InterfaceEnabled = false;
		}
		SetControlsCoords();
	}

	protected virtual void HandleSavePosJoystikClicked(object sender, EventArgs e)
	{
		float num = (GlobalGameController.LeftHanded ? 1 : (-1));
		Save.SaveVector3Array(JoystickSett, new Vector3[7]
		{
			new Vector3(zoomButton.transform.localPosition.x * num, zoomButton.transform.localPosition.y, zoomButton.transform.localPosition.z),
			new Vector3(reloadButton.transform.localPosition.x * num, reloadButton.transform.localPosition.y, reloadButton.transform.localPosition.z),
			new Vector3(jumpButton.transform.localPosition.x * num, jumpButton.transform.localPosition.y, jumpButton.transform.localPosition.z),
			new Vector3(fireButton.transform.localPosition.x * num, fireButton.transform.localPosition.y, fireButton.transform.localPosition.z),
			new Vector3(joystick.transform.localPosition.x * num, joystick.transform.localPosition.y, joystick.transform.localPosition.z),
			new Vector3(grenadeButton.transform.localPosition.x * num, grenadeButton.transform.localPosition.y, grenadeButton.transform.localPosition.z),
			new Vector3(fireButtonInJoystick.transform.localPosition.x * num, fireButtonInJoystick.transform.localPosition.y, fireButtonInJoystick.transform.localPosition.z)
		});
		SettingsJoysticksPanel.SetActive(false);
		settingsPanel.SetActive(true);
		ExperienceController.sharedController.isShowRanks = false;
		Action controlsChanged = ControlsSettingsBase.ControlsChanged;
		if (controlsChanged != null)
		{
			ControlsSettingsBase.ControlsChanged();
		}
	}

	private void HandleDefaultPosJoystikClicked(object sender, EventArgs e)
	{
		float num = (GlobalGameController.LeftHanded ? 1 : (-1));
		Defs.InitCoordsIphone();
		zoomButton.transform.localPosition = new Vector3((float)Defs.ZoomButtonX * num, Defs.ZoomButtonY, zoomButton.transform.localPosition.z);
		reloadButton.transform.localPosition = new Vector3((float)Defs.ReloadButtonX * num, Defs.ReloadButtonY, reloadButton.transform.localPosition.z);
		jumpButton.transform.localPosition = new Vector3((float)Defs.JumpButtonX * num, Defs.JumpButtonY, jumpButton.transform.localPosition.z);
		fireButton.transform.localPosition = new Vector3((float)Defs.FireButtonX * num, Defs.FireButtonY, fireButton.transform.localPosition.z);
		joystick.transform.localPosition = new Vector3((float)Defs.JoyStickX * num, Defs.JoyStickY, joystick.transform.localPosition.z);
		grenadeButton.transform.localPosition = new Vector3((float)Defs.GrenadeX * num, Defs.GrenadeY, grenadeButton.transform.localPosition.z);
		fireButtonInJoystick.transform.localPosition = new Vector3((float)Defs.FireButton2X * num, Defs.FireButton2Y, fireButtonInJoystick.transform.localPosition.z);
	}

	protected virtual void HandleCancelPosJoystikClicked(object sender, EventArgs e)
	{
		_isCancellationRequested = true;
	}

	protected void Start()
	{
		if (savePosJoystikButton != null)
		{
			ButtonHandler component = savePosJoystikButton.GetComponent<ButtonHandler>();
			if (component != null)
			{
				component.Clicked += HandleSavePosJoystikClicked;
			}
		}
		if (defaultPosJoystikButton != null)
		{
			ButtonHandler component2 = defaultPosJoystikButton.GetComponent<ButtonHandler>();
			if (component2 != null)
			{
				component2.Clicked += HandleDefaultPosJoystikClicked;
			}
		}
		if (cancelPosJoystikButton != null)
		{
			ButtonHandler component3 = cancelPosJoystikButton.GetComponent<ButtonHandler>();
			if (component3 != null)
			{
				component3.Clicked += HandleCancelPosJoystikClicked;
			}
		}
	}
}
