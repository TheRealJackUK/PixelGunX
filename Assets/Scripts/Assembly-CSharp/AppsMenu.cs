using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.CompilerServices;
using Rilisoft;
using UnityEngine;

[Obfuscation(Exclude = true)]
internal sealed class AppsMenu : MonoBehaviour
{
	[CompilerGenerated]
	private sealed class _003CStart_003Ec__Iterator3 : IEnumerator, IDisposable, IEnumerator<object>
	{
		internal Action<string> _003Chandle_003E__0;

		internal LicenseVerificationController.PackageInfo _003CactualPackageInfo_003E__1;

		internal Exception _003Cex_003E__2;

		internal string _003CactualPackageName_003E__3;

		internal string _003CactualSignatureHash_003E__4;

		internal string _003CmainPath_003E__5;

		internal UnityEngine.Object _003CactivityIndicatorPrefab_003E__6;

		internal int _0024PC;

		internal object _0024current;

		internal AppsMenu _003C_003Ef__this;

		private static Action<string> _003C_003Ef__am_0024cacheA;

		object IEnumerator<object>.Current
		{
			[DebuggerHidden]
			get
			{
				return _0024current;
			}
		}

		object IEnumerator.Current
		{
			[DebuggerHidden]
			get
			{
				return _0024current;
			}
		}

		public bool MoveNext()
		{
			//Discarded unreachable code: IL_03ac
			uint num = (uint)_0024PC;
			_0024PC = -1;
			switch (num)
			{
			case 0u:
				if (Launcher.UsingNewLauncher)
				{
					goto default;
				}
				if (Application.platform == RuntimePlatform.Android && (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro))
				{
					_003Chandle_003E__0 = delegate(string sceneName)
					{
						UnityEngine.Debug.LogError("AppsMenu.Start(): Cheating detected.");
						if (Application.platform == RuntimePlatform.Android && (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro))
						{
							string abuseKey_21493d = GetAbuseKey_21493d18(558447896u);
							DateTime utcNow = DateTime.UtcNow;
							long num2 = utcNow.Ticks >> 1;
							long result = num2;
							UnityEngine.Debug.Log("AppsMenu.Start(): Trying handle cheating.");
							if (!Storager.hasKey(abuseKey_21493d))
							{
								UnityEngine.Debug.LogError(string.Format("AppsMenu.Start(): Setting “{0}”: {1} ({2:s})", abuseKey_21493d, num2, utcNow));
								Storager.setString(abuseKey_21493d, num2.ToString(), false);
							}
							else if (long.TryParse(Storager.getString(abuseKey_21493d, false), out result))
							{
								UnityEngine.Debug.Log("Cheating Timestamp: " + new DateTime(result << 1).ToString("s"));
								long num3 = Math.Min(num2, result);
								UnityEngine.Debug.Log("Min Timestamp: " + new DateTime(num3 << 1).ToString("s"));
								Storager.setString(abuseKey_21493d, num3.ToString(), false);
							}
							else
							{
								Storager.setString(abuseKey_21493d, num2.ToString(), false);
							}
							if (_internetChecker.Value != null)
							{
								UnityEngine.Debug.Log("Trying to start coroutine.");
								_internetChecker.Value.StartCoroutine(MeetTheCoroutine(sceneName, result << 1, num2 << 1));
							}
							else
							{
								UnityEngine.Debug.LogError("InternetChecker is null.");
							}
						}
					};
					_003CactualPackageInfo_003E__1 = default(LicenseVerificationController.PackageInfo);
					_003CactualPackageName_003E__3 = _003CactualPackageInfo_003E__1.PackageName;
					UnityEngine.Debug.Log("Package check passed.");
					UnityEngine.Debug.Log("Signature check passed.");
				}
				_003C_003Ef__this.currentFon = _003C_003Ef__this.androidFon;
				if (ApplicationBinarySplitted && !Application.isEditor || Application.isMobilePlatform)
				{
					_003CmainPath_003E__5 = GooglePlayDownloader.GetMainOBBPath(_003C_003Ef__this.expPath);
					if (_003CmainPath_003E__5 == null)
					{
						// GooglePlayDownloader.FetchOBB();
					}
					goto IL_02a3;
				}
				goto IL_030f;
			case 1u:
				if (_003CmainPath_003E__5 == null)
				{
					goto IL_02a3;
				}
				goto IL_030f;
			case 2u:
				_003CactivityIndicatorPrefab_003E__6 = Resources.Load("ActivityIndicator");
				UnityEngine.Object.DontDestroyOnLoad(_003CactivityIndicatorPrefab_003E__6);
				if (_003CactivityIndicatorPrefab_003E__6 == null)
				{
					UnityEngine.Debug.LogWarning("activityIndicatorPrefab == null");
				}
				else
				{
					StoreKitEventListener.purchaseActivityInd = UnityEngine.Object.Instantiate(_003CactivityIndicatorPrefab_003E__6) as GameObject;
				}
				SetCurrentLanguage();
				_0024current = null;
				_0024PC = 3;
				break;
			case 3u:
				_0024PC = -1;
				goto default;
			default:
				{
					return false;
				}
				IL_030f:
				_003C_003Ef__this.StartCoroutine(_003C_003Ef__this.LoadLoadingScene());
				_0024current = null;
				_0024PC = 2;
				break;
				IL_02a3:
				_003CmainPath_003E__5 = GooglePlayDownloader.GetMainOBBPath(_003C_003Ef__this.expPath);
				if (_003CmainPath_003E__5 != null)
				{
					UnityEngine.Debug.Log(string.Format("MainPath: “{0}”", _003CmainPath_003E__5));
					goto IL_030f;
				}
				UnityEngine.Debug.LogWarning("Waiting mainPath...");
				_0024current = new WaitForSeconds(0.5f);
				_0024PC = 1;
				break;
			}
			return true;
		}

		[DebuggerHidden]
		public void Dispose()
		{
			_0024PC = -1;
		}

		[DebuggerHidden]
		public void Reset()
		{
			throw new NotSupportedException();
		}

		private static void _003C_003Em__2(string sceneName)
		{
			UnityEngine.Debug.LogError("AppsMenu.Start(): Cheating detected.");
			if (Application.platform == RuntimePlatform.Android && (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro))
			{
				string abuseKey_21493d = GetAbuseKey_21493d18(558447896u);
				DateTime utcNow = DateTime.UtcNow;
				long num = utcNow.Ticks >> 1;
				long result = num;
				UnityEngine.Debug.Log("AppsMenu.Start(): Trying handle cheating.");
				if (!Storager.hasKey(abuseKey_21493d))
				{
					UnityEngine.Debug.LogError(string.Format("AppsMenu.Start(): Setting “{0}”: {1} ({2:s})", abuseKey_21493d, num, utcNow));
					Storager.setString(abuseKey_21493d, num.ToString(), false);
				}
				else if (long.TryParse(Storager.getString(abuseKey_21493d, false), out result))
				{
					UnityEngine.Debug.Log("Cheating Timestamp: " + new DateTime(result << 1).ToString("s"));
					long num2 = Math.Min(num, result);
					UnityEngine.Debug.Log("Min Timestamp: " + new DateTime(num2 << 1).ToString("s"));
					Storager.setString(abuseKey_21493d, num2.ToString(), false);
				}
				else
				{
					Storager.setString(abuseKey_21493d, num.ToString(), false);
				}
				if (_internetChecker.Value != null)
				{
					UnityEngine.Debug.Log("Trying to start coroutine.");
					_internetChecker.Value.StartCoroutine(MeetTheCoroutine(sceneName, result << 1, num << 1));
				}
				else
				{
					UnityEngine.Debug.LogError("InternetChecker is null.");
				}
			}
		}

		private void _003C_003E__Finally0()
		{
			if (_003CactualPackageInfo_003E__1.SignatureHash == null)
			{
				UnityEngine.Debug.Log("actualPackageInfo.SignatureHash == null");
				_003Chandle_003E__0(GetTerminalSceneName_4de1(19937u));
			}
		}
	}

	private const string _suffix = "Scene";

	public Texture androidFon;

	public Texture riliFon;

	public string intendedSignatureHash;

	private Texture currentFon;

	private GameObject purchaseActivityInd;

	private static Material m_Material = null;

	private static int _startFrameIndex;

	internal volatile object _preventAggressiveOptimisation;

	private static readonly Rilisoft.Lazy<InternetChecker> _internetChecker = new Rilisoft.Lazy<InternetChecker>(UnityEngine.Object.FindObjectOfType<InternetChecker>);

	private static volatile uint _preventInlining = 3565584061u;

	private string expPath = string.Empty;

	private Texture loadingNote;

	private int resetKeychainAllowCounter;

	internal static bool ApplicationBinarySplitted
	{
		get
		{
			return false;
		}
	}

	private void Awake()
	{
		Screen.SetResolution(Screen.currentResolution.width, Screen.currentResolution.height, true);
		if (Storager.getInt("currentExperience", false) < 0 || Storager.getInt("currentExperience", false) == null) 
		{
			Storager.setInt("currentExperience", 1, false);
		}
		if (PlayerPrefs.GetInt("currentlevel") < 1 || PlayerPrefs.GetInt("currentlevel") == null) 
		{
			PlayerPrefs.SetInt("currentlevel", 1);
			PlayerPrefs.SetInt("currentlevel1", 1);
		}
		if (!Storager.hasKey(Defs.PremiumEnabledFromServer))
		{
			Storager.setInt(Defs.PremiumEnabledFromServer, 1, false);
		}
		if (Launcher.UsingNewLauncher)
		{
			return;
		}
		foreach (float item in AppsMenuAwakeCoroutine())
		{
			float num = item;
			_preventAggressiveOptimisation = num;
		}
	}

	internal static IEnumerable<float> AppsMenuAwakeCoroutine()
	{
		if (PlayerPrefs.HasKey("WantToResetKeychain"))
		{
			PlayerPrefs.DeleteKey("WantToResetKeychain");
			PlayerPrefs.DeleteAll();
			PlayerPrefs.Save();
			Defs.ResetTrainingInDevBuild = true;
		}
		yield return 0.1f;
		Defs2.InitializeTier8_3_0Key();
		if (PlayerPrefs.GetInt(Defs.TrainingCompleted_4_4_Sett, 0) == 1)
		{
			Storager.setInt(Defs.TrainingCompleted_4_4_Sett, 1, false);
		}
		Defs.isTrainingFlag = Storager.getInt(Defs.TrainingCompleted_4_4_Sett, false) == 0;
		if (Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.WP8Player)
		{
			Application.targetFrameRate = 240;
		}
		_startFrameIndex = Time.frameCount;
		yield return 0.2f;
		if (!Launcher.UsingNewLauncher)
		{
			//m_Material = Material.Create("Shader \"Plane/No zTest\" { SubShader { Pass { Blend SrcAlpha OneMinusSrcAlpha ZWrite Off Cull Off Fog { Mode Off } BindChannels { Bind \"Color\",color } } } }");
		}
		if (Device.isWeakDevice && Screen.width > 500)
		{
			if (Application.platform != RuntimePlatform.Android && Application.platform != RuntimePlatform.WP8Player)
			{
				Screen.SetResolution(Screen.currentResolution.width, Screen.currentResolution.height, true);
			}
			yield return 0.3f;
		}
		if (BuildSettings.BuildTarget != BuildTarget.iPhone)
		{
			using (PlayerPrefsHelper p = new PlayerPrefsHelper())
			{
				if (!p.Verify())
				{
					Action<object> log = UnityEngine.Debug.LogWarning;
					log("Device id verification failed. Quitting the application...");
					FlurryPluginWrapper.LogEventWithParameterAndValue("Verification Error", "Message", "Device id verification failed.");
					string key = GetAbuseKey_53232de5(1394814437u);
					DateTime now = DateTime.UtcNow;
					long nowHalved = now.Ticks >> 1;
					long ticksHalved = nowHalved;
					if (!Storager.hasKey(key))
					{
						UnityEngine.Debug.LogError(string.Format("PlayerPrefsHelper.Verify(): Setting “{0}”: {1} ({2:s})", key, nowHalved, now));
						Storager.setString(key, nowHalved.ToString(), false);
					}
					else if (long.TryParse(Storager.getString(key, false), out ticksHalved))
					{
						Storager.setString(key, Math.Min(nowHalved, ticksHalved).ToString(), false);
					}
					else
					{
						Storager.setString(key, nowHalved.ToString(), false);
					}
					if (_internetChecker.Value != null)
					{
						_internetChecker.Value.StartCoroutine(MeetTheCoroutine(GetTerminalSceneName_4de1(19937u), ticksHalved << 1, nowHalved << 1));
					}
					else
					{
						UnityEngine.Debug.LogError("InternetChecker is null.");
					}
				}
			}
			yield return 0.4f;
		}
		if (PlayerPrefs.GetInt("Dev.ResolutionDowngrade", 1) == 1)
		{
			if (Application.platform == RuntimePlatform.IPhonePlayer && Screen.width == 2048)
			{
				Screen.SetResolution(Screen.currentResolution.width, Screen.currentResolution.height, true);
			}
			yield return 0.5f;
		}
		UnityEngine.Object disabler = Resources.Load("Disabler");
		if (disabler == null)
		{
			UnityEngine.Debug.LogWarning("disabler == null");
		}
		else
		{
			UnityEngine.Object.Instantiate(disabler);
		}
		yield return 0.6f;
		if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
		{
			GameObject memoryLimitMonitor = new GameObject();
			memoryLimitMonitor.AddComponent<MemoryLimitMonitor>();
			UnityEngine.Object.DontDestroyOnLoad(memoryLimitMonitor);
			yield return 0.7f;
		}
		yield return 1f;
	}

	private static IEnumerator MeetTheCoroutine(string sceneName, long abuseTicks, long nowTicks)
	{
		TimeSpan timespan = TimeSpan.FromTicks(Math.Abs(nowTicks - abuseTicks));
		UnityEngine.Debug.Log("MeetTheCoroutine: " + timespan);
		if (Defs.IsDeveloperBuild)
		{
			if (timespan.TotalMinutes < 3.0)
			{
				UnityEngine.Debug.Log("Developer Build, breaking: " + timespan);
				yield break;
			}
		}
		else if (timespan.TotalDays < 1.0)
		{
			yield break;
		}
		System.Random prng = new System.Random(nowTicks.GetHashCode());
		float delaySeconds = prng.Next(15, 60);
		UnityEngine.Debug.Log("Waiting " + delaySeconds + " seconds...");
		yield return new WaitForSeconds(delaySeconds);
		UnityEngine.Debug.Log("Trying to load terminal scene: “" + sceneName + "”");
		Application.LoadLevel(sceneName);
	}

	private static string GetAbuseKey_53232de5(uint pad)
	{
		if (pad != 1394814437)
		{
			UnityEngine.Debug.LogError(string.Format("Invalid argument. {0:x} expected, but {1:x} passed.", 1394814437u, pad));
		}
		uint num = 0x97C95CDCu ^ pad;
		if (num != 3303698745u)
		{
			UnityEngine.Debug.LogError(string.Format("Logic error. {0:x} expected, but {1:x} computed.", 3303698745u, num));
		}
		_preventInlining++;
		return num.ToString("x");
	}

	private static string GetAbuseKey_21493d18(uint pad)
	{
		if (pad != 558447896)
		{
			UnityEngine.Debug.LogError(string.Format("Invalid argument. {0:x} expected, but {1:x} passed.", 558447896u, pad));
		}
		uint num = 0xE5A34C21u ^ pad;
		if (num != 3303698745u)
		{
			UnityEngine.Debug.LogError(string.Format("Logic error. {0:x} expected, but {1:x} computed.", 3303698745u, num));
		}
		_preventInlining++;
		return num.ToString("x");
	}

	private static string GetTerminalSceneName_4de1(uint gamma)
	{
		return "Closing4de1Scene".Replace(gamma.ToString("x"), string.Empty);
	}

	private void Update()
	{
		if (!Launcher.UsingNewLauncher && Input.GetKeyUp(KeyCode.Escape))
		{
			Application.Quit();
			Input.ResetInputAxes();
		}
	}

	private IEnumerator Start()
	{
		if (Application.platform == RuntimePlatform.Android && (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro))
		{
			Action<string> handle = delegate(string sceneName)
			{
				UnityEngine.Debug.LogError("AppsMenu.Start(): Cheating detected.");
				if (Application.platform == RuntimePlatform.Android && (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro))
				{
					string abuseKey_21493d = GetAbuseKey_21493d18(558447896u);
					DateTime utcNow = DateTime.UtcNow;
					long num = utcNow.Ticks >> 1;
					long result = num;
					UnityEngine.Debug.Log("AppsMenu.Start(): Trying handle cheating.");
					if (!Storager.hasKey(abuseKey_21493d))
					{
						UnityEngine.Debug.LogError(string.Format("AppsMenu.Start(): Setting “{0}”: {1} ({2:s})", abuseKey_21493d, num, utcNow));
						Storager.setString(abuseKey_21493d, num.ToString(), false);
					}
					else if (long.TryParse(Storager.getString(abuseKey_21493d, false), out result))
					{
						UnityEngine.Debug.Log("Cheating Timestamp: " + new DateTime(result << 1).ToString("s"));
						long num2 = Math.Min(num, result);
						UnityEngine.Debug.Log("Min Timestamp: " + new DateTime(num2 << 1).ToString("s"));
						Storager.setString(abuseKey_21493d, num2.ToString(), false);
					}
					else
					{
						Storager.setString(abuseKey_21493d, num.ToString(), false);
					}
					if (_internetChecker.Value != null)
					{
						UnityEngine.Debug.Log("Trying to start coroutine.");
						_internetChecker.Value.StartCoroutine(MeetTheCoroutine(sceneName, result << 1, num << 1));
					}
					else
					{
						UnityEngine.Debug.LogError("InternetChecker is null.");
					}
				}
			};
			LicenseVerificationController.PackageInfo actualPackageInfo = default(LicenseVerificationController.PackageInfo);
			string actualPackageName = actualPackageInfo.PackageName;
			if (string.Compare(actualPackageName, Defs.GetIntendedAndroidPackageName(), StringComparison.Ordinal) != 0)
			{
				UnityEngine.Debug.LogWarning("Verification FakeBundleDetected:    " + actualPackageName);
				FlurryPluginWrapper.LogEventWithParameterAndValue("Verification FakeBundleDetected", "Actual Package Name", actualPackageName);
				handle(GetTerminalSceneName_4de1(19937u));
			}
			else
			{
				UnityEngine.Debug.Log("Package check passed.");
			}
			if (string.IsNullOrEmpty(intendedSignatureHash))
			{
				UnityEngine.Debug.LogWarning("String.IsNullOrEmpty(intendedSignatureHash)");
				handle(GetTerminalSceneName_4de1(19937u));
			}
			string actualSignatureHash = actualPackageInfo.SignatureHash;
			if (string.Compare(actualSignatureHash, intendedSignatureHash, StringComparison.Ordinal) != 0)
			{
				UnityEngine.Debug.LogWarning("Verification FakeSignatureDetected:    " + actualSignatureHash);
				FlurryPluginWrapper.LogEventWithParameterAndValue("Verification FakeSignatureDetected", "Actual Signature Hash", actualSignatureHash);
				Switcher.AppendAbuseMethod(AbuseMetod.AndroidPackageSignature);
				handle(GetTerminalSceneName_4de1(19937u));
			}
			else
			{
				UnityEngine.Debug.Log("Signature check passed.");
			}
		}
		currentFon = androidFon;
		if (ApplicationBinarySplitted && !Application.isEditor || Application.isMobilePlatform)
		{
			string mainPath2 = GooglePlayDownloader.GetMainOBBPath(expPath);
			if (mainPath2 == null)
			{
				GooglePlayDownloader.FetchOBB();
			}
			do
			{
				mainPath2 = GooglePlayDownloader.GetMainOBBPath(expPath);
				if (mainPath2 != null)
				{
					UnityEngine.Debug.Log(string.Format("MainPath: “{0}”", mainPath2));
					break;
				}
				UnityEngine.Debug.LogWarning("Waiting mainPath...");
				yield return new WaitForSeconds(0.5f);
			}
			while (mainPath2 == null);
		}
		StartCoroutine(LoadLoadingScene());
		yield return null;
		UnityEngine.Object activityIndicatorPrefab = Resources.Load("ActivityIndicator");
		UnityEngine.Object.DontDestroyOnLoad(activityIndicatorPrefab);
		if (activityIndicatorPrefab == null)
		{
			UnityEngine.Debug.LogWarning("activityIndicatorPrefab == null");
		}
		else
		{
			StoreKitEventListener.purchaseActivityInd = UnityEngine.Object.Instantiate(activityIndicatorPrefab) as GameObject;
		}
		SetCurrentLanguage();
		yield return null;
	}

	private static void CheckRenameOldLanguageName()
	{
		if (Storager.IsInitialized(Defs.ChangeOldLanguageName))
		{
			return;
		}
		Storager.SetInitialized(Defs.ChangeOldLanguageName);
		string @string = PlayerPrefs.GetString(Defs.CurrentLanguage, string.Empty);
		if (!string.IsNullOrEmpty(@string))
		{
			switch (@string)
			{
			case "Français":
				PlayerPrefs.SetString(Defs.CurrentLanguage, "French");
				PlayerPrefs.Save();
				break;
			case "Deutsch":
				PlayerPrefs.SetString(Defs.CurrentLanguage, "German");
				PlayerPrefs.Save();
				break;
			case "日本人":
				PlayerPrefs.SetString(Defs.CurrentLanguage, "Japanese");
				PlayerPrefs.Save();
				break;
			case "Español":
				PlayerPrefs.SetString(Defs.CurrentLanguage, "Spanish");
				PlayerPrefs.Save();
				break;
			}
		}
	}

	internal static void SetCurrentLanguage()
	{
		CheckRenameOldLanguageName();
		string @string = PlayerPrefs.GetString(Defs.CurrentLanguage);
		if (string.IsNullOrEmpty(@string))
		{
			@string = LocalizationStore.CurrentLanguage;
		}
		else
		{
			LocalizationStore.CurrentLanguage = @string;
		}
	}

	private static void HandleNotification(string message, Dictionary<string, object> additionalData, bool isActive)
	{
		UnityEngine.Debug.Log(string.Format("GameThrive HandleNotification(“{0}”, ..., {1})", message, isActive));
	}

	private void LoadLoading()
	{
		//GlobalGameController.currentLevel = -1;
		Application.LoadLevel("Loading");
	}

	private void DrawQuad(Color aColor, float aAlpha)
	{
		aColor.a = aAlpha;
		if (m_Material.SetPass(0))
		{
			GL.PushMatrix();
			GL.LoadOrtho();
			GL.Begin(7);
			GL.Color(aColor);
			GL.Vertex3(0f, 0f, -1f);
			GL.Vertex3(0f, 1f, -1f);
			GL.Vertex3(1f, 1f, -1f);
			GL.Vertex3(1f, 0f, -1f);
			GL.End();
			GL.PopMatrix();
		}
		else
		{
			UnityEngine.Debug.LogWarning("Couldnot set pass for material.");
		}
	}

	private IEnumerator Fade(float aFadeOutTime, float aFadeInTime)
	{
		UnityEngine.Debug.Log("fade");
		Color aColor = Color.black;
		float t = 0f;
		while (t < 1f)
		{
			yield return new WaitForEndOfFrame();
			t = Mathf.Clamp01(t + Time.deltaTime / aFadeOutTime);
			DrawQuad(aColor, t);
		}
		currentFon = androidFon;
		purchaseActivityInd.SetActive(true);
		if (loadingNote == null)
		{
			loadingNote = Resources.Load<Texture>("LevelLoadings" + ((!Device.isRetinaAndStrong) ? string.Empty : "/Hi") + "/Loading");
		}
		while (t > 0f && !(Mathf.Abs(aFadeInTime) < 1E-06f))
		{
			t = Mathf.Clamp01(t - Time.deltaTime / aFadeInTime);
			DrawQuad(aColor, t);
			yield return new WaitForEndOfFrame();
		}
		LoadLoading();
	}

	private void OnGUI()
	{
		if (Launcher.UsingNewLauncher)
		{
			return;
		}
		Rect position = ((!(currentFon == riliFon)) ? new Rect(((float)Screen.width - 1366f * Defs.Coef) / 2f, 0f, 1366f * Defs.Coef, Screen.height) : new Rect(((float)Screen.width - 1024f * Defs.Coef) / 2f, 0f, 1024f * Defs.Coef, Screen.height));
		GUI.DrawTexture(position, currentFon, ScaleMode.StretchToFill);
		if (!Application.isEditor || Application.isMobilePlatform)
		{
			if (!GooglePlayDownloader.RunningOnAndroid())
			{
				GUI.Label(new Rect(10f, 10f, Screen.width - 10, 20f), "Use GooglePlayDownloader only on Android device!");
				return;
			}
			if (string.IsNullOrEmpty(expPath))
			{
				GUI.Label(new Rect(10f, 10f, Screen.width - 10, 20f), "External storage is not available!");
			}
		}
		if (BuildSettings.BuildTarget == BuildTarget.Android && Time.frameCount > _startFrameIndex + 1)
		{
			LoadingProgress.Instance.Draw(0f);
		}
		if (loadingNote != null)
		{
			GUI.DrawTexture(new Rect((float)Screen.width * 0.5f - (float)loadingNote.width * 0.5f * Defs.Coef, (float)Screen.height * 0.2f, (float)loadingNote.width * Defs.Coef, (float)loadingNote.height * Defs.Coef), loadingNote);
		}
	}

	private IEnumerator LoadLoadingScene()
	{
		yield return new WaitForSeconds(0.5f);
		Application.LoadLevel("Loading");
	}
}
