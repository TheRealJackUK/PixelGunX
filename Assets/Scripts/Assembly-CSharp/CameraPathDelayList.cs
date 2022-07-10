using System;
using UnityEngine;

[ExecuteInEditMode]
public class CameraPathDelayList : CameraPathPointList
{
	public delegate void CameraPathDelayEventHandler(float time);

	public float MINIMUM_EASE_VALUE = 0.01f;

	private float _lastPercentage;

	[SerializeField]
	private CameraPathDelay _introPoint;

	[SerializeField]
	private CameraPathDelay _outroPoint;

	[SerializeField]
	private bool delayInitialised;

	public new CameraPathDelay this[int index]
	{
		get
		{
			return (CameraPathDelay)base[index];
		}
	}

	public CameraPathDelay introPoint
	{
		get
		{
			return _introPoint;
		}
	}

	public CameraPathDelay outroPoint
	{
		get
		{
			return _outroPoint;
		}
	}

	public event CameraPathDelayEventHandler CameraPathDelayEvent;

	private void OnEnable()
	{
		base.hideFlags = HideFlags.HideInInspector;
	}

	public override void Init(CameraPath _cameraPath)
	{
		base.Init(_cameraPath);
		if (!delayInitialised)
		{
			_introPoint = base.gameObject.AddComponent<CameraPathDelay>();
			_introPoint.customName = "Start Point";
			_introPoint.hideFlags = HideFlags.HideInInspector;
			AddPoint(introPoint, 0f);
			_outroPoint = base.gameObject.AddComponent<CameraPathDelay>();
			_outroPoint.customName = "End Point";
			_outroPoint.hideFlags = HideFlags.HideInInspector;
			AddPoint(outroPoint, 1f);
			RecalculatePoints();
			delayInitialised = true;
		}
		pointTypeName = "Delay";
	}

	public void AddDelayPoint(CameraPathControlPoint atPoint)
	{
		CameraPathDelay cameraPathDelay = base.gameObject.AddComponent<CameraPathDelay>();
		cameraPathDelay.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathDelay, atPoint);
		RecalculatePoints();
	}

	public CameraPathDelay AddDelayPoint(CameraPathControlPoint curvePointA, CameraPathControlPoint curvePointB, float curvePercetage)
	{
		CameraPathDelay cameraPathDelay = base.gameObject.AddComponent<CameraPathDelay>();
		cameraPathDelay.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathDelay, curvePointA, curvePointB, curvePercetage);
		RecalculatePoints();
		return cameraPathDelay;
	}

	public void OnAnimationStart(float startPercentage)
	{
		_lastPercentage = startPercentage;
	}

	public void CheckEvents(float percentage)
	{
		if (Mathf.Abs(percentage - _lastPercentage) > 0.1f)
		{
			_lastPercentage = percentage;
		}
		else
		{
			if (_lastPercentage == percentage)
			{
				return;
			}
			for (int i = 0; i < base.realNumberOfPoints; i++)
			{
				CameraPathDelay cameraPathDelay = this[i];
				if (cameraPathDelay == outroPoint)
				{
					continue;
				}
				if (cameraPathDelay.percent >= _lastPercentage && cameraPathDelay.percent <= percentage)
				{
					if (cameraPathDelay != introPoint)
					{
						FireDelay(cameraPathDelay);
					}
					else if (cameraPathDelay.time > 0f)
					{
						FireDelay(cameraPathDelay);
					}
				}
				else if (cameraPathDelay.percent >= percentage && cameraPathDelay.percent <= _lastPercentage)
				{
					if (cameraPathDelay != introPoint)
					{
						FireDelay(cameraPathDelay);
					}
					else if (cameraPathDelay.time > 0f)
					{
						FireDelay(cameraPathDelay);
					}
				}
			}
			_lastPercentage = percentage;
		}
	}

	public float CheckEase(float percent)
	{
		float val = 1f;
		for (int i = 0; i < base.realNumberOfPoints; i++)
		{
			CameraPathDelay cameraPathDelay = this[i];
			if (cameraPathDelay != introPoint)
			{
				CameraPathDelay cameraPathDelay2 = (CameraPathDelay)GetPoint(i - 1);
				float pathPercentage = cameraPath.GetPathPercentage(cameraPathDelay2.percent, cameraPathDelay.percent, 1f - cameraPathDelay.introStartEasePercentage);
				if (pathPercentage < percent && cameraPathDelay.percent > percent)
				{
					float time = (percent - pathPercentage) / (cameraPathDelay.percent - pathPercentage);
					val = cameraPathDelay.introCurve.Evaluate(time);
				}
			}
			if (cameraPathDelay != outroPoint)
			{
				CameraPathDelay cameraPathDelay3 = (CameraPathDelay)GetPoint(i + 1);
				float pathPercentage2 = cameraPath.GetPathPercentage(cameraPathDelay.percent, cameraPathDelay3.percent, cameraPathDelay.outroEndEasePercentage);
				if (cameraPathDelay.percent < percent && pathPercentage2 > percent)
				{
					float time2 = (percent - cameraPathDelay.percent) / (pathPercentage2 - cameraPathDelay.percent);
					val = cameraPathDelay.outroCurve.Evaluate(time2);
				}
			}
		}
		return Math.Max(val, MINIMUM_EASE_VALUE);
	}

	public void FireDelay(CameraPathDelay eventPoint)
	{
		if (this.CameraPathDelayEvent != null)
		{
			this.CameraPathDelayEvent(eventPoint.time);
		}
	}
}
