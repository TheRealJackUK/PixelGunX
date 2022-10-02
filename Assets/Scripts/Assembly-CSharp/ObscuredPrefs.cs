using UnityEngine;
using System;
using System.Text;

public class ObscuredPrefs : MonoBehaviour 
{
    public static string ConvertHex(string var1)
    {
        return var1;
    }
    public static string Base64Encode(string var1) {
        var var2 = System.Text.Encoding.UTF8.GetBytes(var1);
        return System.Convert.ToBase64String(var2);
    }
    public static string Base64Decode(string var1) {
        var var2 = System.Convert.FromBase64String(var1);
        return System.Text.Encoding.UTF8.GetString(var2);
    }
    public static string ToBytes(string var1) {
        return var1;
    }
    public static bool HasKey(string var1) {
        string var2 = Base64Encode(ToBytes(var1));
        return PlayerPrefs.HasKey(var2);
    }

    public static void SetString(string var1, string var2) {
        string var3 = Base64Encode(var1);
        string var4 = Base64Encode(var2);
        PlayerPrefs.SetString(var3, var4);
    }

    // keep in mind this is setstring because you cant really store base64 in ints
    public static void SetInt(string var1, int var2) {
        string var3 = Base64Encode(var1);
        string var4 = Base64Encode(var2.ToString());
        PlayerPrefs.SetString(var3, var4);
    }
    public static void DeleteKey(string var1) {
        string var3 = Base64Encode(var1);
        PlayerPrefs.DeleteKey(var3);
    }
    public static string GetString(string var1) {
        string var2 = Base64Encode(var1);
        if (HasKey(var1)) {
            return ConvertHex(Base64Decode(PlayerPrefs.GetString(var2)));
        }
        return "";
    }

    public static int GetInt(string var1) {
        string var2 = Base64Encode(var1);
        if (HasKey(var1)) {
            //UnityEngine.Debug.Log(ConvertHex(Base64Decode(PlayerPrefs.GetString(var2))));
            return int.Parse(ConvertHex(Base64Decode(PlayerPrefs.GetString(var2))));
        }
        return 0;
    }
}