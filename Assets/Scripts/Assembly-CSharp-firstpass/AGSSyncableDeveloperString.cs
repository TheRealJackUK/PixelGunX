using UnityEngine;

public class AGSSyncableDeveloperString : AGSSyncable
{
	public AGSSyncableDeveloperString(AmazonJavaWrapper javaObject)
		: base(javaObject)
	{
	}

	public AGSSyncableDeveloperString(AndroidJavaObject javaObject)
		: base(javaObject)
	{
	}

	public string getCloudValue()
	{
		return javaObject.Call<string>("getCloudValue", new object[0]);
	}

	public string getValue()
	{
		return javaObject.Call<string>("getValue", new object[0]);
	}

	public bool inConflict()
	{
		return javaObject.Call<bool>("inConflict", new object[0]);
	}

	public bool isSet()
	{
		return javaObject.Call<bool>("isSet", new object[0]);
	}

	public void markAsResolved()
	{
		javaObject.Call("markAsResolved");
	}

	public void setValue(string val)
	{
		javaObject.Call("setValue", val);
	}
}
