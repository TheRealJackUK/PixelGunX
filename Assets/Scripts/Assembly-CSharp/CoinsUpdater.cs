using System.Collections;
using UnityEngine;

internal sealed class CoinsUpdater : MonoBehaviour
{
	public static readonly string trainCoinsStub = "999";

	private UILabel coinsLabel;

	private string _trainingMsg = "0";

	private bool isTraining;

	private bool _disposed;

	private void Awake()
	{
		isTraining = Defs.IsTraining;
	}

	private void Start()
	{
		coinsLabel = GetComponent<UILabel>();
		CoinsMessage.CoinsLabelDisappeared += _ReplaceMsgForTraining;
		string text = Storager.getInt("Coins", false).ToString();
		if (coinsLabel != null)
		{
			coinsLabel.text = text;
		}
	}

	private void OnEnable()
	{
		StartCoroutine(UpdateCoinsLabel());
	}

	private void _ReplaceMsgForTraining(bool isGems)
	{
		if (isTraining)
		{
			_trainingMsg = trainCoinsStub;
		}
	}

	private IEnumerator UpdateCoinsLabel()
	{
		while (!_disposed)
		{
			if (Defs.IsTraining)
			{
				if (coinsLabel != null)
				{
					if (ShopNGUIController.sharedShop != null && ShopNGUIController.GuiActive)
					{
						coinsLabel.text = "999";
					}
					else
					{
						coinsLabel.text = _trainingMsg;
					}
				}
				yield return null;
			}
			else
			{
				string coinCountString = Storager.getInt("Coins", false).ToString();
				if (coinsLabel != null)
				{
					coinsLabel.text = coinCountString;
				}
				yield return null;
			}
			yield return StartCoroutine(MyWaitForSeconds(1f));
		}
	}

	public IEnumerator MyWaitForSeconds(float tm)
	{
		float startTime = Time.realtimeSinceStartup;
		do
		{
			yield return null;
		}
		while (Time.realtimeSinceStartup - startTime < tm);
	}

	private void OnDestroy()
	{
		CoinsMessage.CoinsLabelDisappeared -= _ReplaceMsgForTraining;
		_disposed = true;
	}
}
