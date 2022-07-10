using UnityEngine;

namespace RilisoftBot
{
	public class BotAnimationEventHandler : MonoBehaviour
	{
		public delegate void OnDamageEventDelegate();

		public event OnDamageEventDelegate OnDamageEvent;

		private void OnApplyShootEffect()
		{
			if (this.OnDamageEvent != null)
			{
				this.OnDamageEvent();
			}
		}
	}
}
