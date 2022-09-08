using UnityEngine;

public class CameraPathPoint : MonoBehaviour
{
	public enum PositionModes
	{
		Free = 0,
		FixedToPoint = 1,
		FixedToPercent = 2,
	}

	public PositionModes positionModes;
	public string givenName;
	public string customName;
	public string fullName;
	[SerializeField]
	protected float float_0;
	[SerializeField]
	protected float float_1;
	public CameraPathControlPoint point;
	public int index;
	public CameraPathControlPoint cpointA;
	public CameraPathControlPoint cpointB;
	public float curvePercentage;
	public Vector3 worldPosition;
	public bool lockPoint;
}
