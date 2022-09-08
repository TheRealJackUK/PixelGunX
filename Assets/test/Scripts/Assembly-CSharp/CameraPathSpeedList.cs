using UnityEngine;

public class CameraPathSpeedList : CameraPathPointList
{
	public enum Interpolation
	{
		None = 0,
		Linear = 1,
		SmoothStep = 2,
	}

	public Interpolation interpolation_0;
	[SerializeField]
	private bool bool_1;
}
