using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class CameraPath : MonoBehaviour
{
	public enum PointModes
	{
		Transform,
		ControlPoints,
		FOV,
		Events,
		Speed,
		Delay,
		Ease,
		Orientations,
		Tilt,
		AddPathPoints,
		RemovePathPoints,
		AddOrientations,
		RemoveOrientations,
		TargetOrientation,
		AddFovs,
		RemoveFovs,
		AddTilts,
		RemoveTilts,
		AddEvents,
		RemoveEvents,
		AddSpeeds,
		RemoveSpeeds,
		AddDelays,
		RemoveDelays,
		Options
	}

	public enum Interpolation
	{
		Linear,
		SmoothStep,
		CatmullRom,
		Hermite,
		Bezier
	}

	public delegate void RecalculateCurvesHandler();

	public delegate void PathPointAddedHandler(CameraPathControlPoint point);

	public delegate void PathPointRemovedHandler(CameraPathControlPoint point);

	public delegate void CheckStartPointCullHandler(float percentage);

	public delegate void CheckEndPointCullHandler(float percentage);

	public delegate void CleanUpListsHandler();

	private const float CLIP_THREASHOLD = 0.5f;

	public static float CURRENT_VERSION_NUMBER = 3.2f;

	public float version = CURRENT_VERSION_NUMBER;

	[SerializeField]
	private List<CameraPathControlPoint> _points = new List<CameraPathControlPoint>();

	[SerializeField]
	private Interpolation _interpolation = Interpolation.Bezier;

	[SerializeField]
	private bool initialised;

	[SerializeField]
	private float _storedTotalArcLength;

	[SerializeField]
	private float[] _storedArcLengths;

	[SerializeField]
	private float[] _storedArcLengthsFull;

	[SerializeField]
	private Vector3[] _storedPoints;

	[SerializeField]
	private float[] _normalisedPercentages;

	[SerializeField]
	private float _storedPointResolution = 0.1f;

	[SerializeField]
	private int _storedValueArraySize;

	[SerializeField]
	private Vector3[] _storedPathDirections;

	[SerializeField]
	private CameraPathControlPoint[] _pointALink;

	[SerializeField]
	private CameraPathControlPoint[] _pointBLink;

	[SerializeField]
	private CameraPathOrientationList _orientationList;

	[SerializeField]
	private CameraPathFOVList _fovList;

	[SerializeField]
	private CameraPathTiltList _tiltList;

	[SerializeField]
	private CameraPathSpeedList _speedList;

	[SerializeField]
	private CameraPathEventList _eventList;

	[SerializeField]
	private CameraPathDelayList _delayList;

	[SerializeField]
	private bool _addOrientationsWithPoints = true;

	[SerializeField]
	private bool _looped;

	[SerializeField]
	private bool _normalised = true;

	[SerializeField]
	private Bounds _pathBounds = default(Bounds);

	public float hermiteTension;

	public float hermiteBias;

	public GameObject editorPreview;

	public int selectedPoint;

	public PointModes pointMode;

	public float addPointAtPercent;

	[SerializeField]
	private CameraPath _nextPath;

	[SerializeField]
	private bool _interpolateNextPath;

	public bool showGizmos = true;

	public Color selectedPathColour = CameraPathColours.GREEN;

	public Color unselectedPathColour = CameraPathColours.GREY;

	public Color selectedPointColour = CameraPathColours.RED;

	public Color unselectedPointColour = CameraPathColours.GREEN;

	public bool showOrientationIndicators;

	public float orientationIndicatorUnitLength = 2.5f;

	public Color orientationIndicatorColours = CameraPathColours.PURPLE;

	public bool autoSetStoedPointRes = true;

	public bool enableUndo = true;

	public bool showPreview = true;

	public bool enablePreviews = true;

	public CameraPathControlPoint this[int index]
	{
		get
		{
			int count = _points.Count;
			if (_looped)
			{
				if (shouldInterpolateNextPath)
				{
					if (index == count)
					{
						index = 0;
					}
					else
					{
						if (index > count)
						{
							return _nextPath[index % count];
						}
						if (index < 0)
						{
							Debug.LogError("Index out of range");
						}
					}
				}
				else
				{
					index %= count;
				}
			}
			else
			{
				if (index < 0)
				{
					Debug.LogError("Index can't be minus");
				}
				if (index >= _points.Count)
				{
					if (index >= _points.Count && shouldInterpolateNextPath)
					{
						return nextPath[index % count];
					}
					Debug.LogError("Index out of range");
				}
			}
			return _points[index];
		}
	}

	public int numberOfPoints
	{
		get
		{
			if (_points.Count == 0)
			{
				return 0;
			}
			int num = ((!_looped) ? _points.Count : (_points.Count + 1));
			if (shouldInterpolateNextPath)
			{
				num++;
			}
			return num;
		}
	}

	public int realNumberOfPoints
	{
		get
		{
			return _points.Count;
		}
	}

	public int numberOfCurves
	{
		get
		{
			if (_points.Count < 2)
			{
				return 0;
			}
			return numberOfPoints - 1;
		}
	}

	public bool loop
	{
		get
		{
			return _looped;
		}
		set
		{
			if (_looped != value)
			{
				_looped = value;
				RecalculateStoredValues();
			}
		}
	}

	public float pathLength
	{
		get
		{
			return _storedTotalArcLength;
		}
	}

	public CameraPathOrientationList orientationList
	{
		get
		{
			return _orientationList;
		}
	}

	public CameraPathFOVList fovList
	{
		get
		{
			return _fovList;
		}
	}

	public CameraPathTiltList tiltList
	{
		get
		{
			return _tiltList;
		}
	}

	public CameraPathSpeedList speedList
	{
		get
		{
			return _speedList;
		}
	}

	public CameraPathEventList eventList
	{
		get
		{
			return _eventList;
		}
	}

	public CameraPathDelayList delayList
	{
		get
		{
			return _delayList;
		}
	}

	public Bounds bounds
	{
		get
		{
			return _pathBounds;
		}
	}

	public int storedValueArraySize
	{
		get
		{
			return _storedValueArraySize;
		}
	}

	public CameraPathControlPoint[] pointALink
	{
		get
		{
			return _pointALink;
		}
	}

	public CameraPathControlPoint[] pointBLink
	{
		get
		{
			return _pointBLink;
		}
	}

	public Vector3[] storedPoints
	{
		get
		{
			return _storedPoints;
		}
	}

	public bool normalised
	{
		get
		{
			return _normalised;
		}
		set
		{
			_normalised = value;
		}
	}

	public Interpolation interpolation
	{
		get
		{
			return _interpolation;
		}
		set
		{
			if (value != _interpolation)
			{
				_interpolation = value;
				RecalculateStoredValues();
			}
		}
	}

	public CameraPath nextPath
	{
		get
		{
			return _nextPath;
		}
		set
		{
			if (value != _nextPath)
			{
				if (value == this)
				{
					Debug.LogError("Do not link a path to itself! The Universe would crumble and it would be your fault!! If you want to loop a path, just toggle the loop option...");
					return;
				}
				_nextPath = value;
				_nextPath.GetComponent<CameraPathAnimator>().playOnStart = false;
				RecalculateStoredValues();
			}
		}
	}

	public bool interpolateNextPath
	{
		get
		{
			return _interpolateNextPath;
		}
		set
		{
			if (_interpolateNextPath != value)
			{
				_interpolateNextPath = value;
				RecalculateStoredValues();
			}
		}
	}

	public bool shouldInterpolateNextPath
	{
		get
		{
			return nextPath != null && interpolateNextPath;
		}
	}

	public float storedPointResolution
	{
		get
		{
			return _storedPointResolution;
		}
		set
		{
			_storedPointResolution = value;
		}
	}

	public event RecalculateCurvesHandler RecalculateCurvesEvent;

	public event PathPointAddedHandler PathPointAddedEvent;

	public event PathPointRemovedHandler PathPointRemovedEvent;

	public event CheckStartPointCullHandler CheckStartPointCullEvent;

	public event CheckEndPointCullHandler CheckEndPointCullEvent;

	public event CleanUpListsHandler CleanUpListsEvent;

	public float StoredArcLength(int curve)
	{
		curve = ((!_looped) ? Mathf.Clamp(curve, 0, numberOfCurves - 1) : (curve % (numberOfCurves - 1)));
		return _storedArcLengths[curve];
	}

	public int StoredValueIndex(float percentage)
	{
		int num = storedValueArraySize - 1;
		return Mathf.Clamp(Mathf.RoundToInt((float)num * percentage), 0, num);
	}

	public CameraPathControlPoint AddPoint(Vector3 position)
	{
		CameraPathControlPoint cameraPathControlPoint = base.gameObject.AddComponent<CameraPathControlPoint>();
		cameraPathControlPoint.hideFlags = HideFlags.HideInInspector;
		cameraPathControlPoint.localPosition = position;
		_points.Add(cameraPathControlPoint);
		if (_addOrientationsWithPoints)
		{
			orientationList.AddOrientation(cameraPathControlPoint);
		}
		RecalculateStoredValues();
		this.PathPointAddedEvent(cameraPathControlPoint);
		return cameraPathControlPoint;
	}

	public void AddPoint(CameraPathControlPoint point)
	{
		_points.Add(point);
		RecalculateStoredValues();
		this.PathPointAddedEvent(point);
	}

	public void InsertPoint(CameraPathControlPoint point, int index)
	{
		_points.Insert(index, point);
		RecalculateStoredValues();
		this.PathPointAddedEvent(point);
	}

	public CameraPathControlPoint InsertPoint(int index)
	{
		CameraPathControlPoint cameraPathControlPoint = base.gameObject.AddComponent<CameraPathControlPoint>();
		cameraPathControlPoint.hideFlags = HideFlags.HideInInspector;
		_points.Insert(index, cameraPathControlPoint);
		RecalculateStoredValues();
		this.PathPointAddedEvent(cameraPathControlPoint);
		return cameraPathControlPoint;
	}

	public void RemovePoint(int index)
	{
		RemovePoint(this[index]);
	}

	public bool RemovePoint(string pointName)
	{
		foreach (CameraPathControlPoint point in _points)
		{
			if (point.displayName == pointName)
			{
				RemovePoint(point);
				return true;
			}
		}
		return false;
	}

	public void RemovePoint(Vector3 pointPosition)
	{
		foreach (CameraPathControlPoint point in _points)
		{
			if (point.worldPosition == pointPosition)
			{
				RemovePoint(point);
			}
		}
		float nearestPoint = GetNearestPoint(pointPosition, true);
		RemovePoint(GetNearestPointIndex(nearestPoint));
	}

	public void RemovePoint(CameraPathControlPoint point)
	{
		if (_points.Count < 3)
		{
			Debug.Log("We can't see any point in allowing you to delete any more points so we're not going to do it.");
			return;
		}
		this.PathPointRemovedEvent(point);
		int num = _points.IndexOf(point);
		if (num == 0)
		{
			float pathPercentage = GetPathPercentage(1);
			this.CheckStartPointCullEvent(pathPercentage);
		}
		if (num == realNumberOfPoints - 1)
		{
			float pathPercentage2 = GetPathPercentage(realNumberOfPoints - 2);
			this.CheckEndPointCullEvent(pathPercentage2);
		}
		_points.Remove(point);
		RecalculateStoredValues();
	}

	private float ParsePercentage(float percentage)
	{
		if (percentage == 0f)
		{
			return 0f;
		}
		if (percentage == 1f)
		{
			return 1f;
		}
		percentage = ((!_looped) ? Mathf.Clamp01(percentage) : (percentage % 1f));
		if (_normalised)
		{
			int max = storedValueArraySize - 1;
			float num = 1f / (float)storedValueArraySize;
			int num2 = Mathf.Clamp(Mathf.FloorToInt((float)storedValueArraySize * percentage), 0, max);
			int num3 = Mathf.Clamp(num2 + 1, 0, max);
			float num4 = (float)num2 * num;
			float num5 = (float)num3 * num;
			float num6 = _normalisedPercentages[num2];
			float num7 = _normalisedPercentages[num3];
			if (num6 == num7)
			{
				return percentage;
			}
			float t = (percentage - num4) / (num5 - num4);
			percentage = Mathf.Lerp(num6, num7, t);
		}
		return percentage;
	}

	public float CalculateNormalisedPercentage(float percentage)
	{
		if (realNumberOfPoints < 2)
		{
			return percentage;
		}
		if (percentage == 0f)
		{
			return 0f;
		}
		if (percentage == 1f)
		{
			return 1f;
		}
		if (_storedTotalArcLength == 0f)
		{
			return percentage;
		}
		float num = percentage * _storedTotalArcLength;
		int num2 = 0;
		int num3 = storedValueArraySize;
		int num4 = 0;
		while (num2 < num3)
		{
			num4 = num2 + (num3 - num2) / 2;
			if (_storedArcLengthsFull[num4] < num)
			{
				num2 = num4 + 1;
			}
			else
			{
				num3 = num4;
			}
		}
		if (_storedArcLengthsFull[num4] > num && num4 > 0)
		{
			num4--;
		}
		float num5 = _storedArcLengthsFull[num4];
		float result = (float)num4 / (float)storedValueArraySize;
		if (num5 == num)
		{
			return result;
		}
		return ((float)num4 + (num - num5) / (_storedArcLengthsFull[num4 + 1] - num5)) / (float)storedValueArraySize;
	}

	public float DeNormalisePercentage(float normalisedPercent)
	{
		int num = _normalisedPercentages.Length;
		for (int i = 0; i < num; i++)
		{
			if (_normalisedPercentages[i] > normalisedPercent)
			{
				if (i == 0)
				{
					return 0f;
				}
				float from = (float)(i - 1) / (float)num;
				float to = (float)i / (float)num;
				float num2 = _normalisedPercentages[i - 1];
				float num3 = _normalisedPercentages[i];
				float t = (normalisedPercent - num2) / (num3 - num2);
				return Mathf.Lerp(from, to, t);
			}
		}
		return 1f;
	}

	public int GetPointNumber(float percentage)
	{
		percentage = ParsePercentage(percentage);
		float num = 1f / (float)numberOfCurves;
		return Mathf.Clamp(Mathf.FloorToInt(percentage / num), 0, _points.Count - 1);
	}

	public Vector3 GetPathPosition(float percentage)
	{
		return GetPathPosition(percentage, false);
	}

	public Vector3 GetPathPosition(float percentage, bool ignoreNormalisation)
	{
		if (realNumberOfPoints < 2)
		{
			Debug.LogError("Not enough points to define a curve");
			return Vector3.zero;
		}
		if (!ignoreNormalisation)
		{
			percentage = ParsePercentage(percentage);
		}
		float num = 1f / (float)numberOfCurves;
		int num2 = Mathf.FloorToInt(percentage / num);
		float num3 = Mathf.Clamp01((percentage - (float)num2 * num) * (float)numberOfCurves);
		CameraPathControlPoint point = GetPoint(num2);
		CameraPathControlPoint point2 = GetPoint(num2 + 1);
		if (point == null || point2 == null)
		{
			return Vector3.zero;
		}
		switch (interpolation)
		{
		case Interpolation.Bezier:
			return CPMath.CalculateBezier(num3, point.worldPosition, point.forwardControlPointWorld, point2.backwardControlPointWorld, point2.worldPosition);
		case Interpolation.Hermite:
		{
			CameraPathControlPoint point3 = GetPoint(num2 - 1);
			CameraPathControlPoint point4 = GetPoint(num2 + 2);
			return CPMath.CalculateHermite(point3.worldPosition, point.worldPosition, point2.worldPosition, point4.worldPosition, num3, hermiteTension, hermiteBias);
		}
		case Interpolation.CatmullRom:
		{
			CameraPathControlPoint point3 = GetPoint(num2 - 1);
			CameraPathControlPoint point4 = GetPoint(num2 + 2);
			return CPMath.CalculateCatmullRom(point3.worldPosition, point.worldPosition, point2.worldPosition, point4.worldPosition, num3);
		}
		case Interpolation.SmoothStep:
			return Vector3.Lerp(point.worldPosition, point2.worldPosition, CPMath.SmoothStep(num3));
		case Interpolation.Linear:
			return Vector3.Lerp(point.worldPosition, point2.worldPosition, num3);
		default:
			return Vector3.zero;
		}
	}

	public Quaternion GetPathRotation(float percentage, bool ignoreNormalisation)
	{
		if (!ignoreNormalisation)
		{
			percentage = ParsePercentage(percentage);
		}
		return orientationList.GetOrientation(percentage);
	}

	public Vector3 GetPathDirection(float percentage)
	{
		return GetPathDirection(percentage, true);
	}

	public Vector3 GetPathDirection(float percentage, bool normalisePercent)
	{
		if (normalisePercent)
		{
			percentage = ParsePercentage(percentage);
		}
		return _storedPathDirections[StoredValueIndex(percentage)];
	}

	public float GetPathTilt(float percentage)
	{
		percentage = ParsePercentage(percentage);
		return _tiltList.GetTilt(percentage);
	}

	public float GetPathFOV(float percentage)
	{
		percentage = ParsePercentage(percentage);
		return _fovList.GetFOV(percentage);
	}

	public float GetPathSpeed(float percentage)
	{
		percentage = ParsePercentage(percentage);
		float speed = _speedList.GetSpeed(percentage);
		return speed * _delayList.CheckEase(percentage);
	}

	public float GetPathEase(float percentage)
	{
		percentage = ParsePercentage(percentage);
		return _delayList.CheckEase(percentage);
	}

	public void CheckEvents(float percentage)
	{
		percentage = ParsePercentage(percentage);
		_eventList.CheckEvents(percentage);
		_delayList.CheckEvents(percentage);
	}

	public float GetPathPercentage(CameraPathControlPoint point)
	{
		int num = _points.IndexOf(point);
		return (float)num / (float)numberOfCurves;
	}

	public float GetPathPercentage(int pointIndex)
	{
		return (float)pointIndex / (float)numberOfCurves;
	}

	public int GetNearestPointIndex(float percentage)
	{
		percentage = ParsePercentage(percentage);
		return Mathf.RoundToInt((float)numberOfCurves * percentage);
	}

	public int GetLastPointIndex(float percentage, bool isNormalised)
	{
		if (isNormalised)
		{
			percentage = ParsePercentage(percentage);
		}
		return Mathf.FloorToInt((float)numberOfCurves * percentage);
	}

	public int GetNextPointIndex(float percentage, bool isNormalised)
	{
		if (isNormalised)
		{
			percentage = ParsePercentage(percentage);
		}
		return Mathf.CeilToInt((float)numberOfCurves * percentage);
	}

	public float GetCurvePercentage(CameraPathControlPoint pointA, CameraPathControlPoint pointB, float percentage)
	{
		float num = GetPathPercentage(pointA);
		float num2 = GetPathPercentage(pointB);
		if (num == num2)
		{
			return num;
		}
		if (num > num2)
		{
			float num3 = num2;
			num2 = num;
			num = num3;
		}
		return Mathf.Clamp01((percentage - num) / (num2 - num));
	}

	public float GetCurvePercentage(CameraPathPoint pointA, CameraPathPoint pointB, float percentage)
	{
		float num = pointA.percent;
		float num2 = pointB.percent;
		if (num > num2)
		{
			float num3 = num2;
			num2 = num;
			num = num3;
		}
		return Mathf.Clamp01((percentage - num) / (num2 - num));
	}

	public float GetCurvePercentage(CameraPathPoint point)
	{
		float num = GetPathPercentage(point.cpointA);
		float num2 = GetPathPercentage(point.cpointB);
		if (num > num2)
		{
			float num3 = num2;
			num2 = num;
			num = num3;
		}
		point.curvePercentage = Mathf.Clamp01((point.percent - num) / (num2 - num));
		return point.curvePercentage;
	}

	public float GetOutroEasePercentage(CameraPathDelay point)
	{
		float num = point.percent;
		float num2 = _delayList.GetPoint(point.index + 1).percent;
		if (num > num2)
		{
			float num3 = num2;
			num2 = num;
			num = num3;
		}
		return Mathf.Lerp(num, num2, point.outroEndEasePercentage);
	}

	public float GetIntroEasePercentage(CameraPathDelay point)
	{
		float percent = _delayList.GetPoint(point.index - 1).percent;
		float percent2 = point.percent;
		return Mathf.Lerp(percent, percent2, 1f - point.introStartEasePercentage);
	}

	public float GetPathPercentage(CameraPathControlPoint pointA, CameraPathControlPoint pointB, float curvePercentage)
	{
		float pathPercentage = GetPathPercentage(pointA);
		float pathPercentage2 = GetPathPercentage(pointB);
		return Mathf.Lerp(pathPercentage, pathPercentage2, curvePercentage);
	}

	public float GetPathPercentage(float pointA, float pointB, float curvePercentage)
	{
		return Mathf.Lerp(pointA, pointB, curvePercentage);
	}

	public int GetStoredPoint(float percentage)
	{
		percentage = ParsePercentage(percentage);
		return Mathf.Clamp(Mathf.FloorToInt((float)storedValueArraySize * percentage), 0, storedValueArraySize - 1);
	}

	private void Awake()
	{
		Init();
	}

	private void Start()
	{
		if (!Application.isPlaying && version != CURRENT_VERSION_NUMBER)
		{
			if (version > CURRENT_VERSION_NUMBER)
			{
				Debug.LogError("Camera Path v." + version + ": Great scot! This data is from the future! (version:" + CURRENT_VERSION_NUMBER + ") - need to avoid contact to ensure the survival of the universe...");
			}
			else
			{
				Debug.Log("Camera Path v." + version + " Upgrading to version " + CURRENT_VERSION_NUMBER + "\nRemember to backup your data!");
				version = CURRENT_VERSION_NUMBER;
			}
		}
	}

	private void OnValidate()
	{
		InitialiseLists();
		if (!Application.isPlaying)
		{
			RecalculateStoredValues();
		}
	}

	private void OnDestroy()
	{
		Clear();
		if (this.CleanUpListsEvent != null)
		{
			this.CleanUpListsEvent();
		}
	}

	public void RecalculateStoredValues()
	{
		if (autoSetStoedPointRes && _storedTotalArcLength > 0f)
		{
			_storedPointResolution = _storedTotalArcLength / 1000f;
		}
		for (int i = 0; i < realNumberOfPoints; i++)
		{
			CameraPathControlPoint cameraPathControlPoint = _points[i];
			cameraPathControlPoint.percentage = GetPathPercentage(i);
			cameraPathControlPoint.normalisedPercentage = CalculateNormalisedPercentage(_points[i].percentage);
			cameraPathControlPoint.givenName = "Point " + i;
			cameraPathControlPoint.fullName = base.name + " Point " + i;
			cameraPathControlPoint.index = i;
			cameraPathControlPoint.hideFlags = HideFlags.HideInInspector;
		}
		if (_points.Count >= 2)
		{
			_storedTotalArcLength = 0f;
			for (int j = 0; j < numberOfCurves; j++)
			{
				CameraPathControlPoint point = GetPoint(j);
				CameraPathControlPoint point2 = GetPoint(j + 1);
				float num = 0f;
				num += Vector3.Distance(point.worldPosition, point.forwardControlPointWorld);
				num += Vector3.Distance(point.forwardControlPointWorld, point2.backwardControlPointWorld);
				num += Vector3.Distance(point2.backwardControlPointWorld, point2.worldPosition);
				_storedTotalArcLength += num;
			}
			_storedValueArraySize = Mathf.Max(Mathf.RoundToInt(_storedTotalArcLength / _storedPointResolution), 1);
			_storedArcLengths = new float[numberOfCurves];
			float num2 = 1f / (float)_storedValueArraySize;
			float num3 = 0f;
			_storedArcLengthsFull = new float[_storedValueArraySize];
			_storedArcLengthsFull[0] = 0f;
			for (int k = 0; k < _storedValueArraySize - 1; k++)
			{
				float num4 = num2 * (float)(k + 1);
				float percentage = num2 * (float)(k + 1) + num2;
				Vector3 pathPosition = GetPathPosition(num4, true);
				Vector3 pathPosition2 = GetPathPosition(percentage, true);
				float num5 = Vector3.Distance(pathPosition, pathPosition2);
				num3 += num5;
				int num6 = Mathf.FloorToInt(num4 * (float)numberOfCurves);
				_storedArcLengths[num6] += num5;
				_storedArcLengthsFull[k + 1] = num3;
			}
			_storedTotalArcLength = num3;
			_storedPoints = new Vector3[_storedValueArraySize];
			_storedPathDirections = new Vector3[_storedValueArraySize];
			_normalisedPercentages = new float[_storedValueArraySize];
			for (int l = 0; l < _storedValueArraySize; l++)
			{
				float percentage2 = num2 * (float)(l + 1);
				float percentage3 = num2 * (float)(l + 1);
				float percentage4 = num2 * (float)(l - 1);
				_normalisedPercentages[l] = CalculateNormalisedPercentage(percentage2);
				Vector3 pathPosition3 = GetPathPosition(percentage2, true);
				Vector3 pathPosition4 = GetPathPosition(percentage3, true);
				Vector3 pathPosition5 = GetPathPosition(percentage4, true);
				_storedPathDirections[l] = ((pathPosition4 - pathPosition3 + (pathPosition4 - pathPosition5)) * 0.5f).normalized;
			}
			for (int m = 0; m < _storedValueArraySize; m++)
			{
				float percentage5 = num2 * (float)m;
				Vector3 pathPosition6 = GetPathPosition(percentage5);
				_storedPoints[m] = pathPosition6;
			}
			if (this.RecalculateCurvesEvent != null)
			{
				this.RecalculateCurvesEvent();
			}
		}
	}

	public float GetNearestPoint(Vector3 fromPostition)
	{
		return GetNearestPoint(fromPostition, false, 4);
	}

	public float GetNearestPoint(Vector3 fromPostition, bool ignoreNormalisation)
	{
		return GetNearestPoint(fromPostition, ignoreNormalisation, 4);
	}

	public float GetNearestPoint(Vector3 fromPostition, bool ignoreNormalisation, int refinments)
	{
		int num = 10;
		float num2 = 1f / (float)num;
		float num3 = 0f;
		float num4 = 0f;
		float num5 = float.PositiveInfinity;
		float num6 = float.PositiveInfinity;
		for (float num7 = 0f; num7 < 1f; num7 += num2)
		{
			Vector3 pathPosition = GetPathPosition(num7, ignoreNormalisation);
			Vector3 a = pathPosition - fromPostition;
			float num8 = Vector3.SqrMagnitude(a);
			if (num5 > num8)
			{
				num3 = num7;
				num5 = num8;
			}
		}
		num4 = num3;
		num6 = num5;
		for (int i = 0; i < refinments; i++)
		{
			float num9 = num2 / 1.8f;
			float num10 = num3 - num9;
			float num11 = num3 + num9;
			float num12 = num2 / (float)num;
			for (float num13 = num10; num13 < num11; num13 += num12)
			{
				float num14 = num13 % 1f;
				if (num14 < 0f)
				{
					num14 += 1f;
				}
				Vector3 pathPosition2 = GetPathPosition(num14, ignoreNormalisation);
				Vector3 a2 = pathPosition2 - fromPostition;
				float num15 = Vector3.SqrMagnitude(a2);
				if (num5 > num15)
				{
					num4 = num3;
					num6 = num5;
					num3 = num14;
					num5 = num15;
				}
				else if (num6 > num15)
				{
					num4 = num14;
					num6 = num15;
				}
			}
			num2 = num12;
		}
		float t = num5 / (num5 + num6);
		return Mathf.Clamp01(Mathf.Lerp(num3, num4, t));
	}

	public void Clear()
	{
		_points.Clear();
	}

	public CameraPathControlPoint GetPoint(int index)
	{
		return this[GetPointIndex(index)];
	}

	public int GetPointIndex(int index)
	{
		if (_points.Count == 0)
		{
			return -1;
		}
		if (!_looped)
		{
			return Mathf.Clamp(index, 0, numberOfCurves);
		}
		if (index >= numberOfCurves)
		{
			index -= numberOfCurves;
		}
		if (index < 0)
		{
			index += numberOfCurves;
		}
		return index;
	}

	public int GetCurveIndex(int startPointIndex)
	{
		if (_points.Count == 0)
		{
			return -1;
		}
		if (!_looped)
		{
			return Mathf.Clamp(startPointIndex, 0, numberOfCurves - 1);
		}
		if (startPointIndex >= numberOfCurves - 1)
		{
			startPointIndex = startPointIndex - numberOfCurves - 1;
		}
		if (startPointIndex < 0)
		{
			startPointIndex = startPointIndex + numberOfCurves - 1;
		}
		return startPointIndex;
	}

	private void Init()
	{
		InitialiseLists();
		if (!initialised)
		{
			CameraPathControlPoint cameraPathControlPoint = base.gameObject.AddComponent<CameraPathControlPoint>();
			CameraPathControlPoint cameraPathControlPoint2 = base.gameObject.AddComponent<CameraPathControlPoint>();
			CameraPathControlPoint cameraPathControlPoint3 = base.gameObject.AddComponent<CameraPathControlPoint>();
			CameraPathControlPoint cameraPathControlPoint4 = base.gameObject.AddComponent<CameraPathControlPoint>();
			cameraPathControlPoint.hideFlags = HideFlags.HideInInspector;
			cameraPathControlPoint2.hideFlags = HideFlags.HideInInspector;
			cameraPathControlPoint3.hideFlags = HideFlags.HideInInspector;
			cameraPathControlPoint4.hideFlags = HideFlags.HideInInspector;
			cameraPathControlPoint.localPosition = new Vector3(-20f, 0f, -20f);
			cameraPathControlPoint2.localPosition = new Vector3(20f, 0f, -20f);
			cameraPathControlPoint3.localPosition = new Vector3(20f, 0f, 20f);
			cameraPathControlPoint4.localPosition = new Vector3(-20f, 0f, 20f);
			cameraPathControlPoint.forwardControlPoint = new Vector3(0f, 0f, -20f);
			cameraPathControlPoint2.forwardControlPoint = new Vector3(40f, 0f, -20f);
			cameraPathControlPoint3.forwardControlPoint = new Vector3(0f, 0f, 20f);
			cameraPathControlPoint4.forwardControlPoint = new Vector3(-40f, 0f, 20f);
			AddPoint(cameraPathControlPoint);
			AddPoint(cameraPathControlPoint2);
			AddPoint(cameraPathControlPoint3);
			AddPoint(cameraPathControlPoint4);
			initialised = true;
		}
	}

	private void InitialiseLists()
	{
		if (_orientationList == null)
		{
			_orientationList = base.gameObject.AddComponent<CameraPathOrientationList>();
		}
		if (_fovList == null)
		{
			_fovList = base.gameObject.AddComponent<CameraPathFOVList>();
		}
		if (_tiltList == null)
		{
			_tiltList = base.gameObject.AddComponent<CameraPathTiltList>();
		}
		if (_speedList == null)
		{
			_speedList = base.gameObject.AddComponent<CameraPathSpeedList>();
		}
		if (_eventList == null)
		{
			_eventList = base.gameObject.AddComponent<CameraPathEventList>();
		}
		if (_delayList == null)
		{
			_delayList = base.gameObject.AddComponent<CameraPathDelayList>();
		}
		_orientationList.Init(this);
		_fovList.Init(this);
		_tiltList.Init(this);
		_speedList.Init(this);
		_eventList.Init(this);
		_delayList.Init(this);
	}
}
