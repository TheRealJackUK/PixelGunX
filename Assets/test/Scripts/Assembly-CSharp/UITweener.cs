using UnityEngine;
using System.Collections.Generic;

public class UITweener : MonoBehaviour
{
	public enum Method
	{
		Linear = 0,
		EaseIn = 1,
		EaseOut = 2,
		EaseInOut = 3,
		BounceIn = 4,
		BounceOut = 5,
	}

	public enum Style
	{
		Once = 0,
		Loop = 1,
		PingPong = 2,
	}

	public Method method_0;
	public Style style_0;
	public AnimationCurve animationCurve_0;
	public bool bool_0;
	public float float_0;
	public float float_1;
	public bool bool_1;
	public int int_0;
	public List<EventDelegate> list_0;
	public GameObject gameObject_0;
	public string string_0;
}
