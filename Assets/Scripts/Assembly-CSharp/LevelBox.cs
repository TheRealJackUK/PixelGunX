using System.Collections.Generic;

public class LevelBox
{
	public static List<LevelBox> campaignBoxes;

	public List<CampaignLevel> levels = new List<CampaignLevel>(6);

	public int starsToOpen;

	public string name;

	public string mapName;

	public string PreviewNAme = string.Empty;

	public int gems;

	public int coins;

	public static Dictionary<string, string> weaponsFromBosses;

	public int CompletionExperienceAward { get; set; }

	static LevelBox()
	{
		campaignBoxes = new List<LevelBox>(4);
		weaponsFromBosses = new Dictionary<string, string>(20);
		InitializeWeaponsFromBosses(weaponsFromBosses);
		LevelBox item = new LevelBox
		{
			starsToOpen = int.MaxValue,
			PreviewNAme = "Box_coming_soon",
			name = "coming soon",
			CompletionExperienceAward = 0
		};
		LevelBox levelBox = new LevelBox
		{
			starsToOpen = 30,
			name = "Crossed",
			mapName = string.Empty,
			PreviewNAme = "Box_3",
			CompletionExperienceAward = 100,
			gems = 15,
			coins = 20
		};
		levelBox.levels.Add(new CampaignLevel("Swamp_campaign3"));
		levelBox.levels.Add(new CampaignLevel("Castle_campaign3"));
		levelBox.levels.Add(new CampaignLevel("Space_campaign3"));
		levelBox.levels.Add(new CampaignLevel("Parkour"));
		levelBox.levels.Add(new CampaignLevel("Code_campaign3"));
		LevelBox levelBox2 = new LevelBox
		{
			starsToOpen = 20,
			name = "minecraft",
			mapName = string.Empty,
			PreviewNAme = "Box_2",
			CompletionExperienceAward = 70,
			gems = 10,
			coins = 15
		};
		CampaignLevel item2 = new CampaignLevel
		{
			sceneName = "Utopia"
		};
		CampaignLevel item3 = new CampaignLevel
		{
			sceneName = "Maze"
		};
		CampaignLevel item4 = new CampaignLevel
		{
			sceneName = "Sky_islands"
		};
		CampaignLevel item5 = new CampaignLevel
		{
			sceneName = "Winter"
		};
		CampaignLevel item6 = new CampaignLevel
		{
			sceneName = "Castle"
		};
		CampaignLevel item7 = new CampaignLevel
		{
			sceneName = "Gluk_2"
		};
		levelBox2.levels.Add(item2);
		levelBox2.levels.Add(item3);
		levelBox2.levels.Add(item4);
		levelBox2.levels.Add(item5);
		levelBox2.levels.Add(item6);
		levelBox2.levels.Add(item7);
		LevelBox levelBox3 = new LevelBox
		{
			name = "Real",
			mapName = string.Empty,
			PreviewNAme = "Box_1",
			CompletionExperienceAward = 50,
			gems = 5,
			coins = 15
		};
		CampaignLevel item8 = new CampaignLevel
		{
			sceneName = "Farm"
		};
		CampaignLevel item9 = new CampaignLevel
		{
			sceneName = "Cementery"
		};
		CampaignLevel item10 = new CampaignLevel
		{
			sceneName = "City"
		};
		CampaignLevel item11 = new CampaignLevel
		{
			sceneName = "Hospital"
		};
		CampaignLevel item12 = new CampaignLevel
		{
			sceneName = "Bridge"
		};
		CampaignLevel item13 = new CampaignLevel
		{
			sceneName = "Jail"
		};
		CampaignLevel item14 = new CampaignLevel
		{
			sceneName = "Slender"
		};
		CampaignLevel item15 = new CampaignLevel
		{
			sceneName = "Area52"
		};
		CampaignLevel item16 = new CampaignLevel
		{
			sceneName = "School"
		};
		levelBox3.levels.Add(item8);
		levelBox3.levels.Add(item9);
		levelBox3.levels.Add(item10);
		levelBox3.levels.Add(item11);
		levelBox3.levels.Add(item12);
		levelBox3.levels.Add(item13);
		levelBox3.levels.Add(item14);
		levelBox3.levels.Add(item15);
		levelBox3.levels.Add(item16);
		campaignBoxes.Add(levelBox3);
		campaignBoxes.Add(levelBox2);
		campaignBoxes.Add(levelBox);
		campaignBoxes.Add(item);
	}

	private static void InitializeWeaponsFromBosses(Dictionary<string, string> weaponsFromBosses)
	{
		weaponsFromBosses.Add("Farm", WeaponManager.UZI_WN);
		weaponsFromBosses.Add("Cementery", WeaponManager.MP5WN);
		weaponsFromBosses.Add("City", "Weapon4");
		weaponsFromBosses.Add("Hospital", "Weapon8");
		weaponsFromBosses.Add("Jail", "Weapon5");
		weaponsFromBosses.Add("Slender", "Weapon51");
		weaponsFromBosses.Add("Area52", "Weapon52");
		weaponsFromBosses.Add("Bridge", WeaponManager.M16_2WN);
		weaponsFromBosses.Add("Utopia", WeaponManager.CampaignRifle_WN);
		weaponsFromBosses.Add("Code_campaign3", WeaponManager.BugGunWN);
	}
}
