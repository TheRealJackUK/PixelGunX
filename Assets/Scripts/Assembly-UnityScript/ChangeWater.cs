using System;
using UnityEngine;

[Serializable]
public class ChangeWater : MonoBehaviour
{
	public GameObject[] waters;

	private int currentIndex;

	public virtual void Update()
	{
		if (Input.anyKeyDown)
		{
			if (currentIndex < waters.Length - 1)
			{
				currentIndex++;
			}
			else
			{
				currentIndex = 0;
			}
			int i = 0;
			GameObject[] array = waters;
			for (int length = array.Length; i < length; i++)
			{
				array[i].SetActiveRecursively(false);
			}
			waters[currentIndex].SetActiveRecursively(true);
		}
	}

	public virtual void Main()
	{
	}
}
