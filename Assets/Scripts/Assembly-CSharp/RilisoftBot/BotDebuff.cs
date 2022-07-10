namespace RilisoftBot
{
	public class BotDebuff
	{
		public delegate void OnRunDelegate(BotDebuff debuff);

		public delegate void OnStopDelegate(BotDebuff debuff);

		public BotDebuffType type { get; private set; }

		public float timeLife { get; set; }

		public object parametrs { get; private set; }

		public bool isRun { get; private set; }

		public event OnRunDelegate OnRun;

		public event OnStopDelegate OnStop;

		public BotDebuff(BotDebuffType typeDebuff, float timeLifeDebuff, object parametrsDebuff)
		{
			type = typeDebuff;
			timeLife = timeLifeDebuff;
			parametrs = parametrsDebuff;
			isRun = false;
		}

		public float GetFloatParametr()
		{
			if (parametrs == null)
			{
				return 0f;
			}
			return (float)parametrs;
		}

		public void Run()
		{
			if (this.OnRun != null)
			{
				isRun = true;
				this.OnRun(this);
			}
		}

		public void Stop()
		{
			if (this.OnStop != null)
			{
				isRun = false;
				this.OnStop(this);
			}
		}

		public void ReplaceValues(float newTimeLife, object newParametrs)
		{
			timeLife = newTimeLife;
			parametrs = newParametrs;
		}
	}
}
