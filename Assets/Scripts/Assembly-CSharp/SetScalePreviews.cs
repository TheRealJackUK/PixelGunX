using UnityEngine;

public class SetScalePreviews : MonoBehaviour
{
	public UIPanel myScrollPanel;

	private float widthCell;

	private void Start()
	{
		widthCell = ConnectSceneNGUIController.sharedController.widthCell;
	}

	public void LateUpdate()
	{
		MapPreviewController[] componentsInChildren = base.transform.GetComponentsInChildren<MapPreviewController>();
		if (componentsInChildren == null)
		{
			return;
		}
		float x = myScrollPanel.clipOffset.x;
		float num = 0.9f;
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			float num2 = 1f - Mathf.Abs(componentsInChildren[i].transform.localPosition.x - x) / widthCell * 0.1f;
			if (num2 <= 0f)
			{
				num2 = 0.1f;
			}
			componentsInChildren[i].transform.localScale = new Vector3(num2, num2, num2);
		}
	}
}
