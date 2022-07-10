using UnityEngine;

namespace I2.Loc
{
	public class LanguagePopup : MonoBehaviour
	{
		public LanguageSource Source;

		private void Start()
		{
			UIPopupList component = GetComponent<UIPopupList>();
			component.items = Source.GetLanguages();
			EventDelegate.Add(component.onChange, OnValueChange);
			component.value = LocalizationManager.CurrentLanguage;
		}

		public void OnValueChange()
		{
			LocalizationStore.CurrentLanguage = UIPopupList.current.value;
		}
	}
}
