using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using Rilisoft.MiniJson;
using UnityEngine;

public class UploadShopItemDataToServer : MonoBehaviour
{
	private enum PlatformType
	{
		IOS,
		Test,
		Android,
		Amazon,
		WindowsPhone
	}

	public enum TypeWindow
	{
		UploadFileToServer,
		ChangePlatform
	}

	public UIToggle defaultToggle;

	public UIToggle defaultFilterToggle;

	public List<EditorShopItemData> itemsData;

	public UILabel buttonApplyLabel;

	public UISprite generateButton;

	public UIWidget filtersContainer;

	public UIWidget checkAllContainer;

	private PlatformType _typePlatform;

	private TypeWindow _typeWindow;

	private string GenerateJsonStringWithData()
	{
		Dictionary<string, object> dictionary = new Dictionary<string, object>();
		List<List<object>> value = new List<List<object>>();
		List<string> list = new List<string>();
		list.Add(WeaponTags.DragonGun_Tag);
		list.Add(WeaponTags.FreezeGun_0_Tag);
		list.Add(WeaponTags.FreezeGunTag);
		list.Add(WeaponTags.AK74Tag);
		List<string> value2 = list;
		list = new List<string>();
		list.Add(WeaponTags.RailgunTag);
		list.Add(WeaponTags.MinigunTag);
		list.Add(WeaponTags.GlockTag);
		List<string> value3 = list;
		List<string> list2 = new List<string>();
		List<string> list3 = new List<string>();
		List<List<object>> list4 = new List<List<object>>();
		for (int i = 0; i < itemsData.Count; i++)
		{
			if (itemsData[i].isNew)
			{
				list2.Add(itemsData[i].tag);
			}
			if (itemsData[i].isTop)
			{
				list3.Add(itemsData[i].tag);
			}
			if (itemsData[i].discount > 0)
			{
				List<object> list5 = new List<object>();
				list5.Add(itemsData[i].tag);
				list5.Add(itemsData[i].discount);
				list4.Add(list5);
			}
		}
		dictionary.Add("discounts", value);
		dictionary.Add("news", value2);
		dictionary.Add("news_up", list2);
		dictionary.Add("topSellers", value3);
		dictionary.Add("topSellers_up", list3);
		dictionary.Add("discounts_up", list4);
		return Json.Serialize(dictionary);
	}

	public void Show(TypeWindow type)
	{
		base.gameObject.GetComponent<UIPanel>().alpha = 1f;
		_typePlatform = PlatformType.Test;
		defaultToggle.value = true;
		_typeWindow = type;
		if (_typeWindow == TypeWindow.UploadFileToServer)
		{
			buttonApplyLabel.text = "Upload to server";
		}
		else if (_typeWindow == TypeWindow.ChangePlatform)
		{
			buttonApplyLabel.text = "Download from server";
		}
	}

	public void Hide()
	{
		base.gameObject.GetComponent<UIPanel>().alpha = 0f;
	}

	public void ChangeCurrentPlatform(UIToggle toggle)
	{
		if (!(toggle == null) && toggle.value)
		{
			switch (toggle.name)
			{
			case "IOSCheckbox":
				_typePlatform = PlatformType.IOS;
				break;
			case "TestCheckbox":
				_typePlatform = PlatformType.Test;
				break;
			case "AndroidCheckbox":
				_typePlatform = PlatformType.Android;
				break;
			case "AmazonCheckbox":
				_typePlatform = PlatformType.Amazon;
				break;
			case "WindowsPhoneCheckbox":
				_typePlatform = PlatformType.WindowsPhone;
				break;
			}
		}
	}

	private string GetFileNameForPlatform(PlatformType type)
	{
		switch (_typePlatform)
		{
		case PlatformType.Amazon:
			return "promo_actions_amazon.php";
		case PlatformType.Android:
			return "promo_actions_android.php";
		case PlatformType.IOS:
			return "promo_actions.php";
		case PlatformType.Test:
			return "promo_actions_test1.php";
		case PlatformType.WindowsPhone:
			return "promo_actions_wp8.php";
		default:
			return "promo_actions_test1.php";
		}
	}

	public string GetPromoActionUrl()
	{
		switch (_typePlatform)
		{
		case PlatformType.Amazon:
			return "https://secure.pixelgunserver.com/promo_actions_amazon.php";
		case PlatformType.Android:
			return "https://secure.pixelgunserver.com/promo_actions_android.php";
		case PlatformType.IOS:
			return "https://secure.pixelgunserver.com/promo_actions.php";
		case PlatformType.Test:
			return "https://secure.pixelgunserver.com/promo_actions_test.php";
		case PlatformType.WindowsPhone:
			return "https://secure.pixelgunserver.com/promo_actions_wp8.php";
		default:
			return "https://secure.pixelgunserver.com/promo_actions.php";
		}
	}

	private string CreatePhpFileByString(string text)
	{
		string fileNameForPlatform = GetFileNameForPlatform(_typePlatform);
		try
		{
			if (File.Exists(fileNameForPlatform))
			{
				File.Delete(fileNameForPlatform);
			}
			using (FileStream fileStream = File.Create(fileNameForPlatform))
			{
				byte[] bytes = new UTF8Encoding(true).GetBytes(text);
				fileStream.Write(bytes, 0, bytes.Length);
				return fileNameForPlatform;
			}
		}
		catch (Exception ex)
		{
			Debug.LogError(ex.ToString());
			return fileNameForPlatform;
		}
	}

	private void UploadPhpFileToServer(string fileName)
	{
		try
		{
			FtpWebRequest ftpWebRequest = (FtpWebRequest)WebRequest.Create("ftp://secure.pixelgunserver.com//test.htm");
			ftpWebRequest.Method = "STOR";
			ftpWebRequest.UsePassive = false;
			ftpWebRequest.Credentials = new NetworkCredential("rilisoft", "11QQwwee");
			FtpWebResponse ftpWebResponse = (FtpWebResponse)ftpWebRequest.GetResponse();
			Debug.Log(string.Format("Upload File Complete, status {0}", ftpWebResponse.StatusDescription));
			ftpWebResponse.Close();
		}
		catch (WebException ex)
		{
			string statusDescription = ((FtpWebResponse)ex.Response).StatusDescription;
			Debug.Log(statusDescription);
		}
	}

	public string GenerateTextForUploadFile()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine("<?php");
		string text = GenerateJsonStringWithData();
		text = text.Replace("\"", "\\\"");
		text += "\\r\\n";
		stringBuilder.AppendFormat("$val = \"{0}\";\n", text);
		stringBuilder.AppendLine("echo $val;");
		stringBuilder.AppendLine("?>");
		return stringBuilder.ToString();
	}

	private void UploadFileToServer()
	{
		string text = GenerateTextForUploadFile();
		string text2 = CreatePhpFileByString(text);
		UploadPhpFileToServer(text2);
		Debug.Log(text2);
	}

	public void ApplyButtonClick()
	{
		switch (_typeWindow)
		{
		case TypeWindow.UploadFileToServer:
			UploadFileToServer();
			break;
		case TypeWindow.ChangePlatform:
			generateButton.gameObject.SetActive(true);
			filtersContainer.gameObject.SetActive(true);
			checkAllContainer.gameObject.SetActive(true);
			defaultFilterToggle.value = true;
			break;
		}
		Hide();
	}
}
