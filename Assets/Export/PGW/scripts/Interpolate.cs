using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Interpolate
{
	public enum EaseType
	{
		Linear = 0,
		EaseInQuad = 1,
		EaseOutQuad = 2,
		EaseInOutQuad = 3,
		EaseInCubic = 4,
		EaseOutCubic = 5,
		EaseInOutCubic = 6,
		EaseInQuart = 7,
		EaseOutQuart = 8,
		EaseInOutQuart = 9,
		EaseInQuint = 10,
		EaseOutQuint = 11,
		EaseInOutQuint = 12,
		EaseInSine = 13,
		EaseOutSine = 14,
		EaseInOutSine = 15,
		EaseInExpo = 16,
		EaseOutExpo = 17,
		EaseInOutExpo = 18,
		EaseInCirc = 19,
		EaseOutCirc = 20,
		EaseInOutCirc = 21
	}

	public delegate Vector3 ToVector3<T>(T gparam_0);

	public delegate float Function(float float_0, float float_1, float float_2, float float_3);

	private static Vector3 Identity(Vector3 vector3_0)
	{
		return vector3_0;
	}

	private static Vector3 TransformDotPosition(Transform transform_0)
	{
		return transform_0.position;
	}

	private static IEnumerable<float> NewTimer(float float_0)
	{
		float num = 0f;
		while (num < float_0)
		{
			yield return num;
			num += Time.deltaTime;
			if (num >= float_0)
			{
				yield return num;
			}
		}
	}

	private static IEnumerable<float> NewCounter(int int_0, int int_1, int int_2)
	{
		for (int i = int_0; i <= int_1; i += int_2)
		{
			yield return i;
		}
	}

	public static IEnumerator NewEase(Function function_0, Vector3 vector3_0, Vector3 vector3_1, float float_0)
	{
		IEnumerable<float> ienumerable_ = NewTimer(float_0);
		return NewEase(function_0, vector3_0, vector3_1, float_0, ienumerable_);
	}

	public static IEnumerator NewEase(Function function_0, Vector3 vector3_0, Vector3 vector3_1, int int_0)
	{
		IEnumerable<float> ienumerable_ = NewCounter(0, int_0 + 1, 1);
		return NewEase(function_0, vector3_0, vector3_1, int_0 + 1, ienumerable_);
	}

	private static IEnumerator NewEase(Function function_0, Vector3 vector3_0, Vector3 vector3_1, float float_0, IEnumerable<float> ienumerable_0)
	{
		Vector3 vector = vector3_1 - vector3_0;
		IEnumerator<float> enumerator = ienumerable_0.GetEnumerator();
		/*Error near IL_004e: Could not find block for branch target IL_005c*/;
		yield break;
	}

	private static Vector3 Ease(Function function_0, Vector3 vector3_0, Vector3 vector3_1, float float_0, float float_1)
	{
		vector3_0.x = function_0(vector3_0.x, vector3_1.x, float_0, float_1);
		vector3_0.y = function_0(vector3_0.y, vector3_1.y, float_0, float_1);
		vector3_0.z = function_0(vector3_0.z, vector3_1.z, float_0, float_1);
		return vector3_0;
	}

	public static Function Ease(EaseType easeType_0)
	{
		Function result = null;
		switch (easeType_0)
		{
		case EaseType.Linear:
			result = Linear;
			break;
		case EaseType.EaseInQuad:
			result = EaseInQuad;
			break;
		case EaseType.EaseOutQuad:
			result = EaseOutQuad;
			break;
		case EaseType.EaseInOutQuad:
			result = EaseInOutQuad;
			break;
		case EaseType.EaseInCubic:
			result = EaseInCubic;
			break;
		case EaseType.EaseOutCubic:
			result = EaseOutCubic;
			break;
		case EaseType.EaseInOutCubic:
			result = EaseInOutCubic;
			break;
		case EaseType.EaseInQuart:
			result = EaseInQuart;
			break;
		case EaseType.EaseOutQuart:
			result = EaseOutQuart;
			break;
		case EaseType.EaseInOutQuart:
			result = EaseInOutQuart;
			break;
		case EaseType.EaseInQuint:
			result = EaseInQuint;
			break;
		case EaseType.EaseOutQuint:
			result = EaseOutQuint;
			break;
		case EaseType.EaseInOutQuint:
			result = EaseInOutQuint;
			break;
		case EaseType.EaseInSine:
			result = EaseInSine;
			break;
		case EaseType.EaseOutSine:
			result = EaseOutSine;
			break;
		case EaseType.EaseInOutSine:
			result = EaseInOutSine;
			break;
		case EaseType.EaseInExpo:
			result = EaseInExpo;
			break;
		case EaseType.EaseOutExpo:
			result = EaseOutExpo;
			break;
		case EaseType.EaseInOutExpo:
			result = EaseInOutExpo;
			break;
		case EaseType.EaseInCirc:
			result = EaseInCirc;
			break;
		case EaseType.EaseOutCirc:
			result = EaseOutCirc;
			break;
		case EaseType.EaseInOutCirc:
			result = EaseInOutCirc;
			break;
		}
		return result;
	}

	public static IEnumerable<Vector3> NewBezier(Function function_0, Transform[] transform_0, float float_0)
	{
		IEnumerable<float> ienumerable_ = NewTimer(float_0);
		return NewBezier<Transform>(function_0, transform_0, TransformDotPosition, float_0, ienumerable_);
	}

	public static IEnumerable<Vector3> NewBezier(Function function_0, Transform[] transform_0, int int_0)
	{
		IEnumerable<float> ienumerable_ = NewCounter(0, int_0 + 1, 1);
		return NewBezier<Transform>(function_0, transform_0, TransformDotPosition, int_0 + 1, ienumerable_);
	}

	public static IEnumerable<Vector3> NewBezier(Function function_0, Vector3[] vector3_0, float float_0)
	{
		IEnumerable<float> ienumerable_ = NewTimer(float_0);
		return NewBezier<Vector3>(function_0, vector3_0, Identity, float_0, ienumerable_);
	}

	public static IEnumerable<Vector3> NewBezier(Function function_0, Vector3[] vector3_0, int int_0)
	{
		IEnumerable<float> ienumerable_ = NewCounter(0, int_0 + 1, 1);
		return NewBezier<Vector3>(function_0, vector3_0, Identity, int_0 + 1, ienumerable_);
	}

	private static IEnumerable<Vector3> NewBezier<T>(Function function_0, IList ilist_0, ToVector3<T> toVector3_0, float float_0, IEnumerable<float> ienumerable_0)
	{
		if (ilist_0.Count >= 2)
		{
			Vector3[] points = new Vector3[ilist_0.Count];
			IEnumerator<float> enumerator = ienumerable_0.GetEnumerator();
			/*Error near IL_005e: Could not find block for branch target IL_006c*/;
		}
		yield break;
	}

	private static Vector3 Bezier(Function function_0, Vector3[] vector3_0, float float_0, float float_1)
	{
		for (int num = vector3_0.Length - 1; num > 0; num--)
		{
			for (int i = 0; i < num; i++)
			{
				vector3_0[i].x = function_0(vector3_0[i].x, vector3_0[i + 1].x - vector3_0[i].x, float_0, float_1);
				vector3_0[i].y = function_0(vector3_0[i].y, vector3_0[i + 1].y - vector3_0[i].y, float_0, float_1);
				vector3_0[i].z = function_0(vector3_0[i].z, vector3_0[i + 1].z - vector3_0[i].z, float_0, float_1);
			}
		}
		return vector3_0[0];
	}

	public static IEnumerable<Vector3> NewCatmullRom(Transform[] transform_0, int int_0, bool bool_0)
	{
		return NewCatmullRom<Transform>(transform_0, TransformDotPosition, int_0, bool_0);
	}

	public static IEnumerable<Vector3> NewCatmullRom(Vector3[] vector3_0, int int_0, bool bool_0)
	{
		return NewCatmullRom<Vector3>(vector3_0, Identity, int_0, bool_0);
	}

	private static IEnumerable<Vector3> NewCatmullRom<T>(IList ilist_0, ToVector3<T> toVector3_0, int int_0, bool bool_0)
	{
		if (ilist_0.Count < 2)
		{
			yield break;
		}
		yield return toVector3_0((T)ilist_0[0]);
		int last = ilist_0.Count - 1;
		for (int current = 0; bool_0 || current < last; current++)
		{
			if (bool_0 && current > last)
			{
				current = 0;
			}
			int previous = ((current != 0) ? (current - 1) : ((!bool_0) ? current : last));
			int start = current;
			int end = ((current != last) ? (current + 1) : ((!bool_0) ? current : 0));
			int next = ((end != last) ? (end + 1) : ((!bool_0) ? end : 0));
			int stepCount = int_0 + 1;
			for (int step = 1; step <= stepCount; step++)
			{
				yield return CatmullRom(toVector3_0((T)ilist_0[previous]), toVector3_0((T)ilist_0[start]), toVector3_0((T)ilist_0[end]), toVector3_0((T)ilist_0[next]), step, stepCount);
			}
		}
	}

	private static Vector3 CatmullRom(Vector3 vector3_0, Vector3 vector3_1, Vector3 vector3_2, Vector3 vector3_3, float float_0, float float_1)
	{
		float num = float_0 / float_1;
		float num2 = num * num;
		float num3 = num2 * num;
		return vector3_0 * (-0.5f * num3 + num2 - 0.5f * num) + vector3_1 * (1.5f * num3 + -2.5f * num2 + 1f) + vector3_2 * (-1.5f * num3 + 2f * num2 + 0.5f * num) + vector3_3 * (0.5f * num3 - 0.5f * num2);
	}

	private static float Linear(float float_0, float float_1, float float_2, float float_3)
	{
		if (float_2 > float_3)
		{
			float_2 = float_3;
		}
		return float_1 * (float_2 / float_3) + float_0;
	}

	private static float EaseInQuad(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / float_3) : 1f);
		return float_1 * float_2 * float_2 + float_0;
	}

	private static float EaseOutQuad(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / float_3) : 1f);
		return (0f - float_1) * float_2 * (float_2 - 2f) + float_0;
	}

	private static float EaseInOutQuad(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / (float_3 / 2f)) : 2f);
		if (float_2 < 1f)
		{
			return float_1 / 2f * float_2 * float_2 + float_0;
		}
		float_2 -= 1f;
		return (0f - float_1) / 2f * (float_2 * (float_2 - 2f) - 1f) + float_0;
	}

	private static float EaseInCubic(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / float_3) : 1f);
		return float_1 * float_2 * float_2 * float_2 + float_0;
	}

	private static float EaseOutCubic(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / float_3) : 1f);
		float_2 -= 1f;
		return float_1 * (float_2 * float_2 * float_2 + 1f) + float_0;
	}

	private static float EaseInOutCubic(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / (float_3 / 2f)) : 2f);
		if (float_2 < 1f)
		{
			return float_1 / 2f * float_2 * float_2 * float_2 + float_0;
		}
		float_2 -= 2f;
		return float_1 / 2f * (float_2 * float_2 * float_2 + 2f) + float_0;
	}

	private static float EaseInQuart(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / float_3) : 1f);
		return float_1 * float_2 * float_2 * float_2 * float_2 + float_0;
	}

	private static float EaseOutQuart(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / float_3) : 1f);
		float_2 -= 1f;
		return (0f - float_1) * (float_2 * float_2 * float_2 * float_2 - 1f) + float_0;
	}

	private static float EaseInOutQuart(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / (float_3 / 2f)) : 2f);
		if (float_2 < 1f)
		{
			return float_1 / 2f * float_2 * float_2 * float_2 * float_2 + float_0;
		}
		float_2 -= 2f;
		return (0f - float_1) / 2f * (float_2 * float_2 * float_2 * float_2 - 2f) + float_0;
	}

	private static float EaseInQuint(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / float_3) : 1f);
		return float_1 * float_2 * float_2 * float_2 * float_2 * float_2 + float_0;
	}

	private static float EaseOutQuint(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / float_3) : 1f);
		float_2 -= 1f;
		return float_1 * (float_2 * float_2 * float_2 * float_2 * float_2 + 1f) + float_0;
	}

	private static float EaseInOutQuint(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / (float_3 / 2f)) : 2f);
		if (float_2 < 1f)
		{
			return float_1 / 2f * float_2 * float_2 * float_2 * float_2 * float_2 + float_0;
		}
		float_2 -= 2f;
		return float_1 / 2f * (float_2 * float_2 * float_2 * float_2 * float_2 + 2f) + float_0;
	}

	private static float EaseInSine(float float_0, float float_1, float float_2, float float_3)
	{
		if (float_2 > float_3)
		{
			float_2 = float_3;
		}
		return (0f - float_1) * Mathf.Cos(float_2 / float_3 * ((float)Math.PI / 2f)) + float_1 + float_0;
	}

	private static float EaseOutSine(float float_0, float float_1, float float_2, float float_3)
	{
		if (float_2 > float_3)
		{
			float_2 = float_3;
		}
		return float_1 * Mathf.Sin(float_2 / float_3 * ((float)Math.PI / 2f)) + float_0;
	}

	private static float EaseInOutSine(float float_0, float float_1, float float_2, float float_3)
	{
		if (float_2 > float_3)
		{
			float_2 = float_3;
		}
		return (0f - float_1) / 2f * (Mathf.Cos((float)Math.PI * float_2 / float_3) - 1f) + float_0;
	}

	private static float EaseInExpo(float float_0, float float_1, float float_2, float float_3)
	{
		if (float_2 > float_3)
		{
			float_2 = float_3;
		}
		return float_1 * Mathf.Pow(2f, 10f * (float_2 / float_3 - 1f)) + float_0;
	}

	private static float EaseOutExpo(float float_0, float float_1, float float_2, float float_3)
	{
		if (float_2 > float_3)
		{
			float_2 = float_3;
		}
		return float_1 * (0f - Mathf.Pow(2f, -10f * float_2 / float_3) + 1f) + float_0;
	}

	private static float EaseInOutExpo(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / (float_3 / 2f)) : 2f);
		if (float_2 < 1f)
		{
			return float_1 / 2f * Mathf.Pow(2f, 10f * (float_2 - 1f)) + float_0;
		}
		float_2 -= 1f;
		return float_1 / 2f * (0f - Mathf.Pow(2f, -10f * float_2) + 2f) + float_0;
	}

	private static float EaseInCirc(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / float_3) : 1f);
		return (0f - float_1) * (Mathf.Sqrt(1f - float_2 * float_2) - 1f) + float_0;
	}

	private static float EaseOutCirc(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / float_3) : 1f);
		float_2 -= 1f;
		return float_1 * Mathf.Sqrt(1f - float_2 * float_2) + float_0;
	}

	private static float EaseInOutCirc(float float_0, float float_1, float float_2, float float_3)
	{
		float_2 = ((!(float_2 > float_3)) ? (float_2 / (float_3 / 2f)) : 2f);
		if (float_2 < 1f)
		{
			return (0f - float_1) / 2f * (Mathf.Sqrt(1f - float_2 * float_2) - 1f) + float_0;
		}
		float_2 -= 2f;
		return float_1 / 2f * (Mathf.Sqrt(1f - float_2 * float_2) + 1f) + float_0;
	}
}
