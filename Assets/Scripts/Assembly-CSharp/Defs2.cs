using System.Collections.Generic;
using System.Security.Cryptography;
using Rilisoft;
using UnityEngine;

public sealed class Defs2
{
	private class MapInfo
	{
		public string mapId;

		public string mapName;

		public string mapPreviewName;

		public string mapPreviewSize;

		public MapInfo(string mapId, string mapName, string mapPreviewName, string mapPreviewSize)
		{
			this.mapId = mapId;
			this.mapName = mapName;
			this.mapPreviewName = mapPreviewName;
			this.mapPreviewSize = mapPreviewSize;
		}
	}

	private static bool TierAfter8_3_0Initialized;

	public static Dictionary<string, string> mapNamesForUser;

	public static Dictionary<string, string> mapEnglishNamesForPreviewMap;

	public static Dictionary<string, string> mapNamesForPreviewMap;

	public static Dictionary<string, string> mapSizesForPreviewMap;

	private static List<MapInfo> _mapsInfo;

	private static SignedPreferences _signedPreferences;

	private static readonly byte[] _rsaParameters;

	public static int MaxGrenadeCount
	{
		get
		{
			return 10;
		}
	}

	public static int GrenadeOnePrice
	{
		get
		{
			return VirtualCurrencyHelper.Price("GrenadeID" + GearManager.OneItemSuffix + GearManager.CurrentNumberOfUphradesForGear("GrenadeID")).Price;
		}
	}

	public static string ApplicationUrl
	{
		get
		{
			return (BuildSettings.BuildTarget == BuildTarget.Android && Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon) ? "http://www.amazon.com/Pixel-Gun-3D-Multiplayer-Minecraft/dp/B00I6IKSZ0/ref=sr_1_1?ie=UTF8&qid=1392637296&sr=8-1&keywords=pixel+gun+3d" : ((BuildSettings.BuildTarget != BuildTarget.WP8Player) ? "http://pixelgun3d.com/get.html" : "http://www.windowsphone.com/en-us/store/app/pixel-gun-3d/8aca569e-6414-428e-ae98-d60a9f839141");
		}
	}

	internal static SignedPreferences SignedPreferences
	{
		get
		{
			if (_signedPreferences == null)
			{
				RSACryptoServiceProvider rSACryptoServiceProvider = new RSACryptoServiceProvider(512);
				rSACryptoServiceProvider.ImportCspBlob(_rsaParameters);
				_signedPreferences = new RsaSignedPreferences(new PersistentPreferences(), rSACryptoServiceProvider, SystemInfo.deviceUniqueIdentifier);
			}
			return _signedPreferences;
		}
	}

	static Defs2()
	{
		TierAfter8_3_0Initialized = false;
		mapNamesForUser = new Dictionary<string, string>();
		mapEnglishNamesForPreviewMap = new Dictionary<string, string>();
		mapNamesForPreviewMap = new Dictionary<string, string>();
		mapSizesForPreviewMap = new Dictionary<string, string>();
		_mapsInfo = new List<MapInfo>();
		_rsaParameters = new byte[308]
		{
			7, 2, 0, 0, 0, 164, 0, 0, 82, 83,
			65, 50, 0, 2, 0, 0, 17, 0, 0, 0,
			1, 24, 67, 211, 214, 189, 210, 144, 254, 145,
			230, 212, 19, 254, 185, 112, 117, 120, 142, 89,
			80, 227, 74, 157, 136, 99, 204, 254, 117, 105,
			106, 52, 143, 219, 180, 55, 4, 174, 130, 222,
			59, 143, 80, 32, 56, 220, 204, 215, 254, 202,
			38, 42, 34, 141, 116, 38, 68, 147, 247, 71,
			65, 49, 18, 153, 205, 10, 30, 210, 118, 97,
			196, 36, 168, 88, 201, 246, 230, 160, 110, 13,
			124, 85, 105, 5, 43, 72, 1, 158, 28, 194,
			234, 109, 169, 124, 57, 167, 5, 106, 4, 145,
			166, 174, 181, 8, 222, 238, 193, 247, 67, 4,
			63, 158, 68, 238, 149, 46, 126, 245, 244, 34,
			194, 82, 16, 202, 202, 47, 85, 234, 177, 145,
			103, 107, 6, 167, 139, 19, 113, 83, 144, 51,
			172, 211, 28, 133, 56, 20, 84, 65, 236, 67,
			16, 239, 26, 32, 10, 254, 38, 72, 99, 157,
			197, 181, 106, 238, 33, 247, 188, 47, 35, 40,
			87, 193, 215, 151, 33, 197, 170, 220, 239, 73,
			82, 102, 162, 100, 132, 69, 125, 74, 225, 224,
			235, 68, 230, 233, 9, 162, 182, 97, 205, 7,
			35, 71, 107, 239, 213, 14, 6, 135, 7, 137,
			140, 150, 80, 39, 253, 197, 12, 101, 164, 157,
			109, 89, 10, 134, 225, 17, 130, 168, 84, 111,
			116, 89, 20, 67, 132, 7, 204, 191, 33, 103,
			113, 0, 12, 11, 19, 139, 190, 49, 110, 98,
			16, 209, 75, 236, 139, 213, 86, 4, 8, 182,
			121, 126, 53, 5, 123, 132, 234, 114, 1, 125,
			120, 63, 150, 29, 192, 102, 100, 11, 230, 161,
			170, 133, 253, 231, 199, 89, 5, 45
		};
		SetMapsInfo();
		LocalizationStore.AddEventCallAfterLocalize(SetLocalizeForMaps);
		PlayerEventScoreController.SetScoreEventInfo();
	}

	public static void InitializeTier8_3_0Key()
	{
		if (!TierAfter8_3_0Initialized)
		{
			if (!Storager.hasKey(Defs.TierAfter8_3_0Key))
			{
				Storager.setInt(Defs.TierAfter8_3_0Key, ExpController.GetOurTier(), false);
			}
			TierAfter8_3_0Initialized = true;
		}
	}

	public static bool IsAvalibleAddFrends()
	{
		return FriendsController.sharedController.friends.Count + FriendsController.sharedController.invitesFromUs.Count + FriendsController.sharedController.invitesToUs.Count < Defs.maxCountFriend;
	}

	public static void SetMapsInfo()
	{
		_mapsInfo.Clear();
		_mapsInfo.Add(new MapInfo("Maze", "Key_0446", "Key_0492", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Cementery", "Key_0447", "Key_0493", "Key_0539"));
		_mapsInfo.Add(new MapInfo("City", "Key_0448", "Key_0494", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Gluk", "Key_0449", "Key_0495", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Jail", "Key_0450", "Key_0496", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Hospital", "Key_0451", "Key_0497", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Pool", "Key_0452", "Key_0498", "Key_0541"));
		_mapsInfo.Add(new MapInfo("Slender", "Key_0453", "Key_0499", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Castle", "Key_0454", "Key_0500", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Ranch", "Key_0455", "Key_0501", "Key_0541"));
		_mapsInfo.Add(new MapInfo("Arena_MP", "Key_0456", "Key_0502", "Key_0541"));
		_mapsInfo.Add(new MapInfo("Sky_islands", "Key_0457", "Key_0503", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Dust", "Key_0458", "Key_0504", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Bridge", "Key_0459", "Key_0505", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Farm", "Key_0460", "Key_0506", "Key_0539"));
		_mapsInfo.Add(new MapInfo("Utopia", "Key_0461", "Key_0507", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Aztec", "Key_0462", "Key_0508", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Arena", "Key_0463", "Key_0509", "Key_0539"));
		_mapsInfo.Add(new MapInfo("Assault", "Key_0464", "Key_0510", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Winter", "Key_0465", "Key_0511", "Key_0538"));
		_mapsInfo.Add(new MapInfo("School", "Key_0466", "Key_0512", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Parkour", "Key_0467", "Key_0513", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Coliseum_MP", "Key_0468", "Key_0514", "Key_0541"));
		_mapsInfo.Add(new MapInfo("Hungry", "Key_0469", "Key_0515", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Hungry_Night", "Key_0470", "Key_0516", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Hungry_2", "Key_0471", "Key_0517", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Estate", "Key_0472", "Key_0518", "Key_0539"));
		_mapsInfo.Add(new MapInfo("Space", "Key_0473", "Key_0519", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Portal", "Key_0474", "Key_0520", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Two_Castles", "Key_0475", "Key_0521", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Ships", "Key_0476", "Key_0522", "Key_0539"));
		_mapsInfo.Add(new MapInfo("Ships_Night", "Key_0477", "Key_0523", "Key_0539"));
		_mapsInfo.Add(new MapInfo("Gluk_3", "Key_0478", "Key_0524", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Matrix", "Key_0479", "Key_0525", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Ants", "Key_0480", "Key_0526", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Hill", "Key_0481", "Key_0527", "Key_0539"));
		_mapsInfo.Add(new MapInfo("Heaven", "Key_0482", "Key_0528", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Underwater", "Key_0483", "Key_0529", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Knife", "Key_0484", "Key_0530", "Key_0539"));
		_mapsInfo.Add(new MapInfo("Day_D", "Key_0485", "Key_0531", "Key_0540"));
		_mapsInfo.Add(new MapInfo("NuclearCity", "Key_0486", "Key_0532", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Cube", "Key_0487", "Key_0533", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Train", "Key_0488", "Key_0534", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Sniper", "Key_0489", "Key_0535", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Supermarket", "Key_0490", "Key_0536", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Pumpkins", "Key_0491", "Key_0537", "Key_0539"));
		_mapsInfo.Add(new MapInfo("Christmas_Town", "Key_0985", "Key_0917", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Christmas_Town_Night", "Key_1021", "Key_1020", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Paradise", "Key_1030", "Key_1029", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Bota", "Key_1069", "Key_1044", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Pizza", "Key_1093", "Key_1092", "Key_0538"));
		_mapsInfo.Add(new MapInfo("Barge", "Key_1199", "Key_1198", "Key_0539"));
		_mapsInfo.Add(new MapInfo("Slender_Multy", "Key_0453", "Key_0499", "Key_0540"));
		_mapsInfo.Add(new MapInfo("Mine", "Key_1280", "Key_1279", "Key_0540"));
		_mapsInfo.Add(new MapInfo("DevScene", "devscene", "devscene", "Key_0541"));
		_mapsInfo.Add(new MapInfo("Pool_Abandoned", "Abandoned Pool", "Abandoned Pool", "Key_0541"));
		_mapsInfo.Add(new MapInfo("Lean_Matrix", "Inside The Lean", "Inside The Lean", "Key_0541"));
		_mapsInfo.Add(new MapInfo("Tatuan", "Space Desert", "Space Desert", "Large Map"));
		_mapsInfo.Add(new MapInfo("ChinaPand", "Kung Fu Village", "Kung Fu Village", "Medium Map"));
		_mapsInfo.Add(new MapInfo("PiratIsland", "Isla De La Muerte", "Isla De La Muerte", "Large Map"));
		_mapsInfo.Add(new MapInfo("emperors_palace", "Emperor's Palace", "Emperor's Palace", "Large Map"));
		_mapsInfo.Add(new MapInfo("Christmas_dinner", "Christmas Dinner", "Christmas Dinner", "Large Map"));
		_mapsInfo.Add(new MapInfo("Secret_Base", "Secret Base", "Secret Base", "Large Map"));
		_mapsInfo.Add(new MapInfo("Helicarrier", "Aircraft Carrier", "Aircraft Carrier", "Very Large Map"));
	}

	public static void SetLocalizeForMaps()
	{
		mapNamesForUser.Clear();
		mapEnglishNamesForPreviewMap.Clear();
		mapNamesForPreviewMap.Clear();
		mapSizesForPreviewMap.Clear();
		foreach (MapInfo item in _mapsInfo)
		{
			mapNamesForUser.Add(item.mapId, LocalizationStore.Get(item.mapName));
			mapEnglishNamesForPreviewMap.Add(item.mapId, LocalizationStore.GetByDefault(item.mapPreviewName));
			mapNamesForPreviewMap.Add(item.mapId, LocalizationStore.Get(item.mapPreviewName));
			mapSizesForPreviewMap.Add(item.mapId, LocalizationStore.Get(item.mapPreviewSize));
		}
	}

	public static string GetMapEnglishName(string mapId)
	{
		if (mapEnglishNamesForPreviewMap.ContainsKey(mapId))
		{
			return mapEnglishNamesForPreviewMap[mapId];
		}
		return "Unknown";
	}
}
