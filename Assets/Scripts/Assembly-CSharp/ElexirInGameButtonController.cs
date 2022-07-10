using System.Linq;
using UnityEngine;

public class ElexirInGameButtonController : MonoBehaviour
{
	public bool isActivePotion;

	public UIButton myButton;

	public UILabel myLabelTime;

	public UILabel myLabelCount;

	public int price = 10;

	public GameObject plusSprite;

	public GameObject myPotion;

	public GameObject priceLabel;

	public GameObject lockSprite;

	private bool isKnifeMap;

	private void Awake()
	{
		string text = myPotion.name;
		string text2 = myPotion.name;
		if (GearManager.Gear.Contains(text))
		{
			text = GearManager.OneItemIDForGear(text, GearManager.CurrentNumberOfUphradesForGear(text));
		}
		isKnifeMap = Application.loadedLevelName.Equals("Knife");
		if (Defs.isHunger || isKnifeMap)
		{
			myButton.disabledSprite = "game_clear";
			myButton.isEnabled = false;
			lockSprite.SetActive(true);
		}
		ItemPrice itemPrice = VirtualCurrencyHelper.Price(text);
		if (text2 != null && text2.Equals(GearManager.Grenade))
		{
			itemPrice = new ItemPrice(itemPrice.Price * GearManager.ItemsInPackForGear(GearManager.Grenade), itemPrice.Currency);
		}
		priceLabel.GetComponent<UILabel>().text = itemPrice.Price.ToString();
		PotionsController.PotionDisactivated += HandlePotionDisactivated;
	}

	private void Start()
	{
		OnEnable();
	}

	private void HandlePotionDisactivated(string obj)
	{
		if (obj.Equals(myPotion.name))
		{
			myButton.isEnabled = true;
			myLabelTime.text = string.Empty;
			int @int = Storager.getInt(obj, false);
			myLabelTime.enabled = false;
			isActivePotion = false;
			myLabelTime.gameObject.SetActive(base.gameObject.activeSelf);
			if (@int == 0)
			{
				SetStateBuy();
			}
			else
			{
				SetStateUse();
			}
		}
	}

	private void SetStateBuy()
	{
		myButton.normalSprite = "game_clear_yellow";
		myButton.pressedSprite = "game_clear_yellow_n";
		priceLabel.SetActive(true);
		myLabelCount.gameObject.SetActive(false);
		plusSprite.SetActive(true);
		myLabelTime.enabled = false;
	}

	private void SetStateUse()
	{
		myLabelCount.gameObject.SetActive(true);
		plusSprite.SetActive(false);
		myButton.normalSprite = "game_clear";
		myButton.pressedSprite = "game_clear_n";
		priceLabel.SetActive(false);
		if (!isActivePotion)
		{
			myLabelTime.enabled = false;
		}
	}

	private void Update()
	{
	}

	private void OnDestroy()
	{
		PotionsController.PotionDisactivated -= HandlePotionDisactivated;
	}

	private void OnEnable()
	{
		int @int = Storager.getInt(myPotion.name, false);
		myLabelCount.text = @int.ToString();
		myLabelTime.gameObject.SetActive(true);
		if (@int == 0)
		{
			if (!isActivePotion)
			{
				SetStateBuy();
			}
		}
		else
		{
			SetStateUse();
		}
	}

	private void OnDisable()
	{
		if (!isActivePotion)
		{
			myLabelTime.gameObject.SetActive(false);
		}
	}
}
