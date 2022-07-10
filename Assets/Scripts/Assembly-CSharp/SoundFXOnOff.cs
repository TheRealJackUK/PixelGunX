using Rilisoft;
using UnityEngine;

public class SoundFXOnOff : MonoBehaviour
{
	private GameObject soundFX;

	private bool _isWeakdevice;

	private void Start()
	{
		if (BuildSettings.BuildTarget == BuildTarget.iPhone)
		{
			_isWeakdevice = Device.isWeakDevice;
		}
		else if (BuildSettings.BuildTarget == BuildTarget.Android || BuildSettings.BuildTarget == BuildTarget.WP8Player)
		{
			_isWeakdevice = true;
		}
		else
		{
			_isWeakdevice = Device.IsLoweMemoryDevice;
		}
		soundFX = base.transform.GetChild(0).gameObject;
		soundFX.SetActive(!_isWeakdevice && Defs.isSoundFX);
	}

	private void FixedUpdate()
	{
		if (!_isWeakdevice && soundFX.activeSelf != Defs.isSoundFX)
		{
			soundFX.SetActive(Defs.isSoundFX);
		}
	}
}
