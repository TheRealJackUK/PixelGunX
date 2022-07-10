using System;
using UnityEngine;

public class WebViewObject : MonoBehaviour
{
	private Action<string> callback;

	private AndroidJavaObject webView;

	private Vector2 offset;

	public void Init(Action<string> cb = null)
	{
		callback = cb;
		offset = new Vector2(0f, 0f);
		webView = new AndroidJavaObject("net.gree.unitywebview.WebViewPlugin");
		webView.Call("Init", base.name);
	}

	private void OnDestroy()
	{
		if (webView != null)
		{
			webView.Call("Destroy");
		}
	}

	public void SetMargins(int left, int top, int right, int bottom)
	{
		if (webView != null)
		{
			offset = new Vector2(left, top);
			webView.Call("SetMargins", left, top, right, bottom);
		}
	}

	public void SetVisibility(bool v)
	{
		if (webView != null)
		{
			webView.Call("SetVisibility", v);
		}
	}

	public void LoadURL(string url)
	{
		if (webView != null)
		{
			webView.Call("LoadURL", url);
		}
	}

	public void EvaluateJS(string js)
	{
		if (webView != null)
		{
			webView.Call("LoadURL", "javascript:" + js);
		}
	}

	public void CallFromJS(string message)
	{
		if (callback != null)
		{
			callback(message);
		}
	}

	public void goHome()
	{
	}
}
