using UnityEngine;
using UnityEngine.UI;

public sealed class CameraTouchControlSchemeConfigurator : MonoBehaviour
{
	public Toggle toggleCleanNGUI;

	public Toggle toggleSmoothDump;

	public Toggle toggleLowPassFilter;

	public Toggle toggleUFPS;

	public RectTransform panelCleanNGUI;

	public RectTransform panelSmoothDump;

	public RectTransform panelLowPassFilter;

	public RectTransform panelUFPS;

	public InputField firstDragClampedMax1;

	public InputField startMovingThreshold1;

	public InputField senseModifier;

	public InputField senseModifierByAxisX;

	public InputField senseModifierByAxisY;

	public InputField dampingTime;

	public InputField firstDragClampedMax2;

	public InputField lerpCoeff;

	public InputField startMovingThreshold2;

	public InputField mouseLookSensitivityX;

	public InputField mouseLookSensitivityY;

	public InputField mouseLookSmoothSteps;

	public InputField mouseLookSmoothWeight;

	public Toggle mouseLookAcceleration;

	public InputField mouseLookAccelerationThreshold;

	private static CameraTouchControlScheme_CleanNGUI touchControlScheme_CleanNGUI = new CameraTouchControlScheme_CleanNGUI();

	private static CameraTouchControlScheme_SmoothDump touchControlScheme_SmoothDump = new CameraTouchControlScheme_SmoothDump();

	private static CameraTouchControlScheme_LowPassFilter touchControlScheme_LowPassFilter = new CameraTouchControlScheme_LowPassFilter();

	private static CameraTouchControlScheme_UFPS touchControlScheme_UFPS = new CameraTouchControlScheme_UFPS();

	public static CameraTouchControlSchemeConfigurator Instance { get; private set; }

	public void Start()
	{
		Instance = this;
		OnEnable();
	}

	private void OnEnable()
	{
		CameraTouchControlScheme touchControlScheme = JoystickController.rightJoystick.touchControlScheme;
		if (touchControlScheme == touchControlScheme_CleanNGUI)
		{
			toggleCleanNGUI.isOn = true;
		}
		else if (touchControlScheme == touchControlScheme_SmoothDump)
		{
			toggleSmoothDump.isOn = true;
		}
		else if (touchControlScheme == touchControlScheme_LowPassFilter)
		{
			toggleLowPassFilter.isOn = true;
		}
		else if (touchControlScheme == touchControlScheme_UFPS)
		{
			toggleUFPS.isOn = true;
		}
	}

	private void OnDestroy()
	{
		Instance = null;
	}

	private void ShowPanel(RectTransform panel)
	{
		panelCleanNGUI.gameObject.SetActive(false);
		panelSmoothDump.gameObject.SetActive(false);
		panelLowPassFilter.gameObject.SetActive(false);
		panelUFPS.gameObject.SetActive(false);
		panel.gameObject.SetActive(true);
	}

	public void OnToggleChanged(bool isOn)
	{
		SyncUI();
	}

	public static void Show()
	{
		if (Instance == null)
		{
			GameObject original = Resources.Load<GameObject>("InputDebug");
			GameObject gameObject = Object.Instantiate(original, Vector3.zero, Quaternion.identity) as GameObject;
			Instance = gameObject.GetComponent<CameraTouchControlSchemeConfigurator>();
		}
		Instance.gameObject.SetActive(true);
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.SetInterfaceVisible(false);
		}
	}

	public void Close()
	{
		if (InGameGUI.sharedInGameGUI != null)
		{
			InGameGUI.sharedInGameGUI.SetInterfaceVisible(true);
		}
		Object.Destroy(base.gameObject);
	}

	public void SyncUI()
	{
		if (toggleCleanNGUI.isOn)
		{
			ShowPanel(panelCleanNGUI);
			firstDragClampedMax1.text = touchControlScheme_CleanNGUI.firstDragClampedMax.ToString();
		}
		else if (toggleSmoothDump.isOn)
		{
			ShowPanel(panelSmoothDump);
			startMovingThreshold1.text = Mathf.Round(Mathf.Sqrt(touchControlScheme_SmoothDump.startMovingThresholdSq)).ToString();
			senseModifier.text = touchControlScheme_SmoothDump.senseModifier.ToString();
			senseModifierByAxisX.text = touchControlScheme_SmoothDump.senseModifierByAxis.x.ToString();
			senseModifierByAxisY.text = touchControlScheme_SmoothDump.senseModifierByAxis.y.ToString();
			dampingTime.text = touchControlScheme_SmoothDump.dampingTime.ToString();
		}
		else if (toggleLowPassFilter.isOn)
		{
			ShowPanel(panelLowPassFilter);
			firstDragClampedMax2.text = touchControlScheme_LowPassFilter.dragClamp.ToString();
			lerpCoeff.text = touchControlScheme_LowPassFilter.lerpCoeff.ToString();
		}
		else if (toggleUFPS.isOn)
		{
			ShowPanel(panelUFPS);
			startMovingThreshold2.text = Mathf.Round(Mathf.Sqrt(touchControlScheme_UFPS.startMovingThresholdSq)).ToString();
			mouseLookSensitivityX.text = touchControlScheme_UFPS.mouseLookSensitivity.x.ToString();
			mouseLookSensitivityY.text = touchControlScheme_UFPS.mouseLookSensitivity.y.ToString();
			mouseLookSmoothSteps.text = touchControlScheme_UFPS.mouseLookSmoothSteps.ToString();
			mouseLookSmoothWeight.text = touchControlScheme_UFPS.mouseLookSmoothWeight.ToString();
			mouseLookAcceleration.isOn = touchControlScheme_UFPS.mouseLookAcceleration;
			mouseLookAccelerationThreshold.text = touchControlScheme_UFPS.mouseLookAccelerationThreshold.ToString();
		}
	}

	public void ApplySettings()
	{
		if (toggleCleanNGUI.isOn)
		{
			if (true && float.TryParse(firstDragClampedMax1.text, out touchControlScheme_CleanNGUI.firstDragClampedMax))
			{
				ChangeTouchControlScheme(touchControlScheme_CleanNGUI);
				Close();
			}
		}
		else if (toggleSmoothDump.isOn)
		{
			bool flag = true;
			float result = 0f;
			flag = flag && float.TryParse(startMovingThreshold1.text, out result);
			touchControlScheme_SmoothDump.startMovingThresholdSq = result * result;
			if (flag && float.TryParse(senseModifier.text, out touchControlScheme_SmoothDump.senseModifier) && float.TryParse(senseModifierByAxisX.text, out touchControlScheme_SmoothDump.senseModifierByAxis.x) && float.TryParse(senseModifierByAxisY.text, out touchControlScheme_SmoothDump.senseModifierByAxis.y) && float.TryParse(dampingTime.text, out touchControlScheme_SmoothDump.dampingTime))
			{
				ChangeTouchControlScheme(touchControlScheme_SmoothDump);
				Close();
			}
		}
		else if (toggleLowPassFilter.isOn)
		{
			if (true && float.TryParse(firstDragClampedMax2.text, out touchControlScheme_LowPassFilter.dragClamp) && float.TryParse(lerpCoeff.text, out touchControlScheme_LowPassFilter.lerpCoeff))
			{
				ChangeTouchControlScheme(touchControlScheme_LowPassFilter);
				Close();
			}
		}
		else if (toggleUFPS.isOn)
		{
			bool flag2 = true;
			float result2 = 0f;
			flag2 = flag2 && float.TryParse(startMovingThreshold2.text, out result2);
			touchControlScheme_UFPS.startMovingThresholdSq = result2 * result2;
			flag2 = flag2 && float.TryParse(mouseLookSensitivityX.text, out touchControlScheme_UFPS.mouseLookSensitivity.x) && float.TryParse(mouseLookSensitivityY.text, out touchControlScheme_UFPS.mouseLookSensitivity.y) && int.TryParse(mouseLookSmoothSteps.text, out touchControlScheme_UFPS.mouseLookSmoothSteps) && float.TryParse(mouseLookSmoothWeight.text, out touchControlScheme_UFPS.mouseLookSmoothWeight);
			touchControlScheme_UFPS.mouseLookAcceleration = mouseLookAcceleration.isOn;
			if (flag2 && float.TryParse(mouseLookAccelerationThreshold.text, out touchControlScheme_UFPS.mouseLookAccelerationThreshold))
			{
				ChangeTouchControlScheme(touchControlScheme_UFPS);
				Close();
			}
		}
	}

	private void ChangeTouchControlScheme(CameraTouchControlScheme touchControlScheme)
	{
		if (JoystickController.rightJoystick != null)
		{
			JoystickController.rightJoystick.touchControlScheme = touchControlScheme;
		}
	}
}
