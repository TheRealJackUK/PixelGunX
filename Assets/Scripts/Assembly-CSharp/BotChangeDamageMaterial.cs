using RilisoftBot;
using UnityEngine;

public class BotChangeDamageMaterial : MonoBehaviour
{
	private Texture _mainTexture;

	private Texture _damageTexture;

	private void Start()
	{
		string text = base.transform.root.GetChild(0).name;
		Texture texture = null;
		if (text.Contains("Enemy") && !(texture = SkinsManagerPixlGun.sharedManager.skins[text + "_Level" + CurrentCampaignGame.currentLevel] as Texture))
		{
			Debug.Log("No skin: " + text + "_Level" + CurrentCampaignGame.currentLevel);
		}
		if (texture != null)
		{
			_mainTexture = texture;
			ResetMainMaterial();
		}
		else
		{
			_mainTexture = base.GetComponent<Renderer>().material.mainTexture;
		}
		BaseBot botScriptForObject = BaseBot.GetBotScriptForObject(base.transform.root);
		if (botScriptForObject != null)
		{
			_damageTexture = botScriptForObject.flashDeadthTexture;
		}
	}

	public void ShowDamageEffect()
	{
		base.GetComponent<Renderer>().material.mainTexture = _damageTexture;
	}

	public void ResetMainMaterial()
	{
		base.GetComponent<Renderer>().material.mainTexture = _mainTexture;
	}
}
