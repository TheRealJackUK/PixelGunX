using System;
using System.Collections;

public sealed class WeaponComparer : IComparer
{
	public static readonly string[] multiplayerWeaponsOrd = new string[]
	{
		WeaponTags.ShotgunTag,
		WeaponTags.Red_StoneRent_Tag,
		WeaponTags.Assault_Machine_Gun_Tag,
		WeaponTags.Assault_Machine_GunBuy_Tag,
		WeaponTags.Assault_Machine_GunBuy_2_Tag,
		WeaponTags.Assault_Machine_GunBuy_3_Tag,
		WeaponTags.Valentine_Shotgun_Tag,
		WeaponTags.Valentine_Shotgun_2_Tag,
		WeaponTags.Valentine_Shotgun_3_Tag,
		WeaponTags.Water_Rifle_Tag,
		WeaponTags.Water_Rifle_2_Tag,
		WeaponTags.Water_Rifle_3_Tag,
		WeaponTags.m16_2_Tag,
		WeaponTags.Uzi2Tag,
		WeaponTags.UziTag,
		WeaponTags.AK47Tag,
		WeaponTags.DoubleShotgunTag,
		WeaponTags.m16Tag,
		WeaponTags.m16_3_Tag,
		WeaponTags.m16_4_Tag,
		WeaponTags.AK74Tag,
		WeaponTags.AK74_2_Tag,
		WeaponTags.AK74_3_Tag,
		WeaponTags.FAMASTag,
		WeaponTags.SandFamasTag,
		WeaponTags.NavyFamasTag,
		WeaponTags._3pl_ShotgunTag,
		WeaponTags.SteamPower_2_Tag,
		WeaponTags.SteamPower_3_Tag,
		WeaponTags._3_shotgun_2_Tag,
		WeaponTags._3_shotgun_3_Tag,
		WeaponTags.plazma_Tag,
		WeaponTags.plazma_2_Tag,
		WeaponTags.plazma_3_Tag,
		WeaponTags.PlasmaRifle_2_Tag,
		WeaponTags.PlasmaRifle_3_Tag,
		WeaponTags.Thompson_Tag,
		WeaponTags.StateDefender_2_tag,
		WeaponTags.MinigunTag,
		WeaponTags.RedMinigunTag,
		WeaponTags.minigun_3_Tag,
		WeaponTags.Minigun_4_Tag,
		WeaponTags.Minigun_5_Tag,
		WeaponTags.XM8_1_Tag,
		WeaponTags.XM8_2_Tag,
		WeaponTags.XM8_3_Tag,
		WeaponTags.Shmaiser_Tag,
		WeaponTags.HeavyShotgun_Tag,
		WeaponTags.HeavyShotgun_2_Tag,
		WeaponTags.HeavyShotgun_3_Tag,
		WeaponTags.AUGTag,
		WeaponTags.AUG_2Tag,
		WeaponTags.AUG_3tag,
		WeaponTags.Thompson_2_Tag,
		WeaponTags.AutoShotgun_Tag,
		WeaponTags.AutoShotgun_2_Tag,
		WeaponTags.AutoShotgun_3tag,
		WeaponTags.Red_StoneTag,
		WeaponTags.GoldenRed_StoneTag,
		WeaponTags.Red_Stone_3_Tag,
		WeaponTags.Red_Stone_4_Tag,
		WeaponTags.Red_Stone_5tag,
		WeaponTags.SPASTag,
		WeaponTags.GoldenSPASTag,
		WeaponTags.CrystalSPASTag,
		WeaponTags.PX_3000_Tag,
		WeaponTags.DualUzi_Tag,
		WeaponTags.DualUzi_2_Tag,
		WeaponTags.DualUzi_3_Tag,
		WeaponTags.SeriousArgument_Tag,
		WeaponTags.FutureRifle_Tag,
		WeaponTags.FutureRifle_2_Tag,
		WeaponTags.PlasmaShotgun_Tag,
		WeaponTags.PlasmaShotgun_2_Tag,
		WeaponTags.RapidFireRifle_Tag,
		WeaponTags.RapidFireRifle_2_Tag,
		WeaponTags.PistolTag,
		WeaponTags.TwoBoltersRent_Tag,
		WeaponTags.RevolverTag,
		WeaponTags.Water_Pistol_Tag,
		WeaponTags.Water_Pistol_2_Tag,
		WeaponTags.Water_Pistol_3tag,
		WeaponTags.AlienGunTag,
		WeaponTags.GlockTag,
		WeaponTags.GoldenGlockTag,
		WeaponTags.CrystalGlockTag,
		WeaponTags.EagleTag,
		WeaponTags.BlackEagleTag,
		WeaponTags.eagle_3Tag,
		WeaponTags.BerettaTag,
		WeaponTags.WhiteBerettaTag,
		WeaponTags.BlackBerettaTag,
		WeaponTags.plazma_pistol_Tag,
		WeaponTags.plazma_pistol_2_Tag,
		WeaponTags.SparklyBlasterTag,
		WeaponTags.SparklyBlaster_2tag,
		WeaponTags.SparklyBlaster_3tag,
		WeaponTags.TwoRevolvers_Tag,
		WeaponTags.TwoRevolvers_2_Tag,
		WeaponTags.TwoRevolvers_3tag,
		WeaponTags.mauser_Tag,
		WeaponTags.Revolver2Tag,
		WeaponTags.Revolver5_Tag,
		WeaponTags.Revolver6_Tag,
		WeaponTags.revolver_2_2_Tag,
		WeaponTags.revolver_2_3_Tag,
		WeaponTags.flower_Tag,
		WeaponTags.flower_2_Tag,
		WeaponTags.flower_3_Tag,
		WeaponTags.TwoBolters_Tag,
		WeaponTags.TwoBolters_2_Tag,
		WeaponTags.TwoBolters_3_Tag,
		WeaponTags.plazma_pistol_3_Tag,
		WeaponTags.FreezeGun_0_Tag,
		WeaponTags.FreezeGun_0_2_Tag,
		WeaponTags.RailRevolver_1_Tag,
		WeaponTags.RailRevolverBuy_Tag,
		WeaponTags.RailRevolverBuy_2_Tag,
		WeaponTags.RailRevolverBuy_3_Tag,
		WeaponTags.DualHawks_Tag,
		WeaponTags.Photon_Pistol_Tag,
		WeaponTags.Photon_Pistol_2_Tag,
		WeaponTags.KnifeTag,
		WeaponTags.Carrot_Sword_Tag,
		WeaponTags.Carrot_Sword_2_Tag,
		WeaponTags.Carrot_Sword_3_Tag,
		WeaponTags.MinersWeaponTag,
		WeaponTags.GoldenPickTag,
		WeaponTags.CrystalPickTag,
		WeaponTags.SteelAxeTag,
		WeaponTags.GoldenAxeTag,
		WeaponTags.CrystalAxeTag,
		WeaponTags.IronSwordTag,
		WeaponTags.GoldenSwordTag,
		WeaponTags.CrystalSwordTag,
		WeaponTags.HammerTag,
		WeaponTags.ChainsawTag,
		WeaponTags.Chainsaw2Tag,
		WeaponTags.MaceTag,
		WeaponTags.Mace2Tag,
		WeaponTags.Sword_2Tag,
		WeaponTags.Sword_22Tag,
		WeaponTags.Sword_2_3_Tag,
		WeaponTags.Sword_2_4_Tag,
		WeaponTags.Sword_2_5_Tag,
		WeaponTags.TreeTag,
		WeaponTags.Tree_2_Tag,
		WeaponTags.FireAxeTag,
		WeaponTags.ScytheTag,
		WeaponTags.Scythe_2_Tag,
		WeaponTags.scythe_3_Tag,
		WeaponTags.Hammer2Tag,
		WeaponTags.LightSwordTag,
		WeaponTags.RedLightSaberTag,
		WeaponTags.LightSword_3_Tag,
		WeaponTags.LightSword_4_Tag,
		WeaponTags.LightSword_5tag,
		WeaponTags.katana_Tag,
		WeaponTags.katana_2_Tag,
		WeaponTags.katana_3_Tag,
		WeaponTags.katana_4tag,
		WeaponTags.ShovelTag,
		WeaponTags.StormHammer_Tag,
		WeaponTags.MachineGunTag,
		WeaponTags.Impulse_Sniper_Rifle_Tag,
		WeaponTags.Impulse_Sniper_RifleBuy_Tag,
		WeaponTags.Impulse_Sniper_RifleBuy_2_Tag,
		WeaponTags.Impulse_Sniper_RifleBuy_3_Tag,
		WeaponTags.Needle_Throw_Tag,
		WeaponTags.Needle_Throw_2_Tag,
		WeaponTags.Solar_Ray_Tag,
		WeaponTags.Solar_Ray_2_Tag,
		WeaponTags.Solar_Ray_3_Tag,
		WeaponTags.HunterRifleTag,
		WeaponTags.WoodenBowTag,
		WeaponTags.MagicBowTag,
		WeaponTags.Bow_3_Tag,
		WeaponTags.SteelCrossbowTag,
		WeaponTags.CrossbowTag,
		WeaponTags.CrystalCrossbowTag,
		WeaponTags.svdTag,
		WeaponTags.svd_2Tag,
		WeaponTags.svd_3_Tag,
		WeaponTags.BarrettTag,
		WeaponTags.Barrett_2Tag,
		WeaponTags.barret_3_Tag,
		WeaponTags.Barret_4tag,
		WeaponTags.SnowballGun_Tag,
		WeaponTags.SnowballGun_2_Tag,
		WeaponTags.SnowballGun_3_Tag,
		WeaponTags.FlamethrowerTag,
		WeaponTags.Flamethrower_2Tag,
		WeaponTags.Flamethrower_3_Tag,
		WeaponTags.Flamethrower_4tag,
		WeaponTags.Flamethrower_5tag,
		WeaponTags.RailgunTag,
		WeaponTags.railgun_2_Tag,
		WeaponTags.railgun_3_Tag,
		WeaponTags.RazerTag,
		WeaponTags.Razer_2Tag,
		WeaponTags.Razer_3_Tag,
		WeaponTags.TeslaTag,
		WeaponTags.Tesla_2Tag,
		WeaponTags.tesla_3_Tag,
		WeaponTags.FreezeGunTag,
		WeaponTags.FreezeGun_2_Tag,
		WeaponTags.FreezeGun_3tag,
		WeaponTags.Sunrise_Tag,
		WeaponTags.ElectroBlastRifle_Tag,
		WeaponTags.ElectroBlastRifle_2_Tag,
		WeaponTags.LaserDiscThower_Tag,
		WeaponTags.LaserDiscThower_2_Tag,
		WeaponTags.TacticalBow_Tag,
		WeaponTags.TacticalBow_2_Tag,
		WeaponTags.TacticalBow_3_Tag,
		WeaponTags.SignalPistol_Tag,
		WeaponTags.BadCodeGun_Tag,
		WeaponTags.PumpkinGunRent_Tag,
		WeaponTags.DragonGunRent_Tag,
		WeaponTags.RayMinigunRent_Tag,
		WeaponTags.Autoaim_Rocketlauncher_Tag,
		WeaponTags.Autoaim_RocketlauncherBuy_Tag,
		WeaponTags.Autoaim_RocketlauncherBuy_2_Tag,
		WeaponTags.Autoaim_RocketlauncherBuy_3_Tag,
		WeaponTags.Solar_Power_Cannon_Tag,
		WeaponTags.Solar_Power_Cannon_2_Tag,
		WeaponTags.Solar_Power_Cannon_3tag,
		WeaponTags.GrenadeLuancherTag,
		WeaponTags.m79_2_Tag,
		WeaponTags.BazookaTag,
		WeaponTags.Bazooka_2Tag,
		WeaponTags.Bazooka_1_3_Tag,
		WeaponTags.GravigunTag,
		WeaponTags.gravity_2_Tag,
		WeaponTags.gravity_3_Tag,
		WeaponTags.GrenadeLuancher_2Tag,
		WeaponTags.m32_1_2_Tag,
		WeaponTags.grenade_launcher_3_Tag,
		WeaponTags.Bazooka_3Tag,
		WeaponTags.Bazooka_3_2_Tag,
		WeaponTags.Bazooka_3_3_Tag,
		WeaponTags.Bazooka_2_1_Tag,
		WeaponTags.buddy_Tag,
		WeaponTags.bigbuddy_2tag,
		WeaponTags.bigbuddy_3tag,
		WeaponTags.StaffTag,
		WeaponTags.Staff2Tag,
		WeaponTags.m79_3_Tag,
		WeaponTags.Staff_3_Tag,
		WeaponTags.Basscannon_Tag,
		WeaponTags.SnowballMachingun_Tag,
		WeaponTags.SnowballMachingun_2_Tag,
		WeaponTags.SnowballMachingun_3_Tag,
		WeaponTags.CherryGunTag,
		WeaponTags.Bazooka_2_3_Tag,
		WeaponTags.Bazooka_2_4tag,
		WeaponTags.PumpkinGun_1_Tag,
		WeaponTags.PumpkinGun_2_Tag,
		WeaponTags.DragonGun_Tag,
		WeaponTags.DragonGun_2_Tag,
		WeaponTags.RayMinigun_Tag,
		WeaponTags.Bastion_Tag,
		WeaponTags.Devostator_Tag,
		WeaponTags.Devostator_2_Tag,
		WeaponTags.Dark_Matter_Generator_Tag,
		WeaponTags.Dark_Matter_Generator_2_Tag,
		WeaponTags.Hydra_Tag,
		WeaponTags.Hydra_2_Tag,
		WeaponTags.Tesla_Cannon_Tag,
		WeaponTags.Tesla_Cannon_2_Tag,
		WeaponTags.Tesla_Cannon_3_Tag
	};

	public int Compare(object x, object y)
	{
		string tag = ((Weapon)x).weaponPrefab.tag;
		string tag2 = ((Weapon)y).weaponPrefab.tag;
		return Array.IndexOf(multiplayerWeaponsOrd, tag2).CompareTo(Array.IndexOf(multiplayerWeaponsOrd, tag));
	}
}
