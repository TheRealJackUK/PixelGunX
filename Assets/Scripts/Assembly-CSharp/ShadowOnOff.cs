using UnityEngine;

public class ShadowOnOff : MonoBehaviour
{
	private void Start()
	{
		if (Device.isWeakDevice)
		{
			base.gameObject.SetActive(false);
		}
	}
}
