using System;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class ProgressBounds
	{
		private float _lowerBound;

		private float _upperBound = 1f;

		public float LowerBound
		{
			get
			{
				return _lowerBound;
			}
		}

		public float UpperBound
		{
			get
			{
				return _upperBound;
			}
		}

		public float Clamp(float progress)
		{
			return Mathf.Clamp(progress, _lowerBound, _upperBound);
		}

		public float Lerp(float progress, float time)
		{
			return Mathf.Lerp(Clamp(progress), UpperBound, time);
		}

		public void SetBounds(float lowerBound, float upperBound)
		{
			lowerBound = Mathf.Clamp01(lowerBound);
			upperBound = Mathf.Clamp01(upperBound);
			if (lowerBound > upperBound)
			{
				throw new ArgumentException("Bounds are not ordered.");
			}
			_lowerBound = lowerBound;
			_upperBound = upperBound;
		}
	}
}
