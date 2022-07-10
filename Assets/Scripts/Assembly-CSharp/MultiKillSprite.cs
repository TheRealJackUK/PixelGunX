using UnityEngine;

public class MultiKillSprite : MonoBehaviour
{
	private void Start()
	{
		if (ConnectSceneNGUIController.regim == ConnectSceneNGUIController.RegimGame.FlagCapture)
		{
			base.transform.localPosition = new Vector3(base.transform.localPosition.x, -195f, base.transform.localPosition.z);
		}
	}

	private void Update()
	{
	}
}
