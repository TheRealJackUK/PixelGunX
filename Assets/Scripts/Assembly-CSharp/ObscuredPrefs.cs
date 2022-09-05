using UnityEngine;
using System;

public class ObscuredPrefs : MonoBehaviour 
{
    public static string ConvertHex(String hexString)
    {
        try
        {
            string ascii = string.Empty;

            for (int i = 0; i < hexString.Length; i += 2)
            {
                String hs = string.Empty;

                hs   = hexString.Substring(i,2);
                uint decval =   System.Convert.ToUInt32(hs, 16);
                char character = System.Convert.ToChar(decval);
                ascii += character;

            }

            return ascii;
        }
        catch (Exception ex) { Console.WriteLine(ex.Message); }

        return string.Empty;
    }
    public static string Base64Encode(string plainText) {
        var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
        return System.Convert.ToBase64String(plainTextBytes);
    }
    public static string Base64Decode(string base64EncodedData) {
        var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
        return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
    }
    public static void ToBytes(string var1) {
        byte[] ba = Encoding.Default.GetBytes(var1);
        var hexString = BitConverter.ToString(ba);
        hexString = hexString.Replace("-", "");
    }
    public static bool HasKey(string var1) {
        string var2 = Base64Encode(ToBytes(var1));
        return PlayerPrefs.HasKey(var2);
    }

    public static void SetString(string var1, string var2) {
        string var3 = Base64Encode(ToBytes(var1));
        string var4 = Base64Encode(ToBytes(var2));
        PlayerPrefs.SetString(var3, var4);
    }

    // keep in mind this is setstring because you cant really store base64 in ints
    public static void SetInt(string var1, string var2) {
        string var3 = Base64Encode(ToBytes(var1));
        string var4 = Base64Encode(ToBytes(var2));
        PlayerPrefs.SetString(var3, var4);
    }
    public static string GetString(string var1) {
        string var2 = Base64Encode(ToBytes(var1));
        return ConvertHex(Base64Decode(PlayerPrefs.GetString(var2)));
    }

    public static int GetInt(string var1) {
        string var2 = Base64Encode(ToBytes(var1));
        return int.Parse(ConvertHex(Base64Decode(PlayerPrefs.GetString(var2))));
    }
}