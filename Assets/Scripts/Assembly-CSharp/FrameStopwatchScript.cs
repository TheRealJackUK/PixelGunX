using System.Diagnostics;
using UnityEngine;

internal sealed class FrameStopwatchScript : MonoBehaviour
{
	private readonly Stopwatch _stopwatch = new Stopwatch();

	public float GetSecondsSinceFrameStarted()
	{
		return (float)_stopwatch.ElapsedMilliseconds / 1000f;
	}

	internal void Start()
	{
		_stopwatch.Start();
	}

	internal void Update()
	{
		_stopwatch.Reset();
		_stopwatch.Start();
	}
}
