using UnityEngine;

public sealed class BlinkHealthButton : MonoBehaviour
{
	public enum RegimButton
	{
		Health,
		Ammo
	}

	public RegimButton typeButton;

	public static bool isBlink;

	private bool isBlinkOld;

	public float timerBlink;

	public float maxTimerBlink = 0.5f;

	public Color blinkColor = new Color(1f, 0f, 0f);

	public Color unBlinkColor = new Color(1f, 1f, 1f);

	public bool isBlinkState;

	public UISprite[] blinkObjs;

	public bool isBlinkTemp;

	public UISprite shine;

	private Player_move_c player_move_c;

	private Color _blinkColorNoAlpha;

	private void Start()
	{
		isBlink = false;
		isBlinkState = false;
		_blinkColorNoAlpha = new Color(blinkColor.r, blinkColor.g, blinkColor.b, 0f);
	}

	private void Update()
	{
		if (player_move_c == null)
		{
			if (Defs.isMulti)
			{
				player_move_c = WeaponManager.sharedManager.myPlayerMoveC;
			}
			else
			{
				GameObject gameObject = GameObject.FindGameObjectWithTag("Player");
				if (gameObject != null)
				{
					player_move_c = gameObject.GetComponent<SkinName>().playerMoveC;
				}
			}
		}
		if (player_move_c == null)
		{
			return;
		}
		if (typeButton == RegimButton.Health)
		{
			if (player_move_c.CurHealth + player_move_c.curArmor < 3f && !player_move_c.isMechActive)
			{
				isBlink = true;
			}
			else
			{
				isBlink = false;
			}
		}
		if (typeButton == RegimButton.Ammo)
		{
			Weapon weapon = (Weapon)WeaponManager.sharedManager.playerWeapons[WeaponManager.sharedManager.CurrentWeaponIndex];
			if (weapon.currentAmmoInClip == 0 && weapon.currentAmmoInBackpack == 0 && (!weapon.weaponPrefab.GetComponent<WeaponSounds>().isMelee || weapon.weaponPrefab.GetComponent<WeaponSounds>().isShotMelee) && !player_move_c.isMechActive)
			{
				isBlink = true;
			}
			else
			{
				isBlink = false;
			}
		}
		isBlinkTemp = isBlink;
		if (isBlinkOld != isBlink)
		{
			timerBlink = maxTimerBlink;
		}
		if (isBlink)
		{
			timerBlink -= Time.deltaTime;
			if (timerBlink < 0f)
			{
				timerBlink = maxTimerBlink;
				isBlinkState = !isBlinkState;
				if (shine != null)
				{
					shine.color = ((!isBlinkState) ? _blinkColorNoAlpha : blinkColor);
				}
			}
		}
		if (!isBlink && isBlinkState)
		{
			isBlinkState = !isBlinkState;
			if (shine != null)
			{
				shine.color = ((!isBlinkState) ? _blinkColorNoAlpha : blinkColor);
			}
		}
		isBlinkOld = isBlink;
	}
}
