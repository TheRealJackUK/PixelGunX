using System;
using UnityEngine;

internal sealed class AdButtonScript : MonoBehaviour
{
	public UIButton Button;

	public void HandleClick()
	{
	}

	private void Start()
	{
		if (Button != null)
		{
			Button.isEnabled = false;
		}
		base.gameObject.SetActive(false);
	}

	private void Update()
	{
	}

	private void OnEnable()
	{
		Debug.Log("Trying to load interstitial...");
	}

	private void OnDisable()
	{
		if (Button != null)
		{
			Button.isEnabled = false;
		}
	}

	private void HandleInterstitialLoaded(object sender, EventArgs e)
	{
		Debug.Log("InterstitialLoaded event received.");
		if (Button != null)
		{
			Button.isEnabled = true;
		}
	}

	private static void HandleAdFailedToLoad(object sender, EventArgs e)
	{
		Debug.LogWarning("AdFailedToLoad event received.");
	}

	private void HandleAdOpened(object sender, EventArgs e)
	{
		Debug.LogWarning("AdOpened event received.");
		if (!(Button != null))
		{
		}
	}
}
