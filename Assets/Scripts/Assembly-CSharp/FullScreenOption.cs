using UnityEngine;

[AddComponentMenu("Common/Full Screen Option")]
public class FullScreenOption : MonoBehaviour
{
	private void Update()
	{
		if (Input.GetKeyDown(KeyCode.F5))
		{
			if (Screen.fullScreen)
			{
				Screen.SetResolution(Screen.currentResolution.width, Screen.currentResolution.height, true);
			}
			else
			{
				Screen.SetResolution(Screen.currentResolution.width, Screen.currentResolution.height, true);
			}
		}
	}
}
