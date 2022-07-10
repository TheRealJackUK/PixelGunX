public class ChestBonusItemData
{
	public string tag;

	public int count;

	public int timeLife;

	public string GetTimeLabel(bool isShort = false)
	{
		int num = timeLife / 24;
		if (num > 0)
		{
			if (isShort)
			{
				return string.Format("{0}d.", num);
			}
			return string.Format("{0} {1}", LocalizationStore.Get("Key_1231"), num);
		}
		return string.Format("{0}h.", timeLife);
	}
}
