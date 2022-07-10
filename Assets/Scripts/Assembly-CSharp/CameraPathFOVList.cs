using UnityEngine;

[ExecuteInEditMode]
public class CameraPathFOVList : CameraPathPointList
{
	public enum Interpolation
	{
		None,
		Linear,
		SmoothStep
	}

	private const float DEFAULT_FOV = 60f;

	public Interpolation interpolation = Interpolation.SmoothStep;

	public bool listEnabled = true;

	public new CameraPathFOV this[int index]
	{
		get
		{
			return (CameraPathFOV)base[index];
		}
	}

	private float defaultFOV
	{
		get
		{
			if ((bool)Camera.current)
			{
				return Camera.current.fieldOfView;
			}
			Camera[] allCameras = Camera.allCameras;
			if (allCameras.Length > 0)
			{
				return allCameras[0].fieldOfView;
			}
			return 60f;
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
			cameraPath.PathPointAddedEvent += AddFOV;
			pointTypeName = "FOV";
			initialised = true;
		}
	}

	public override void CleanUp()
	{
		base.CleanUp();
		cameraPath.PathPointAddedEvent -= AddFOV;
		initialised = false;
	}

	public void AddFOV(CameraPathControlPoint atPoint)
	{
		CameraPathFOV cameraPathFOV = base.gameObject.AddComponent<CameraPathFOV>();
		cameraPathFOV.FOV = defaultFOV;
		cameraPathFOV.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathFOV, atPoint);
		RecalculatePoints();
	}

	public CameraPathFOV AddFOV(CameraPathControlPoint curvePointA, CameraPathControlPoint curvePointB, float curvePercetage, float fov)
	{
		CameraPathFOV cameraPathFOV = base.gameObject.AddComponent<CameraPathFOV>();
		cameraPathFOV.hideFlags = HideFlags.HideInInspector;
		cameraPathFOV.FOV = fov;
		AddPoint(cameraPathFOV, curvePointA, curvePointB, curvePercetage);
		RecalculatePoints();
		return cameraPathFOV;
	}

	public float GetFOV(float percentage)
	{
		if (base.realNumberOfPoints < 2)
		{
			if (base.realNumberOfPoints == 1)
			{
				return this[0].FOV;
			}
			return 60f;
		}
		percentage = Mathf.Clamp(percentage, 0f, 1f);
		switch (interpolation)
		{
		case Interpolation.SmoothStep:
			return SmoothStepInterpolation(percentage);
		case Interpolation.Linear:
			return LinearInterpolation(percentage);
		default:
			return LinearInterpolation(percentage);
		}
	}

	private float LinearInterpolation(float percentage)
	{
		int lastPointIndex = GetLastPointIndex(percentage);
		CameraPathFOV cameraPathFOV = (CameraPathFOV)GetPoint(lastPointIndex);
		CameraPathFOV cameraPathFOV2 = (CameraPathFOV)GetPoint(lastPointIndex + 1);
		float percent = cameraPathFOV.percent;
		float num = cameraPathFOV2.percent;
		if (percent > num)
		{
			num += 1f;
		}
		float num2 = num - percent;
		float num3 = percentage - percent;
		float t = num3 / num2;
		return Mathf.Lerp(cameraPathFOV.FOV, cameraPathFOV2.FOV, t);
	}

	private float SmoothStepInterpolation(float percentage)
	{
		int lastPointIndex = GetLastPointIndex(percentage);
		CameraPathFOV cameraPathFOV = (CameraPathFOV)GetPoint(lastPointIndex);
		CameraPathFOV cameraPathFOV2 = (CameraPathFOV)GetPoint(lastPointIndex + 1);
		float percent = cameraPathFOV.percent;
		float num = cameraPathFOV2.percent;
		if (percent > num)
		{
			num += 1f;
		}
		float num2 = num - percent;
		float num3 = percentage - percent;
		float val = num3 / num2;
		return Mathf.Lerp(cameraPathFOV.FOV, cameraPathFOV2.FOV, CPMath.SmoothStep(val));
	}
}
