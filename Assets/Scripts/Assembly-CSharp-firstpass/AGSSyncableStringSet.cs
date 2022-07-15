using System;
using System.Collections.Generic;
using UnityEngine;

public class AGSSyncableStringSet : AGSSyncable
{
	public AGSSyncableStringSet(AmazonJavaWrapper javaObject)
		: base(javaObject)
	{
	}

	public AGSSyncableStringSet(AndroidJavaObject javaObject)
		: base(javaObject)
	{
	}

	public void Add(string val)
	{
		javaObject.Call("add", val);
	}

	public void Add(string val, Dictionary<string, string> metadata)
	{
		javaObject.Call("add", val, DictionaryToAndroidHashMap(metadata));
	}

	public AGSSyncableStringElement Get(string val)
	{
		return GetAGSSyncable<AGSSyncableStringElement>(SyncableMethod.getStringSet, val);
	}

	public bool Contains(string val)
	{
		return javaObject.Call<bool>("contains", new object[1] { val });
	}

	public bool IsSet()
	{
		return javaObject.Call<bool>("isSet", new object[0]);
	}

	public HashSet<AGSSyncableStringElement> GetValues()
	{
		return new HashSet<AGSSyncableStringElement>();
	}
}
