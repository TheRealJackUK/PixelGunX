using UnityEngine;

internal sealed class JoystickController : MonoBehaviour
{
	public static UIJoystick leftJoystick;

	public static TouchPadController rightJoystick;

	public static TouchPadInJoystick leftTouchPad;

	public UIJoystick _leftJoystick;

	public TouchPadController _rightJoystick;

	public TouchPadInJoystick _leftTouchPad;

	private void Awake()
	{
		leftJoystick = _leftJoystick;
		rightJoystick = _rightJoystick;
		leftTouchPad = _leftTouchPad;
	}

	private void OnDestroy()
	{
		leftJoystick = null;
		rightJoystick = null;
		leftTouchPad = null;
	}
}
