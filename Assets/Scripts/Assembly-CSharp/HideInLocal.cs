using UnityEngine;

public class HideInLocal : MonoBehaviour
{
	private void Start()
	{
		if (!Defs.isInet)
		{
			base.gameObject.SetActive(false);
		}
	}
}
