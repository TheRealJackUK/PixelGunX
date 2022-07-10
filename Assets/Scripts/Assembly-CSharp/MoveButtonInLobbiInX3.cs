using UnityEngine;

public class MoveButtonInLobbiInX3 : MonoBehaviour
{
	public float yX3;

	private Transform myTransform;

	private float yNotX3;

	private bool oldStateX3;

	private void Start()
	{
		myTransform = base.transform;
		yNotX3 = myTransform.localPosition.y;
		Move();
	}

	private void Move()
	{
		if (oldStateX3 != PromoActionsManager.sharedManager.IsEventX3Active)
		{
			oldStateX3 = PromoActionsManager.sharedManager.IsEventX3Active;
			myTransform.localPosition = new Vector3(myTransform.localPosition.x, (!oldStateX3) ? yNotX3 : yX3, myTransform.localPosition.z);
		}
	}

	private void Update()
	{
		Move();
	}
}
