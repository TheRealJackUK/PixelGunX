using UnityEngine;

public class FreezerRay : MonoBehaviour
{
	private Player_move_c mc;

	public float lifetime = 0.1f;

	public float timeLeft;

	public float Length
	{
		set
		{
			base.transform.GetChild(0).GetComponent<LineRenderer>().SetPosition(1, new Vector3(0f, 0f, value));
		}
	}

	private void Start()
	{
		timeLeft += lifetime;
	}

	private void Update()
	{
		timeLeft -= Time.deltaTime;
		if (timeLeft <= 0f)
		{
			Object.Destroy(base.gameObject);
			return;
		}
		Transform transform = null;
		if (mc != null && mc.transform.childCount > 0)
		{
			Transform child = mc.transform.GetChild(0);
			FlashFire component = child.GetComponent<FlashFire>();
			if (component != null && component.gunFlashObj != null)
			{
				transform = component.gunFlashObj.transform;
			}
		}
		if (mc != null && transform != null && transform.parent != null && transform.parent.parent != null)
		{
			base.transform.position = transform.parent.position;
			base.transform.forward = transform.parent.parent.forward;
		}
	}

	public void SetParentMoveC(Player_move_c move_c)
	{
		mc = move_c;
		if (mc != null)
		{
			mc.FreezerFired += HandleFreezerFired;
		}
	}

	private void HandleFreezerFired(float length)
	{
		timeLeft += lifetime;
		Length = length;
	}

	private void OnDestroy()
	{
		if (mc != null)
		{
			mc.FreezerFired -= HandleFreezerFired;
		}
	}
}
