using System;
using Rilisoft;
using UnityEngine;

public class PlusMinusController : MonoBehaviour
{
	public int stepValue = 1;

	public SaltedInt minValue = default(SaltedInt);

	public SaltedInt maxValue = default(SaltedInt);

	public SaltedInt value = default(SaltedInt);

	public GameObject plusButton;

	public GameObject minusButton;

	public UILabel countLabel;

	public UILabel headLabel;

	private void Awake()
	{
		minValue.Value = 4;
		maxValue.Value = 8;
		value.Value = 4;
	}

	private void Start()
	{
		if (plusButton != null)
		{
			ButtonHandler component = plusButton.GetComponent<ButtonHandler>();
			if (component != null)
			{
				component.Clicked += HandlePlusButtonClicked;
			}
		}
		if (minusButton != null)
		{
			ButtonHandler component2 = minusButton.GetComponent<ButtonHandler>();
			if (component2 != null)
			{
				component2.Clicked += HandleMinusButtonClicked;
			}
		}
	}

	private void HandlePlusButtonClicked(object sender, EventArgs e)
	{
		value.Value += stepValue;
		if (value.Value > maxValue.Value)
		{
			value.Value = maxValue.Value;
		}
	}

	private void HandleMinusButtonClicked(object sender, EventArgs e)
	{
		value.Value -= stepValue;
		if (value.Value < minValue.Value)
		{
			value.Value = minValue.Value;
		}
	}

	private void Update()
	{
		if (countLabel != null)
		{
			countLabel.text = value.Value.ToString();
		}
	}
}
