using System;
using System.Collections.Generic;
using UnityEngine;

public class AGSSyncableNumberList : AGSSyncableList
{
	public AGSSyncableNumberList(AmazonJavaWrapper javaObject)
		: base(javaObject)
	{
	}

	public AGSSyncableNumberList(AndroidJavaObject javaObject)
		: base(javaObject)
	{
	}

	public void Add(long val)
	{
		javaObject.Call("add", val);
	}

	public void Add(double val)
	{
		javaObject.Call("add", val);
	}

	public void Add(int val)
	{
		javaObject.Call("add", val);
	}

	public void Add(long val, Dictionary<string, string> metadata)
	{
		javaObject.Call("add", val, DictionaryToAndroidHashMap(metadata));
	}

	public void Add(double val, Dictionary<string, string> metadata)
	{
		javaObject.Call("add", val, DictionaryToAndroidHashMap(metadata));
	}

	public void Add(int val, Dictionary<string, string> metadata)
	{
		javaObject.Call("add", val, DictionaryToAndroidHashMap(metadata));
	}

	public AGSSyncableNumberElement[] GetValues()
	{
		return new AGSSyncableNumberElement[]{};
	}
}
