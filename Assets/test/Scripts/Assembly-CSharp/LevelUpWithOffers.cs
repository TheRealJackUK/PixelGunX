using UnityEngine;
using Rilisoft;

public class LevelUpWithOffers : MonoBehaviour
{
	public UIButton continueButton;
	public UIButton shopButton;
	public UILabel[] rewardGemsPriceLabel;
	public UILabel totalGemsLabel;
	public UILabel[] currentRankLabel;
	public UILabel[] rewardPriceLabel;
	public UILabel totalCoinsLabel;
	public NewAvailableItemInShop[] items;
	public UIGrid grid;
	public bool isTierLevelUp;
}
