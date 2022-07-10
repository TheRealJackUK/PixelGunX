using UnityEngine;

public sealed class AddLabel : MonoBehaviour
{
	private bool isBigPorog;

	private bool isBigPorogOld;

	private void Start()
	{
		if (Defs.isCompany || Defs.isCOOP)
		{
			base.gameObject.SetActive(false);
		}
	}
}
