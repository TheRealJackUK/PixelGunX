using UnityEngine;

public class WebViewStarter
{
	public static WebViewObject StartBrowser(string Url)
	{
		WebViewObject webViewObject = new GameObject("WebViewObject").AddComponent<WebViewObject>();
		webViewObject.Init(delegate(string msg)
		{
			Debug.Log(string.Format("CallFromJS[{0}]", msg));
		});
		webViewObject.LoadURL(Url);
		webViewObject.SetVisibility(true);
		RuntimePlatform platform = Application.platform;
		if (platform == RuntimePlatform.OSXEditor || platform == RuntimePlatform.OSXPlayer || platform == RuntimePlatform.IPhonePlayer)
		{
			webViewObject.EvaluateJS("window.addEventListener('load', function() {\twindow.Unity = {\t\tcall:function(msg) {\t\t\tvar iframe = document.createElement('IFRAME');\t\t\tiframe.setAttribute('src', 'unity:' + msg);\t\t\tdocument.documentElement.appendChild(iframe);\t\t\tiframe.parentNode.removeChild(iframe);\t\t\tiframe = null;\t\t}\t}}, false);");
		}
		webViewObject.EvaluateJS("window.addEventListener('load', function() {\twindow.addEventListener('click', function() {\t\tUnity.call('clicked');\t}, false);}, false);");
		return webViewObject;
	}
}
