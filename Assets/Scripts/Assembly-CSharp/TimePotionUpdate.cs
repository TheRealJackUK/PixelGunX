using System;
using UnityEngine;

public class TimePotionUpdate : MonoBehaviour
{
	public UILabel myLabel;

	private float timerUpdate = -1f;

	public string myPotionName;

	private void Start()
	{
	}

	private void Update()
	{
		if (myLabel.enabled)
		{
			timerUpdate -= Time.deltaTime;
			if (timerUpdate < 0f)
			{
				timerUpdate = 0.25f;
				SetTimeForLabel();
			}
		}
	}

	private void SetTimeForLabel()
	{
		string text = myPotionName;
		if (PotionsController.sharedController.PotionIsActive(text))
		{
			float num = PotionsController.sharedController.RemainDuratioForPotion(text);
			TimeSpan timeSpan = TimeSpan.FromSeconds(num);
			myLabel.text = string.Format("{0:D2}:{1:D2}", timeSpan.Minutes, timeSpan.Seconds);
			if (num <= 5f)
			{
				myLabel.color = new Color(1f, 0f, 0f);
			}
			else
			{
				myLabel.color = new Color(1f, 1f, 1f);
			}
		}
	}
}
