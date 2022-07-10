using System.Collections;
using System.Reflection;
using UnityEngine;

public sealed class CameraTouchControlScheme_LowPassFilter : CameraTouchControlScheme
{
	public float dragClampInterval = 1.5f;

	public float dragClamp = 1f;

	public float lerpCoeff = 0.25f;

	private Vector2? _accumulatedDrag;

	private Vector2? _unfilteredAccumulatedDrag;

	private bool limitDrag;

	private bool firstDrag;

	private Vector2? _azimuthTilt;

	public override void OnPress(bool isDown)
	{
		if (isDown)
		{
			_accumulatedDrag = Vector2.zero;
			_unfilteredAccumulatedDrag = Vector2.zero;
		}
		else
		{
			_accumulatedDrag = null;
			_unfilteredAccumulatedDrag = null;
		}
		firstDrag = isDown;
		limitDrag = isDown;
		if (isDown)
		{
			if ((bool)JoystickController.rightJoystick)
			{
				JoystickController.rightJoystick.StartCoroutine(CancelLimitDrag());
			}
		}
		else if ((bool)JoystickController.rightJoystick)
		{
			JoystickController.rightJoystick.StopCoroutine(CancelLimitDrag());
		}
	}

	[Obfuscation(Exclude = true)]
	private IEnumerator CancelLimitDrag()
	{
		yield return new WaitForSeconds(dragClampInterval);
		limitDrag = false;
	}

	public override void OnDrag(Vector2 delta)
	{
		if (!firstDrag)
		{
			_deltaPosition = delta;
		}
		firstDrag = false;
		if (limitDrag)
		{
			limitDrag = false;
			if ((bool)JoystickController.rightJoystick)
			{
				JoystickController.rightJoystick.StopCoroutine(CancelLimitDrag());
			}
			_deltaPosition = Vector2.ClampMagnitude(delta, dragClamp);
		}
		if (_accumulatedDrag.HasValue && _unfilteredAccumulatedDrag.HasValue)
		{
			Vector2 deltaPosition = _deltaPosition;
			Vector2 vector = _unfilteredAccumulatedDrag.Value + deltaPosition;
			Vector2 value = _accumulatedDrag.Value;
			Vector2 value2 = Vector2.Lerp(value, vector, lerpCoeff);
			_accumulatedDrag = value2;
			_unfilteredAccumulatedDrag = vector;
		}
	}

	public override void Reset()
	{
		_deltaPosition = Vector2.zero;
		_accumulatedDrag = null;
		_unfilteredAccumulatedDrag = null;
	}

	public override void ApplyDeltaTo(Vector2 deltaPosition, Transform yawTransform, Transform pitchTransform, float sensitivity, bool invert)
	{
		if (_accumulatedDrag.HasValue)
		{
			if (_azimuthTilt.HasValue)
			{
				Vector2 value = _accumulatedDrag.Value;
				float num = sensitivity / 30f;
				yawTransform.rotation = Quaternion.Euler(0f, _azimuthTilt.Value.x + value.x * num, 0f);
				float num2 = _azimuthTilt.Value.y;
				if (num2 > 180f)
				{
					num2 -= 360f;
				}
				float num3 = num2 + value.y * ((!invert) ? (-1f) : 1f) * num;
				if (num3 > 80f)
				{
					num3 = 80f;
				}
				if (num3 < -65f)
				{
					num3 = -65f;
				}
				pitchTransform.localRotation = Quaternion.Euler(num3, 0f, 0f);
			}
			else
			{
				_azimuthTilt = new Vector2(yawTransform.rotation.eulerAngles.y, pitchTransform.localEulerAngles.x);
			}
		}
		else
		{
			_azimuthTilt = null;
		}
	}
}
