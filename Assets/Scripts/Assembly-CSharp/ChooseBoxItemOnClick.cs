using UnityEngine;

public class ChooseBoxItemOnClick : MonoBehaviour
{
	private void OnClick()
	{
		if (base.gameObject.name.Contains((ChooseBox.instance.nguiController.selectIndexMap + 1).ToString()))
		{
			ChooseBox.instance.StartNameBox(base.gameObject.name);
			return;
		}
		MyCenterOnChild component = base.transform.parent.GetComponent<MyCenterOnChild>();
		if (component != null)
		{
			component.CenterOn(base.transform);
		}
	}
}
