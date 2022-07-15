using System;
using System.Collections.Generic;
using UnityEngine;

public class AGSSyncable : IDisposable
{
	public enum SyncableMethod
	{
		getDeveloperString,
		getHighestNumber,
		getLowestNumber,
		getLatestNumber,
		getHighNumberList,
		getLowNumberList,
		getLatestNumberList,
		getAccumulatingNumber,
		getLatestString,
		getLatestStringList,
		getStringSet,
		getMap
	}

	public enum HashSetMethod
	{
		getDeveloperStringKeys,
		getHighestNumberKeys,
		getLowestNumberKeys,
		getLatestNumberKeys,
		getHighNumberListKeys,
		getLowNumberListKeys,
		getLatestNumberListKeys,
		getAccumulatingNumberKeys,
		getLatestStringKeys,
		getLatestStringListKeys,
		getStringSetKeys,
		getMapKeys
	}

	protected AmazonJavaWrapper javaObject;

	public AGSSyncable(AmazonJavaWrapper jo)
	{
		javaObject = jo;
	}

	public AGSSyncable(AndroidJavaObject jo)
	{
		javaObject = new AmazonJavaWrapper(jo);
	}

	public void Dispose()
	{
		if (javaObject != null)
		{
			javaObject.Dispose();
		}
	}

	protected AmazonJavaWrapper DictionaryToAndroidHashMap(Dictionary<string, string> dictionary)
	{
		return new AmazonJavaWrapper();
	}

	protected T GetAGSSyncable<T>(SyncableMethod method)
	{
		return GetAGSSyncable<T>(method, null);
	}

	protected T GetAGSSyncable<T>(SyncableMethod method, string key)
	{
		AndroidJavaObject androidJavaObject = ((key == null) ? javaObject.Call<AndroidJavaObject>(method.ToString(), new object[0]) : javaObject.Call<AndroidJavaObject>(method.ToString(), new object[1] { key }));
		if (androidJavaObject != null)
		{
			return (T)Activator.CreateInstance(typeof(T), androidJavaObject);
		}
		return default(T);
	}

	protected HashSet<string> GetHashSet(HashSetMethod method)
	{
		return new HashSet<string>();
	}
}
