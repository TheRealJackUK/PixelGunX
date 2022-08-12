using UnityEngine;

public class SwordTrail : MonoBehaviour
{
	[SerializeField]
	private AnimationClip animationClip_0;

	private AnimationState animationState_0;

	[SerializeField]
	private int int_0;

	[SerializeField]
	private int int_1;

	private float float_0;

	private float float_1;

	private float float_2;

	private float float_3;

	private float float_4;

	[SerializeField]
	private MeleeWeaponTrail meleeWeaponTrail_0;

	private bool bool_0 = true;

	private void Start()
	{
		float num = animationClip_0.frameRate * animationClip_0.length;
		float_0 = (float)int_0 / num;
		float_1 = (float)int_1 / num;
		animationState_0 = base.GetComponent<Animation>()[animationClip_0.name];
		meleeWeaponTrail_0.Boolean_0 = false;
	}

	private void Update()
	{
		float_2 += animationState_0.normalizedTime - float_4;
		if (float_2 > 1f || bool_0)
		{
			if (!bool_0)
			{
				float_2 -= 1f;
			}
			bool_0 = false;
		}
		if (float_3 < float_0 && float_2 >= float_0)
		{
			meleeWeaponTrail_0.Boolean_0 = true;
		}
		else if (float_3 < float_1 && float_2 >= float_1)
		{
			meleeWeaponTrail_0.Boolean_0 = false;
		}
		float_3 = float_2;
		float_4 = animationState_0.normalizedTime;
	}
}
