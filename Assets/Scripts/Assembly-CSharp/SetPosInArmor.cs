using UnityEngine;

public class SetPosInArmor : MonoBehaviour
{
	public Transform target;

	private Transform myTransform;

	public void SetPosition()
	{
		if (target != null)
		{
			base.transform.position = target.position;
			base.transform.rotation = target.rotation;
		}
	}

	private void Start()
	{
		myTransform = base.transform;
	}

	private void Update()
	{
		if (target != null)
		{
			SetPosition();
		}
		else if (myTransform.root.GetComponent<SkinName>() != null && myTransform.root.GetComponent<SkinName>().playerMoveC.transform.childCount > 0 && myTransform.root.GetComponent<SkinName>().playerMoveC.transform.GetChild(0).GetComponent<WeaponSounds>() != null)
		{
			if (base.gameObject.name.Equals("Armor_Arm_Left"))
			{
				target = myTransform.root.GetComponent<SkinName>().playerMoveC.transform.GetChild(0).GetComponent<WeaponSounds>().LeftArmorHand;
			}
			else
			{
				target = myTransform.root.GetComponent<SkinName>().playerMoveC.transform.GetChild(0).GetComponent<WeaponSounds>().RightArmorHand;
			}
		}
	}
}
