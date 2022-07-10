using UnityEngine;

namespace Rilisoft
{
	public sealed class NewAvailableItemInShop : MonoBehaviour
	{
		public new string tag = string.Empty;

		public ShopNGUIController.CategoryNames category;

		public UITexture itemImage;

		public UILabel itemName;
	}
}
