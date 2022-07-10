using UnityEngine;

[ExecuteInEditMode]
public class CameraPathTiltList : CameraPathPointList
{
	public enum Interpolation
	{
		None,
		Linear,
		SmoothStep
	}

	public Interpolation interpolation = Interpolation.SmoothStep;

	public bool listEnabled = true;

	public float autoSensitivity = 1f;

	public new CameraPathTilt this[int index]
	{
		get
		{
			return (CameraPathTilt)base[index];
		}
	}

	private void OnEnable()
	{
		base.hideFlags = HideFlags.HideInInspector;
	}

	public override void Init(CameraPath _cameraPath)
	{
		if (!initialised)
		{
			base.Init(_cameraPath);
			cameraPath.PathPointAddedEvent += AddTilt;
			pointTypeName = "Tilt";
			initialised = true;
		}
	}

	public override void CleanUp()
	{
		base.CleanUp();
		cameraPath.PathPointAddedEvent -= AddTilt;
		initialised = false;
	}

	public void AddTilt(CameraPathControlPoint atPoint)
	{
		CameraPathTilt cameraPathTilt = base.gameObject.AddComponent<CameraPathTilt>();
		cameraPathTilt.tilt = 0f;
		cameraPathTilt.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathTilt, atPoint);
		RecalculatePoints();
	}

	public CameraPathTilt AddTilt(CameraPathControlPoint curvePointA, CameraPathControlPoint curvePointB, float curvePercetage, float tilt)
	{
		CameraPathTilt cameraPathTilt = base.gameObject.AddComponent<CameraPathTilt>();
		cameraPathTilt.tilt = tilt;
		cameraPathTilt.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathTilt, curvePointA, curvePointB, curvePercetage);
		RecalculatePoints();
		return cameraPathTilt;
	}

	public float GetTilt(float percentage)
	{
		if (base.realNumberOfPoints < 2)
		{
			if (base.realNumberOfPoints == 1)
			{
				return this[0].tilt;
			}
			return 0f;
		}
		percentage = Mathf.Clamp(percentage, 0f, 1f);
		switch (interpolation)
		{
		case Interpolation.SmoothStep:
			return SmoothStepInterpolation(percentage);
		case Interpolation.Linear:
			return LinearInterpolation(percentage);
		case Interpolation.None:
		{
			CameraPathTilt cameraPathTilt = (CameraPathTilt)GetPoint(GetNextPointIndex(percentage));
			return cameraPathTilt.tilt;
		}
		default:
			return LinearInterpolation(percentage);
		}
	}

	public void AutoSetTilts()
	{
		for (int i = 0; i < base.realNumberOfPoints; i++)
		{
			AutoSetTilt(this[i]);
		}
	}

	public void AutoSetTilt(CameraPathTilt point)
	{
		float percent = point.percent;
		Vector3 pathPosition = cameraPath.GetPathPosition(percent - 0.1f);
		Vector3 pathPosition2 = cameraPath.GetPathPosition(percent);
		Vector3 pathPosition3 = cameraPath.GetPathPosition(percent + 0.1f);
		Vector3 vector = pathPosition2 - pathPosition;
		Vector3 vector2 = pathPosition3 - pathPosition2;
		Quaternion quaternion = Quaternion.LookRotation(-cameraPath.GetPathDirection(point.percent));
		Vector3 vector3 = quaternion * (vector2 - vector).normalized;
		float num = Vector2.Angle(Vector2.up, new Vector2(vector3.x, vector3.y));
		float num2 = Mathf.Min(Mathf.Abs(vector3.x) + Mathf.Abs(vector3.y) / Mathf.Abs(vector3.z), 1f);
		point.tilt = (0f - num) * autoSensitivity * num2;
	}

	private float LinearInterpolation(float percentage)
	{
		int lastPointIndex = GetLastPointIndex(percentage);
		CameraPathTilt cameraPathTilt = (CameraPathTilt)GetPoint(lastPointIndex);
		CameraPathTilt cameraPathTilt2 = (CameraPathTilt)GetPoint(lastPointIndex + 1);
		float percent = cameraPathTilt.percent;
		float num = cameraPathTilt2.percent;
		if (percent > num)
		{
			num += 1f;
		}
		float num2 = num - percent;
		float num3 = percentage - percent;
		float t = num3 / num2;
		return Mathf.Lerp(cameraPathTilt.tilt, cameraPathTilt2.tilt, t);
	}

	private float SmoothStepInterpolation(float percentage)
	{
		int lastPointIndex = GetLastPointIndex(percentage);
		CameraPathTilt cameraPathTilt = (CameraPathTilt)GetPoint(lastPointIndex);
		CameraPathTilt cameraPathTilt2 = (CameraPathTilt)GetPoint(lastPointIndex + 1);
		float percent = cameraPathTilt.percent;
		float num = cameraPathTilt2.percent;
		if (percent > num)
		{
			num += 1f;
		}
		float num2 = num - percent;
		float num3 = percentage - percent;
		float val = num3 / num2;
		return Mathf.Lerp(cameraPathTilt.tilt, cameraPathTilt2.tilt, CPMath.SmoothStep(val));
	}
}
