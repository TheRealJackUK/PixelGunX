using System;
using System.Text;
using UnityEngine;

public class X3DateConverter : MonoBehaviour
{
	public UIInput dateStartInput;

	public UIInput timeStartInput;

	public UIInput durationInput;

	public UILabel statusLabel;

	private double ConvertToUnixTimestamp(DateTime date)
	{
		DateTime dateTime = new DateTime(1970, 1, 1, 0, 0, 0, 0);
		DateTime dateTime2 = DateTime.SpecifyKind(date, DateTimeKind.Utc);
		return Math.Floor((dateTime2 - dateTime).TotalSeconds);
	}

	public void CalculateAndCopyClick()
	{
		string s = string.Format("{0}T{1}", dateStartInput.value, timeStartInput.value);
		DateTime result = default(DateTime);
		if (!DateTime.TryParse(s, out result))
		{
			statusLabel.text = "Incorrect date or time format!";
			return;
		}
		float result2;
		if (!float.TryParse(durationInput.value, out result2))
		{
			statusLabel.text = "Incorrect duration format!";
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine("{");
		stringBuilder.AppendFormat("\t\"start\": {0}\n", ConvertToUnixTimestamp(result));
		float num = result2 * 360f;
		stringBuilder.AppendFormat("\t\"duration\": {0}\n", num);
		stringBuilder.AppendLine("}");
		EditorListBuilder.CopyTextInClipboard(stringBuilder.ToString());
		statusLabel.text = "Converted complete!";
	}
}
