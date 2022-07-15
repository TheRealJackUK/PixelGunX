using System;
using System.Collections.Generic;
using UnityEngine;

public class AGSSyncableElement : AGSSyncable
{
	public AGSSyncableElement(AmazonJavaWrapper javaObject)
		: base(javaObject)
	{
	}

	public AGSSyncableElement(AndroidJavaObject javaObject)
		: base(javaObject)
	{
	}

	public long GetTimestamp()
	{
		return javaObject.Call<long>("getTimestamp", new object[0]);
	}

	public Dictionary<string, string> GetMetadata()
	{
		return new Dictionary<string, string>();
	}
}
