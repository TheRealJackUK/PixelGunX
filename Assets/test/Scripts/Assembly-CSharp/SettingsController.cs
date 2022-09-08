using UnityEngine;

internal class SettingsController : MonoBehaviour
{
	public MainMenuHeroCamera rotateCamera;
	public UIButton backButton;
	public UIButton controlsButton;
	public GameObject controlsSettings;
	public GameObject tapPanel;
	public GameObject swipePanel;
	public GameObject mainPanel;
	public GameObject socialPanel;
	public UISlider sensitivitySlider;
	public UILabel versionLabel;
	public SettingsToggleButtons chatToggleButtons;
	public SettingsToggleButtons musicToggleButtons;
	public SettingsToggleButtons soundToggleButtons;
	public SettingsToggleButtons invertCameraToggleButtons;
	public SettingsToggleButtons leftHandedToggleButtons;
	public UILabel resolution;
	public UIPopupList resolutionPopup;
	public UIToggle windowMode;
}
