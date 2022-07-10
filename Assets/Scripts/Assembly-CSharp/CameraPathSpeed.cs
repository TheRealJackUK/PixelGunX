using UnityEngine;

public class CameraPathSpeed : CameraPathPoint
{
	public float _speed = 1f;

	public float speed
	{
		get
		{
			return _speed;
		}
		set
		{
			_speed = Mathf.Max(value, 1E-07f);
		}
	}
}
