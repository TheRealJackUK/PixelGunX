using System.Globalization;

namespace Rilisoft
{
	internal static class MetadataExtensions
	{
		public static string GetDescription()
		{
			return string.Format(CultureInfo.InvariantCulture, "{0} ({1:s})");
		}
	}
}
