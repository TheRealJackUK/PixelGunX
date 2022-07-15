using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class EtceteraAndroid
{
	public enum ScalingMode
	{
		None,
		AspectFit,
		Fill
	}

	public class Contact
	{
		public string name;

		public List<string> emails;

		public List<string> phoneNumbers;
	}

	private static AndroidJavaObject _plugin;

	static EtceteraAndroid()
	{
		return;
	}

	public static Texture2D textureFromFileAtPath(string filePath)
	{
		byte[] data = File.ReadAllBytes(filePath);
		Texture2D texture2D = new Texture2D(1, 1);
		texture2D.LoadImage(data);
		texture2D.Apply();
		Debug.Log("texture size: " + texture2D.width + "x" + texture2D.height);
		return texture2D;
	}

	public static void setSystemUiVisibilityToLowProfile(bool useLowProfile)
	{
	}

	public static void playMovie(string pathOrUrl, uint bgColor, bool showControls, ScalingMode scalingMode, bool closeOnTouch)
	{
	}

	public static void setAlertDialogTheme(int theme)
	{
	}

	public static void showToast(string text, bool useShortDuration)
	{
	}

	public static void showAlert(string title, string message, string positiveButton)
	{
		showAlert(title, message, positiveButton, string.Empty);
	}

	public static void showAlert(string title, string message, string positiveButton, string negativeButton)
	{
	}

	public static void showAlertPrompt(string title, string message, string promptHint, string promptText, string positiveButton, string negativeButton)
	{
	}

	public static void showAlertPromptWithTwoFields(string title, string message, string promptHintOne, string promptTextOne, string promptHintTwo, string promptTextTwo, string positiveButton, string negativeButton)
	{
	}

	public static void showProgressDialog(string title, string message)
	{
	}

	public static void hideProgressDialog()
	{
	}

	public static void showWebView(string url)
	{
	}

	public static void showCustomWebView(string url, bool disableTitle, bool disableBackButton)
	{
	}

	public static void showEmailComposer(string toAddress, string subject, string text, bool isHTML)
	{
		showEmailComposer(toAddress, subject, text, isHTML, string.Empty);
	}

	public static void showEmailComposer(string toAddress, string subject, string text, bool isHTML, string attachmentFilePath)
	{
	}

	public static bool isSMSComposerAvailable()
	{
		return false;

	}

	public static void showSMSComposer(string body)
	{
		showSMSComposer(body, null);
	}

	public static void showSMSComposer(string body, string[] recipients)
	{
		if (Application.platform != RuntimePlatform.Android)
		{
			return;
		}
	}

	public static void shareImageWithNativeShareIntent(string pathToImage, string chooserText)
	{
	}

	public static void shareWithNativeShareIntent(string text, string subject, string chooserText, string pathToImage = null)
	{
	}

	public static void promptToTakePhoto(string name)
	{
	}

	public static void promptForPictureFromAlbum(string name)
	{
	}

	public static void promptToTakeVideo(string name)
	{
	}

	public static bool saveImageToGallery(string pathToPhoto, string title)
	{
		return false;
	}

	public static void scaleImageAtPath(string pathToImage, float scale)
	{
	}

	public static Vector2 getImageSizeAtPath(string pathToImage)
	{
		return Vector2.zero;
	}

	public static void enableImmersiveMode(bool shouldEnable)
	{
	}

	public static void loadContacts(int startingIndex, int totalToRetrieve)
	{
	}

	public static void initTTS()
	{
		if (false)
		{
			_plugin.Call("initTTS");
		}
	}

	public static void teardownTTS()
	{
		if (false)
		{
			_plugin.Call("teardownTTS");
		}
	}

	public static void speak(string text)
	{
		speak(text, TTSQueueMode.Add);
	}

	public static void speak(string text, TTSQueueMode queueMode)
	{
		if (false)
		{
			_plugin.Call("speak", text, (int)queueMode);
		}
	}

	public static void stop()
	{
		if (false)
		{
			_plugin.Call("stop");
		}
	}

	public static void playSilence(long durationInMs, TTSQueueMode queueMode)
	{
		if (false)
		{
			_plugin.Call("playSilence", durationInMs, (int)queueMode);
		}
	}

	public static void setPitch(float pitch)
	{
		if (false)
		{
			_plugin.Call("setPitch", pitch);
		}
	}

	public static void setSpeechRate(float rate)
	{
		if (false)
		{
			_plugin.Call("setSpeechRate", rate);
		}
	}

	public static void askForReviewSetButtonTitles(string remindMeLaterTitle, string dontAskAgainTitle, string rateItTitle)
	{
		if (false)
		{
			_plugin.Call("askForReviewSetButtonTitles", remindMeLaterTitle, dontAskAgainTitle, rateItTitle);
		}
	}

	public static void askForReview(int launchesUntilPrompt, int hoursUntilFirstPrompt, int hoursBetweenPrompts, string title, string message, bool isAmazonAppStore = false)
	{
		if (false)
		{
			if (isAmazonAppStore)
			{
				_plugin.Set("isAmazonAppStore", true);
			}
			_plugin.Call("askForReview", launchesUntilPrompt, hoursUntilFirstPrompt, hoursBetweenPrompts, title, message);
		}
	}

	public static void askForReviewNow(string title, string message, bool isAmazonAppStore = false)
	{
		if (false)
		{
			if (isAmazonAppStore)
			{
				_plugin.Set("isAmazonAppStore", true);
			}
			_plugin.Call("askForReviewNow", title, message);
		}
	}

	public static void resetAskForReview()
	{
		if (false)
		{
			_plugin.Call("resetAskForReview");
		}
	}

	public static void openReviewPageInPlayStore(bool isAmazonAppStore = false)
	{
		if (false)
		{
			if (isAmazonAppStore)
			{
				_plugin.Set("isAmazonAppStore", true);
			}
			_plugin.Call("openReviewPageInPlayStore");
		}
	}

	public static void inlineWebViewShow(string url, int x, int y, int width, int height)
	{
		if (false)
		{
			_plugin.Call("inlineWebViewShow", url, x, y, width, height);
		}
	}

	public static void inlineWebViewClose()
	{
		if (false)
		{
			_plugin.Call("inlineWebViewClose");
		}
	}

	public static void inlineWebViewSetUrl(string url)
	{
		if (false)
		{
			_plugin.Call("inlineWebViewSetUrl", url);
		}
	}

	public static void inlineWebViewSetFrame(int x, int y, int width, int height)
	{
		if (false)
		{
			_plugin.Call("inlineWebViewSetFrame", x, y, width, height);
		}
	}

	public static int scheduleNotification(long secondsFromNow, string title, string subtitle, string tickerText, string extraData, int requestCode = -1)
	{
		return scheduleNotification(secondsFromNow, title, subtitle, tickerText, extraData, null, null, requestCode);
	}

	public static int scheduleNotification(long secondsFromNow, string title, string subtitle, string tickerText, string extraData, string smallIcon, string largeIcon, int requestCode = -1)
	{
		return -1;
	}

	public static void cancelNotification(int notificationId)
	{
		if (false)
		{
			_plugin.Call("cancelNotification", notificationId);
		}
	}

	public static void cancelAllNotifications()
	{
		if (false)
		{
			_plugin.Call("cancelAllNotifications");
		}
	}

	public static void checkForNotifications()
	{
		if (false)
		{
			_plugin.Call("checkForNotifications");
		}
	}
}
