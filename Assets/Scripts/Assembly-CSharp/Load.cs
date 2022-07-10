using System;
using UnityEngine;

public class Load : MonoBehaviour
{
	public static void LoadPos(string name, GameObject gameObject)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			gameObject.transform.position = new Vector3(0f, 0f, 0f);
		}
		string[] array = PlayerPrefs.GetString(name).Split("&"[0]);
		Vector3 position = new Vector3(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]));
		gameObject.transform.position = position;
	}

	public static string LoadString(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return string.Empty;
		}
		return PlayerPrefs.GetString(name);
	}

	public static string[] LoadStringArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			Debug.Log("LoadStringArray(): Cannot find key " + name);
			return null;
		}
		return PlayerPrefs.GetString(name).Split('#');
	}

	public static string[] LoadStringArray(string name, char separator)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		return PlayerPrefs.GetString(name).Split(separator);
	}

	public static int LoadInt(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0;
		}
		return PlayerPrefs.GetInt(name);
	}

	public static int[] LoadIntArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		int[] array2 = new int[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = Convert.ToInt32(array[i]);
		}
		return array2;
	}

	public static uint LoadUInt(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0u;
		}
		return uint.Parse(PlayerPrefs.GetString(name));
	}

	public static uint[] LoadUIntArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		uint[] array2 = new uint[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = Convert.ToUInt32(array[i]);
		}
		return array2;
	}

	public static long LoadLong(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0L;
		}
		return long.Parse(PlayerPrefs.GetString(name));
	}

	public static long[] LoadLongArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		long[] array2 = new long[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = long.Parse(array[i]);
		}
		return array2;
	}

	public static ulong LoadULong(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0uL;
		}
		return ulong.Parse(PlayerPrefs.GetString(name));
	}

	public static ulong[] LoadULongArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		ulong[] array2 = new ulong[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = ulong.Parse(array[i]);
		}
		return array2;
	}

	public static short LoadShort(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0;
		}
		return short.Parse(PlayerPrefs.GetString(name));
	}

	public static short[] LoadShortArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		short[] array2 = new short[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = short.Parse(array[i]);
		}
		return array2;
	}

	public static ushort LoadUShort(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0;
		}
		return ushort.Parse(PlayerPrefs.GetString(name));
	}

	public static ushort[] LoadUShortArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		ushort[] array2 = new ushort[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = ushort.Parse(array[i]);
		}
		return array2;
	}

	public static float LoadFloat(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0f;
		}
		return PlayerPrefs.GetFloat(name);
	}

	public static float[] LoadFloatArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		float[] array2 = new float[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = float.Parse(array[i]);
		}
		return array2;
	}

	public static double LoadDouble(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0.0;
		}
		return double.Parse(PlayerPrefs.GetString(name));
	}

	public static double[] LoadDoubleArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		double[] array2 = new double[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = double.Parse(array[i]);
		}
		return array2;
	}

	public static bool LoadBool(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return false;
		}
		string @string = PlayerPrefs.GetString(name);
		return bool.Parse(@string);
	}

	public static bool[] LoadBoolArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		bool[] array2 = new bool[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = bool.Parse(array[i]);
		}
		return array2;
	}

	public static char LoadChar(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return '\0';
		}
		char result = '\0';
		char.TryParse(PlayerPrefs.GetString(name), out result);
		return result;
	}

	public static char[] LoadCharArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		char[] array2 = new char[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			char.TryParse(array[i], out array2[i]);
		}
		return array2;
	}

	public static decimal LoadDecimal(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0m;
		}
		return decimal.Parse(PlayerPrefs.GetString(name));
	}

	public static decimal[] LoadDecimalArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		decimal[] array2 = new decimal[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = decimal.Parse(array[i]);
		}
		return array2;
	}

	public static byte LoadByte(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0;
		}
		return byte.Parse(PlayerPrefs.GetString(name));
	}

	public static byte[] LoadByteArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		byte[] array2 = new byte[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = byte.Parse(array[i]);
		}
		return array2;
	}

	public static sbyte LoadSByte(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return 0;
		}
		return sbyte.Parse(PlayerPrefs.GetString(name));
	}

	public static sbyte[] LoadSByteArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		sbyte[] array2 = new sbyte[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = sbyte.Parse(array[i]);
		}
		return array2;
	}

	public static Vector4 LoadVector4(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return new Vector4(0f, 0f, 0f, 0f);
		}
		string[] array = PlayerPrefs.GetString(name).Split("&"[0]);
		return new Vector4(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]), float.Parse(array[3]));
	}

	public static Vector4[] LoadVector4Array(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		Vector4[] array2 = new Vector4[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			string[] array3 = array[i].Split("&"[0]);
			array2[i] = new Vector4(float.Parse(array3[0]), float.Parse(array3[1]), float.Parse(array3[2]), float.Parse(array3[3]));
		}
		return array2;
	}

	public static Vector3 LoadVector3(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return new Vector3(0f, 0f, 0f);
		}
		string[] array = PlayerPrefs.GetString(name).Split("&"[0]);
		return new Vector3(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]));
	}

	public static Vector3[] LoadVector3Array(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split('#');
		Vector3[] array2 = new Vector3[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			string[] array3 = array[i].Split('&');
			array2[i] = new Vector3(float.Parse(array3[0]), float.Parse(array3[1]), float.Parse(array3[2]));
		}
		return array2;
	}

	public static Vector2 LoadVector2(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return new Vector2(0f, 0f);
		}
		string[] array = PlayerPrefs.GetString(name).Split("&"[0]);
		return new Vector2(float.Parse(array[0]), float.Parse(array[1]));
	}

	public static Vector2[] LoadVector2Array(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		Vector2[] array2 = new Vector2[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			string[] array3 = array[i].Split("&"[0]);
			array2[i] = new Vector2(float.Parse(array3[0]), float.Parse(array3[1]));
		}
		return array2;
	}

	public static Quaternion LoadQuaternion(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return new Quaternion(0f, 0f, 0f, 0f);
		}
		string[] array = PlayerPrefs.GetString(name).Split("&"[0]);
		return new Quaternion(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]), float.Parse(array[3]));
	}

	public static Quaternion[] LoadQuaternionArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		Quaternion[] array2 = new Quaternion[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			string[] array3 = array[i].Split("&"[0]);
			array2[i] = new Quaternion(float.Parse(array3[0]), float.Parse(array3[1]), float.Parse(array3[2]), float.Parse(array3[3]));
		}
		return array2;
	}

	public static Color LoadColor(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return new Color(0f, 0f, 0f, 0f);
		}
		string[] array = PlayerPrefs.GetString(name).Split("&"[0]);
		return new Color(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]), float.Parse(array[3]));
	}

	public static Color[] LoadColorArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		Color[] array2 = new Color[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			string[] array3 = array[i].Split("&"[0]);
			array2[i] = new Color(float.Parse(array3[0]), float.Parse(array3[1]), float.Parse(array3[2]), float.Parse(array3[3]));
		}
		return array2;
	}

	public static KeyCode LoadKeyCode(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return KeyCode.Space;
		}
		return (KeyCode)(int)Enum.Parse(typeof(KeyCode), PlayerPrefs.GetString(name));
	}

	public static KeyCode[] LoadKeyCodeArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		KeyCode[] array2 = new KeyCode[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			array2[i] = (KeyCode)(int)Enum.Parse(typeof(KeyCode), array[i]);
		}
		return array2;
	}

	public static Rect LoadRect(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return new Rect(0f, 0f, 0f, 0f);
		}
		string[] array = PlayerPrefs.GetString(name).Split("&"[0]);
		return new Rect(float.Parse(array[0]), float.Parse(array[1]), float.Parse(array[2]), float.Parse(array[3]));
	}

	public static Rect[] LoadRectArray(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("#"[0]);
		Rect[] array2 = new Rect[array.Length - 1];
		for (int i = 0; i < array.Length - 1; i++)
		{
			string[] array3 = array[i].Split("&"[0]);
			array2[i] = new Rect(float.Parse(array3[0]), float.Parse(array3[1]), float.Parse(array3[2]), float.Parse(array3[3]));
		}
		return array2;
	}

	public static Texture2D LoadTexture2D(string name)
	{
		if (!PlayerPrefs.HasKey(name))
		{
			return null;
		}
		string[] array = PlayerPrefs.GetString(name).Split("&"[0]);
		byte[] data = Convert.FromBase64String(array[2]);
		Texture2D texture2D = new Texture2D(int.Parse(array[0]), int.Parse(array[1]));
		texture2D.LoadImage(data);
		return texture2D;
	}

	public static Texture2D LoadTexture2DURL(string url)
	{
		WWW wWW = new WWW(url);
		while (!wWW.isDone)
		{
		}
		return wWW.texture;
	}

	public static void LoadTexture2DURL(string url, GameObject gameObject)
	{
		WWW wWW = new WWW(url);
		while (!wWW.isDone)
		{
		}
		Texture2D texture = wWW.texture;
		gameObject.GetComponent<Renderer>().material.mainTexture = texture;
	}
}
