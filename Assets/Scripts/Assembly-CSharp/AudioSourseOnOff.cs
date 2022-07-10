using UnityEngine;

public class AudioSourseOnOff : MonoBehaviour
{
	private AudioSource myAudioSourse;

	private void Start()
	{
		myAudioSourse = GetComponent<AudioSource>();
		if (myAudioSourse != null)
		{
			myAudioSourse.enabled = Defs.isSoundFX;
		}
	}

	private void OnEnable()
	{
		if (myAudioSourse != null && myAudioSourse.enabled != Defs.isSoundFX)
		{
			myAudioSourse.enabled = Defs.isSoundFX;
		}
	}
}
