using Rilisoft.Phone.Info;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class MemoryLimitMonitor : MonoBehaviour
	{
		private int _timestamp;

		private long _currentMemoryUsage;

		private long _peakMemoryUsage;

		private string _texturesStrings = string.Empty;

		internal void Update()
		{
			if (Application.platform == RuntimePlatform.WP8Player && Time.frameCount % 60 == 0)
			{
				long applicationPeakMemoryUsage = DeviceStatus.ApplicationPeakMemoryUsage;
				if (_peakMemoryUsage < applicationPeakMemoryUsage)
				{
					_peakMemoryUsage = applicationPeakMemoryUsage;
					_timestamp = Time.frameCount;
				}
				_currentMemoryUsage = DeviceStatus.ApplicationCurrentMemoryUsage;
			}
		}

		private static int GetBitsPerPixel(TextureFormat format)
		{
			switch (format)
			{
			case TextureFormat.Alpha8:
				return 8;
			case TextureFormat.ARGB4444:
				return 16;
			case TextureFormat.RGB24:
				return 24;
			case TextureFormat.RGBA32:
				return 32;
			case TextureFormat.ARGB32:
				return 32;
			case TextureFormat.RGB565:
				return 16;
			case TextureFormat.DXT1:
				return 4;
			case TextureFormat.DXT5:
				return 8;
			case TextureFormat.PVRTC_RGB2:
				return 2;
			case TextureFormat.PVRTC_RGBA2:
				return 2;
			case TextureFormat.PVRTC_RGB4:
				return 4;
			case TextureFormat.PVRTC_RGBA4:
				return 4;
			case TextureFormat.ETC_RGB4:
				return 4;
			case TextureFormat.ATC_RGB4:
				return 4;
			case TextureFormat.ATC_RGBA8:
				return 8;
			case TextureFormat.BGRA32:
				return 32;
			default:
				return 0;
			}
		}
	}
}
