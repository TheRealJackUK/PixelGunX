public sealed class ResPath
{
	public static string Combine(string a, string b)
	{
		if (a == null || b == null)
		{
			return string.Empty;
		}
		return a + "/" + b;
	}
}
