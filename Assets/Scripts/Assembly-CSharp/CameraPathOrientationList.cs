using UnityEngine;

[ExecuteInEditMode]
public class CameraPathOrientationList : CameraPathPointList
{
	public enum Interpolation
	{
		None,
		Linear,
		SmoothStep,
		Hermite,
		Cubic
	}

	public Interpolation interpolation = Interpolation.Cubic;

	public new CameraPathOrientation this[int index]
	{
		get
		{
			return (CameraPathOrientation)base[index];
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
			pointTypeName = "Orientation";
			base.Init(_cameraPath);
			cameraPath.PathPointAddedEvent += AddOrientation;
			initialised = true;
		}
	}

	public override void CleanUp()
	{
		base.CleanUp();
		cameraPath.PathPointAddedEvent -= AddOrientation;
		initialised = false;
	}

	public void AddOrientation(CameraPathControlPoint atPoint)
	{
		CameraPathOrientation cameraPathOrientation = base.gameObject.AddComponent<CameraPathOrientation>();
		if (atPoint.forwardControlPoint != Vector3.zero)
		{
			cameraPathOrientation.rotation = Quaternion.LookRotation(atPoint.forwardControlPoint);
		}
		else
		{
			cameraPathOrientation.rotation = Quaternion.LookRotation(cameraPath.GetPathDirection(atPoint.percentage));
		}
		cameraPathOrientation.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathOrientation, atPoint);
		RecalculatePoints();
	}

	public CameraPathOrientation AddOrientation(CameraPathControlPoint curvePointA, CameraPathControlPoint curvePointB, float curvePercetage, Quaternion rotation)
	{
		CameraPathOrientation cameraPathOrientation = base.gameObject.AddComponent<CameraPathOrientation>();
		cameraPathOrientation.rotation = rotation;
		cameraPathOrientation.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathOrientation, curvePointA, curvePointB, curvePercetage);
		RecalculatePoints();
		return cameraPathOrientation;
	}

	public void RemovePoint(CameraPathOrientation orientation)
	{
		RemovePoint((CameraPathPoint)orientation);
		RecalculatePoints();
	}

	public Quaternion GetOrientation(float percentage)
	{
		if (base.realNumberOfPoints < 2)
		{
			if (base.realNumberOfPoints == 1)
			{
				return this[0].rotation;
			}
			return Quaternion.identity;
		}
		if (float.IsNaN(percentage))
		{
			percentage = 0f;
		}
		percentage = Mathf.Clamp(percentage, 0f, 1f);
		Quaternion identity = Quaternion.identity;
		switch (interpolation)
		{
		case Interpolation.Cubic:
			identity = CubicInterpolation(percentage);
			break;
		case Interpolation.Hermite:
			identity = CubicInterpolation(percentage);
			break;
		case Interpolation.SmoothStep:
			identity = SmootStepInterpolation(percentage);
			break;
		case Interpolation.Linear:
			identity = LinearInterpolation(percentage);
			break;
		case Interpolation.None:
		{
			CameraPathOrientation cameraPathOrientation = (CameraPathOrientation)GetPoint(GetNextPointIndex(percentage));
			identity = cameraPathOrientation.rotation;
			break;
		}
		default:
			identity = Quaternion.LookRotation(Vector3.forward);
			break;
		}
		if (float.IsNaN(identity.x))
		{
			return Quaternion.identity;
		}
		return identity;
	}

	private Quaternion LinearInterpolation(float percentage)
	{
		int lastPointIndex = GetLastPointIndex(percentage);
		CameraPathOrientation cameraPathOrientation = (CameraPathOrientation)GetPoint(lastPointIndex);
		CameraPathOrientation cameraPathOrientation2 = (CameraPathOrientation)GetPoint(lastPointIndex + 1);
		float percent = cameraPathOrientation.percent;
		float num = cameraPathOrientation2.percent;
		if (percent > num)
		{
			num += 1f;
		}
		float num2 = num - percent;
		float num3 = percentage - percent;
		float t = num3 / num2;
		return Quaternion.Lerp(cameraPathOrientation.rotation, cameraPathOrientation2.rotation, t);
	}

	private Quaternion SmootStepInterpolation(float percentage)
	{
		int lastPointIndex = GetLastPointIndex(percentage);
		CameraPathOrientation cameraPathOrientation = (CameraPathOrientation)GetPoint(lastPointIndex);
		CameraPathOrientation cameraPathOrientation2 = (CameraPathOrientation)GetPoint(lastPointIndex + 1);
		float percent = cameraPathOrientation.percent;
		float num = cameraPathOrientation2.percent;
		if (percent > num)
		{
			num += 1f;
		}
		float num2 = num - percent;
		float num3 = percentage - percent;
		float val = num3 / num2;
		return Quaternion.Lerp(cameraPathOrientation.rotation, cameraPathOrientation2.rotation, CPMath.SmoothStep(val));
	}

	private Quaternion CubicInterpolation(float percentage)
	{
		int lastPointIndex = GetLastPointIndex(percentage);
		CameraPathOrientation cameraPathOrientation = (CameraPathOrientation)GetPoint(lastPointIndex);
		CameraPathOrientation cameraPathOrientation2 = (CameraPathOrientation)GetPoint(lastPointIndex + 1);
		CameraPathOrientation cameraPathOrientation3 = (CameraPathOrientation)GetPoint(lastPointIndex - 1);
		CameraPathOrientation cameraPathOrientation4 = (CameraPathOrientation)GetPoint(lastPointIndex + 2);
		float percent = cameraPathOrientation.percent;
		float num = cameraPathOrientation2.percent;
		if (percent > num)
		{
			num += 1f;
		}
		float num2 = num - percent;
		float num3 = percentage - percent;
		float t = num3 / num2;
		Quaternion result = CPMath.CalculateCubic(cameraPathOrientation.rotation, cameraPathOrientation3.rotation, cameraPathOrientation4.rotation, cameraPathOrientation2.rotation, t);
		if (float.IsNaN(result.x))
		{
			Debug.Log(percentage + " " + cameraPathOrientation.fullName + " " + cameraPathOrientation2.fullName + " " + cameraPathOrientation3.fullName + " " + cameraPathOrientation4.fullName);
		}
		return result;
	}

	protected override void RecalculatePoints()
	{
		base.RecalculatePoints();
		for (int i = 0; i < base.realNumberOfPoints; i++)
		{
			CameraPathOrientation cameraPathOrientation = this[i];
			if (cameraPathOrientation.lookAt != null)
			{
				cameraPathOrientation.rotation = Quaternion.LookRotation(cameraPathOrientation.lookAt.transform.position - cameraPathOrientation.worldPosition);
			}
		}
	}
}
