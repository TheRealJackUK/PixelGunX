using System;
using UnityEngine;

public class AGSSyncableStringList : AGSSyncableList
{
	public AGSSyncableStringList(AmazonJavaWrapper javaObject)
		: base(javaObject)
	{
	}

	public AGSSyncableStringList(AndroidJavaObject javaObject)
		: base(javaObject)
	{
	}

	public AGSSyncableString[] GetValues()
	{
		return new AGSSyncableString[]{};
	}
}
