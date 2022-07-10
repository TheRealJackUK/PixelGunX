using System;
using System.Diagnostics;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class StopwatchLogger : IDisposable
	{
		private readonly Stopwatch _stopwatch;

		private readonly string _text;

		private readonly bool _verbose;

		public StopwatchLogger(string text, bool verbose)
		{
			_verbose = verbose;
			_text = text ?? string.Empty;
			if (_verbose)
			{
				UnityEngine.Debug.Log(string.Format("{0}: started.", _text));
			}
			_stopwatch = Stopwatch.StartNew();
		}

		public StopwatchLogger(string text)
			: this(text, true)
		{
		}

		public void Dispose()
		{
			_stopwatch.Stop();
			if (_verbose)
			{
				UnityEngine.Debug.Log(string.Format("{0}: finished at {1:0.00}", _text, _stopwatch.ElapsedMilliseconds));
			}
		}
	}
}
