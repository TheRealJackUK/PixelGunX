using System;
using System.IO;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class CrashReporter : MonoBehaviour
	{
		private string _reportText = string.Empty;

		private string _reportTime = string.Empty;

		private bool _showReport;

		internal void OnGUI()
		{
			float num = ((Screen.dpi != 0f) ? Screen.dpi : 160f);
			if (GUILayout.Button("Simulate exception", GUILayout.Width(1f * num)))
			{
				throw new InvalidOperationException(DateTime.Now.ToString("s"));
			}
			GUILayout.Label("Report path: " + Application.persistentDataPath);
			if (!string.IsNullOrEmpty(_reportText))
			{
				_showReport = GUILayout.Toggle(_showReport, "Show: " + _reportTime);
				if (_showReport)
				{
					GUILayout.Label(_reportText);
				}
			}
		}

		internal void Start()
		{
			if (Debug.isDebugBuild)
			{
				AppDomain.CurrentDomain.UnhandledException += HandleException;
				string[] files = Directory.GetFiles(Application.persistentDataPath, "Report_*.txt", SearchOption.TopDirectoryOnly);
				if (files.Length > 0)
				{
					string path = files[files.Length - 1];
					_reportTime = Path.GetFileNameWithoutExtension(path);
					_reportText = File.ReadAllText(path);
				}
			}
			else
			{
				base.enabled = false;
			}
		}

		private static void HandleException(object sender, UnhandledExceptionEventArgs e)
		{
			Exception ex = e.ExceptionObject as Exception;
			if (ex != null)
			{
				string path = string.Format("Report_{0:s}.txt", DateTime.Now).Replace(':', '-');
				string path2 = Path.Combine(Application.persistentDataPath, path);
				File.WriteAllText(path2, ex.ToString());
			}
		}
	}
}
