using UnityEngine;

public class DamageTakesRotator : MonoBehaviour
{
	private Transform thisTransform;

	public InGameGUI inGameGUI;

	private GameObject myPlayer;

	private void Start()
	{
		thisTransform = base.transform;
	}

	private void Update()
	{
		if (myPlayer == null)
		{
			if (Defs.isMulti)
			{
				myPlayer = WeaponManager.sharedManager.myPlayer;
			}
			else
			{
				myPlayer = GameObject.FindGameObjectWithTag("Player");
			}
		}
		if (!(myPlayer == null))
		{
			thisTransform.localRotation = Quaternion.Euler(new Vector3(0f, 0f, myPlayer.transform.localRotation.eulerAngles.y));
		}
	}
}
