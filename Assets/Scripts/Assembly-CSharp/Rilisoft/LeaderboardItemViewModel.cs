namespace Rilisoft
{
	public sealed class LeaderboardItemViewModel
	{
		private static LeaderboardItemViewModel _empty = new LeaderboardItemViewModel
		{
			Id = string.Empty,
			Nickname = string.Empty,
			ClanLogo = string.Empty
		};

		public string Id { get; set; }

		public int Rank { get; set; }

		public string Nickname { get; set; }

		public int WinCount { get; set; }

		public int Place { get; set; }

		public bool Highlight { get; set; }

		public string ClanLogo { get; set; }

		public static LeaderboardItemViewModel Empty
		{
			get
			{
				return _empty;
			}
		}
	}
}
