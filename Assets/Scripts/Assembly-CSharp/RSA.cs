using System;
using System.Reflection;

internal class RSA
{
	public static void SimpleParseASN1(string publicKey, ref byte[] modulus, ref byte[] exponent)
	{
		byte[] array = Convert.FromBase64String(publicKey);
		Type type = Type.GetType("Mono.Security.ASN1");
		ConstructorInfo constructor = type.GetConstructor(new Type[1] { typeof(byte[]) });
		PropertyInfo property = type.GetProperty("Value");
		PropertyInfo property2 = type.GetProperty("Item");
		object obj = constructor.Invoke(new object[1] { array });
		object value = property2.GetValue(obj, new object[1] { 1 });
		byte[] array2 = (byte[])property.GetValue(value, null);
		byte[] array3 = new byte[array2.Length - 1];
		Array.Copy(array2, 1, array3, 0, array2.Length - 1);
		obj = constructor.Invoke(new object[1] { array3 });
		object value2 = property2.GetValue(obj, new object[1] { 0 });
		object value3 = property2.GetValue(obj, new object[1] { 1 });
		modulus = (byte[])property.GetValue(value2, null);
		exponent = (byte[])property.GetValue(value3, null);
	}
}
