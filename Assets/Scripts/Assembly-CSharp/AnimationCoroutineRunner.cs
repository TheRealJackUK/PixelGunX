using System;
using System.Collections;
using UnityEngine;

public class AnimationCoroutineRunner : MonoBehaviour
{
	public void StartPlay(Animation animation, string clipName, bool useTimeScale, Action onComplete)
	{
		StartCoroutine(Play(animation, clipName, useTimeScale, onComplete));
	}

	public IEnumerator Play(Animation animation, string clipName, bool useTimeScale, Action onComplete)
	{
		Debug.Log("Overwritten Play animation, useTimeScale? " + useTimeScale);
		if (!useTimeScale)
		{
			Debug.Log("Started this animation! ( " + clipName + " ) ");
			AnimationState _currState = animation[clipName];
			bool isPlaying = true;
			float _progressTime = 0f;
			float _timeAtLastFrame2 = 0f;
			float _timeAtCurrentFrame2 = 0f;
			float deltaTime2 = 0f;
			animation.Play(clipName);
			_timeAtLastFrame2 = Time.realtimeSinceStartup;
			while (isPlaying)
			{
				_timeAtCurrentFrame2 = Time.realtimeSinceStartup;
				deltaTime2 = _timeAtCurrentFrame2 - _timeAtLastFrame2;
				_timeAtLastFrame2 = _timeAtCurrentFrame2;
				_progressTime += deltaTime2;
				_currState.normalizedTime = _progressTime / _currState.length;
				animation.Sample();
				if (_progressTime >= _currState.length)
				{
					if (_currState.wrapMode != WrapMode.Loop)
					{
						isPlaying = false;
					}
					else
					{
						_progressTime = 0f;
					}
				}
				yield return new WaitForEndOfFrame();
			}
			yield return null;
			if (onComplete != null)
			{
				Debug.Log("Start onComplete");
				onComplete();
			}
		}
		else
		{
			animation.Play(clipName);
		}
	}
}
