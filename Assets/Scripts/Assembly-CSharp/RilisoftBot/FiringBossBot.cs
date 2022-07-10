namespace RilisoftBot
{
	public class FiringBossBot : FiringShotBot
	{
		protected override void Initialize()
		{
			isMobChampion = true;
			base.Initialize();
		}
	}
}
