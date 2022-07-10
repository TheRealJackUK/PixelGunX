using UnityEngine;

public sealed class ButtonClickSound : MonoBehaviour
{
	public static ButtonClickSound Instance;

	public AudioClip Click;

	private void Start()
	{
		Instance = this;
		Object.DontDestroyOnLoad(base.gameObject);
	}

	public void PlayClick()
	{
		if (Click != null && Defs.isSoundFX)
		{
			NGUITools.PlaySound(Click);
		}
	}
}
