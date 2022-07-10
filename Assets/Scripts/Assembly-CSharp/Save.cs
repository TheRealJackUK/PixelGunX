using System;
using UnityEngine;

public class Save : MonoBehaviour
{
	public static void SavePos(string name, GameObject gameObject)
	{
		PlayerPrefs.SetString(name, gameObject.transform.position.x + "&" + gameObject.transform.position.y + "&" + gameObject.transform.position.z);
	}

	public static void SaveString(string name, string variable)
	{
		PlayerPrefs.SetString(name, variable);
	}

	public static void SaveStringArray(string name, string[] variable)
	{
		Debug.Log("SaveStringArray name: " + name + "  variable=" + variable);
		PlayerPrefs.SetString(name, string.Join("#", variable));
	}

	public static void SaveStringArray(string name, string[] variable, char separator)
	{
		PlayerPrefs.SetString(name, string.Join(separator.ToString(), variable));
	}

	public static void SaveInt(string name, int variable)
	{
		PlayerPrefs.SetInt(name, variable);
	}

	public static void SaveIntArray(string name, int[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveUInt(string name, uint variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveUIntArray(string name, uint[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveLong(string name, long variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveLongArray(string name, long[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveULong(string name, ulong variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveULongArray(string name, ulong[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveShort(string name, short variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveShortArray(string name, short[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveUShort(string name, ushort variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveUShortArray(string name, ushort[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveFloat(string name, float variable)
	{
		PlayerPrefs.SetFloat(name, variable);
	}

	public static void SaveFloatArray(string name, float[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveDouble(string name, double variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveDoubleArray(string name, double[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveBool(string name, bool variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveBoolArray(string name, bool[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveChar(string name, char variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveCharArray(string name, char[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveCharArray(string name, char[] variable, char separator)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + separator;
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveDecimal(string name, decimal variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveDecimalArray(string name, decimal[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveByte(string name, byte variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveByteArray(string name, byte[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveSByte(string name, sbyte variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveSByteArray(string name, sbyte[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i] + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveVector4(string name, Vector4 variable)
	{
		PlayerPrefs.SetString(name, variable.x + "&" + variable.y + "&" + variable.z + "&" + variable.w);
	}

	public static void SaveVector4Array(string name, Vector4[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			string text2 = text;
			text = text2 + variable[i].x + "&" + variable[i].y + "&" + variable[i].z + "&" + variable[i].w + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveVector3(string name, Vector3 variable)
	{
		PlayerPrefs.SetString(name, variable.x + "&" + variable.y + "&" + variable.z);
	}

	public static void SaveVector3Array(string name, Vector3[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			string text2 = text;
			text = text2 + variable[i].x + "&" + variable[i].y + "&" + variable[i].z + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveVector2(string name, Vector2 variable)
	{
		PlayerPrefs.SetString(name, variable.x + "&" + variable.y);
	}

	public static void SaveVector2Array(string name, Vector2[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			string text2 = text;
			text = text2 + variable[i].x + "&" + variable[i].y + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveQuaternion(string name, Quaternion variable)
	{
		PlayerPrefs.SetString(name, variable.x + "&" + variable.y + "&" + variable.z + "&" + variable.w);
	}

	public static void SaveQuaternionArray(string name, Quaternion[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			string text2 = text;
			text = text2 + variable[i].x + "&" + variable[i].y + "&" + variable[i].z + "&" + variable[i].w + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveColor(string name, Color variable)
	{
		PlayerPrefs.SetString(name, variable.r + "&" + variable.g + "&" + variable.b + "&" + variable.a);
	}

	public static void SaveColorArray(string name, Color[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			string text2 = text;
			text = text2 + variable[i].r + "&" + variable[i].g + "&" + variable[i].b + "&" + variable[i].a + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveKeyCode(string name, KeyCode variable)
	{
		PlayerPrefs.SetString(name, variable.ToString());
	}

	public static void SaveKeyCodeArray(string name, KeyCode[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			text = text + variable[i].ToString() + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveRect(string name, Rect variable)
	{
		PlayerPrefs.SetString(name, variable.x + "&" + variable.y + "&" + variable.width + "&" + variable.height);
	}

	public static void SaveRectArray(string name, Rect[] variable)
	{
		string text = string.Empty;
		for (int i = 0; i < variable.Length; i++)
		{
			string text2 = text;
			text = text2 + variable[i].x + "&" + variable[i].y + "&" + variable[i].width + "&" + variable[i].height + "#";
		}
		PlayerPrefs.SetString(name, text.ToString());
	}

	public static void SaveTexture2D(string name, Texture2D variable)
	{
		byte[] inArray = variable.EncodeToPNG();
		int width = variable.width;
		int height = variable.height;
		string value = width + "&" + height + "&" + Convert.ToBase64String(inArray);
		PlayerPrefs.SetString(name, value);
	}

	public static void Delete(string name)
	{
		PlayerPrefs.DeleteKey(name);
	}

	public static void DeleteAll()
	{
		PlayerPrefs.DeleteAll();
	}
}
