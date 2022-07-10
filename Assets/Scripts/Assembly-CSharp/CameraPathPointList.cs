using System;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class CameraPathPointList : MonoBehaviour
{
	[SerializeField]
	private List<CameraPathPoint> _points = new List<CameraPathPoint>();

	[SerializeField]
	protected CameraPath cameraPath;

	protected string pointTypeName = "point";

	[NonSerialized]
	protected bool initialised;

	public CameraPathPoint this[int index]
	{
		get
		{
			if (cameraPath.loop && index > _points.Count - 1)
			{
				index %= _points.Count;
			}
			if (index < 0)
			{
				Debug.LogError("Index can't be minus");
			}
			if (index >= _points.Count)
			{
				Debug.LogError("Index out of range");
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
			return (!cameraPath.loop) ? _points.Count : (_points.Count + 1);
		}
	}

	public int realNumberOfPoints
	{
		get
		{
			return _points.Count;
		}
	}

	private void OnEnable()
	{
		base.hideFlags = HideFlags.HideInInspector;
	}

	public virtual void Init(CameraPath _cameraPath)
	{
		if (!initialised)
		{
			base.hideFlags = HideFlags.HideInInspector;
			cameraPath = _cameraPath;
			cameraPath.CleanUpListsEvent += CleanUp;
			cameraPath.RecalculateCurvesEvent += RecalculatePoints;
			cameraPath.PathPointRemovedEvent += PathPointRemovedEvent;
			cameraPath.CheckStartPointCullEvent += CheckPointCullEventFromStart;
			cameraPath.CheckEndPointCullEvent += CheckPointCullEventFromEnd;
			initialised = true;
		}
	}

	public virtual void CleanUp()
	{
		cameraPath.CleanUpListsEvent -= CleanUp;
		cameraPath.RecalculateCurvesEvent -= RecalculatePoints;
		cameraPath.PathPointRemovedEvent -= PathPointRemovedEvent;
		cameraPath.CheckStartPointCullEvent -= CheckPointCullEventFromStart;
		cameraPath.CheckEndPointCullEvent -= CheckPointCullEventFromEnd;
		initialised = false;
	}

	public int IndexOf(CameraPathPoint point)
	{
		return _points.IndexOf(point);
	}

	public void AddPoint(CameraPathPoint newPoint, CameraPathControlPoint curvePointA, CameraPathControlPoint curvePointB, float curvePercetage)
	{
		newPoint.positionModes = CameraPathPoint.PositionModes.Free;
		newPoint.cpointA = curvePointA;
		newPoint.cpointB = curvePointB;
		newPoint.curvePercentage = curvePercetage;
		_points.Add(newPoint);
		RecalculatePoints();
	}

	public void AddPoint(CameraPathPoint newPoint, float fixPercent)
	{
		newPoint.positionModes = CameraPathPoint.PositionModes.FixedToPercent;
		newPoint.percent = fixPercent;
		_points.Add(newPoint);
		RecalculatePoints();
	}

	public void AddPoint(CameraPathPoint newPoint, CameraPathControlPoint atPoint)
	{
		newPoint.positionModes = CameraPathPoint.PositionModes.FixedToPoint;
		newPoint.point = atPoint;
		_points.Add(newPoint);
		RecalculatePoints();
	}

	public void RemovePoint(CameraPathPoint newPoint)
	{
		_points.Remove(newPoint);
		RecalculatePoints();
	}

	public void PathPointAddedEvent(CameraPathControlPoint addedPoint)
	{
		float percentage = addedPoint.percentage;
		for (int i = 0; i < realNumberOfPoints; i++)
		{
			CameraPathPoint cameraPathPoint = _points[i];
			if (cameraPathPoint.positionModes != 0)
			{
				continue;
			}
			float percentage2 = cameraPathPoint.cpointA.percentage;
			float percentage3 = cameraPathPoint.cpointB.percentage;
			if (percentage > percentage2 && percentage < percentage3)
			{
				if (percentage < cameraPathPoint.percent)
				{
					cameraPathPoint.cpointA = addedPoint;
				}
				else
				{
					cameraPathPoint.cpointB = addedPoint;
				}
				cameraPath.GetCurvePercentage(cameraPathPoint);
			}
		}
	}

	public void PathPointRemovedEvent(CameraPathControlPoint removedPathPoint)
	{
		for (int i = 0; i < realNumberOfPoints; i++)
		{
			CameraPathPoint cameraPathPoint = _points[i];
			switch (cameraPathPoint.positionModes)
			{
			case CameraPathPoint.PositionModes.FixedToPoint:
				if (cameraPathPoint.point == removedPathPoint)
				{
					_points.Remove(cameraPathPoint);
					i--;
				}
				break;
			case CameraPathPoint.PositionModes.Free:
				if (cameraPathPoint.cpointA == removedPathPoint)
				{
					CameraPathControlPoint cameraPathControlPoint = (cameraPathPoint.cpointA = cameraPath.GetPoint(removedPathPoint.index - 1));
					cameraPath.GetCurvePercentage(cameraPathPoint);
				}
				if (cameraPathPoint.cpointB == removedPathPoint)
				{
					CameraPathControlPoint cameraPathControlPoint2 = (cameraPathPoint.cpointB = cameraPath.GetPoint(removedPathPoint.index + 1));
					cameraPath.GetCurvePercentage(cameraPathPoint);
				}
				break;
			}
		}
		RecalculatePoints();
	}

	public void CheckPointCullEventFromStart(float percent)
	{
		int num = _points.Count;
		for (int i = 0; i < num; i++)
		{
			CameraPathPoint cameraPathPoint = _points[i];
			if (cameraPathPoint.positionModes != CameraPathPoint.PositionModes.FixedToPercent && cameraPathPoint.percent < percent)
			{
				_points.Remove(cameraPathPoint);
				i--;
				num--;
			}
		}
		RecalculatePoints();
	}

	public void CheckPointCullEventFromEnd(float percent)
	{
		int num = _points.Count;
		for (int i = 0; i < num; i++)
		{
			CameraPathPoint cameraPathPoint = _points[i];
			if (cameraPathPoint.positionModes != CameraPathPoint.PositionModes.FixedToPercent && cameraPathPoint.percent > percent)
			{
				_points.Remove(cameraPathPoint);
				i--;
				num--;
			}
		}
		RecalculatePoints();
	}

	protected int GetNextPointIndex(float percent)
	{
		if (realNumberOfPoints == 0)
		{
			Debug.LogError("No points to draw from");
		}
		if (percent == 0f)
		{
			return 1;
		}
		if (percent == 1f)
		{
			return _points.Count - 1;
		}
		int count = _points.Count;
		int num = 0;
		for (int i = 1; i < count; i++)
		{
			if (_points[i].percent > percent)
			{
				return num + 1;
			}
			num = i;
		}
		return num;
	}

	protected int GetLastPointIndex(float percent)
	{
		if (realNumberOfPoints == 0)
		{
			Debug.LogError("No points to draw from");
		}
		if (percent == 0f)
		{
			return 0;
		}
		if (percent == 1f)
		{
			return (!cameraPath.loop && !cameraPath.shouldInterpolateNextPath) ? (_points.Count - 2) : (_points.Count - 1);
		}
		int count = _points.Count;
		int result = 0;
		for (int i = 1; i < count; i++)
		{
			if (_points[i].percent > percent)
			{
				return result;
			}
			result = i;
		}
		return result;
	}

	public CameraPathPoint GetPoint(int index)
	{
		int count = _points.Count;
		if (count == 0)
		{
			return null;
		}
		CameraPathPointList cameraPathPointList = this;
		if (cameraPath.shouldInterpolateNextPath)
		{
			switch (pointTypeName)
			{
			case "Orientation":
				cameraPathPointList = cameraPath.nextPath.orientationList;
				break;
			case "FOV":
				cameraPathPointList = cameraPath.nextPath.fovList;
				break;
			case "Tilt":
				cameraPathPointList = cameraPath.nextPath.tiltList;
				break;
			}
		}
		if (cameraPathPointList == this)
		{
			if (!cameraPath.loop)
			{
				return _points[Mathf.Clamp(index, 0, count - 1)];
			}
			if (index >= count)
			{
				index -= count;
			}
			if (index < 0)
			{
				index += count;
			}
		}
		else if (cameraPath.loop)
		{
			if (index == count)
			{
				index = 0;
				cameraPathPointList = null;
			}
			else if (index > count)
			{
				index = Mathf.Clamp(index, 0, cameraPathPointList.realNumberOfPoints - 1);
			}
			else if (index < 0)
			{
				index += count;
				cameraPathPointList = null;
			}
			else
			{
				cameraPathPointList = null;
			}
		}
		else if (index > count - 1)
		{
			index = Mathf.Clamp(index - count, 0, cameraPathPointList.realNumberOfPoints - 1);
		}
		else if (index < 0)
		{
			index = 0;
			cameraPathPointList = null;
		}
		else
		{
			index = Mathf.Clamp(index, 0, count - 1);
			cameraPathPointList = null;
		}
		if (cameraPathPointList != null)
		{
			return cameraPathPointList[index];
		}
		return _points[index];
	}

	public CameraPathPoint GetPoint(CameraPathControlPoint atPoint)
	{
		if (_points.Count == 0)
		{
			return null;
		}
		foreach (CameraPathPoint point in _points)
		{
			if (point.positionModes == CameraPathPoint.PositionModes.FixedToPoint && point.point == atPoint)
			{
				return point;
			}
		}
		return null;
	}

	public void Clear()
	{
		_points.Clear();
	}

	public CameraPathPoint DuplicatePointCheck()
	{
		foreach (CameraPathPoint point in _points)
		{
			foreach (CameraPathPoint point2 in _points)
			{
				if (point != point2 && point.percent == point2.percent)
				{
					return point;
				}
			}
		}
		return null;
	}

	protected virtual void RecalculatePoints()
	{
		if (cameraPath == null)
		{
			Debug.LogError("Camera Path Point List was not initialised - run Init();");
			return;
		}
		int count = _points.Count;
		if (count == 0)
		{
			return;
		}
		List<CameraPathPoint> list = new List<CameraPathPoint>();
		for (int i = 0; i < count; i++)
		{
			if (_points[i] == null)
			{
				continue;
			}
			CameraPathPoint cameraPathPoint = _points[i];
			if (i == 0)
			{
				list.Add(cameraPathPoint);
				continue;
			}
			bool flag = false;
			foreach (CameraPathPoint item in list)
			{
				if (item.percent > cameraPathPoint.percent)
				{
					list.Insert(list.IndexOf(item), cameraPathPoint);
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				list.Add(cameraPathPoint);
			}
		}
		count = list.Count;
		_points = list;
		for (int j = 0; j < count; j++)
		{
			CameraPathPoint cameraPathPoint2 = _points[j];
			cameraPathPoint2.givenName = pointTypeName + " Point " + j;
			cameraPathPoint2.fullName = cameraPath.name + " " + pointTypeName + " Point " + j;
			cameraPathPoint2.index = j;
			if (cameraPath.realNumberOfPoints < 2)
			{
				continue;
			}
			switch (cameraPathPoint2.positionModes)
			{
			case CameraPathPoint.PositionModes.Free:
				if (cameraPathPoint2.cpointA == cameraPathPoint2.cpointB)
				{
					cameraPathPoint2.positionModes = CameraPathPoint.PositionModes.FixedToPoint;
					cameraPathPoint2.point = cameraPathPoint2.cpointA;
					cameraPathPoint2.cpointA = null;
					cameraPathPoint2.cpointB = null;
					cameraPathPoint2.percent = cameraPathPoint2.point.percentage;
					cameraPathPoint2.animationPercentage = ((!cameraPath.normalised) ? cameraPathPoint2.point.percentage : cameraPathPoint2.point.normalisedPercentage);
					cameraPathPoint2.worldPosition = cameraPathPoint2.point.worldPosition;
					return;
				}
				cameraPathPoint2.percent = cameraPath.GetPathPercentage(cameraPathPoint2.cpointA, cameraPathPoint2.cpointB, cameraPathPoint2.curvePercentage);
				cameraPathPoint2.animationPercentage = ((!cameraPath.normalised) ? cameraPathPoint2.percent : cameraPath.CalculateNormalisedPercentage(cameraPathPoint2.percent));
				cameraPathPoint2.worldPosition = cameraPath.GetPathPosition(cameraPathPoint2.percent, true);
				break;
			case CameraPathPoint.PositionModes.FixedToPercent:
				cameraPathPoint2.worldPosition = cameraPath.GetPathPosition(cameraPathPoint2.percent, true);
				cameraPathPoint2.animationPercentage = ((!cameraPath.normalised) ? cameraPathPoint2.percent : cameraPath.CalculateNormalisedPercentage(cameraPathPoint2.percent));
				break;
			case CameraPathPoint.PositionModes.FixedToPoint:
				if (cameraPathPoint2.point == null)
				{
					cameraPathPoint2.point = cameraPath[cameraPath.GetNearestPointIndex(cameraPathPoint2.rawPercent)];
				}
				cameraPathPoint2.percent = cameraPathPoint2.point.percentage;
				cameraPathPoint2.animationPercentage = ((!cameraPath.normalised) ? cameraPathPoint2.point.percentage : cameraPathPoint2.point.normalisedPercentage);
				cameraPathPoint2.worldPosition = cameraPathPoint2.point.worldPosition;
				break;
			}
		}
	}

	public void ReassignCP(CameraPathControlPoint from, CameraPathControlPoint to)
	{
		foreach (CameraPathPoint point in _points)
		{
			if (point.point == from)
			{
				point.point = to;
			}
			if (point.cpointA == from)
			{
				point.cpointA = to;
			}
			if (point.cpointB == from)
			{
				point.cpointB = to;
			}
		}
	}
}
