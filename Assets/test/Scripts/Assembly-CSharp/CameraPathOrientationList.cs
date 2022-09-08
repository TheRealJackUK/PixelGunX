public class CameraPathOrientationList : CameraPathPointList
{
	public enum Interpolation
	{
		None = 0,
		Linear = 1,
		SmoothStep = 2,
		Hermite = 3,
		Cubic = 4,
	}

	public Interpolation interpolation_0;
}
