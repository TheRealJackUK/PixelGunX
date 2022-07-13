using UnityEngine;

internal sealed class BackgroundMusicController : MonoBehaviour
{
	bool isPlaying = true;
	private void Start()
	{
		MenuBackgroundMusic.sharedMusic.PlayMusic(base.GetComponent<AudioSource>());
		base.GetComponent<AudioSource>().spatialBlend = 0;
		isPlaying = true;
	}

	public void Play()
	{
		MenuBackgroundMusic.sharedMusic.PlayMusic(base.GetComponent<AudioSource>());
		base.GetComponent<AudioSource>().spatialBlend = 0;
		isPlaying = true;
	}

	public void Stop()
	{
		MenuBackgroundMusic.sharedMusic.StopMusic(base.GetComponent<AudioSource>());
		isPlaying = false;
	}
}
