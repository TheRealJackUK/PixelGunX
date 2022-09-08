using UnityEngine;

public class CameraPathEvent : CameraPathPoint
{
	public enum Types
	{
		Broadcast = 0,
		Call = 1,
	}

	public enum ArgumentTypes
	{
		None = 0,
		Float = 1,
		Int = 2,
		String = 3,
	}

	public Types types_0;
	public string string_0;
	public GameObject gameObject_0;
	public string string_1;
	public string string_2;
	public ArgumentTypes argumentTypes_0;
}
