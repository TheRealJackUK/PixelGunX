using UnityEngine;
using Rilisoft;

internal class ChooseLevel : MonoBehaviour
{
	public GameObject panel;
	public GameObject[] starEnabledPrototypes;
	public GameObject[] starDisabledPrototypes;
	public GameObject gainedStarCountLabel;
	public GameObject backButton;
	public GameObject shopButton;
	public ButtonHandler nextButton;
	public GameObject[] boxOneLevelButtons;
	public GameObject[] boxTwoLevelButtons;
	public AudioClip shopButtonSound;
	public GameObject backgroundHolder;
	public GameObject backgroundHolder_2;
	public GameObject[] boxContents;
	public ShopNGUIController _shopInstance;
}
