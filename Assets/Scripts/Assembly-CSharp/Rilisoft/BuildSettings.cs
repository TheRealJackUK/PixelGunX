namespace Rilisoft
{
	internal static class BuildSettings
	{
		private static BuildTarget _buildTarget;

		internal static BuildTarget BuildTarget
		{
			get
			{
				return _buildTarget;
			}
		}

		static BuildSettings()
		{
			_buildTarget = BuildTarget.Android;
		}
	}
}
