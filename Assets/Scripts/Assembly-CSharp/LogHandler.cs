using System.Collections;
using Rilisoft;
using UnityEngine;

internal sealed class LogHandler : MonoBehaviour
{
	private bool _cancelled;

	private bool _registered;

	private string _logString = string.Empty;

	private string _stackTrace = string.Empty;

	private void Start()
	{
		if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
		{
			Object.DontDestroyOnLoad(base.gameObject);
		}
		else
		{
			Object.Destroy(base.gameObject);
		}
	}

	private void OnEnable()
	{
		StartCoroutine(RegisterLogCallbackCoroutine());
	}

	private void OnDisable()
	{
		_cancelled = true;
		if (_registered)
		{
			Application.RegisterLogCallback(null);
		}
	}

	private IEnumerator RegisterLogCallbackCoroutine()
	{
		yield return new WaitForSeconds(0.5f);
		if (!_cancelled)
		{
			Application.RegisterLogCallback(HandleLog);
			_registered = true;
		}
	}

	private void HandleLog(string logString, string stackTrace, LogType type)
	{
		if (type == LogType.Exception)
		{
			_logString = logString;
			_stackTrace = stackTrace;
		}
	}
}
