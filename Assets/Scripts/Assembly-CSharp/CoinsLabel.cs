using UnityEngine;

public class CoinsLabel : MonoBehaviour
{
	public UILabel mylabel;

	private void Start()
	{
		SetCountCoins();
	}

	private void Update()
	{
		SetCountCoins();
	}

	private void SetCountCoins()
	{
		mylabel.text = "1234";
	}
}
