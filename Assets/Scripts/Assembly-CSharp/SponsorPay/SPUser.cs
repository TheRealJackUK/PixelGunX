using System;
using System.Collections.Generic;
using System.Globalization;
using LitJson;
using UnityEngine;

namespace SponsorPay
{
	public abstract class SPUser
	{
		private class JsonResponse<T> : AbstractResponse
		{
			public string key { get; set; }

			public T value { get; set; }

			public string error { get; set; }
		}

		protected const string AGE = "age";

		protected const string BIRTHDATE = "birthdate";

		protected const string GENDER = "gender";

		protected const string SEXUAL_ORIENTATION = "sexual_orientation";

		protected const string ETHNICITY = "ethnicity";

		protected const string MARITAL_STATUS = "marital_status";

		protected const string NUMBER_OF_CHILDRENS = "children";

		protected const string ANNUAL_HOUSEHOLD_INCOME = "annual_household_income";

		protected const string EDUCATION = "education";

		protected const string ZIPCODE = "zipcode";

		protected const string INTERESTS = "interests";

		protected const string IAP = "iap";

		protected const string IAP_AMOUNT = "iap_amount";

		protected const string NUMBER_OF_SESSIONS = "number_of_sessions";

		protected const string PS_TIME = "ps_time";

		protected const string LAST_SESSION = "last_session";

		protected const string CONNECTION = "connection";

		protected const string DEVICE = "device";

		protected const string APP_VERSION = "app_version";

		protected const string SPLOCATION = "splocation";

		public void Reset()
		{
			NativeReset();
		}

		public virtual int? GetAge()
		{
			return Get<int?>("age");
		}

		public void SetAge(int age)
		{
			Put("age", age);
		}

		public DateTime? GetBirthdate()
		{
			string s = Get<string>("birthdate");
			DateTime result;
			if (DateTime.TryParseExact(s, "yyyy/MM/dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out result))
			{
				return result;
			}
			return null;
		}

		public void SetBirthdate(DateTime birthdate)
		{
			Put("birthdate", birthdate);
		}

		public virtual SPUserGender? GetGender()
		{
			return Get<SPUserGender?>("gender");
		}

		public void SetGender(SPUserGender gender)
		{
			Put("gender", gender);
		}

		public virtual SPUserSexualOrientation? GetSexualOrientation()
		{
			return Get<SPUserSexualOrientation?>("sexual_orientation");
		}

		public void SetSexualOrientation(SPUserSexualOrientation sexualOrientation)
		{
			Put("sexual_orientation", sexualOrientation);
		}

		public virtual SPUserEthnicity? GetEthnicity()
		{
			return Get<SPUserEthnicity?>("ethnicity");
		}

		public void SetEthnicity(SPUserEthnicity ethnicity)
		{
			Put("ethnicity", ethnicity);
		}

		public SPLocation GetLocation()
		{
			return Get<SPLocation>("splocation");
		}

		public void SetLocation(SPLocation location)
		{
			Put("splocation", location);
		}

		public virtual SPUserMaritalStatus? GetMaritalStatus()
		{
			return Get<SPUserMaritalStatus?>("marital_status");
		}

		public void SetMaritalStatus(SPUserMaritalStatus maritalStatus)
		{
			Put("marital_status", maritalStatus);
		}

		public virtual int? GetNumberOfChildrens()
		{
			return Get<int?>("children");
		}

		public void SetNumberOfChildrens(int numberOfChildrens)
		{
			Put("children", numberOfChildrens);
		}

		public virtual int? GetAnnualHouseholdIncome()
		{
			return Get<int?>("annual_household_income");
		}

		public void SetAnnualHouseholdIncome(int annualHouseholdIncome)
		{
			Put("annual_household_income", annualHouseholdIncome);
		}

		public virtual SPUserEducation? GetEducation()
		{
			return Get<SPUserEducation?>("education");
		}

		public void SetEducation(SPUserEducation education)
		{
			Put("education", education);
		}

		public string GetZipcode()
		{
			return Get<string>("zipcode");
		}

		public void SetZipcode(string zipcode)
		{
			Put("zipcode", zipcode);
		}

		public string[] GetInterests()
		{
			return Get<string[]>("interests");
		}

		public void SetInterests(string[] interests)
		{
			Put("interests", interests);
		}

		public virtual bool? GetIap()
		{
			return Get<bool?>("iap");
		}

		public void SetIap(bool iap)
		{
			Put("iap", iap);
		}

		public virtual float? GetIapAmount()
		{
			double? num = Get<double?>("iap_amount");
			return (!num.HasValue) ? null : new float?((float)num.Value);
		}

		public void SetIapAmount(float iap_amount)
		{
			Put("iap_amount", (double)iap_amount);
		}

		public virtual int? GetNumberOfSessions()
		{
			return Get<int?>("number_of_sessions");
		}

		public void SetNumberOfSessions(int numberOfSessions)
		{
			Put("number_of_sessions", numberOfSessions);
		}

		public virtual long? GetPsTime()
		{
			return Get<long?>("ps_time");
		}

		public void SetPsTime(long ps_time)
		{
			Put("ps_time", ps_time);
		}

		public virtual long? GetLastSession()
		{
			return Get<long?>("last_session");
		}

		public void SetLastSession(long lastSession)
		{
			Put("last_session", lastSession);
		}

		public virtual SPUserConnection? GetConnection()
		{
			return Get<SPUserConnection?>("connection");
		}

		public void SetConnection(SPUserConnection connection)
		{
			Put("connection", connection);
		}

		public string GetDevice()
		{
			return Get<string>("device");
		}

		public void SetDevice(string device)
		{
			Put("device", device);
		}

		public string GetAppVersion()
		{
			return Get<string>("app_version");
		}

		public void SetAppVersion(string appVersion)
		{
			Put("app_version", appVersion);
		}

		public void PutCustomValue(string key, string value)
		{
			Put(key, value);
		}

		public string GetCustomValue(string key)
		{
			return Get<string>(key);
		}

		private void Put(string key, object value)
		{
			string json = GeneratePutJsonString(key, value);
			NativePut(json);
		}

		protected abstract void NativePut(string json);

		protected abstract void NativeReset();

		protected abstract string GetJsonMessage(string key);

		protected T Get<T>(string key)
		{
			string jsonMessage = GetJsonMessage(key);
			JsonResponse<T> jsonResponse = JsonMapper.ToObject<JsonResponse<T>>(jsonMessage);
			if (jsonResponse.success)
			{
				return jsonResponse.value;
			}
			Debug.Log(jsonResponse.error);
			return default(T);
		}

		private string GeneratePutJsonString(string key, object value)
		{
			Dictionary<string, object> dictionary = new Dictionary<string, object>();
			dictionary.Add("action", "put");
			dictionary.Add("key", key);
			dictionary.Add("type", value.GetType().ToString());
			if (value is DateTime)
			{
				dictionary.Add("value", ((DateTime)value).ToString("yyyy/MM/dd"));
			}
			else
			{
				dictionary.Add("value", value);
			}
			return JsonMapper.ToJson(dictionary);
		}

		protected string GenerateGetJsonString(string key)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("action", "get");
			dictionary.Add("key", key);
			return JsonMapper.ToJson(dictionary);
		}
	}
}
