using System.Collections.Generic;
using UnityEngine;

namespace Prime31
{
	public class FacebookEventListener : MonoBehaviour
	{
		private void OnEnable()
		{
			FacebookManager.sessionOpenedEvent += sessionOpenedEvent;
			FacebookManager.loginFailedEvent += loginFailedEvent;
			FacebookManager.dialogCompletedWithUrlEvent += dialogCompletedWithUrlEvent;
			FacebookManager.dialogFailedEvent += dialogFailedEvent;
			FacebookManager.graphRequestCompletedEvent += graphRequestCompletedEvent;
			FacebookManager.graphRequestFailedEvent += facebookCustomRequestFailed;
			FacebookManager.facebookComposerCompletedEvent += facebookComposerCompletedEvent;
			FacebookManager.reauthorizationFailedEvent += reauthorizationFailedEvent;
			FacebookManager.reauthorizationSucceededEvent += reauthorizationSucceededEvent;
			FacebookManager.shareDialogFailedEvent += shareDialogFailedEvent;
			FacebookManager.shareDialogSucceededEvent += shareDialogSucceededEvent;
		}

		private void OnDisable()
		{
			FacebookManager.sessionOpenedEvent -= sessionOpenedEvent;
			FacebookManager.loginFailedEvent -= loginFailedEvent;
			FacebookManager.dialogCompletedWithUrlEvent -= dialogCompletedWithUrlEvent;
			FacebookManager.dialogFailedEvent -= dialogFailedEvent;
			FacebookManager.graphRequestCompletedEvent -= graphRequestCompletedEvent;
			FacebookManager.graphRequestFailedEvent -= facebookCustomRequestFailed;
			FacebookManager.facebookComposerCompletedEvent -= facebookComposerCompletedEvent;
			FacebookManager.reauthorizationFailedEvent -= reauthorizationFailedEvent;
			FacebookManager.reauthorizationSucceededEvent -= reauthorizationSucceededEvent;
			FacebookManager.shareDialogFailedEvent -= shareDialogFailedEvent;
			FacebookManager.shareDialogSucceededEvent -= shareDialogSucceededEvent;
		}

		private void sessionOpenedEvent()
		{
			Debug.Log("Successfully logged in to Facebook");
		}

		private void loginFailedEvent(P31Error error)
		{
			Debug.Log("Facebook login failed: " + error);
		}

		private void dialogCompletedWithUrlEvent(string url)
		{
			Debug.Log("dialogCompletedWithUrlEvent: " + url);
		}

		private void dialogFailedEvent(P31Error error)
		{
			Debug.Log("dialogFailedEvent: " + error);
		}

		private void facebokDialogCompleted()
		{
			Debug.Log("facebokDialogCompleted");
		}

		private void graphRequestCompletedEvent(object obj)
		{
			Debug.Log("graphRequestCompletedEvent");
			Utils.logObject(obj);
		}

		private void facebookCustomRequestFailed(P31Error error)
		{
			Debug.Log("facebookCustomRequestFailed failed: " + error);
		}

		private void facebookComposerCompletedEvent(bool didSucceed)
		{
			Debug.Log("facebookComposerCompletedEvent did succeed: " + didSucceed);
		}

		private void reauthorizationSucceededEvent()
		{
			Debug.Log("reauthorizationSucceededEvent");
		}

		private void reauthorizationFailedEvent(P31Error error)
		{
			Debug.Log("reauthorizationFailedEvent: " + error);
		}

		private void shareDialogFailedEvent(P31Error error)
		{
			Debug.Log("shareDialogFailedEvent: " + error);
		}

		private void shareDialogSucceededEvent(Dictionary<string, object> dict)
		{
			Debug.Log("shareDialogSucceededEvent");
			Utils.logObject(dict);
		}
	}
}
