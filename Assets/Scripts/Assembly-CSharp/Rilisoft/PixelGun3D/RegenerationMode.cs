using System.Collections;
using UnityEngine;

namespace Rilisoft.PixelGun3D
{
	public sealed class RegenerationMode : MonoBehaviour
	{
		private Player_move_c _playerController;

		private void Start()
		{
		}

		private IEnumerator IncrementHealth()
		{
			while (true)
			{
				yield return new WaitForSeconds(1f);
				if (_playerController != null && _playerController.CurHealth < _playerController.MaxHealth)
				{
					_playerController.CurHealth += 1f;
				}
			}
		}
	}
}
