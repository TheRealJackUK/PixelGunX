using UnityEngine;

public class ShadowOnOff : MonoBehaviour
{
	private void Start()
	{
		if (Device.isWeakDevice || Application.platform == RuntimePlatform.Android)
		{
			base.gameObject.SetActive(false);
		}
	}
}
