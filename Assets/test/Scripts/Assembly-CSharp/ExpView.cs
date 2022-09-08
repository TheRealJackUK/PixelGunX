using UnityEngine;

public class ExpView : MonoBehaviour
{
	public UIRoot interfaceHolder;
	public Camera experienceCamera;
	public UISprite experienceFrame;
	public UISprite experienceFrameWithFooter;
	public UILabel levelLabel;
	public UILabel experienceLabel;
	public UISlider currentProgress;
	public UISlider oldProgress;
	public UISprite rankSprite;
	public LevelUpWithOffers levelUpPanel;
	public LevelUpWithOffers levelUpPanelClear;
	public LevelUpWithOffers levelUpPanelTier;
	public GameObject[] arrows;
	public GameObject[] shineNodes;
}
