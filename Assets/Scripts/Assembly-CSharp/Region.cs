using System;

public class Region
{
	public CloudRegionCode Code;

	public string HostAndPort;

	public int Ping;

	public static CloudRegionCode Parse(string codeAsString)
	{
		codeAsString = codeAsString.ToLower();
		CloudRegionCode result = CloudRegionCode.none;
		if (Enum.IsDefined(typeof(CloudRegionCode), codeAsString))
		{
			result = (CloudRegionCode)(int)Enum.Parse(typeof(CloudRegionCode), codeAsString);
		}
		return result;
	}

	public static CloudRegionFlag ParseFlag(string codeAsString)
	{
		codeAsString = codeAsString.ToLower();
		CloudRegionFlag result = (CloudRegionFlag)0;
		if (Enum.IsDefined(typeof(CloudRegionFlag), codeAsString))
		{
			result = (CloudRegionFlag)(int)Enum.Parse(typeof(CloudRegionFlag), codeAsString);
		}
		return result;
	}

	public override string ToString()
	{
		return string.Format("'{0}' \t{1}ms \t{2}", Code, Ping, HostAndPort);
	}
}
