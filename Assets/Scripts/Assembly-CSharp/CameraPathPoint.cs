using UnityEngine;

[ExecuteInEditMode]
public class CameraPathPoint : MonoBehaviour
{
	public enum PositionModes
	{
		Free,
		FixedToPoint,
		FixedToPercent
	}

	public PositionModes positionModes;

	public string givenName = string.Empty;

	public string customName = string.Empty;

	public string fullName = string.Empty;

	[SerializeField]
	protected float _percent;

	[SerializeField]
	protected float _animationPercentage;

	public CameraPathControlPoint point;

	public int index;

	public CameraPathControlPoint cpointA;

	public CameraPathControlPoint cpointB;

	public float curvePercentage;

	public Vector3 worldPosition;

	public bool lockPoint;

	public float percent
	{
		get
		{
			switch (positionModes)
			{
			case PositionModes.Free:
				return _percent;
			case PositionModes.FixedToPercent:
				return _percent;
			case PositionModes.FixedToPoint:
				return point.percentage;
			default:
				return _percent;
			}
		}
		set
		{
			_percent = value;
		}
	}

	public float rawPercent
	{
		get
		{
			return _percent;
		}
	}

	public float animationPercentage
	{
		get
		{
			switch (positionModes)
			{
			case PositionModes.Free:
				return _animationPercentage;
			case PositionModes.FixedToPercent:
				return _animationPercentage;
			case PositionModes.FixedToPoint:
				return point.normalisedPercentage;
			default:
				return _percent;
			}
		}
		set
		{
			_animationPercentage = value;
		}
	}

	public string displayName
	{
		get
		{
			if (customName != string.Empty)
			{
				return customName;
			}
			return givenName;
		}
	}

	private void OnEnable()
	{
		base.hideFlags = HideFlags.HideInInspector;
	}
}
