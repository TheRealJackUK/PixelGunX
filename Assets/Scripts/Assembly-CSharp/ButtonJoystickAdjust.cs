using System;
using UnityEngine;

public class ButtonJoystickAdjust : MonoBehaviour
{
	public GameObject ZoneTopLeft;

	public GameObject ZoneBottonRight;

	private bool _isZone = true;

	public float TimeBlink = 0.5f;

	private float _curTimeBlink;

	public bool IsPress;

	public bool _isDrag;

	private bool _isHidden;

	private bool _isDragLate = true;

	public static EventHandler<EventArgs> PressedDown;

	private Vector3? _nonClampedPosition;

	private void Start()
	{
		if (ZoneBottonRight == null || ZoneTopLeft == null)
		{
			_isZone = false;
		}
	}

	private void OnDrag(Vector2 delta)
	{
		delta /= Defs.Coef;
		_isDrag = true;
		if (_isZone)
		{
			Vector3 localPosition = ZoneTopLeft.transform.localPosition;
			Vector3 localPosition2 = ZoneBottonRight.transform.localPosition;
			if (_nonClampedPosition.HasValue)
			{
				_nonClampedPosition = new Vector3(_nonClampedPosition.Value.x + delta.x, _nonClampedPosition.Value.y + delta.y, 0f);
				Vector3 localPosition3 = new Vector3(Mathf.Clamp(_nonClampedPosition.Value.x, localPosition.x, localPosition2.x), Mathf.Clamp(_nonClampedPosition.Value.y, localPosition2.y, localPosition.y), _nonClampedPosition.Value.z);
				base.transform.localPosition = localPosition3;
			}
		}
		else
		{
			Vector3 localPosition4 = new Vector3(base.transform.localPosition.x + delta.x, base.transform.localPosition.y + delta.y, 0f);
			base.transform.localPosition = localPosition4;
		}
	}

	private void OnPress(bool isDown)
	{
		IsPress = isDown;
		if (isDown)
		{
			_nonClampedPosition = new Vector3(base.transform.localPosition.x, base.transform.localPosition.y, 0f);
			EventHandler<EventArgs> pressedDown = PressedDown;
			if (pressedDown != null)
			{
				pressedDown(base.gameObject, EventArgs.Empty);
			}
		}
		else
		{
			_nonClampedPosition = null;
		}
	}

	private void LateUpdate()
	{
		if (IsPress)
		{
			if (_curTimeBlink < 0f)
			{
				if (_isHidden)
				{
					TweenAlpha.Begin(base.gameObject, TimeBlink, 0.9f);
					_isHidden = false;
				}
				else
				{
					TweenAlpha.Begin(base.gameObject, TimeBlink, 0.1f);
					_isHidden = true;
				}
				_curTimeBlink = TimeBlink;
			}
			else
			{
				_curTimeBlink -= Time.deltaTime;
			}
			_isDragLate = false;
		}
		else if (!_isDragLate)
		{
			TweenAlpha.Begin(base.gameObject, 0.5f, 1f);
			_isHidden = false;
			_curTimeBlink = TimeBlink;
			_isDragLate = true;
		}
	}

	public bool IsDrag()
	{
		bool isDrag = _isDrag;
		_isDrag = false;
		return isDrag;
	}

	public Vector2 GetJoystickPosition()
	{
		Vector3 localPosition = base.transform.localPosition;
		return new Vector2(localPosition.x, localPosition.y);
	}

	public void SetJoystickPosition(Vector2 position)
	{
		base.transform.localPosition = position;
	}
}
