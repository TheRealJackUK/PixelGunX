using System;
using UnityEngine;

public class ShopCarouselElement : MonoBehaviour
{
	public GameObject locked;

	public Transform arrow;

	public UILabel topSeller;

	public UILabel quantity;

	public UILabel newnew;

	public bool showTS;

	public bool showNew;

	public bool showQuantity;

	public string prefabPath;

	public Vector3 baseScale;

	public Vector3 ourPosition;

	public string itemID;

	public string readableName;

	public Transform model;

	private float lastTimeUpdated;

	public Vector3 arrnoInitialPos;

	public void SetQuantity()
	{
		quantity.text = Storager.getInt(GearManager.HolderQuantityForID(itemID), false) + ((itemID == null || !GearManager.HolderQuantityForID(itemID).Equals(GearManager.Grenade)) ? string.Empty : ("/" + GearManager.MaxCountForGear(GearManager.HolderQuantityForID(itemID))));
	}

	private void Awake()
	{
		arrnoInitialPos = new Vector3(70.05f, -0.00016f, -100f);
	}

	private void Start()
	{
		if (Array.IndexOf(PotionsController.potions, itemID) >= 0)
		{
			quantity.gameObject.SetActive(true);
			HandlePotionActivated(itemID);
		}
		PotionsController.PotionActivated += HandlePotionActivated;
	}

	private void HandlePotionActivated(string obj)
	{
		if (itemID != null && obj != null && itemID.Equals(obj))
		{
			quantity.text = Storager.getInt(GearManager.HolderQuantityForID(itemID), false) + ((itemID == null || !GearManager.HolderQuantityForID(itemID).Equals(GearManager.Grenade)) ? string.Empty : ("/" + GearManager.MaxCountForGear(GearManager.HolderQuantityForID(itemID))));
		}
	}

	public void SetPos(float scaleCoef, float offset)
	{
		if (model != null)
		{
			model.localScale = baseScale * scaleCoef;
			model.localPosition = ourPosition * scaleCoef + new Vector3(offset, 0f, 0f);
		}
		if (arrow != null)
		{
			arrow.localScale = new Vector3(1f, 1f, 1f) * scaleCoef;
			arrow.localPosition = new Vector3(arrnoInitialPos.x * scaleCoef, arrnoInitialPos.y * scaleCoef, arrnoInitialPos.z) + new Vector3(offset, 0f, 0f);
		}
		if (locked != null)
		{
			locked.transform.localScale = new Vector3(1f, 1f, 1f) * scaleCoef;
			locked.transform.localPosition = new Vector3(0f, 0f, arrnoInitialPos.z) + new Vector3(offset, 0f, 0f);
		}
	}

	private void OnDestroy()
	{
		PotionsController.PotionActivated -= HandlePotionActivated;
	}
}
