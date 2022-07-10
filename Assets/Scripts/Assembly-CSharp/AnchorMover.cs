using UnityEngine;

public class AnchorMover : MonoBehaviour
{
	public Transform flag1;

	public Transform flag2;

	public Transform ammo;

	public Transform health;

	private void SetSide()
	{
		SetSideCoroutine();
	}

	private void SetSideCoroutine()
	{
		flag1.localPosition = new Vector3((float)((!GlobalGameController.LeftHanded) ? 1 : (-1)) * ((float)Screen.width * 768f / (float)Screen.height / 2f - 30f), flag1.localPosition.y, flag1.localPosition.z);
		flag2.localPosition = new Vector3((float)((!GlobalGameController.LeftHanded) ? 1 : (-1)) * ((float)Screen.width * 768f / (float)Screen.height / 2f - 30f), flag2.localPosition.y, flag2.localPosition.z);
		health.localPosition = new Vector3(health.localPosition.x, (!GlobalGameController.LeftHanded) ? 214f : 140f, health.localPosition.z);
		ammo.localPosition = new Vector3(ammo.localPosition.x, (!GlobalGameController.LeftHanded) ? 282f : 208f, ammo.localPosition.z);
	}

	private void Start()
	{
		SetSide();
		PauseNGUIController.PlayerHandUpdated += SetSide;
	}

	private void OnDestroy()
	{
		PauseNGUIController.PlayerHandUpdated -= SetSide;
	}

	private void OnEnable()
	{
		SetSideCoroutine();
	}
}
