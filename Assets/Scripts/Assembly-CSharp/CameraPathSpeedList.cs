using UnityEngine;

[ExecuteInEditMode]
public class CameraPathSpeedList : CameraPathPointList
{
	public enum Interpolation
	{
		None,
		Linear,
		SmoothStep
	}

	public Interpolation interpolation = Interpolation.SmoothStep;

	[SerializeField]
	private bool _enabled = true;

	public new CameraPathSpeed this[int index]
	{
		get
		{
			return (CameraPathSpeed)base[index];
		}
	}

	public bool listEnabled
	{
		get
		{
			return _enabled && base.realNumberOfPoints > 0;
		}
		set
		{
			_enabled = value;
		}
	}

	private void OnEnable()
	{
		base.hideFlags = HideFlags.HideInInspector;
	}

	public override void Init(CameraPath _cameraPath)
	{
		pointTypeName = "Speed";
		base.Init(_cameraPath);
	}

	public void AddSpeedPoint(CameraPathControlPoint atPoint)
	{
		CameraPathSpeed cameraPathSpeed = base.gameObject.AddComponent<CameraPathSpeed>();
		cameraPathSpeed.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathSpeed, atPoint);
		RecalculatePoints();
	}

	public CameraPathSpeed AddSpeedPoint(CameraPathControlPoint curvePointA, CameraPathControlPoint curvePointB, float curvePercetage)
	{
		CameraPathSpeed cameraPathSpeed = base.gameObject.AddComponent<CameraPathSpeed>();
		cameraPathSpeed.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathSpeed, curvePointA, curvePointB, Mathf.Clamp01(curvePercetage));
		RecalculatePoints();
		return cameraPathSpeed;
	}

	public float GetSpeed(float percentage)
	{
		if (base.realNumberOfPoints < 2)
		{
			if (base.realNumberOfPoints == 1)
			{
				return this[0].speed;
			}
			Debug.Log("Not enough points to define a speed");
			return 0f;
		}
		if (percentage >= 1f)
		{
			return ((CameraPathSpeed)GetPoint(base.realNumberOfPoints - 1)).speed;
		}
		percentage = Mathf.Clamp(percentage, 0f, 0.999f);
		switch (interpolation)
		{
		case Interpolation.SmoothStep:
			return SmoothStepInterpolation(percentage);
		case Interpolation.Linear:
			return LinearInterpolation(percentage);
		case Interpolation.None:
		{
			CameraPathSpeed cameraPathSpeed = (CameraPathSpeed)GetPoint(GetNextPointIndex(percentage));
			return cameraPathSpeed.speed;
		}
		default:
			return LinearInterpolation(percentage);
		}
	}

	private float LinearInterpolation(float percentage)
	{
		int lastPointIndex = GetLastPointIndex(percentage);
		CameraPathSpeed cameraPathSpeed = (CameraPathSpeed)GetPoint(lastPointIndex);
		CameraPathSpeed cameraPathSpeed2 = (CameraPathSpeed)GetPoint(lastPointIndex + 1);
		if (percentage < cameraPathSpeed.percent)
		{
			return cameraPathSpeed.speed;
		}
		if (percentage > cameraPathSpeed2.percent)
		{
			return cameraPathSpeed2.speed;
		}
		float percent = cameraPathSpeed.percent;
		float num = cameraPathSpeed2.percent;
		if (percent > num)
		{
			num += 1f;
		}
		float num2 = num - percent;
		float num3 = percentage - percent;
		float t = num3 / num2;
		return Mathf.Lerp(cameraPathSpeed.speed, cameraPathSpeed2.speed, t);
	}

	private float SmoothStepInterpolation(float percentage)
	{
		int lastPointIndex = GetLastPointIndex(percentage);
		CameraPathSpeed cameraPathSpeed = (CameraPathSpeed)GetPoint(lastPointIndex);
		CameraPathSpeed cameraPathSpeed2 = (CameraPathSpeed)GetPoint(lastPointIndex + 1);
		if (percentage < cameraPathSpeed.percent)
		{
			return cameraPathSpeed.speed;
		}
		if (percentage > cameraPathSpeed2.percent)
		{
			return cameraPathSpeed2.speed;
		}
		float percent = cameraPathSpeed.percent;
		float num = cameraPathSpeed2.percent;
		if (percent > num)
		{
			num += 1f;
		}
		float num2 = num - percent;
		float num3 = percentage - percent;
		float val = num3 / num2;
		return Mathf.Lerp(cameraPathSpeed.speed, cameraPathSpeed2.speed, CPMath.SmoothStep(val));
	}
}
