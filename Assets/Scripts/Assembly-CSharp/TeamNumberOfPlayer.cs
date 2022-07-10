using System;
using Rilisoft;
using UnityEngine;

public class TeamNumberOfPlayer : MonoBehaviour
{
	public int value;

	public GameObject button2x2;

	public GameObject button3x3;

	public GameObject button4x4;

	public GameObject button5x5;

	private int oldValue = 8;

	private void Start()
	{
		if (button2x2 != null)
		{
			ButtonHandler component = button2x2.GetComponent<ButtonHandler>();
			if (component != null)
			{
				component.Clicked += HandleButton2x2Clicked;
			}
		}
		if (button3x3 != null)
		{
			ButtonHandler component2 = button3x3.GetComponent<ButtonHandler>();
			if (component2 != null)
			{
				component2.Clicked += HandleButton3x3Clicked;
			}
		}
		if (button4x4 != null)
		{
			ButtonHandler component3 = button4x4.GetComponent<ButtonHandler>();
			if (component3 != null)
			{
				component3.Clicked += HandleButton4x4Clicked;
			}
		}
		if (button5x5 != null)
		{
			ButtonHandler component4 = button5x5.GetComponent<ButtonHandler>();
			if (component4 != null)
			{
				component4.Clicked += HandleButton5x5Clicked;
			}
		}
		value = 10;
		button2x2.GetComponent<UIButton>().isEnabled = true;
		button3x3.GetComponent<UIButton>().isEnabled = true;
		button4x4.GetComponent<UIButton>().isEnabled = true;
		button5x5.GetComponent<UIButton>().isEnabled = false;
	}

	public void SetValue(int _value)
	{
		value = _value;
		button2x2.GetComponent<UIButton>().isEnabled = value != 4;
		button3x3.GetComponent<UIButton>().isEnabled = value != 6;
		button4x4.GetComponent<UIButton>().isEnabled = value != 8;
		button5x5.GetComponent<UIButton>().isEnabled = value != 10;
	}

	private void HandleButton2x2Clicked(object sender, EventArgs e)
	{
		SetValue(4);
	}

	private void HandleButton3x3Clicked(object sender, EventArgs e)
	{
		SetValue(6);
	}

	private void HandleButton4x4Clicked(object sender, EventArgs e)
	{
		SetValue(8);
	}

	private void HandleButton5x5Clicked(object sender, EventArgs e)
	{
		SetValue(10);
	}
}
