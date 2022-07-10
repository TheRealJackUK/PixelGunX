using System;
using Rilisoft;
using UnityEngine;

public class SkipPresser : MonoBehaviour
{
	public GameObject windowAnchor;

	public static event Action SkipPressed;

	private void Start()
	{
		base.gameObject.SetActive(Defs.IsTraining);
	}

	private void OnClick()
	{
		base.gameObject.SetActive(false);
		windowAnchor.SetActive(true);
		if (SkipPresser.SkipPressed != null)
		{
			SkipPresser.SkipPressed();
		}
		GameObject gameObject = GameObject.FindGameObjectWithTag("PlayerGun");
		if ((bool)gameObject && gameObject != null)
		{
			Transform child = gameObject.transform.GetChild(0);
			if ((bool)child && child != null)
			{
				child.gameObject.SetActive(false);
			}
		}
		TrainingController.SkipTraining();
	}

	private void Update()
	{
		if (TrainingController.stepTraining < TrainingController.stepTrainingList["KillZombi"] || !GlobalGameController.InsideTraining)
		{
			base.transform.localPosition = new Vector3(0f, -1000f, 2f);
		}
		else if (BuildSettings.BuildTarget == BuildTarget.Android)
		{
			base.transform.localPosition = new Vector3(0f, -1000f, 2f);
		}
		else
		{
			base.transform.localPosition = new Vector3(0f, -96f, 2f);
		}
	}
}
