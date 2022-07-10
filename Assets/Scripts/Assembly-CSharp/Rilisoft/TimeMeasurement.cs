using System;
using System.Diagnostics;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class TimeMeasurement
	{
		private readonly string _context;

		private readonly int _startFrame;

		private readonly float _startTime;

		private int _frameCount;

		private float _timeBrutto;

		private readonly Stopwatch _timeNetto;

		public string Context
		{
			get
			{
				return _context;
			}
		}

		public int FrameCount
		{
			get
			{
				return _frameCount;
			}
		}

		public float TimeBrutto
		{
			get
			{
				return _timeBrutto;
			}
		}

		public TimeSpan TimeNetto
		{
			get
			{
				return _timeNetto.Elapsed;
			}
		}

		public TimeMeasurement(string context)
		{
			if (context == null)
			{
				throw new ArgumentNullException("context");
			}
			_context = context;
			_startFrame = Time.frameCount;
			_startTime = Time.realtimeSinceStartup;
			_timeNetto = new Stopwatch();
		}

		public void Start()
		{
			_timeNetto.Start();
		}

		public void Stop()
		{
			_timeNetto.Stop();
			_frameCount = Time.frameCount - _startFrame;
			_timeBrutto = Time.realtimeSinceStartup - _startTime;
		}
	}
}
