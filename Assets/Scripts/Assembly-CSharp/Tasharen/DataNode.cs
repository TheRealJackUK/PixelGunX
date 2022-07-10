using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Reflection;
using UnityEngine;

namespace Tasharen
{
	public class DataNode
	{
		public string name;

		public object value;

		public List<DataNode> children = new List<DataNode>();

		private static object[] mInvokeParams = new object[1];

		private static Dictionary<string, Type> mNameToType = new Dictionary<string, Type>();

		private static Dictionary<Type, string> mTypeToName = new Dictionary<Type, string>();

		public Type type
		{
			get
			{
				return (value == null) ? typeof(void) : value.GetType();
			}
		}

		public object Get(Type type)
		{
			return ConvertValue(value, type);
		}

		public T Get<T>()
		{
			if (value is T)
			{
				return (T)value;
			}
			object obj = Get(typeof(T));
			return (value == null) ? default(T) : ((T)obj);
		}

		public DataNode AddChild()
		{
			DataNode dataNode = new DataNode();
			children.Add(dataNode);
			return dataNode;
		}

		public DataNode AddChild(string name)
		{
			DataNode dataNode = AddChild();
			dataNode.name = name;
			return dataNode;
		}

		public DataNode AddChild(string name, object value)
		{
			DataNode dataNode = AddChild();
			dataNode.name = name;
			dataNode.value = ((!(value is Enum)) ? value : value.ToString());
			return dataNode;
		}

		public DataNode SetChild(string name, object value)
		{
			DataNode dataNode = GetChild(name);
			if (dataNode == null)
			{
				dataNode = AddChild();
			}
			dataNode.name = name;
			dataNode.value = ((!(value is Enum)) ? value : value.ToString());
			return dataNode;
		}

		public DataNode GetChild(string name)
		{
			for (int i = 0; i < children.Count; i++)
			{
				if (children[i].name == name)
				{
					return children[i];
				}
			}
			return null;
		}

		public T GetChild<T>(string name)
		{
			DataNode child = GetChild(name);
			if (child == null)
			{
				return default(T);
			}
			return child.Get<T>();
		}

		public T GetChild<T>(string name, T defaultValue)
		{
			DataNode child = GetChild(name);
			if (child == null)
			{
				return defaultValue;
			}
			return child.Get<T>();
		}

		public void Write(StreamWriter writer)
		{
			Write(writer, 0);
		}

		public void Read(StreamReader reader)
		{
			string nextLine = GetNextLine(reader);
			int offset = CalculateTabs(nextLine);
			Read(reader, nextLine, ref offset);
		}

		public void Clear()
		{
			value = null;
			children.Clear();
		}

		private string GetValueDataString()
		{
			if (value is float)
			{
				return ((float)value).ToString(CultureInfo.InvariantCulture);
			}
			if (value is Vector2)
			{
				Vector2 vector = (Vector2)value;
				return vector.x.ToString(CultureInfo.InvariantCulture) + ", " + vector.y.ToString(CultureInfo.InvariantCulture);
			}
			if (value is Vector3)
			{
				Vector3 vector2 = (Vector3)value;
				return vector2.x.ToString(CultureInfo.InvariantCulture) + ", " + vector2.y.ToString(CultureInfo.InvariantCulture) + ", " + vector2.z.ToString(CultureInfo.InvariantCulture);
			}
			if (value is Vector4)
			{
				Vector4 vector3 = (Vector4)value;
				return vector3.x.ToString(CultureInfo.InvariantCulture) + ", " + vector3.y.ToString(CultureInfo.InvariantCulture) + ", " + vector3.z.ToString(CultureInfo.InvariantCulture) + ", " + vector3.w.ToString(CultureInfo.InvariantCulture);
			}
			if (value is Quaternion)
			{
				Vector3 eulerAngles = ((Quaternion)value).eulerAngles;
				return eulerAngles.x.ToString(CultureInfo.InvariantCulture) + ", " + eulerAngles.y.ToString(CultureInfo.InvariantCulture) + ", " + eulerAngles.z.ToString(CultureInfo.InvariantCulture);
			}
			if (value is Color)
			{
				Color color = (Color)value;
				return color.r.ToString(CultureInfo.InvariantCulture) + ", " + color.g.ToString(CultureInfo.InvariantCulture) + ", " + color.b.ToString(CultureInfo.InvariantCulture) + ", " + color.a.ToString(CultureInfo.InvariantCulture);
			}
			if (value is Color32)
			{
				Color color2 = (Color32)value;
				return color2.r + ", " + color2.g + ", " + color2.b + ", " + color2.a;
			}
			if (value is Rect)
			{
				Rect rect = (Rect)value;
				return rect.x.ToString(CultureInfo.InvariantCulture) + ", " + rect.y.ToString(CultureInfo.InvariantCulture) + ", " + rect.width.ToString(CultureInfo.InvariantCulture) + ", " + rect.height.ToString(CultureInfo.InvariantCulture);
			}
			if (value != null)
			{
				return value.ToString().Replace("\n", "\\n");
			}
			return string.Empty;
		}

		private string GetValueString()
		{
			if (type == typeof(string))
			{
				return string.Concat("\"", value, "\"");
			}
			if (type == typeof(Vector2) || type == typeof(Vector3) || type == typeof(Color))
			{
				return "(" + GetValueDataString() + ")";
			}
			return string.Format("{0}({1})", TypeToName(type), GetValueDataString());
		}

		private bool SetValue(string text, Type type, string[] parts)
		{
			//Discarded unreachable code: IL_0704
			if (type == null || type == typeof(void))
			{
				value = null;
			}
			else if (type == typeof(string))
			{
				value = text;
			}
			else if (type == typeof(bool))
			{
				bool result;
				if (bool.TryParse(text, out result))
				{
					value = result;
				}
			}
			else if (type == typeof(byte))
			{
				byte result2;
				if (byte.TryParse(text, out result2))
				{
					value = result2;
				}
			}
			else if (type == typeof(short))
			{
				short result3;
				if (short.TryParse(text, out result3))
				{
					value = result3;
				}
			}
			else if (type == typeof(ushort))
			{
				ushort result4;
				if (ushort.TryParse(text, out result4))
				{
					value = result4;
				}
			}
			else if (type == typeof(int))
			{
				int result5;
				if (int.TryParse(text, out result5))
				{
					value = result5;
				}
			}
			else if (type == typeof(uint))
			{
				uint result6;
				if (uint.TryParse(text, out result6))
				{
					value = result6;
				}
			}
			else if (type == typeof(float))
			{
				float result7;
				if (float.TryParse(text, NumberStyles.Float, CultureInfo.InvariantCulture, out result7))
				{
					value = result7;
				}
			}
			else if (type == typeof(double))
			{
				double result8;
				if (double.TryParse(text, NumberStyles.Float, CultureInfo.InvariantCulture, out result8))
				{
					value = result8;
				}
			}
			else if (type == typeof(Vector2))
			{
				if (parts == null)
				{
					parts = text.Split(',');
				}
				Vector2 vector = default(Vector2);
				if (parts.Length == 2 && float.TryParse(parts[0], NumberStyles.Float, CultureInfo.InvariantCulture, out vector.x) && float.TryParse(parts[1], NumberStyles.Float, CultureInfo.InvariantCulture, out vector.y))
				{
					value = vector;
				}
			}
			else if (type == typeof(Vector3))
			{
				if (parts == null)
				{
					parts = text.Split(',');
				}
				Vector3 vector2 = default(Vector3);
				if (parts.Length == 3 && float.TryParse(parts[0], NumberStyles.Float, CultureInfo.InvariantCulture, out vector2.x) && float.TryParse(parts[1], NumberStyles.Float, CultureInfo.InvariantCulture, out vector2.y) && float.TryParse(parts[2], NumberStyles.Float, CultureInfo.InvariantCulture, out vector2.z))
				{
					value = vector2;
				}
			}
			else if (type == typeof(Vector4))
			{
				if (parts == null)
				{
					parts = text.Split(',');
				}
				Vector4 vector3 = default(Vector4);
				if (parts.Length == 4 && float.TryParse(parts[0], NumberStyles.Float, CultureInfo.InvariantCulture, out vector3.x) && float.TryParse(parts[1], NumberStyles.Float, CultureInfo.InvariantCulture, out vector3.y) && float.TryParse(parts[2], NumberStyles.Float, CultureInfo.InvariantCulture, out vector3.z) && float.TryParse(parts[3], NumberStyles.Float, CultureInfo.InvariantCulture, out vector3.w))
				{
					value = vector3;
				}
			}
			else if (type == typeof(Quaternion))
			{
				if (parts == null)
				{
					parts = text.Split(',');
				}
				Quaternion quaternion = default(Quaternion);
				if (parts.Length == 4 && float.TryParse(parts[0], NumberStyles.Float, CultureInfo.InvariantCulture, out quaternion.x) && float.TryParse(parts[1], NumberStyles.Float, CultureInfo.InvariantCulture, out quaternion.y) && float.TryParse(parts[2], NumberStyles.Float, CultureInfo.InvariantCulture, out quaternion.z) && float.TryParse(parts[3], NumberStyles.Float, CultureInfo.InvariantCulture, out quaternion.w))
				{
					value = quaternion;
				}
			}
			else if (type == typeof(Color32))
			{
				if (parts == null)
				{
					parts = text.Split(',');
				}
				Color32 color = default(Color32);
				if (parts.Length == 4 && byte.TryParse(parts[0], out color.r) && byte.TryParse(parts[1], out color.g) && byte.TryParse(parts[2], out color.b) && byte.TryParse(parts[3], out color.a))
				{
					value = color;
				}
			}
			else if (type == typeof(Color))
			{
				if (parts == null)
				{
					parts = text.Split(',');
				}
				Color color2 = default(Color);
				if (parts.Length == 4 && float.TryParse(parts[0], NumberStyles.Float, CultureInfo.InvariantCulture, out color2.r) && float.TryParse(parts[1], NumberStyles.Float, CultureInfo.InvariantCulture, out color2.g) && float.TryParse(parts[2], NumberStyles.Float, CultureInfo.InvariantCulture, out color2.b) && float.TryParse(parts[3], NumberStyles.Float, CultureInfo.InvariantCulture, out color2.a))
				{
					value = color2;
				}
			}
			else if (type == typeof(Rect))
			{
				if (parts == null)
				{
					parts = text.Split(',');
				}
				Vector4 vector4 = default(Vector4);
				if (parts.Length == 4 && float.TryParse(parts[0], NumberStyles.Float, CultureInfo.InvariantCulture, out vector4.x) && float.TryParse(parts[1], NumberStyles.Float, CultureInfo.InvariantCulture, out vector4.y) && float.TryParse(parts[2], NumberStyles.Float, CultureInfo.InvariantCulture, out vector4.z) && float.TryParse(parts[3], NumberStyles.Float, CultureInfo.InvariantCulture, out vector4.w))
				{
					value = new Rect(vector4.x, vector4.y, vector4.z, vector4.w);
				}
			}
			else
			{
				if (type.IsSubclassOf(typeof(Component)))
				{
					return false;
				}
				try
				{
					MethodInfo method = type.GetMethod("FromString", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
					if (method == null)
					{
						return false;
					}
					mInvokeParams[0] = text.Replace("\\n", "\n");
					value = method.Invoke(null, mInvokeParams);
				}
				catch (Exception ex)
				{
					Debug.LogWarning(ex.Message);
					return false;
				}
			}
			return true;
		}

		public override string ToString()
		{
			string data = string.Empty;
			Write(ref data, 0);
			return data;
		}

		private void Write(ref string data, int tab)
		{
			if (!string.IsNullOrEmpty(name))
			{
				for (int i = 0; i < tab; i++)
				{
					data += "\t";
				}
				data += Escape(name);
				if (value != null)
				{
					data = data + " = " + GetValueString();
				}
				data += "\n";
				for (int j = 0; j < children.Count; j++)
				{
					children[j].Write(ref data, tab + 1);
				}
			}
		}

		private void Write(StreamWriter writer, int tab)
		{
			if (!string.IsNullOrEmpty(name))
			{
				for (int i = 0; i < tab; i++)
				{
					writer.Write("\t");
				}
				writer.Write(Escape(name));
				if (value != null)
				{
					writer.Write(" = ");
					writer.Write(GetValueString());
				}
				writer.Write("\n");
				for (int j = 0; j < children.Count; j++)
				{
					children[j].Write(writer, tab + 1);
				}
			}
		}

		private string Read(StreamReader reader, string line, ref int offset)
		{
			if (line != null)
			{
				int num = offset;
				Set(line, num);
				line = GetNextLine(reader);
				offset = CalculateTabs(line);
				while (line != null && offset == num + 1)
				{
					line = AddChild().Read(reader, line, ref offset);
				}
			}
			return line;
		}

		private bool Set(string line, int offset)
		{
			int num = line.IndexOf("=", offset);
			if (num == -1)
			{
				name = Unescape(line.Substring(offset)).Trim();
				return true;
			}
			name = Unescape(line.Substring(offset, num - offset)).Trim();
			line = line.Substring(num + 1).Trim();
			if (line.Length < 3)
			{
				return false;
			}
			if (line[0] == '"' && line[line.Length - 1] == '"')
			{
				value = line.Substring(1, line.Length - 2);
				return true;
			}
			if (line[0] == '(' && line[line.Length - 1] == ')')
			{
				line = line.Substring(1, line.Length - 2);
				string[] array = line.Split(',');
				if (array.Length == 1)
				{
					return SetValue(line, typeof(float), null);
				}
				if (array.Length == 2)
				{
					return SetValue(line, typeof(Vector2), array);
				}
				if (array.Length == 3)
				{
					return SetValue(line, typeof(Vector3), array);
				}
				if (array.Length == 4)
				{
					return SetValue(line, typeof(Color), array);
				}
				value = line;
				return true;
			}
			Type type = typeof(string);
			int num2 = line.IndexOf('(');
			if (num2 != -1)
			{
				int num3 = ((line[line.Length - 1] != ')') ? line.LastIndexOf(')', num2) : (line.Length - 1));
				if (num3 != -1 && line.Length > 2)
				{
					string text = line.Substring(0, num2);
					type = NameToType(text);
					line = line.Substring(num2 + 1, num3 - num2 - 1);
				}
			}
			return SetValue(line, type, null);
		}

		private static string GetNextLine(StreamReader reader)
		{
			string text = reader.ReadLine();
			while (text != null && text.Trim().StartsWith("//"))
			{
				text = reader.ReadLine();
				if (text == null)
				{
					return null;
				}
			}
			return text;
		}

		private static int CalculateTabs(string line)
		{
			if (line != null)
			{
				for (int i = 0; i < line.Length; i++)
				{
					if (line[i] != '\t')
					{
						return i;
					}
				}
			}
			return 0;
		}

		private static string Escape(string val)
		{
			if (!string.IsNullOrEmpty(val))
			{
				val = val.Replace("\n", "\\n");
				val = val.Replace("\t", "\\t");
			}
			return val;
		}

		private static string Unescape(string val)
		{
			if (!string.IsNullOrEmpty(val))
			{
				val = val.Replace("\\n", "\n");
				val = val.Replace("\\t", "\t");
			}
			return val;
		}

		private static Type NameToType(string name)
		{
			Type typeFromHandle;
			if (!mNameToType.TryGetValue(name, out typeFromHandle))
			{
				typeFromHandle = Type.GetType(name);
				if (typeFromHandle == null)
				{
					switch (name)
					{
					case "String":
						typeFromHandle = typeof(string);
						break;
					case "Vector2":
						typeFromHandle = typeof(Vector2);
						break;
					case "Vector3":
						typeFromHandle = typeof(Vector3);
						break;
					case "Vector4":
						typeFromHandle = typeof(Vector4);
						break;
					case "Quaternion":
						typeFromHandle = typeof(Quaternion);
						break;
					case "Color":
						typeFromHandle = typeof(Color);
						break;
					case "Rect":
						typeFromHandle = typeof(Rect);
						break;
					case "Color32":
						typeFromHandle = typeof(Color32);
						break;
					}
				}
				mNameToType[name] = typeFromHandle;
			}
			return typeFromHandle;
		}

		private static string TypeToName(Type type)
		{
			string text;
			if (!mTypeToName.TryGetValue(type, out text))
			{
				text = type.ToString();
				if (text.StartsWith("System."))
				{
					text = text.Substring(7);
				}
				if (text.StartsWith("UnityEngine."))
				{
					text = text.Substring(12);
				}
				mTypeToName[type] = text;
			}
			return text;
		}

		private static object ConvertValue(object value, Type type)
		{
			if (type.IsAssignableFrom(value.GetType()))
			{
				return value;
			}
			if (type.IsEnum)
			{
				if (value.GetType() == typeof(int))
				{
					return value;
				}
				if (value.GetType() == typeof(string))
				{
					string text = (string)value;
					if (!string.IsNullOrEmpty(text))
					{
						string[] names = Enum.GetNames(type);
						for (int i = 0; i < names.Length; i++)
						{
							if (names[i] == text)
							{
								return Enum.GetValues(type).GetValue(i);
							}
						}
					}
				}
			}
			return null;
		}
	}
}
