using UnityEngine;

public class RespawnWindow : MonoBehaviour
{
	public UILabel killerLevelNicknameLabel;
	public UITexture killerRank;
	public UILabel killerClanNameLabel;
	public UITexture killerClanLogo;
	public UILabel autoRespawnTitleLabel;
	public UILabel autoRespawnTimerLabel;
	public GameObject characterViewHolder;
	public Camera characterViewCamera;
	public UITexture characterViewTexture;
	public CharacterView characterView;
	public RespawnWindowItemToBuy killerWeapon;
	public RespawnWindowItemToBuy recommendedWeapon;
	public RespawnWindowItemToBuy recommendedArmor;
	public GameObject coinsShopButton;
	public RespawnWindowEquipmentItem hatItem;
	public RespawnWindowEquipmentItem maskItem;
	public RespawnWindowEquipmentItem armorItem;
	public RespawnWindowEquipmentItem capeItem;
	public RespawnWindowEquipmentItem bootsItem;
	public UILabel armorCountLabel;
}
