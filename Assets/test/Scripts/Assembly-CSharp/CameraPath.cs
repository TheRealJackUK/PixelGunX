using UnityEngine;
using System.Collections.Generic;

public class CameraPath : MonoBehaviour
{
	public enum Interpolation
	{
		Linear = 0,
		SmoothStep = 1,
		CatmullRom = 2,
		Hermite = 3,
		Bezier = 4,
	}

	public enum PointModes
	{
		Transform = 0,
		ControlPoints = 1,
		FOV = 2,
		Events = 3,
		Speed = 4,
		Delay = 5,
		Ease = 6,
		Orientations = 7,
		Tilt = 8,
		AddPathPoints = 9,
		RemovePathPoints = 10,
		AddOrientations = 11,
		RemoveOrientations = 12,
		TargetOrientation = 13,
		AddFovs = 14,
		RemoveFovs = 15,
		AddTilts = 16,
		RemoveTilts = 17,
		AddEvents = 18,
		RemoveEvents = 19,
		AddSpeeds = 20,
		RemoveSpeeds = 21,
		AddDelays = 22,
		RemoveDelays = 23,
		Options = 24,
	}

	public float version;
	[SerializeField]
	private List<CameraPathControlPoint> list_0;
	[SerializeField]
	private Interpolation interpolation_0;
	[SerializeField]
	private bool bool_0;
	[SerializeField]
	private float float_2;
	[SerializeField]
	private float[] float_3;
	[SerializeField]
	private float[] float_4;
	[SerializeField]
	private Vector3[] vector3_0;
	[SerializeField]
	private float[] float_5;
	[SerializeField]
	private float float_6;
	[SerializeField]
	private int int_0;
	[SerializeField]
	private Vector3[] vector3_1;
	[SerializeField]
	private CameraPathControlPoint[] cameraPathControlPoint_0;
	[SerializeField]
	private CameraPathControlPoint[] cameraPathControlPoint_1;
	[SerializeField]
	private CameraPathOrientationList cameraPathOrientationList_0;
	[SerializeField]
	private CameraPathFOVList cameraPathFOVList_0;
	[SerializeField]
	private CameraPathTiltList cameraPathTiltList_0;
	[SerializeField]
	private CameraPathSpeedList cameraPathSpeedList_0;
	[SerializeField]
	private CameraPathEventList cameraPathEventList_0;
	[SerializeField]
	private CameraPathDelayList cameraPathDelayList_0;
	[SerializeField]
	private bool bool_1;
	[SerializeField]
	private bool bool_2;
	[SerializeField]
	private bool bool_3;
	[SerializeField]
	private Bounds bounds_0;
	public float hermiteTension;
	public float hermiteBias;
	public GameObject editorPreview;
	public int selectedPoint;
	public PointModes pointMode;
	public float addPointAtPercent;
	[SerializeField]
	private CameraPath cameraPath_0;
	[SerializeField]
	private bool bool_4;
	public bool showGizmos;
	public Color selectedPathColour;
	public Color unselectedPathColour;
	public Color selectedPointColour;
	public Color unselectedPointColour;
	public bool showOrientationIndicators;
	public float orientationIndicatorUnitLength;
	public Color orientationIndicatorColours;
	public bool autoSetStoedPointRes;
	public bool enableUndo;
	public bool showPreview;
	public bool enablePreviews;
}
