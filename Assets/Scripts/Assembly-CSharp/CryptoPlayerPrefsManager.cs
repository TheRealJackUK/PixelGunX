using UnityEngine;

public class CryptoPlayerPrefsManager : MonoBehaviour
{
	public int salt = int.MaxValue;

	public bool useRijndael = true;

	public bool useXor = true;

	private void Awake()
	{
		CryptoPlayerPrefs.setSalt(salt);
		CryptoPlayerPrefs.useRijndael(useRijndael);
		CryptoPlayerPrefs.useXor(useXor);
		Object.Destroy(this);
	}
}
