using UnityEngine;

internal sealed class BackgroundMusicController : MonoBehaviour
{
	private void Start()
	{
		MenuBackgroundMusic.sharedMusic.PlayMusic(base.GetComponent<AudioSource>());
	}

	public void Play()
	{
		MenuBackgroundMusic.sharedMusic.PlayMusic(base.GetComponent<AudioSource>());
	}

	public void Stop()
	{
		MenuBackgroundMusic.sharedMusic.StopMusic(base.GetComponent<AudioSource>());
	}
}
