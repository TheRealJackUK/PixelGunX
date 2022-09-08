using System.Security.Cryptography;

namespace Rilisoft
{
	internal class RsaSignedPreferences : SignedPreferences
	{
		public RsaSignedPreferences(Preferences preferences_1, RSACryptoServiceProvider rsacryptoServiceProvider_2, string string_3) : base(default(Preferences))
		{
		}

	}
}
