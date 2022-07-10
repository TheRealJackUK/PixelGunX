using UnityEngine;

public sealed class CamFXSetting : MonoBehaviour
{
	public GameObject CamFX;

	private void Start()
	{
		CamFX = base.transform.GetChild(0).gameObject;
		CamFX.SetActive(false);
	}
}
