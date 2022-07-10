using UnityEngine;

public class visibleObjPhoton : MonoBehaviour
{
	public ThirdPersonNetwork1 lerpScript;

	public bool isVisible;

	private void Awake()
	{
		if (!Defs.isMulti || !Defs.isInet)
		{
			base.enabled = false;
		}
	}

	private void Start()
	{
	}

	private void OnBecameVisible()
	{
		isVisible = true;
		if (lerpScript != null)
		{
			lerpScript.sglajEnabled = true;
		}
	}

	private void OnBecameInvisible()
	{
		isVisible = false;
		if (lerpScript != null)
		{
			lerpScript.sglajEnabled = false;
		}
	}
}
