using UnityEngine;

public sealed class HideSaleLabelInShop : MonoBehaviour
{
	public GameObject needTier;

	private void Update()
	{
		if (needTier.activeSelf)
		{
			base.gameObject.SetActive(false);
		}
	}
}
