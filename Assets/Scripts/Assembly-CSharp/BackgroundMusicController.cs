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

	public void Update()
	{
		if (Input.GetKeyDown(KeyCode.F1) && Player_move_c.canlock)
		{
			Player_move_c.canlock = false;
			Input.ResetInputAxes();
			Cursor.lockState = CursorLockMode.None;
			Cursor.visible = true;
		}
		if (Input.GetKeyDown(KeyCode.F1) && !Player_move_c.canlock) {
			Player_move_c.canlock = true;
			Input.ResetInputAxes();
			Cursor.lockState = CursorLockMode.None;
			Cursor.visible = true;
		}
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
