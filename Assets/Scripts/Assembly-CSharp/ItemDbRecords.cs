using System.Collections.Generic;

public static class ItemDbRecords
{
	public static List<ItemRecord> GetRecords()
	{
		List<ItemRecord> list = new List<ItemRecord>(145);
		list.Add(new ItemRecord(1, "FirstPistol", null, "Weapon1", null, null, 0, false, false));
		list.Add(new ItemRecord(2, "FirstShotgun", null, "Weapon2", null, null, 0, false, false));
		list.Add(new ItemRecord(3, "UziWeapon", null, "Weapon3", null, null, 0, false, false));
		list.Add(new ItemRecord(4, "Revolver", null, "Weapon4", null, null, 0, false, false));
		list.Add(new ItemRecord(5, "Machingun", null, "Weapon5", null, null, 0, false, false));
		list.Add(new ItemRecord(6, "MinersWeapon", "MinerWeaponSett", "Weapon6", "MinerWeapon", "Miner Weapon", 35, true, false));
		list.Add(new ItemRecord(7, "CrystalSword", "SwordSett", "Weapon7", "crystalsword", "Crystal Sword", 185, true, false, "Coins", 93));
		list.Add(new ItemRecord(8, "AK47", null, "Weapon8", null, null, 0, false, false));
		list.Add(new ItemRecord(9, "Knife", null, "Weapon9", null, null, 0, false, false));
		list.Add(new ItemRecord(10, "m16", "CombatRifleSett", "Weapon10", "combatrifle", "Combat Rifle", 85, true, false));
		list.Add(new ItemRecord(11, "Eagle 1", "GoldenEagleSett", "Weapon11", "goldeneagle", "Golden Eagle", 85, true, false));
		list.Add(new ItemRecord(12, "Bow", "MagicBowSett", "Weapon12", "magicbow", "Magic Bow", 40, false, true));
		list.Add(new ItemRecord(13, "SPAS", "SPASSett", "Weapon13", "spas", "Mega Destroyer", 60, true, false));
		list.Add(new ItemRecord(14, "GoldenAxe", "GoldenAxeSett", "Weapon14", "axe", "Golden Axe", 85, true, false));
		list.Add(new ItemRecord(15, "Chainsaw", "ChainsawS", "Weapon15", "chainsaw", "Tiny Chainsaw", 100, true, true));
		list.Add(new ItemRecord(16, "FAMAS", "FAMASS", "Weapon16", "famas", "Elite Rifle", 120, true, false));
		list.Add(new ItemRecord(17, "Glock", "GlockSett", "Weapon17", "glock", "Fast Death", 50, true, false));
		list.Add(new ItemRecord(18, "Scythe", "ScytheSN", "Weapon18", "scythe", "Creeper's Scythe", 150, true, true));
		list.Add(new ItemRecord(19, "Shovel", "ShovelSN", "Weapon19", "shovel", "Battle Shovel", 30, true, false));
		list.Add(new ItemRecord(20, "Hammer", "HammerSN", "Weapon20", "hammer", "Big Pig Hammer", 85, true, false));
		list.Add(new ItemRecord(21, "Sword_2", "Sword_2_SN", "Weapon21", "sword_2", "Skeleton Sword", 255, true, true));
		list.Add(new ItemRecord(22, "Staff", "StaffSN", "Weapon22", "staff", "Wizard's Arsenal", 200, true, true));
		list.Add(new ItemRecord(23, "Red_Stone", "LaserRifleSN", "Weapon23", "laser", "Redstone Cannon", 340, true, true));
		list.Add(new ItemRecord(24, "LightSword", "LightSwordSN", "Weapon24", "lightsword", "Space Saber", 340, true, true));
		list.Add(new ItemRecord(25, "Beretta", "BerettaSN", "Weapon25", "beretta", "Killer Mushroom", 85, true, false));
		list.Add(new ItemRecord(26, "Mace", "MaceSN", "Weapon26", "mace", "Cactus Flail", 120, true, true));
		list.Add(new ItemRecord(27, "Crossbow", "CrossbowSN", "Weapon27", "crossbow", "Royal Crossbow", 120, true, false));
		list.Add(new ItemRecord(28, "Minigun", "MinigunSN", "Weapon28", "minigun", "Automatic Peacemaker", 300, true, true));
		list.Add(new ItemRecord(29, "GoldenPick", "GoldenPickSN", "Weapon29", "goldenPick", "Miner Weapon 2", 70, true, false));
		list.Add(new ItemRecord(30, "CrystalPick", "CrystakPickSN", "Weapon30", "crystalPick", "Miner Weapon 3", 85, true, false, "Coins", 50));
		list.Add(new ItemRecord(31, "IronSword", "IronSwordSN", "Weapon31", "ironSword", "Iron Sword 1", 70, true, false));
		list.Add(new ItemRecord(32, "GoldenSword", "GoldenSwordSN", "Weapon32", "goldenSword", "Iron Sword 2", 120, true, false));
		list.Add(new ItemRecord(33, "GoldenRed_Stone", "GoldenRed_StoneSN", "Weapon33", "goldenRedStone", "Redstone Cannon 2", 340, true, true));
		list.Add(new ItemRecord(34, "GoldenSPAS", "GoldenSPASSN", "Weapon34", "goldenSPAS", "Mega Destroyer 2", 30, true, false));
		list.Add(new ItemRecord(35, "GoldenGlock", "GoldenGlockSN", "Weapon35", "goldenGlock", "Fast Death 2", 70, true, false));
		list.Add(new ItemRecord(36, "RedMinigun", "RedMinigunSN", "Weapon36", "redMinigun", "Automatic Peacemaker 2", 300, true, true));
		list.Add(new ItemRecord(37, "CrystalCrossbow", "CrystalCrossbowSN", "Weapon37", "crystalCrossbow", "Royal Crossbow 2", 150, true, false, "Coins", 79));
		list.Add(new ItemRecord(38, "RedLightSaber", "RedLightSaberSN", "Weapon38", "redLightSaber", "Dark Force Saber", 140, true, true));
		list.Add(new ItemRecord(39, "SandFamas", "SandFamasSN", "Weapon39", "sandFamas", "Spec OPS Rifle", 150, true, false));
		list.Add(new ItemRecord(40, "WhiteBeretta", "WhiteBerettaSN", "Weapon40", "whiteBeretta", "Assassin Mushroom", 120, true, false));
		list.Add(new ItemRecord(41, "BlackEagle", "BlackEagleSN", "Weapon41", "blackEagle", "Black Python", 85, true, false));
		list.Add(new ItemRecord(42, "CrystalAxe", "CrystalAxeSN", "Weapon42", "crystalAxe", "Crystal Double Axe", 170, true, false, "Coins", 86));
		list.Add(new ItemRecord(43, "SteelAxe", "SteelAxeSN", "Weapon43", "steelAxe", "Steel Axe", 50, true, false));
		list.Add(new ItemRecord(44, "WoodenBow", "WoodenBowSN", "Weapon44", "woodenBow", "Wooden Bow", 100, true, false));
		list.Add(new ItemRecord(45, "Chainsaw 2", "Chainsaw2SN", "Weapon45", "chainsaw2", "Laser Chainsaw", 100, true, false));
		list.Add(new ItemRecord(46, "SteelCrossbow", "SteelCrossbowSN", "Weapon46", "steelCrossbow", "Steel Crossbow", 120, true, false));
		list.Add(new ItemRecord(47, "Hammer 2", "Hammer2SN", "Weapon47", "hammer2", "Pigman Hammer", 150, true, false));
		list.Add(new ItemRecord(48, "Mace 2", "Mace2SN", "Weapon48", "mace2", "Lava Flail", 120, true, false));
		list.Add(new ItemRecord(49, "Sword_2 2", "Sword_22SN", "Weapon49", "sword_22", "Fire Demon", 255, true, true));
		list.Add(new ItemRecord(50, "Staff 2", "Staff2SN", "Weapon50", "staff2", "Archimage Dragon Wand", 200, true, false));
		list.Add(new ItemRecord(51, "DoubleShotgun", null, "Weapon51", null, null, 0, false, false));
		list.Add(new ItemRecord(52, "AlienGun", null, "Weapon52", null, null, 0, false, false));
		list.Add(new ItemRecord(53, "m16_2", null, "Weapon53", null, null, 0, false, false));
		list.Add(new ItemRecord(54, "CrystalGlock", "CrystalGlockSN", "Weapon54", "crystalGlock", "Fast Death 3", 135, true, false, "Coins", 65));
		list.Add(new ItemRecord(55, "CrystalSPAS", "CrystalSPASSN", "Weapon55", "crystalSPAS", "Mega Destroyer 3", 45, true, false));
		list.Add(new ItemRecord(56, "Tree", "TreeSN", "Weapon56", "tree", "Christmas Sword", 75, true, false));
		list.Add(new ItemRecord(57, "Fire_Axe", "FireAxeSN", "Weapon57", "fireAxe", "Happy Tree Slayer", 135, true, false));
		list.Add(new ItemRecord(58, "3pl_Shotgun", "_3PLShotgunSN", "Weapon58", "_3plShotgun", "Deadly ??andy", 135, true, true));
		list.Add(new ItemRecord(59, "Revolver2", "Revolver2SN", "Weapon59", "revolver2", "Powerful Gift", 255, true, true));
		list.Add(new ItemRecord(60, "Barrett50Cal", "BarrettSN", "Weapon60", "barrett", "Brutal Headhunter", 150, true, true));
		list.Add(new ItemRecord(61, "SVD", "SVDSN", "Weapon61", "svd", "Guerilla Rifle", 135, true, false));
		list.Add(new ItemRecord(62, "NavyFamas", "NavyFamasSN", "Weapon62", "navyFamas", "SWAT Rifle", 220, true, false, "Coins", 109));
		list.Add(new ItemRecord(63, "SVD_2", "SVD_2SN", "Weapon63", "svd_2", "Guerilla Rifle M2", 135, true, false));
		list.Add(new ItemRecord(64, "Eagle_3", "Eagle_3SN", "Weapon64", "eagle3", "Deadly Viper", 150, true, false, "Coins", 78));
		list.Add(new ItemRecord(65, "Barrett_2", "Barrett2SN", "Weapon65", "barrett_2", "Ultimate Headhunter", 150, true, false));
		list.Add(new ItemRecord(66, "Uzi2", null, "Weapon66", null, null, 0, false, false));
		list.Add(new ItemRecord(67, "Hunter_Rifle", null, "Weapon67", null, null, 0, false, false));
		list.Add(new ItemRecord(68, "Scythe_2", "Scythe_2_SN", "Weapon68", "scythe2", "Laser Scythe", 150, true, true));
		list.Add(new ItemRecord(69, "m16_3", "m_16_3_Sett", "Weapon69", "m16_3", "Combat Rifle M2", 100, true, false));
		list.Add(new ItemRecord(70, "m16_4", "m_16_4_Sett", "Weapon70", "m16_4", "Combat Rifle M3", 150, true, false, "Coins", 80));
		list.Add(new ItemRecord(71, "BlackBeretta", "Beretta_2_SN", "Weapon71", "beretta2", "Amanita", 200, true, false, "Coins", 97));
		list.Add(new ItemRecord(72, "Tree_2", "Tree_2_SN", "Weapon72", "tree2", "Cactus Sword", 35, true, false));
		list.Add(new ItemRecord(73, "Flamethrower", "FlameThrowerSN", "Weapon73", "flamethrower", "Total Exterminator", 170, true, true));
		list.Add(new ItemRecord(74, "Flamethrower_2", "FlameThrower_2SN", "Weapon74", "flamethrower_2", "Doomsda Flamethrower", 170, true, true));
		list.Add(new ItemRecord(75, "Bazooka", "BazookaSN", "Weapon75", "bazooka", "Apocalypse 3000", 150, true, false));
		list.Add(new ItemRecord(76, "Bazooka_2", "Bazooka_2SN", "Weapon76", "bazooka_2", "Nuclear Launcher", 150, true, false));
		list.Add(new ItemRecord(77, "railgun", "RailgunSN", "Weapon77", "railgun", "Prototype PSR-1", 320, true, false));
		list.Add(new ItemRecord(78, "tesla", "TeslaSN", "Weapon78", "tesla", "Tesla Generator", 270, true, false));
		list.Add(new ItemRecord(79, "grenade_launcher", "GrenadeLnchSN", "Weapon79", "greandeLauncher", "Grenade Launcher", 135, true, false));
		list.Add(new ItemRecord(80, "grenade_launcher2", "GrenadeLnch_2SN", "Weapon80", "greandeLauncher_2", "Firestorm G2", 200, true, false));
		list.Add(new ItemRecord(81, "tesla_2", "Tesla_2SN", "Weapon81", "tesla_2", "Chain Thunderbolt", 200, true, false));
		list.Add(new ItemRecord(82, "Bazooka_3", "Bazooka_3SN", "Weapon82", "bazooka_3", "Armageddon", 340, true, false));
		list.Add(new ItemRecord(83, "GravityGun", "GravigunSN", "Weapon83", "gravigun", "Gravity Gun", 170, true, false));
		list.Add(new ItemRecord(84, "AUG", "AUGSett", "Weapon84", "aug", "Marksman M1", 185, true, false));
		list.Add(new ItemRecord(85, "AUG_2", "AUG_2SN", "Weapon85", "aug_2", "Marksman M2", 170, true, false));
		list.Add(new ItemRecord(86, "Razer", "RazerSN", "Weapon86", "razer", "Razor1", 200, true, true));
		list.Add(new ItemRecord(87, "Razer_2", "Razer_2SN", "Weapon87", "razer_2", "Razor2", 200, true, true));
		list.Add(new ItemRecord(88, "katana", "katana_SN", "Weapon88", "katana", "katana", 185, true, true));
		list.Add(new ItemRecord(89, "katana_2", "katana_2_SN", "Weapon89", "katana_2", "katana 2", 185, true, true));
		list.Add(new ItemRecord(90, "katana_3", "katana_3_SN", "Weapon90", "katana_3", "katana 3", 185, true, false));
		list.Add(new ItemRecord(91, "plazma", "plazmaSN", "Weapon91", "plazma", " Plasma Rifle PZ-1", 155, true, true));
		list.Add(new ItemRecord(92, "plazma_pistol", "plazma_pistol_SN", "Weapon92", "plazma_pistol", " Plasma Pistol PZ-1", 100, true, true));
		list.Add(new ItemRecord(93, "flowerpower", "FlowePowerSN", "Weapon93", "flower_power", "FlowerPower", 135, true, true));
		list.Add(new ItemRecord(94, "bigbuddy", "BuddySN", "Weapon94", "buddy", "BigBuddy", 185, true, false));
		list.Add(new ItemRecord(95, "Mauser", "MauserSN", "Weapon95", "mauser", "Old Comrade", 120, true, false));
		list.Add(new ItemRecord(96, "Shmaiser", "ShmaiserSN", "Weapon96", "shmaiser", "Eindringling", 200, true, false));
		list.Add(new ItemRecord(97, "Tompson", "ThompsonSN", "Weapon97", "thompson", "Brave Patriot", 170, true, false));
		list.Add(new ItemRecord(98, "Tompson_2", "Thompson_2SN", "Weapon98", "thompson_2", "State Defender", 235, true, false));
		list.Add(new ItemRecord(99, "basscannon", "BassCannonSN", "Weapon99", "basscannon", "Basscannon", 255, true, false));
		list.Add(new ItemRecord(100, "SparklyBlaster", "SparklyBlasterSN", "Weapon100", "sparklyBlaster", "Sparkly Blaster", 120, true, false));
		list.Add(new ItemRecord(101, "CherryGun", "CherryGunSN", "Weapon101", "cherry", "Cherru BOMB", 270, true, false));
		list.Add(new ItemRecord(102, "AK74", "AK74_SN", "Weapon102", "ak74", "AK74 1", 100, true, false));
		list.Add(new ItemRecord(103, "AK74_2", "AK74_2_SN", "Weapon103", "ak74_2", "AK74 2", 120, true, false));
		list.Add(new ItemRecord(104, "AK74_3", "AK74_3_SN", "Weapon104", "ak74_3", "AK74 3", 170, true, false, "Coins", 59));
		list.Add(new ItemRecord(105, "FreezeGun", "FreezeGun_SN", "Weapon105", "freeze", "FreezeGun", 340, true, false, "Coins", 175));
		list.Add(new ItemRecord(106, "3pl_Shotgun_2", "_3_shotgun_2", "Weapon107", "_3_shotgun_2", null, 135, true, true));
		list.Add(new ItemRecord(107, "3pl_Shotgun_3", "_3_shotgun_3", "Weapon108", "_3_shotgun_3", null, 135, true, false));
		list.Add(new ItemRecord(108, "flowerpower_2", "flower_2", "Weapon109", "flower_2", null, 135, true, true));
		list.Add(new ItemRecord(109, "flowerpower_3", "flower_3", "Weapon110", "flower_3", null, 135, true, false));
		list.Add(new ItemRecord(110, "GravityGun_2", "gravity_2", "Weapon111", "gravity_2", null, 170, true, false));
		list.Add(new ItemRecord(111, "GravityGun_3", "gravity_3", "Weapon112", "gravity_3", null, 250, true, false, "Coins", 119));
		list.Add(new ItemRecord(112, "grenade_launcher3", "grenade_launcher_3", "Weapon113", "grenade_launcher_3", null, 235, true, false));
		list.Add(new ItemRecord(113, "Revolver3", "revolver_2_2", "Weapon114", "revolver_2_2", null, 255, true, true));
		list.Add(new ItemRecord(114, "Revolver4", "revolver_2_3", "Weapon115", "revolver_2_3", null, 255, true, false));
		list.Add(new ItemRecord(115, "Scythe_3", "scythe_3", "Weapon116", "scythe_3", null, 150, true, false));
		list.Add(new ItemRecord(116, "plazma_2", "plazma_2", "Weapon117", "plazma_2", null, 155, true, true));
		list.Add(new ItemRecord(117, "plazma_3", "plazma_3", "Weapon118", "plazma_3", null, 155, true, false));
		list.Add(new ItemRecord(118, "plazma_pistol_2", "plazma_pistol_2", "Weapon119", "plazma_pistol_2", null, 105, true, false));
		list.Add(new ItemRecord(119, "plazma_pistol_3", "plazma_pistol_3", "Weapon120", "plazma_pistol_3", null, 150, true, false));
		list.Add(new ItemRecord(120, "railgun_2", "railgun_2", "Weapon121", "railgun_2", null, 220, true, false));
		list.Add(new ItemRecord(121, "railgun_3", "railgun_3", "Weapon122", "railgun_3", null, 145, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(122, "Razer_3", "Razer_3", "Weapon123", "Razer_3", null, 200, true, false));
		list.Add(new ItemRecord(123, "tesla_3", "tesla_3", "Weapon124", "tesla_3", null, 139, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(124, "Flamethrower_3", "Flamethrower_3", "Weapon125", "Flamethrower_3", null, 170, true, false));
		list.Add(new ItemRecord(125, "FreezeGun_0", "FreezeGun_0", "Weapon126", "FreezeGun_0", null, 340, true, false, "Coins", 171));
		list.Add(new ItemRecord(126, "Minigun_3", "minigun_3", "Weapon127", "minigun_3", null, 300, true, false));
		list.Add(new ItemRecord(127, "SVD_3", "svd_3", "Weapon128", "svd_3", null, 170, true, false, "Coins", 85));
		list.Add(new ItemRecord(128, "Barret_3", "barret_3", "Weapon129", "barret_3", "barret_3", 220, true, false));
		list.Add(new ItemRecord(129, "LightSword_3", "LightSword_3", "Weapon130", "LightSword_3", null, 340, true, false, "Coins", 145));
		list.Add(new ItemRecord(130, "Sword_2_3", "Sword_2_3", "Weapon131", "Sword_2_3", null, 255, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(131, "Staff 3", "Staff 3", "Weapon132", "Staff 3", null, 235, true, false));
		list.Add(new ItemRecord(132, "DragonGun", "DragonGun", "Weapon133", "DragonGun", null, 425, true, false, "Coins", 211));
		list.Add(new ItemRecord(133, "Bow_3", "Bow_3", "Weapon134", "Bow_3", null, 185, true, false));
		list.Add(new ItemRecord(134, "Bazooka_1_3", "Bazooka_1_3", "Weapon135", "Bazooka_1_3", null, 185, true, false, "Coins", 93));
		list.Add(new ItemRecord(135, "Bazooka_2_1", "Bazooka_2_1", "Weapon136", "Bazooka_2_1", null, 285, true, true));
		list.Add(new ItemRecord(136, "Bazooka_2_3", "Bazooka_2_3", "Weapon137", "Bazooka_2_3", null, 285, true, false));
		list.Add(new ItemRecord(137, "m79_2", "m79_2", "Weapon138", "m79_2", null, 220, true, true));
		list.Add(new ItemRecord(138, "m79_3", "m79_3", "Weapon139", "m79_3", null, 220, true, false));
		list.Add(new ItemRecord(139, "m32_1_2", "m32_1_2", "Weapon140", "m32_1_2", null, 255, true, false, "Coins", 127));
		list.Add(new ItemRecord(140, "Red_Stone_3", "Red_Stone_3", "Weapon141", "Red_Stone_3", "RedStone3", 340, true, false, "Coins", 168, true));
		list.Add(new ItemRecord(141, "XM8_1", "XM8_1", "Weapon142", "XM8_1", "XM8_1", 295, true, false));
		list.Add(new ItemRecord(142, "PumpkinGun_1", "PumpkinGun_1", "Weapon143", "PumpkinGun_1", "PumpkinGun_1", 340, true, false, "Coins", 175));
		list.Add(new ItemRecord(143, "XM8_2", "XM8_2", "Weapon144", "XM8_2", "XM8_2", 170, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(144, "XM8_3", "XM8_3", "Weapon145", "XM8_3", "XM8_3", 131, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(145, "PumpkinGun_2", "PumpkinGun_2", "Weapon147", "PumpkinGun_2", "PumpkinGun_2", 315, true, false, "Coins", 153, true));
		list.Add(new ItemRecord(146, "Red_Stone_4", "Red_Stone_4", "Weapon148", "Red_Stone_4", "Red_Stone_4", 205, true, false, "Coins", 100, true));
		list.Add(new ItemRecord(147, "Minigun_4", "Minigun_4", "Weapon149", "Minigun_4", "Minigun_4", 160, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(148, "Revolver5", "Revolver5", "Weapon150", "Revolver5", "Revolver5", 150, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(149, "FreezeGun_0_2", "FreezeGun_0_2", "Weapon151", "FreezeGun_0_2", "FreezeGun_0_2", 83, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(150, "Revolver6", "Revolver6", "Weapon152", "Revolver6", "Revolver6", 100, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(151, "Sword_2_4", "Sword_2_4", "Weapon153", "Sword_2_4", "Sword_2_4", 120, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(152, "LightSword_4", "LightSword_4", "Weapon154", "LightSword_4", "LightSword_4", 205, true, false, "Coins", 102, true));
		list.Add(new ItemRecord(153, "Sword_2_5", "Sword_2_5", "Weapon155", "Sword_2_5", "Sword_2_5", 127, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(154, "FreezeGun_2", "FreezeGun_2", "Weapon156", "FreezeGun_2", "FreezeGun_2", 190, true, false, "Coins", 95, true));
		list.Add(new ItemRecord(155, "Bazooka_3_2", "Bazooka_3_2", "Weapon157", "Bazooka_3_2", "Bazooka_3_2", 190, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(156, "Bazooka_3_3", "Bazooka_3_3", "Weapon158", "Bazooka_3_3", "Bazooka_3_3", 144, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(157, "Minigun_5", "Minigun_5", "Weapon159", "Minigun_5", "Minigun_5", 112, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(158, "TwoBolters", "TwoBolters", "Weapon160", "TwoBolters", "TwoBolters", 141, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(159, "RayMinigun", "RayMinigun", "Weapon161", "RayMinigun", "RayMinigun", 297, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(160, "SignalPistol", null, "Weapon162", null, null, 0, false, false));
		list.Add(new ItemRecord(161, "AutoShotgun", "AutoShotgun", "Weapon163", "AutoShotgun", "AutoShotgun", 320, true, false, "Coins", 158));
		list.Add(new ItemRecord(162, "TwoRevolvers", "TwoRevolvers", "Weapon164", "TwoRevolvers", "TwoRevolvers", 220, true, false, "Coins", 109));
		list.Add(new ItemRecord(163, "SnowballGun", "SnowballGun", "Weapon165", "SnowballGun", "SnowballGun", 170, true, false));
		list.Add(new ItemRecord(164, "SnowballMachingun", "SnowballMachingun", "Weapon166", "SnowballMachingun", "SnowballMachingun", 177, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(165, "HeavyShotgun", "HeavyShotgun", "Weapon167", "HeavyShotgun", "HeavyShotgun", 153, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(166, "SnowballMachingun_2", "SnowballMachingun_2", "Weapon168", "SnowballMachingun_2", "SnowballMachingun_2", 97, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(167, "SnowballMachingun_3", "SnowballMachingun_3", "Weapon169", "SnowballMachingun_3", "SnowballMachingun_3", 159, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(168, "SnowballGun_2", "SnowballGun_2", "Weapon170", "SnowballGun_2", "SnowballGun_2", 100, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(169, "SnowballGun_3", "SnowballGun_3", "Weapon171", "SnowballGun_3", "SnowballGun_3", 102, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(170, "HeavyShotgun_2", "HeavyShotgun_2", "Weapon172", "HeavyShotgun_2", "HeavyShotgun_2", 85, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(171, "HeavyShotgun_3", "HeavyShotgun_3", "Weapon173", "HeavyShotgun_3", "HeavyShotgun_3", 115, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(172, "TwoBolters_2", "TwoBolters_2", "Weapon174", "TwoBolters_2", "TwoBolters_2", 69, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(173, "TwoBolters_3", "TwoBolters_3", "Weapon175", "TwoBolters_3", "TwoBolters_3", 112, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(174, "TwoRevolvers_2", "TwoRevolvers_2", "Weapon176", "TwoRevolvers_2", "TwoRevolvers_2", 76, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(175, "AutoShotgun_2", "AutoShotgun_2", "Weapon177", "AutoShotgun_2", "AutoShotgun_2", 92, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(176, "Solar_Ray", "Solar_Ray", "Weapon178", "Solar_Ray", "Solar_Ray", 169, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(177, "Water_Pistol", "Water_Pistol", "Weapon179", "Water_Pistol", "Water_Pistol", 120, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(178, "Solar_Power_Cannon", "Solar_Power_Cannon", "Weapon180", "Solar_Power_Cannon", "Solar_Power_Cannon", 169, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(179, "Water_Rifle", "Water_Rifle", "Weapon181", "Water_Rifle", "Water_Rifle", 272, true, false));
		list.Add(new ItemRecord(180, "Water_Rifle_2", "Water_Rifle_2", "Weapon182", "Water_Rifle_2", "Water_Rifle_2", 153, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(181, "Water_Rifle_3", "Water_Rifle_3", "Weapon183", "Water_Rifle_3", "Water_Rifle_3", 110, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(182, "Water_Pistol_2", "Water_Pistol_2", "Weapon184", "Water_Pistol_2", "Water_Pistol_2", 85, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(183, "Solar_Power_Cannon_2", "Solar_Power_Cannon_2", "Weapon185", "Solar_Power_Cannon_2", "Solar_Power_Cannon_2", 90, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(184, "Solar_Ray_2", "Solar_Ray_2", "Weapon186", "Solar_Ray_2", "Solar_Ray_2", 89, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(185, "Solar_Ray_3", "Solar_Ray_3", "Weapon187", "Solar_Ray_3", "Solar_Ray_3", 153, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(186, "Needle_Throw", "Needle_Throw", "Weapon188", "Needle_Throw", "Needle_Throw", 163, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(187, "Valentine_Shotgun", "Valentine_Shotgun", "Weapon189", "Valentine_Shotgun", "Valentine_Shotgun", 255, true, false));
		list.Add(new ItemRecord(188, "Valentine_Shotgun_2", "Valentine_Shotgun_2", "Weapon190", "Valentine_Shotgun_2", "Valentine_Shotgun_2", 153, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(189, "Valentine_Shotgun_3", "Valentine_Shotgun_3", "Weapon191", "Valentine_Shotgun_3", "Valentine_Shotgun_3", 99, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(190, "Needle_Throw_2", "Needle_Throw_2", "Weapon192", "Needle_Throw_2", "Needle_Throw_2", 90, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(191, "RailRevolver_1", null, "Weapon193", "RailRevolver_1", "RailRevolver_1", 5, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(192, "Assault_Machine_Gun", null, "Weapon194", "Assault_Machine_Gun", "Assault_Machine_Gun", 5, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(193, "Impulse_Sniper_Rifle", null, "Weapon195", "Impulse_Sniper_Rifle", "Impulse_Sniper_Rifle", 6, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(194, "Autoaim_Rocketlauncher", null, "Weapon196", "Autoaim_Rocketlauncher", "Autoaim_Rocketlauncher", 8, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(195, "Carrot_Sword", "Carrot_Sword", "Weapon197", "Carrot_Sword", "Carrot_Sword", 221, true, false));
		list.Add(new ItemRecord(199, "Carrot_Sword_2", "Carrot_Sword_2", "Weapon201", "Carrot_Sword_2", "Carrot_Sword_2", 102, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(200, "Carrot_Sword_3", "Carrot_Sword_3", "Weapon202", "Carrot_Sword_3", "Carrot_Sword_3", 119, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(201, "RailRevolverBuy", "RailRevolverBuy", "Weapon203", "RailRevolverBuy", "RailRevolverBuy", true, false, new List<ItemPrice>
		{
			new ItemPrice(177, "GemsCurrency"),
			new ItemPrice(177, "GemsCurrency"),
			new ItemPrice(177, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(202, "RailRevolverBuy_2", "RailRevolverBuy_2", "Weapon204", "RailRevolverBuy_2", "RailRevolverBuy_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(85, "GemsCurrency"),
			new ItemPrice(197, "GemsCurrency"),
			new ItemPrice(177, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(203, "RailRevolverBuy_3", "RailRevolverBuy_3", "Weapon205", "RailRevolverBuy_3", "RailRevolverBuy_3", true, false, new List<ItemPrice>
		{
			new ItemPrice(128, "GemsCurrency"),
			new ItemPrice(128, "GemsCurrency"),
			new ItemPrice(234, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(204, "Assault_Machine_GunBuy", "Assault_Machine_GunBuy", "Weapon206", "Assault_Machine_GunBuy", "Assault_Machine_GunBuy", true, false, new List<ItemPrice>
		{
			new ItemPrice(189, "GemsCurrency"),
			new ItemPrice(189, "GemsCurrency"),
			new ItemPrice(189, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(205, "Assault_Machine_GunBuy_2", "Assault_Machine_GunBuy_2", "Weapon207", "Assault_Machine_GunBuy_2", "Assault_Machine_GunBuy_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(95, "GemsCurrency"),
			new ItemPrice(213, "GemsCurrency"),
			new ItemPrice(189, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(206, "Assault_Machine_GunBuy_3", "Assault_Machine_GunBuy_3", "Weapon208", "Assault_Machine_GunBuy_3", "Assault_Machine_GunBuy_3", true, false, new List<ItemPrice>
		{
			new ItemPrice(139, "GemsCurrency"),
			new ItemPrice(139, "GemsCurrency"),
			new ItemPrice(254, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(207, "Impulse_Sniper_RifleBuy", "Impulse_Sniper_RifleBuy", "Weapon209", "Impulse_Sniper_RifleBuy", "Impulse_Sniper_RifleBuy", true, false, new List<ItemPrice>
		{
			new ItemPrice(183, "GemsCurrency"),
			new ItemPrice(183, "GemsCurrency"),
			new ItemPrice(183, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(208, "Impulse_Sniper_RifleBuy_2", "Impulse_Sniper_RifleBuy_2", "Weapon210", "Impulse_Sniper_RifleBuy_2", "Impulse_Sniper_RifleBuy_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(125, "GemsCurrency"),
			new ItemPrice(231, "GemsCurrency"),
			new ItemPrice(183, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(209, "Impulse_Sniper_RifleBuy_3", "Impulse_Sniper_RifleBuy_3", "Weapon211", "Impulse_Sniper_RifleBuy_3", "Impulse_Sniper_RifleBuy_3", true, false, new List<ItemPrice>
		{
			new ItemPrice(149, "GemsCurrency"),
			new ItemPrice(149, "GemsCurrency"),
			new ItemPrice(274, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(210, "Autoaim_RocketlauncherBuy", "Autoaim_RocketlauncherBuy", "Weapon212", "Autoaim_RocketlauncherBuy", "Autoaim_RocketlauncherBuy", true, false, new List<ItemPrice>
		{
			new ItemPrice(215, "GemsCurrency"),
			new ItemPrice(215, "GemsCurrency"),
			new ItemPrice(215, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(211, "Autoaim_RocketlauncherBuy_2", "Autoaim_RocketlauncherBuy_2", "Weapon213", "Autoaim_RocketlauncherBuy_2", "Autoaim_RocketlauncherBuy_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(112, "GemsCurrency"),
			new ItemPrice(245, "GemsCurrency"),
			new ItemPrice(215, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(212, "Autoaim_RocketlauncherBuy_3", "Autoaim_RocketlauncherBuy_3", "Weapon214", "Autoaim_RocketlauncherBuy_3", "Autoaim_RocketlauncherBuy_3", true, false, new List<ItemPrice>
		{
			new ItemPrice(222, "GemsCurrency"),
			new ItemPrice(222, "GemsCurrency"),
			new ItemPrice(329, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(213, "TwoBoltersRent", null, "Weapon215", "TwoBoltersRent", "TwoBoltersRent", 6, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(214, "Red_StoneRent", null, "Weapon216", "Red_StoneRent", "Red_StoneRent", 6, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(215, "DragonGunRent", null, "Weapon217", "DragonGunRent", "DragonGunRent", 6, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(216, "PumpkinGunRent", null, "Weapon218", "PumpkinGunRent", "PumpkinGunRent", 6, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(217, "RayMinigunRent", null, "Weapon219", "RayMinigunRent", "RayMinigunRent", 6, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(218, "PX-3000", "PX-3000", "Weapon220", "PX-3000", "PX-3000", 289, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(219, "Sunrise", "Sunrise", "Weapon221", "Sunrise", "Sunrise", 295, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(220, "Bastion", "Bastion", "Weapon222", "Bastion", "Bastion", 310, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(221, "SteamPower_2", "SteamPower_2", "Weapon225", "SteamPower_2", "SteamPower_2", 85, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(222, "SteamPower_3", "SteamPower_3", "Weapon226", "SteamPower_3", "SteamPower_3", 85, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(223, "PlasmaRifle_2", "PlasmaRifle_2", "Weapon227", "PlasmaRifle_2", "PlasmaRifle_2", 102, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(224, "PlasmaRifle_3", "PlasmaRifle_3", "Weapon228", "PlasmaRifle_3", "PlasmaRifle_3", 99, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(225, "StateDefender_2", "StateDefender_2", "Weapon229", "StateDefender_2", "StateDefender_2", 170, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(226, "AUG_3", "AUG_3", "Weapon230", "AUG_3", "AUG_3", 109, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(227, "AutoShotgun_3", "AutoShotgun_3", "Weapon231", "AutoShotgun_3", "AutoShotgun_3", 142, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(228, "Red_Stone_5", "Red_Stone_5", "Weapon232", "Red_Stone_5", "Red_Stone_5", 149, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(229, "SparklyBlaster_2", "SparklyBlaster_2", "Weapon233", "SparklyBlaster_2", "SparklyBlaster_2", 85, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(230, "SparklyBlaster_3", "SparklyBlaster_3", "Weapon234", "SparklyBlaster_3", "SparklyBlaster_3", 85, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(231, "TwoRevolvers_3", "TwoRevolvers_3", "Weapon235", "TwoRevolvers_3", "TwoRevolvers_3", 125, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(232, "Water_Pistol_3", "Water_Pistol_3", "Weapon236", "Water_Pistol_3", "Water_Pistol_3", 133, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(233, "katana_4", "katana_4", "Weapon237", "katana_4", "katana_4", 102, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(234, "LightSword_5", "LightSword_5", "Weapon238", "LightSword_5", "LightSword_5", 120, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(235, "Flamethrower_4", "Flamethrower_4", "Weapon239", "Flamethrower_4", "Flamethrower_4", 102, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(236, "Flamethrower_5", "Flamethrower_5", "Weapon240", "Flamethrower_5", "Flamethrower_5", 100, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(237, "Barret_4", "Barret_4", "Weapon241", "Barret_4", "Barret_4", 153, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(239, "FreezeGun_3", "FreezeGun_3", "Weapon243", "FreezeGun_3", "FreezeGun_3", 135, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(240, "bigbuddy_2", "bigbuddy_2", "Weapon244", "bigbuddy_2", "bigbuddy_2", 85, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(241, "bigbuddy_3", "bigbuddy_3", "Weapon245", "bigbuddy_3", "bigbuddy_3", 96, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(243, "Bazooka_2_4", "Bazooka_2_4", "Weapon247", "Bazooka_2_4", "Bazooka_2_4", 204, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(244, "Solar_Power_Cannon_3", "Solar_Power_Cannon_3", "Weapon248", "Solar_Power_Cannon_3", "Solar_Power_Cannon_3", 151, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(246, "StormHammer", "StormHammer", "Weapon224", "StormHammer", "StormHammer", 999, true, false, "Coins", -1, true));
		list.Add(new ItemRecord(247, "DualHawks", "DualHawks", "Weapon223", "DualHawks", "DualHawks", 285, true, false, "GemsCurrency"));
		list.Add(new ItemRecord(248, "DragonGun_2", "DragonGun_2", "Weapon249", "DragonGun_2", "DragonGun_2", 138, true, false, "GemsCurrency", -1, true));
		list.Add(new ItemRecord(249, "Badcode_gun", null, "Weapon250", null, null, 0, false, false));
		list.Add(new ItemRecord(258, "DualUzi", "DualUzi", "Weapon259", "DualUzi", "DualUzi", true, false, new List<ItemPrice>
		{
			new ItemPrice(255, "Coins"),
			new ItemPrice(149, "Coins"),
			new ItemPrice(274, "Coins")
		}, true));
		list.Add(new ItemRecord(262, "DualUzi_2", "DualUzi_2", "Weapon263", "DualUzi_2", "DualUzi_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(153, "Coins"),
			new ItemPrice(306, "Coins"),
			new ItemPrice(274, "Coins")
		}, true));
		list.Add(new ItemRecord(263, "DualUzi_3", "DualUzi_3", "Weapon264", "DualUzi_3", "DualUzi_3", true, false, new List<ItemPrice>
		{
			new ItemPrice(99, "GemsCurrency"),
			new ItemPrice(99, "GemsCurrency"),
			new ItemPrice(255, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(251, "PlasmaShotgun", "PlasmaShotgun", "Weapon252", "PlasmaShotgun", "PlasmaShotgun", true, false, new List<ItemPrice>
		{
			new ItemPrice(170, "Coins"),
			new ItemPrice(99, "Coins"),
			new ItemPrice(255, "Coins")
		}, true));
		list.Add(new ItemRecord(264, "PlasmaShotgun_2", "PlasmaShotgun_2", "Weapon265", "PlasmaShotgun_2", "PlasmaShotgun_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(110, "Coins"),
			new ItemPrice(210, "Coins"),
			new ItemPrice(255, "Coins")
		}, true));
		list.Add(new ItemRecord(257, "RapidFireRifle", "RapidFireRifle", "Weapon258", "RapidFireRifle", "RapidFireRifle", true, false, new List<ItemPrice>
		{
			new ItemPrice(204, "Coins"),
			new ItemPrice(99, "Coins"),
			new ItemPrice(255, "Coins")
		}, true));
		list.Add(new ItemRecord(265, "RapidFireRifle_2", "RapidFireRifle_2", "Weapon266", "RapidFireRifle_2", "RapidFireRifle_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(120, "Coins"),
			new ItemPrice(240, "Coins"),
			new ItemPrice(255, "Coins")
		}, true));
		list.Add(new ItemRecord(256, "FutureRifle", "FutureRifle", "Weapon257", "FutureRifle", "FutureRifle", true, false, new List<ItemPrice>
		{
			new ItemPrice(235, "Coins"),
			new ItemPrice(99, "Coins"),
			new ItemPrice(255, "Coins")
		}, true));
		list.Add(new ItemRecord(276, "FutureRifle_2", "FutureRifle_2", "Weapon277", "FutureRifle_2", "FutureRifle_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(170, "Coins"),
			new ItemPrice(305, "Coins"),
			new ItemPrice(255, "Coins")
		}, true));
		list.Add(new ItemRecord(261, "Photon_Pistol", "Photon_Pistol", "Weapon262", "Photon_Pistol", "Photon_Pistol", true, false, new List<ItemPrice>
		{
			new ItemPrice(205, "Coins"),
			new ItemPrice(99, "Coins"),
			new ItemPrice(255, "Coins")
		}, true));
		list.Add(new ItemRecord(266, "Photon_Pistol_2", "Photon_Pistol_2", "Weapon267", "Photon_Pistol_2", "Photon_Pistol_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(140, "Coins"),
			new ItemPrice(270, "Coins"),
			new ItemPrice(255, "Coins")
		}, true));
		list.Add(new ItemRecord(255, "TacticalBow", "TacticalBow", "Weapon256", "TacticalBow", "TacticalBow", true, false, new List<ItemPrice>
		{
			new ItemPrice(170, "Coins"),
			new ItemPrice(99, "Coins"),
			new ItemPrice(255, "Coins")
		}, true));
		list.Add(new ItemRecord(267, "TacticalBow_2", "TacticalBow_2", "Weapon268", "TacticalBow_2", "TacticalBow_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(140, "Coins"),
			new ItemPrice(235, "Coins"),
			new ItemPrice(255, "Coins")
		}, true));
		list.Add(new ItemRecord(268, "TacticalBow_3", "TacticalBow_3", "Weapon269", "TacticalBow_3", "TacticalBow_3", true, false, new List<ItemPrice>
		{
			new ItemPrice(150, "GemsCurrency"),
			new ItemPrice(150, "GemsCurrency"),
			new ItemPrice(265, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(259, "LaserDiscThower", "LaserDiscThower", "Weapon260", "LaserDiscThower", "LaserDiscThower", true, false, new List<ItemPrice>
		{
			new ItemPrice(200, "Coins"),
			new ItemPrice(150, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(269, "LaserDiscThower_2", "LaserDiscThower_2", "Weapon270", "LaserDiscThower_2", "LaserDiscThower_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(140, "Coins"),
			new ItemPrice(255, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(250, "ElectroBlastRifle", "ElectroBlastRifle", "Weapon251", "ElectroBlastRifle", "ElectroBlastRifle", true, false, new List<ItemPrice>
		{
			new ItemPrice(220, "Coins"),
			new ItemPrice(150, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(270, "ElectroBlastRifle_2", "ElectroBlastRifle_2", "Weapon271", "ElectroBlastRifle_2", "ElectroBlastRifle_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(153, "Coins"),
			new ItemPrice(280, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(260, "Tesla_Cannon", "Tesla_Cannon", "Weapon261", "Tesla_Cannon", "Tesla_Cannon", true, false, new List<ItemPrice>
		{
			new ItemPrice(200, "Coins"),
			new ItemPrice(150, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(271, "Tesla_Cannon_2", "Tesla_Cannon_2", "Weapon272", "Tesla_Cannon_2", "Tesla_Cannon_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(140, "Coins"),
			new ItemPrice(255, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(272, "Tesla_Cannon_3", "Tesla_Cannon_3", "Weapon273", "Tesla_Cannon_3", "Tesla_Cannon_3", true, false, new List<ItemPrice>
		{
			new ItemPrice(120, "GemsCurrency"),
			new ItemPrice(120, "GemsCurrency"),
			new ItemPrice(240, "GemsCurrency")
		}, true));
		list.Add(new ItemRecord(252, "Devostator", "Devostator", "Weapon253", "Devostator", "Devostator", true, false, new List<ItemPrice>
		{
			new ItemPrice(220, "Coins"),
			new ItemPrice(255, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(273, "Devostator_2", "Devostator_2", "Weapon274", "Devostator_2", "Devostator_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(140, "Coins"),
			new ItemPrice(270, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(254, "Hydra", "Hydra", "Weapon255", "Hydra", "Hydra", true, false, new List<ItemPrice>
		{
			new ItemPrice(235, "Coins"),
			new ItemPrice(255, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(274, "Hydra_2", "Hydra_2", "Weapon275", "Hydra_2", "Hydra_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(155, "Coins"),
			new ItemPrice(295, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(253, "Dark_Matter_Generator", "Dark_Matter_Generator", "Weapon254", "Dark_Matter_Generator", "Dark_Matter_Generator", true, false, new List<ItemPrice>
		{
			new ItemPrice(285, "Coins"),
			new ItemPrice(255, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		list.Add(new ItemRecord(275, "Dark_Matter_Generator_2", "Dark_Matter_Generator_2", "Weapon276", "Dark_Matter_Generator_2", "Dark_Matter_Generator_2", true, false, new List<ItemPrice>
		{
			new ItemPrice(204, "Coins"),
			new ItemPrice(370, "Coins"),
			new ItemPrice(265, "Coins")
		}, true));
		return list;
	}
}
