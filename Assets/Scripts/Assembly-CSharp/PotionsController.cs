using System;
using System.Collections.Generic;
using UnityEngine;

public sealed class PotionsController : MonoBehaviour
{
	public const string InvisibilityPotion = "InvisibilityPotion";

	public static string HastePotion;

	public static string RegenerationPotion;

	public static string MightPotion;

	public static int MaxNumOFPotions;

	public static PotionsController sharedController;

	public static Dictionary<string, KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>> potionMethods;

	public static Dictionary<string, float> potionDurations;

	public static string[] potions;

	private Dictionary<string, float> activePotions = new Dictionary<string, float>();

	public static float AntiGravityMult
	{
		get
		{
			return 0.75f;
		}
	}

	public static event Action<string> PotionActivated;

	public static event Action<string> PotionDisactivated;

	static PotionsController()
	{
		HastePotion = "HastePotion";
		RegenerationPotion = "RegenerationPotion";
		MightPotion = "MightPotion";
		MaxNumOFPotions = 1000000;
		sharedController = null;
		potionMethods = new Dictionary<string, KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>>();
		potionDurations = new Dictionary<string, float>();
		potions = new string[4] { HastePotion, MightPotion, RegenerationPotion, "InvisibilityPotion" };
		potionMethods.Add(HastePotion, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(HastePotionActivation, HastePotionDeactivation));
		potionMethods.Add(MightPotion, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(MightPotionActivation, MightPotionDeactivation));
		potionMethods.Add("InvisibilityPotion", new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(InvisibilityPotionActivation, InvisibilityPotionDeactivation));
		potionMethods.Add(RegenerationPotion, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(RegenerationPotionActivation, RegenerationPotionDeactivation));
		potionMethods.Add(GearManager.Jetpack, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(MightPotionActivation, MightPotionDeactivation));
		potionMethods.Add(GearManager.Turret, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(RegenerationPotionActivation, TurretPotionDeactivation));
		potionMethods.Add(GearManager.Mech, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(MechActivation, MechDeactivation));
		potionDurations.Add(HastePotion, 0f);
		potionDurations.Add(MightPotion, 0f);
		potionDurations.Add(RegenerationPotion, 0f);
		potionDurations.Add("InvisibilityPotion0", 0f);
		potionDurations.Add(GearManager.Turret + "0", 0f);
		potionDurations.Add(GearManager.Jetpack + "0", 0f);
		potionDurations.Add(GearManager.Mech + "0", 0f);
		potionDurations.Add("InvisibilityPotion1", 0f);
		potionDurations.Add(GearManager.Turret + "1", 0f);
		potionDurations.Add(GearManager.Jetpack + "1", 0f);
		potionDurations.Add(GearManager.Mech + "1", 0f);
		potionDurations.Add("InvisibilityPotion2", 0f);
		potionDurations.Add(GearManager.Turret + "2", 0f);
		potionDurations.Add(GearManager.Jetpack + "2", 0f);
		potionDurations.Add(GearManager.Mech + "2", 0f);
		potionDurations.Add("InvisibilityPotion3", 0f);
		potionDurations.Add(GearManager.Turret + "3", 0f);
		potionDurations.Add(GearManager.Jetpack + "3", 0f);
		potionDurations.Add(GearManager.Mech + "3", 0f);
		potionDurations.Add("InvisibilityPotion4", 0f);
		potionDurations.Add(GearManager.Turret + "4", 0f);
		potionDurations.Add(GearManager.Jetpack + "4", 0f);
		potionDurations.Add(GearManager.Mech + "4", 0f);
		potionDurations.Add("InvisibilityPotion5", 0f);
		potionDurations.Add(GearManager.Turret + "5", 0f);
		potionDurations.Add(GearManager.Jetpack + "5", 0f);
		potionDurations.Add(GearManager.Mech + "5", 0f);
	}

	public bool PotionIsActive(string nm)
	{
		return nm != null && activePotions != null && activePotions.ContainsKey(nm);
	}

	public static void HastePotionActivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
		if ((bool)move_c._player && move_c._player != null)
		{
			FirstPersonControlSharp component = move_c._player.GetComponent<FirstPersonControlSharp>();
			if ((bool)component && component != null)
			{
				component.gravityMultiplier *= AntiGravityMult;
			}
		}
	}

	public static void HastePotionDeactivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
		if ((bool)move_c._player && move_c._player != null)
		{
			FirstPersonControlSharp component = move_c._player.GetComponent<FirstPersonControlSharp>();
			if ((bool)component && component != null)
			{
				component.gravityMultiplier /= AntiGravityMult;
			}
		}
	}

	public static void MightPotionActivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
		GameObject gameObject = null;
		gameObject = ((!Defs.isMulti) ? GameObject.FindGameObjectWithTag("Player") : WeaponManager.sharedManager.myPlayer);
		if (gameObject != null)
		{
			gameObject.GetComponent<SkinName>().playerMoveC.SetJetpackEnabled(true);
		}
	}

	public static void MightPotionDeactivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
		GameObject gameObject = null;
		gameObject = ((!Defs.isMulti) ? GameObject.FindGameObjectWithTag("Player") : WeaponManager.sharedManager.myPlayer);
		if (gameObject != null)
		{
			gameObject.GetComponent<SkinName>().playerMoveC.SetJetpackEnabled(false);
		}
	}

	public static void RegenerationPotionActivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
	}

	public static void RegenerationPotionDeactivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
	}

	public static void TurretPotionDeactivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
		Player_move_c player_move_c = null;
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
		if (player_move_c == null || player_move_c.currentTurret == null)
		{
			return;
		}
		if (Defs.isMulti)
		{
			if (Defs.isInet)
			{
				PhotonNetwork.Destroy(player_move_c.currentTurret);
			}
			else
			{
				PhotonNetwork.Destroy(player_move_c.currentTurret);
			}
		}
		else
		{
			UnityEngine.Object.Destroy(player_move_c.currentTurret);
		}
	}

	public static void NightVisionPotionActivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
		if ((bool)move_c.inGameGUI && move_c.inGameGUI.nightVisionEffect != null)
		{
			move_c.inGameGUI.nightVisionEffect.SetActive(true);
		}
	}

	public static void NightVisionPotionDeactivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
		if ((bool)move_c.inGameGUI && move_c.inGameGUI.nightVisionEffect != null)
		{
			move_c.inGameGUI.nightVisionEffect.SetActive(false);
		}
	}

	public static void InvisibilityPotionActivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
		move_c.SetInvisible(true);
	}

	public static void InvisibilityPotionDeactivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
		move_c.SetInvisible(false);
	}

	public static void AntiGravityPotionActivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
	}

	public static void AntiGravityPotionDeactivation(Player_move_c move_c, Dictionary<string, object> pars)
	{
	}

	private static void MechActivation(Player_move_c arg1, Dictionary<string, object> arg2)
	{
		Debug.Log("Mech ON");
		arg1.ActivateMech(0);
	}

	private static void MechDeactivation(Player_move_c arg1, Dictionary<string, object> arg2)
	{
		Debug.Log("Mech OFF");
		arg1.DeactivateMech();
	}

	public float RemainDuratioForPotion(string potion)
	{
		if (potion == null || !activePotions.ContainsKey(potion))
		{
			return 0f;
		}
		return activePotions[potion] + EffectsController.AddingForPotionDuration(potion);
	}

	public void ReactivatePotions(Player_move_c move_c, Dictionary<string, object> pars)
	{
		foreach (string key in activePotions.Keys)
		{
			ActivatePotion(key, move_c, pars);
		}
	}

	public void ActivatePotion(string potion, Player_move_c move_c, Dictionary<string, object> pars)
	{
		if (!activePotions.ContainsKey(potion))
		{
			activePotions.Add(potion, potionDurations[potion + GearManager.CurrentNumberOfUphradesForGear(potion)]);
		}
		if (potionMethods.ContainsKey(potion))
		{
			potionMethods[potion].Key(move_c, pars);
		}
		if (PotionsController.PotionActivated != null)
		{
			PotionsController.PotionActivated(potion);
		}
	}

	public void Step(float tm, Player_move_c p)
	{
		List<string> list = new List<string>();
		List<string> list2 = new List<string>();
		foreach (string key3 in activePotions.Keys)
		{
			list2.Add(key3);
		}
		foreach (string item in list2)
		{
			Dictionary<string, float> dictionary;
			Dictionary<string, float> dictionary2 = (dictionary = activePotions);
			string key;
			string key2 = (key = item);
			float num = dictionary[key];
			dictionary2[key2] = num - tm;
			if (RemainDuratioForPotion(item) <= 0f)
			{
				list.Add(item);
			}
		}
		foreach (string item2 in list)
		{
			DeActivePotion(item2, p);
		}
	}

	public void DeActivePotion(string _potion, Player_move_c p, bool isDeleteObject = true)
	{
		if (PotionsController.PotionDisactivated != null)
		{
			PotionsController.PotionDisactivated(_potion);
		}
		if (activePotions.ContainsKey(_potion))
		{
			activePotions.Remove(_potion);
			if (isDeleteObject)
			{
				potionMethods[_potion].Value(p, new Dictionary<string, object>());
			}
		}
	}

	private void OnLevelWasLoaded(int lev)
	{
		if (Array.IndexOf(ConnectSceneNGUIController.masMapNameHunger, Application.loadedLevelName) == -1)
		{
			activePotions.Clear();
		}
	}

	private void Start()
	{
		sharedController = this;
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
	}
}
