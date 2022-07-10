namespace RilisoftBot
{
	public class ShootingBossBot : ShootingBot
	{
		protected override void Initialize()
		{
			isMobChampion = true;
			base.Initialize();
		}
	}
}
