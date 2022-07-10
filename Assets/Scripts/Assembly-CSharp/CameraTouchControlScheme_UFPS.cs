using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;

public sealed class CameraTouchControlScheme_UFPS : CameraTouchControlScheme
{
	public float startMovingThresholdSq = 4f;

	public Vector2 mouseLookSensitivity = new Vector2(2.8f, 1.876f);

	public int mouseLookSmoothSteps = 10;

	public float mouseLookSmoothWeight = 0.15f;

	public bool mouseLookAcceleration;

	public float mouseLookAccelerationThreshold = 0.4f;

	private bool _grabTouches;

	private int _touchId;

	private Vector2 _firstTouchPosition;

	private Vector2 _previousTouchPosition;

	private Vector2 _currentTouchPosition;

	private bool _isTouchInputValid;

	private bool _isTouchMoving;

	private Quaternion _originalRotationPitch;

	private Quaternion _originalRotationYaw;

	private Vector2? _pitchYaw;

	private Vector2 m_MouseLookSmoothMove = Vector2.zero;

	private List<Vector2> m_MouseLookSmoothBuffer = new List<Vector2>();

	private int m_LastMouseLookFrame = -1;

	private Vector2 m_CurrentMouseLook = Vector2.zero;

	private float Delta
	{
		get
		{
			return Time.deltaTime * 30f;
		}
	}

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
		deltaPosition *= sensitivity * 0.01f;
		deltaPosition = new Vector2(deltaPosition.x, deltaPosition.y);
		Vector2 mouseLook = GetMouseLook(deltaPosition);
		if (_isTouchInputValid)
		{
			if (!_pitchYaw.HasValue)
			{
				_originalRotationPitch = pitchTransform.localRotation;
				_originalRotationYaw = yawTransform.rotation;
				_pitchYaw = Vector2.zero;
			}
			Vector2 value = _pitchYaw.Value;
			value.x += mouseLook.y;
			value.y += mouseLook.x;
			if (value.x > 180f)
			{
				value.x -= 360f;
			}
			if (value.y > 180f)
			{
				value.y -= 360f;
			}
			if (value.x < -180f)
			{
				value.x += 360f;
			}
			if (value.y < -180f)
			{
				value.y += 360f;
			}
			value.x = Mathf.Clamp(value.x, -89.5f, 89.5f);
			value.y = Mathf.Clamp(value.y, -360f, 360f);
			_pitchYaw = value;
			yawTransform.rotation = _originalRotationYaw;
			pitchTransform.localRotation = _originalRotationPitch;
			yawTransform.rotation = _originalRotationYaw * Quaternion.Euler(0f, _pitchYaw.Value.y, 0f);
			pitchTransform.localRotation = _originalRotationPitch * Quaternion.Euler(_pitchYaw.Value.x * ((!invert) ? (-1f) : 1f), 0f, 0f);
		}
		else
		{
			_pitchYaw = null;
		}
	}

	public Vector2 GetMouseLook(Vector2 touchDeltaPosition)
	{
		if (m_LastMouseLookFrame == Time.frameCount)
		{
			return m_CurrentMouseLook;
		}
		m_LastMouseLookFrame = Time.frameCount;
		m_MouseLookSmoothMove.x = touchDeltaPosition.x * Time.timeScale;
		m_MouseLookSmoothMove.y = touchDeltaPosition.y * Time.timeScale;
		mouseLookSmoothSteps = Mathf.Clamp(mouseLookSmoothSteps, 1, 20);
		mouseLookSmoothWeight = Mathf.Clamp01(mouseLookSmoothWeight);
		while (m_MouseLookSmoothBuffer.Count > mouseLookSmoothSteps)
		{
			m_MouseLookSmoothBuffer.RemoveAt(0);
		}
		m_MouseLookSmoothBuffer.Add(m_MouseLookSmoothMove);
		float num = 1f;
		Vector2 zero = Vector2.zero;
		float num2 = 0f;
		for (int num3 = m_MouseLookSmoothBuffer.Count - 1; num3 > 0; num3--)
		{
			zero += m_MouseLookSmoothBuffer[num3] * num;
			num2 += 1f * num;
			num *= mouseLookSmoothWeight / Delta;
		}
		num2 = Mathf.Max(1f, num2);
		m_CurrentMouseLook = NaNSafeVector2(zero / num2);
		float num4 = 0f;
		float num5 = Mathf.Abs(m_CurrentMouseLook.x);
		float num6 = Mathf.Abs(m_CurrentMouseLook.y);
		if (mouseLookAcceleration)
		{
			num4 = Mathf.Sqrt(num5 * num5 + num6 * num6) / Delta;
			num4 = ((!(num4 <= mouseLookAccelerationThreshold)) ? num4 : 0f);
		}
		m_CurrentMouseLook.x *= mouseLookSensitivity.x + num4;
		m_CurrentMouseLook.y *= mouseLookSensitivity.y + num4;
		return m_CurrentMouseLook;
	}

	private static Vector2 NaNSafeVector2(Vector2 vector, [Optional] Vector2 prevVector)
	{
		vector.x = ((!double.IsNaN(vector.x)) ? vector.x : prevVector.x);
		vector.y = ((!double.IsNaN(vector.y)) ? vector.y : prevVector.y);
		return vector;
	}
}
