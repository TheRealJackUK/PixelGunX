using UnityEngine;

public sealed class CameraTouchControlScheme_SmoothDump : CameraTouchControlScheme
{
	public float startMovingThresholdSq = 4f;

	public float senseModifier = 0.03f;

	public Vector2 senseModifierByAxis = new Vector2(1f, 0.8f);

	public float dampingTime = 0.01f;

	private bool _grabTouches;

	private int _touchId;

	private Vector2 _firstTouchPosition;

	private Vector2 _previousTouchPosition;

	private Vector2 _currentTouchPosition;

	private bool _isTouchInputValid;

	private bool _isTouchMoving;

	private Quaternion _originalRotationPitch;

	private Quaternion _originalRotationYaw;

	private Vector2? _followPitchYaw;

	private Vector2 _followPitchYawVelocity;

	private Vector2? _targetPitchYaw;

	public override void OnPress(bool isDown)
	{
		if ((isDown && _touchId == -100) || (!isDown && _touchId != -100))
		{
			_grabTouches = isDown;
			_touchId = ((!isDown) ? (-100) : UICamera.currentTouchID);
			_firstTouchPosition = UICamera.currentTouch.pos;
			_previousTouchPosition = _firstTouchPosition;
			_currentTouchPosition = _firstTouchPosition;
			_isTouchMoving = false;
		}
	}

	public override void OnUpdate()
	{
		_isTouchInputValid = false;
		Touch? touch = null;
		if (_grabTouches)
		{
			Touch[] touches = Input.touches;
			for (int i = 0; i < touches.Length; i++)
			{
				Touch value = touches[i];
				if (value.fingerId == _touchId && (value.phase == TouchPhase.Moved || value.phase == TouchPhase.Stationary))
				{
					_isTouchInputValid = true;
					_previousTouchPosition = _currentTouchPosition;
					_currentTouchPosition = value.position;
					touch = value;
					break;
				}
			}
		}
		_deltaPosition = Vector2.zero;
		if (_isTouchInputValid && (_isTouchMoving || !((_currentTouchPosition - _firstTouchPosition).sqrMagnitude < startMovingThresholdSq)))
		{
			if (!_isTouchMoving)
			{
				_isTouchMoving = true;
			}
			else
			{
				_deltaPosition = _currentTouchPosition - _previousTouchPosition;
			}
		}
	}

	public override void Reset()
	{
		_deltaPosition = Vector2.zero;
		_grabTouches = false;
		_touchId = -100;
		_isTouchInputValid = false;
		_isTouchMoving = false;
	}

	public override void ApplyDeltaTo(Vector2 deltaPosition, Transform yawTransform, Transform pitchTransform, float sensitivity, bool invert)
	{
		if (_isTouchInputValid)
		{
			if (!_followPitchYaw.HasValue)
			{
				_originalRotationPitch = pitchTransform.localRotation;
				_originalRotationYaw = yawTransform.rotation;
				_followPitchYaw = Vector2.zero;
				_targetPitchYaw = Vector2.zero;
			}
			Vector2 value = _followPitchYaw.Value;
			Vector2 value2 = _targetPitchYaw.Value;
			if (value2.x > 180f)
			{
				value2.x -= 360f;
				value.x -= 360f;
			}
			if (value2.y > 180f)
			{
				value2.y -= 360f;
				value.y -= 360f;
			}
			if (value2.x < -180f)
			{
				value2.x += 360f;
				value.x += 360f;
			}
			if (value2.y < -180f)
			{
				value2.y += 360f;
				value.y += 360f;
			}
			value2.x += deltaPosition.y * sensitivity * senseModifier * senseModifierByAxis.y;
			value2.y += deltaPosition.x * sensitivity * senseModifier * senseModifierByAxis.x;
			value2.x = Mathf.Clamp(value2.x, -65f, 80f);
			value.x = Mathf.SmoothDamp(value.x, value2.x, ref _followPitchYawVelocity.x, dampingTime);
			value.y = Mathf.SmoothDamp(value.y, value2.y, ref _followPitchYawVelocity.y, dampingTime);
			_followPitchYaw = value;
			_targetPitchYaw = value2;
		}
		else
		{
			_followPitchYaw = _targetPitchYaw;
			_followPitchYawVelocity = Vector2.zero;
			_targetPitchYaw = null;
		}
		if (_followPitchYaw.HasValue)
		{
			yawTransform.rotation = _originalRotationYaw * Quaternion.Euler(0f, _followPitchYaw.Value.y, 0f);
			pitchTransform.localRotation = _originalRotationPitch * Quaternion.Euler(_followPitchYaw.Value.x * ((!invert) ? (-1f) : 1f), 0f, 0f);
		}
		if (!_isTouchInputValid)
		{
			_followPitchYaw = null;
		}
	}
}
