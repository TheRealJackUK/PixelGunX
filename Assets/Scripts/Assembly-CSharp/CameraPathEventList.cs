using UnityEngine;

[ExecuteInEditMode]
public class CameraPathEventList : CameraPathPointList
{
	public delegate void CameraPathEventPointHandler(string name);

	private float _lastPercentage;

	public new CameraPathEvent this[int index]
	{
		get
		{
			return (CameraPathEvent)base[index];
		}
	}

	public event CameraPathEventPointHandler CameraPathEventPoint;

	private void OnEnable()
	{
		base.hideFlags = HideFlags.HideInInspector;
	}

	public override void Init(CameraPath _cameraPath)
	{
		pointTypeName = "Event";
		base.Init(_cameraPath);
	}

	public void AddEvent(CameraPathControlPoint atPoint)
	{
		CameraPathEvent cameraPathEvent = base.gameObject.AddComponent<CameraPathEvent>();
		cameraPathEvent.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathEvent, atPoint);
		RecalculatePoints();
	}

	public CameraPathEvent AddEvent(CameraPathControlPoint curvePointA, CameraPathControlPoint curvePointB, float curvePercetage)
	{
		CameraPathEvent cameraPathEvent = base.gameObject.AddComponent<CameraPathEvent>();
		cameraPathEvent.hideFlags = HideFlags.HideInInspector;
		AddPoint(cameraPathEvent, curvePointA, curvePointB, curvePercetage);
		RecalculatePoints();
		return cameraPathEvent;
	}

	public void OnAnimationStart(float startPercentage)
	{
		_lastPercentage = startPercentage;
	}

	public void CheckEvents(float percentage)
	{
		if (Mathf.Abs(percentage - _lastPercentage) > 0.5f)
		{
			_lastPercentage = percentage;
			return;
		}
		for (int i = 0; i < base.realNumberOfPoints; i++)
		{
			CameraPathEvent cameraPathEvent = this[i];
			if ((cameraPathEvent.percent >= _lastPercentage && cameraPathEvent.percent <= percentage) || (cameraPathEvent.percent >= percentage && cameraPathEvent.percent <= _lastPercentage))
			{
				switch (cameraPathEvent.type)
				{
				case CameraPathEvent.Types.Broadcast:
					BroadCast(cameraPathEvent);
					break;
				case CameraPathEvent.Types.Call:
					Call(cameraPathEvent);
					break;
				}
			}
		}
		_lastPercentage = percentage;
	}

	public void BroadCast(CameraPathEvent eventPoint)
	{
		if (this.CameraPathEventPoint != null)
		{
			this.CameraPathEventPoint(eventPoint.eventName);
		}
	}

	public void Call(CameraPathEvent eventPoint)
	{
		if (eventPoint.target == null)
		{
			Debug.LogError("Camera Path Event Error: There is an event call without a specified target. Please check " + eventPoint.displayName, cameraPath);
			return;
		}
		switch (eventPoint.argumentType)
		{
		case CameraPathEvent.ArgumentTypes.None:
			eventPoint.target.SendMessage(eventPoint.methodName, SendMessageOptions.DontRequireReceiver);
			break;
		case CameraPathEvent.ArgumentTypes.Int:
		{
			int result;
			if (int.TryParse(eventPoint.methodArgument, out result))
			{
				eventPoint.target.SendMessage(eventPoint.methodName, result, SendMessageOptions.DontRequireReceiver);
			}
			else
			{
				Debug.LogError("Camera Path Aniamtor: The argument specified is not an integer");
			}
			break;
		}
		case CameraPathEvent.ArgumentTypes.Float:
		{
			float num = float.Parse(eventPoint.methodArgument);
			if (float.IsNaN(num))
			{
				Debug.LogError("Camera Path Aniamtor: The argument specified is not a float");
			}
			eventPoint.target.SendMessage(eventPoint.methodName, num, SendMessageOptions.DontRequireReceiver);
			break;
		}
		case CameraPathEvent.ArgumentTypes.String:
		{
			string methodArgument = eventPoint.methodArgument;
			eventPoint.target.SendMessage(eventPoint.methodName, methodArgument, SendMessageOptions.DontRequireReceiver);
			break;
		}
		}
	}
}
