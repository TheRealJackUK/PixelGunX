using UnityEngine;

public class SetChatLabelController : MonoBehaviour
{
	public UILabel killerLabel;

	public UILabel killedLabel;

	public UISprite reasonSprite;

	public UISprite reasonSprite2;

	public void SetChatLabelText(string _nameKiller, string _reasonSpriteName2, string _nameKilled, string _reasonSpriteName = null)
	{
		killerLabel.text = _nameKiller;
		int num = killerLabel.width;
		if (reasonSprite != null && !string.IsNullOrEmpty(_reasonSpriteName))
		{
			if (!reasonSprite.gameObject.activeSelf)
			{
				reasonSprite.gameObject.SetActive(true);
			}
			reasonSprite.transform.localPosition = new Vector3((float)num + 30f, 0f, 0f);
			num += 60;
			reasonSprite.spriteName = SubstituteWeaponImageIfNeeded(_reasonSpriteName);
		}
		else if (reasonSprite != null && reasonSprite.gameObject.activeSelf)
		{
			reasonSprite.gameObject.SetActive(false);
		}
		if (string.IsNullOrEmpty(_reasonSpriteName2))
		{
			if (reasonSprite2.gameObject.activeSelf)
			{
				reasonSprite2.gameObject.SetActive(false);
			}
		}
		else
		{
			if (!reasonSprite2.gameObject.activeSelf)
			{
				reasonSprite2.gameObject.SetActive(true);
			}
			reasonSprite2.transform.localPosition = new Vector3((float)num + 20f, 0f, 0f);
			num += 40;
			reasonSprite2.spriteName = SubstituteWeaponImageIfNeeded(_reasonSpriteName2);
		}
		if (string.IsNullOrEmpty(_nameKilled))
		{
			if (killedLabel.gameObject.activeSelf)
			{
				killedLabel.gameObject.SetActive(false);
			}
			return;
		}
		if (!killedLabel.gameObject.activeSelf)
		{
			killedLabel.gameObject.SetActive(true);
		}
		killedLabel.transform.localPosition = new Vector3(num, 0f, 0f);
		killedLabel.text = _nameKilled;
	}

	private string SubstituteWeaponImageIfNeeded(string source)
	{
		if (source == null)
		{
			return null;
		}
		ItemRecord byPrefabName = ItemDb.GetByPrefabName(source);
		if (byPrefabName != null && byPrefabName.UseImagesFromFirstUpgrade && byPrefabName.Tag != null)
		{
			string text = WeaponUpgrades.TagOfFirstUpgrade(byPrefabName.Tag);
			if (text != null && !text.Equals(byPrefabName.Tag))
			{
				ItemRecord byTag = ItemDb.GetByTag(text);
				if (byTag != null && byTag.PrefabName != null)
				{
					return byTag.PrefabName;
				}
			}
		}
		return source;
	}
}
