namespace RilisoftBot
{
	public class MeleeBossBot : MeleeBot
	{
		protected override void Initialize()
		{
			isMobChampion = true;
			base.Initialize();
		}
	}
}
