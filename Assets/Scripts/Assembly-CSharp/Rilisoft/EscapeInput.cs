using System;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class EscapeInput : MonoBehaviour
	{
		private static bool _disposed;

		private bool _escapePressed;

		private static EscapeInput _instance;

		public static EscapeInput Instance
		{
			get
			{
				if (_disposed)
				{
					throw new ObjectDisposedException(typeof(EscapeInput).Name);
				}
				if (_instance == null)
				{
					_instance = UnityEngine.Object.FindObjectOfType<EscapeInput>();
					if (_instance == null)
					{
						GameObject gameObject = new GameObject(typeof(EscapeInput).Name + " Singleton");
						UnityEngine.Object.DontDestroyOnLoad(gameObject);
						gameObject.SetActive(true);
						_instance = gameObject.AddComponent<EscapeInput>();
					}
				}
				return _instance;
			}
		}

		public bool Pressed
		{
			get
			{
				return _escapePressed;
			}
		}

		private EscapeInput()
		{
		}

		private void DoUpdate()
		{
			_escapePressed = Input.GetKeyUp(KeyCode.Escape);
		}

		public void Reset()
		{
			_escapePressed = false;
		}

		private void OnDestroy()
		{
			_disposed = true;
		}

		private void Start()
		{
			_escapePressed = Input.GetKeyUp(KeyCode.Escape);
		}

		private void Update()
		{
			DoUpdate();
		}
	}
}
