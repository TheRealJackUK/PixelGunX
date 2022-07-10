using UnityEngine;

public class LightFXOnOff : MonoBehaviour
{
	private void Start()
	{
		if (Device.isWeakDevice || Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.WP8Player)
		{
			base.gameObject.SetActive(false);
		}
	}
}
