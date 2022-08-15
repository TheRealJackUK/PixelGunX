using System.Collections.Generic;
using Rilisoft.Phone.Info;
using UnityEngine;

public sealed class Device
{
	private static readonly IDictionary<string, int> _gpuRatings = new Dictionary<string, int>
	{
		{ "Adreno (TM) 330", 17 },
		{ "PowerVR SGX 554MP", 15 },
		{ "Mali-T628", 15 },
		{ "Mali-T624", 15 },
		{ "PowerVR G6430", 15 },
		{ "PowerVR Rogue", 14 },
		{ "Mali-T604", 11 },
		{ "Adreno (TM) 320", 11 },
		{ "PowerVR SGX G6200", 10 },
		{ "PowerVR SGX 543MP", 8 },
		{ "PowerVR SGX 544", 8 },
		{ "PowerVR SGX 544MP", 8 },
		{ "Intel HD Graphics", 8 },
		{ "Mali-450 MP", 8 },
		{ "Vivante GC4000", 6 },
		{ "Adreno (TM) 305", 5 },
		{ "NVIDIA Tegra 3", 5 },
		{ "NVIDIA Tegra 3 / Chainfire3D", 5 },
		{ "Vivante GC2000", 5 },
		{ "GC2000 core / Chainfire3D", 5 },
		{ "Mali-400 MP", 4 },
		{ "MALI-400MP4", 4 },
		{ "Mali-400 MP / Chainfire3D", 4 },
		{ "Adreno (TM) 225", 4 },
		{ "VideoCore IV HW", 4 },
		{ "NVIDIA Tegra", 3 },
		{ "GC1000 core", 3 },
		{ "Adreno (TM) 220", 3 },
		{ "Adreno (TM) 220 / Chainfire3D", 3 },
		{ "Vivante GC1000", 3 },
		{ "Adreno (TM) 203", 2 },
		{ "Adreno (TM) 205", 2 },
		{ "PowerVR SGX 531 / Chainfire3D", 2 },
		{ "PowerVR SGX 540", 2 },
		{ "PowerVR SGX 540 / Chainfire3D", 2 },
		{ "Adreno (TM) 200", 1 },
		{ "Adreno (TM) 200 / Chainfire3D", 1 },
		{ "Immersion.16", 1 },
		{ "Immersion.16 / Chainfire3D", 1 },
		{ "Bluestacks", 1 },
		{ "GC800 core", 1 },
		{ "GC800 core / Chainfire3D", 1 },
		{ "Mali-200", 1 },
		{ "Mali-300", 1 },
		{ "GC400 core", 1 },
		{ "S5 Multicore c", 1 },
		{ "PowerVR SGX530", 1 },
		{ "PowerVR SGX 530", 1 },
		{ "PowerVR SGX 531", 1 },
		{ "PowerVR SGX 535", 1 },
		{ "PowerVR SGX 543", 1 }
	};

	public static bool IsLoweMemoryDevice
	{
		get
		{
			return false;
		}
	}

	public static bool isWeakDevice
	{
		get
		{
			return false;
		}
	}

	public static bool isNonRetinaDevice
	{
		get
		{
			return true;
		}
	}

	public static bool isRetinaAndStrong
	{
		get
		{
			if (Application.isEditor)
			{
				return true;
			}
			return false;
		}
	}

	internal static bool TryGetGpuRating(out int rating)
	{
		return _gpuRatings.TryGetValue(SystemInfo.graphicsDeviceName, out rating);
	}

	internal static string FormatGpuModelMemoryRating()
	{
		string format = SystemInfo.graphicsDeviceName + ": {{ Memory: {0}Mb, Rating: {1} }}";
		int value;
		return (!_gpuRatings.TryGetValue(SystemInfo.graphicsDeviceName, out value)) ? string.Format(format, SystemInfo.graphicsMemorySize, "?") : string.Format(format, SystemInfo.graphicsMemorySize, value);
	}

	internal static string FormatDeviceModelMemoryRating()
	{
		string format = SystemInfo.deviceModel + ": {{ Memory: {0}Mb, Rating: {1} }}";
		int value;
		return (!_gpuRatings.TryGetValue(SystemInfo.graphicsDeviceName, out value)) ? string.Format(format, SystemInfo.systemMemorySize, "?") : string.Format(format, SystemInfo.systemMemorySize, value);
	}

	public static bool GpuRatingIsAtLeast(int desiredGpuRating)
	{
		int value;
		return !_gpuRatings.TryGetValue(SystemInfo.graphicsDeviceName, out value) || value >= desiredGpuRating;
	}

	public static bool IsQuiteGoodAndroidDevice()
	{
		return false;
	}
}
