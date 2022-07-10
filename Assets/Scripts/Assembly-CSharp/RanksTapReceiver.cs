using System;
using UnityEngine;

public class RanksTapReceiver : MonoBehaviour
{
	public static event Action RanksClicked;

	private void Start()
	{
		base.gameObject.SetActive(Defs.isMulti);
	}

	private void OnClick()
	{
		if (RanksTapReceiver.RanksClicked != null)
		{
			RanksTapReceiver.RanksClicked();
		}
	}
}
