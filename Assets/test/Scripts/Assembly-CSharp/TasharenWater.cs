using UnityEngine;

public class TasharenWater : MonoBehaviour
{
	public enum Quality
	{
		Fastest = 0,
		Low = 1,
		Medium = 2,
		High = 3,
		Uber = 4,
	}

	public Quality quality;
	public LayerMask highReflectionMask;
	public LayerMask mediumReflectionMask;
	public bool keepUnderCamera;
}
