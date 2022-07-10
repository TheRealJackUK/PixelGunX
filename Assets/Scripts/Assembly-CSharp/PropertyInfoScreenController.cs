using UnityEngine;

public class PropertyInfoScreenController : MonoBehaviour
{
	public GameObject description;

	public GameObject descriptionMelee;

	public virtual void Show(bool isMelee)
	{
		base.gameObject.SetActive(true);
		((!isMelee) ? description : descriptionMelee).SetActive(true);
		((!isMelee) ? descriptionMelee : description).SetActive(false);
	}

	public virtual void Hide()
	{
		base.gameObject.SetActive(false);
	}
}
