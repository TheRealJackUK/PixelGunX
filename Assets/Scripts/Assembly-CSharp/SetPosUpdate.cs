using UnityEngine;

public class SetPosUpdate : MonoBehaviour
{
	public int index;

	private void Start()
	{
		SetPos();
	}

	private void Update()
	{
		SetPos();
	}

	private void SetPos()
	{
		switch (index)
		{
		case 0:
			if (MainMenu.SkinsMakerSupproted())
			{
				base.transform.localPosition = new Vector3(-385f - (768f * (float)Screen.width / (float)Screen.height - 976f) / 3f, 64f, 1f);
			}
			else
			{
				base.transform.localPosition = new Vector3(-124f, 64f, 0f);
			}
			break;
		case 1:
			base.transform.localPosition = new Vector3(-424f - (768f * (float)Screen.width / (float)Screen.height - 912f) / 2f, 44f, 0f);
			break;
		}
	}
}
