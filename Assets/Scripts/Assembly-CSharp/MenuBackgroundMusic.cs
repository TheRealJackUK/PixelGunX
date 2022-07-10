using System;
using System.Collections;
using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

internal sealed class MenuBackgroundMusic : MonoBehaviour
{
	private List<AudioSource> _customMusicStack = new List<AudioSource>();

	private AudioSource currentAudioSource;

	public static bool keepPlaying = false;

	public static MenuBackgroundMusic sharedMusic;

	public static string[] scenetsToPlayMusicOn = new string[9]
	{
		Defs.MainMenuScene,
		"ConnectScene",
		"SettingScene",
		"SkinEditor",
		"ChooseLevel",
		"CampaignChooseBox",
		"ProfileShop",
		"Friends",
		"Clans"
	};

	private bool subscribedOnFreeAwardStateChange;

	public void PlayCustomMusicFrom(GameObject audioSourceObj)
	{
		RemoveNullsFromCustomMusicStack();
		if (audioSourceObj != null && audioSourceObj != null && Defs.isSoundMusic)
		{
			PlayMusic(audioSourceObj.GetComponent<AudioSource>());
			if (!_customMusicStack.Contains(audioSourceObj.GetComponent<AudioSource>()))
			{
				if (_customMusicStack.Count > 0)
				{
					StopMusic(_customMusicStack[_customMusicStack.Count - 1]);
				}
				_customMusicStack.Add(audioSourceObj.GetComponent<AudioSource>());
			}
		}
		if (Array.IndexOf(scenetsToPlayMusicOn, Application.loadedLevelName) >= 0)
		{
			Stop();
			return;
		}
		GameObject gameObject = GameObject.FindGameObjectWithTag("BackgroundMusic");
		if (gameObject != null)
		{
			AudioSource component = gameObject.GetComponent<AudioSource>();
			if (component != null)
			{
				StopMusic(component);
			}
		}
	}

	public void StopCustomMusicFrom(GameObject audioSourceObj)
	{
		RemoveNullsFromCustomMusicStack();
		if (audioSourceObj != null && audioSourceObj.GetComponent<AudioSource>() != null)
		{
			StopMusic(audioSourceObj.GetComponent<AudioSource>());
			if (_customMusicStack.Contains(audioSourceObj.GetComponent<AudioSource>()))
			{
				_customMusicStack.Remove(audioSourceObj.GetComponent<AudioSource>());
			}
		}
		if (_customMusicStack.Count > 0)
		{
			PlayMusic(_customMusicStack[_customMusicStack.Count - 1]);
			return;
		}
		if (Array.IndexOf(scenetsToPlayMusicOn, Application.loadedLevelName) >= 0)
		{
			Play();
			return;
		}
		GameObject gameObject = GameObject.FindGameObjectWithTag("BackgroundMusic");
		if (gameObject != null)
		{
			AudioSource component = gameObject.GetComponent<AudioSource>();
			if (component != null)
			{
				PlayMusic(component);
			}
		}
	}

	private void Start()
	{
		sharedMusic = this;
		Defs.isSoundMusic = PlayerPrefsX.GetBool(PlayerPrefsX.SoundMusicSetting, true);
		Defs.isSoundFX = PlayerPrefsX.GetBool(PlayerPrefsX.SoundFXSetting, true);
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
	}

	public void Play()
	{
		if (Defs.isSoundMusic)
		{
			PlayMusic(base.GetComponent<AudioSource>());
		}
	}

	public void Stop()
	{
		StopMusic(base.GetComponent<AudioSource>());
	}

	private void RemoveNullsFromCustomMusicStack()
	{
		List<AudioSource> customMusicStack = _customMusicStack;
		_customMusicStack = new List<AudioSource>();
		foreach (AudioSource item in customMusicStack)
		{
			if (item != null)
			{
				_customMusicStack.Add(item);
			}
		}
	}

	private void OnLevelWasLoaded(int idx)
	{
		if (BuildSettings.BuildTarget == BuildTarget.iPhone && !subscribedOnFreeAwardStateChange && FreeAwardController.Instance != null)
		{
			subscribedOnFreeAwardStateChange = true;
			FreeAwardController.Instance.StateChanged += HandleFreeAwardControllerStateChanged;
		}
		StopAllCoroutines();
		foreach (AudioSource item in _customMusicStack)
		{
			item.Stop();
		}
		_customMusicStack.Clear();
		if (Array.IndexOf(scenetsToPlayMusicOn, Application.loadedLevelName) >= 0 || keepPlaying)
		{
			if (!base.GetComponent<AudioSource>().isPlaying && PlayerPrefsX.GetBool(PlayerPrefsX.SoundMusicSetting, true))
			{
				PlayMusic(base.GetComponent<AudioSource>());
			}
		}
		else
		{
			StopMusic(base.GetComponent<AudioSource>());
		}
		keepPlaying = false;
	}

	private void HandleFreeAwardControllerStateChanged(object sender, FreeAwardController.StateEventArgs e)
	{
		if (e.State is FreeAwardController.WatchingState)
		{
			PauseCurrentMusic();
		}
		else if (e.OldState is FreeAwardController.WatchingState)
		{
			PlayCurrentMusic();
		}
	}

	public void PlayMusic(AudioSource audioSource)
	{
		if (!(audioSource == null) && Defs.isSoundMusic)
		{
			audioSource.Play();
		}
	}

	public void StopMusic(AudioSource audioSource)
	{
		if (!(audioSource == null))
		{
			audioSource.Stop();
		}
	}

	private IEnumerator PlayMusicInternal(AudioSource audioSource)
	{
		float targetVolume = 1f;
		audioSource.volume = 1f;
		audioSource.Play();
		currentAudioSource = audioSource;
		float startTime = Time.realtimeSinceStartup;
		float fadeTime = 0.5f;
		while (Time.realtimeSinceStartup - startTime <= fadeTime)
		{
			if (audioSource == null)
			{
				audioSource.volume = 1f;
				yield break;
			}
			audioSource.volume = targetVolume * (Time.realtimeSinceStartup - startTime) / fadeTime;
			Debug.Log("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ PlayMusicInternal " + audioSource.volume);
			yield return null;
		}
		audioSource.volume = 1f;
		Debug.Log("----------------------------------------------------------------- PlayMusicInternal " + audioSource.volume);
	}

	private IEnumerator StopMusicInternal(AudioSource audioSource)
	{
		float currentVolume = 1f;
		float startTime = Time.realtimeSinceStartup;
		float fadeTime = 0.5f;
		while (Time.realtimeSinceStartup - startTime <= fadeTime)
		{
			if (audioSource == null)
			{
				yield break;
			}
			audioSource.volume = currentVolume * (1f - (Time.realtimeSinceStartup - startTime) / fadeTime);
			Debug.Log("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ StopMusicInternal " + audioSource.volume);
			yield return null;
		}
		audioSource.volume = 0f;
		audioSource.Stop();
		currentAudioSource = null;
		audioSource.volume = 1f;
		Debug.Log("----------------------------------------------------------------- StopMusicInternal " + audioSource.volume);
	}

	private void PlayCurrentMusic()
	{
		if (currentAudioSource != null)
		{
			PlayMusic(currentAudioSource);
		}
	}

	private void PauseCurrentMusic()
	{
		if (currentAudioSource != null)
		{
			currentAudioSource.Pause();
		}
	}

	private void OnApplicationPause(bool pausing)
	{
		if (!pausing)
		{
			PlayCurrentMusic();
		}
		else
		{
			PauseCurrentMusic();
		}
	}
}
