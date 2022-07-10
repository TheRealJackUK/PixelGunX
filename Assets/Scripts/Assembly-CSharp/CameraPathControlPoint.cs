using UnityEngine;

[ExecuteInEditMode]
public class CameraPathControlPoint : MonoBehaviour
{
	public string givenName = string.Empty;

	public string customName = string.Empty;

	public string fullName = string.Empty;

	[SerializeField]
	private Vector3 _position;

	[SerializeField]
	private bool _splitControlPoints;

	[SerializeField]
	private Vector3 _forwardControlPoint;

	[SerializeField]
	private Vector3 _backwardControlPoint;

	[SerializeField]
	private Vector3 _pathDirection = Vector3.forward;

	public int index;

	public float percentage;

	public float normalisedPercentage;

	public Vector3 localPosition
	{
		get
		{
			return base.transform.rotation * _position;
		}
		set
		{
			Vector3 vector = value;
			vector = (_position = Quaternion.Inverse(base.transform.rotation) * vector);
		}
	}

	public Vector3 worldPosition
	{
		get
		{
			return base.transform.rotation * _position + base.transform.position;
		}
		set
		{
			Vector3 vector = value - base.transform.position;
			vector = (_position = Quaternion.Inverse(base.transform.rotation) * vector);
		}
	}

	public Vector3 forwardControlPointWorld
	{
		get
		{
			return forwardControlPoint + base.transform.position;
		}
		set
		{
			forwardControlPoint = value - base.transform.position;
		}
	}

	public Vector3 forwardControlPoint
	{
		get
		{
			return base.transform.rotation * (_forwardControlPoint + _position);
		}
		set
		{
			Vector3 vector = value;
			vector = Quaternion.Inverse(base.transform.rotation) * vector;
			vector += -_position;
			_forwardControlPoint = vector;
		}
	}

	public Vector3 forwardControlPointLocal
	{
		get
		{
			return base.transform.rotation * _forwardControlPoint;
		}
		set
		{
			Vector3 vector = value;
			vector = (_forwardControlPoint = Quaternion.Inverse(base.transform.rotation) * vector);
		}
	}

	public Vector3 backwardControlPointWorld
	{
		get
		{
			return backwardControlPoint + base.transform.position;
		}
		set
		{
			backwardControlPoint = value - base.transform.position;
		}
	}

	public Vector3 backwardControlPoint
	{
		get
		{
			Vector3 vector = ((!_splitControlPoints) ? (-_forwardControlPoint) : _backwardControlPoint);
			return base.transform.rotation * (vector + _position);
		}
		set
		{
			Vector3 vector = value;
			vector = Quaternion.Inverse(base.transform.rotation) * vector;
			vector += -_position;
			if (_splitControlPoints)
			{
				_backwardControlPoint = vector;
			}
			else
			{
				_forwardControlPoint = -vector;
			}
		}
	}

	public bool splitControlPoints
	{
		get
		{
			return _splitControlPoints;
		}
		set
		{
			if (value != _splitControlPoints)
			{
				_backwardControlPoint = -_forwardControlPoint;
			}
			_splitControlPoints = value;
		}
	}

	public Vector3 trackDirection
	{
		get
		{
			return _pathDirection;
		}
		set
		{
			if (!(value == Vector3.zero))
			{
				_pathDirection = value.normalized;
			}
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

	public void CopyData(CameraPathControlPoint to)
	{
		to.customName = customName;
		to.index = index;
		to.percentage = percentage;
		to.normalisedPercentage = normalisedPercentage;
		to.worldPosition = worldPosition;
		to.splitControlPoints = _splitControlPoints;
		to.forwardControlPoint = _forwardControlPoint;
		to.backwardControlPoint = _backwardControlPoint;
	}
}
