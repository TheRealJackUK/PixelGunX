using System;
using UnityEngine;

public class DevToDevCustomEventParams : IDisposable
{
	private readonly AndroidJavaObject eventParams;

	public AndroidJavaObject JavaEventParams
	{
		get
		{
			return eventParams;
		}
	}

	public DevToDevCustomEventParams()
	{
		eventParams = new AndroidJavaObject("com.devtodev.core.data.metrics.aggregated.events.CustomEventParams");
	}

	public void Put(string key, string value)
	{
		eventParams.Call("putString", key, value);
	}

	public void Put(string key, int value)
	{
		eventParams.Call("putInteger", key, value);
	}

	public void Put(string key, float value)
	{
		eventParams.Call("putFloat", key, value);
	}

	public void Put(string key, double value)
	{
		eventParams.Call("putDouble", key, value);
	}

	public void Put(string key, long value)
	{
		eventParams.Call("putLong", key, value);
	}

	public void Put(string key, DateTime value)
	{
		DateTime dateTime = new DateTime(1970, 1, 1);
		long num = (value.Ticks - dateTime.Ticks) / 10000000;
		using (AndroidJavaObject androidJavaObject = new AndroidJavaObject("java.util.Date", num))
		{
			eventParams.Call("putDate", key, androidJavaObject);
		}
	}

	public void Dispose()
	{
		eventParams.Dispose();
	}
}
