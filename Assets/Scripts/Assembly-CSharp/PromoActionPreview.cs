using UnityEngine;

public class PromoActionPreview : MonoBehaviour
{
	public UISprite currencyImage;

	public string tg;

	public UITexture icon;

	public UILabel topSeller;

	public UILabel newItem;

	public UILabel sale;

	public UILabel coins;

	public Texture unpressed;

	public Texture pressed;

	public int Discount { get; set; }

	private void Start()
	{
	}

	private void OnEnable()
	{
		UIButton[] componentsInChildren = GetComponentsInChildren<UIButton>(true);
		foreach (UIButton uIButton in componentsInChildren)
		{
			uIButton.isEnabled = !Defs.isTrainingFlag;
		}
		if (Discount > 0)
		{
			sale.text = string.Format("{0}\n{1}%", LocalizationStore.Key_0419, Discount);
		}
	}

	private void Update()
	{
	}
}
