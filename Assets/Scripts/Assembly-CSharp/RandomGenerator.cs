public class RandomGenerator
{
	private const uint B = 1842502087u;

	private const uint C = 1357980759u;

	private const uint D = 273326509u;

	private static uint counter;

	private uint a;

	private uint b;

	private uint c;

	private uint d;

	public RandomGenerator(uint val)
	{
		SetSeed(val);
	}

	public RandomGenerator()
	{
		SetSeed(counter++);
	}

	public uint GenerateUint()
	{
		uint num = a ^ (a << 11);
		a = b;
		b = c;
		c = d;
		return d = d ^ (d >> 19) ^ (num ^ (num >> 8));
	}

	public int Range(int max)
	{
		return (int)((long)GenerateUint() % (long)max);
	}

	public int Range(int min, int max)
	{
		return min + (int)((long)GenerateUint() % (long)(max - min));
	}

	public float GenerateFloat()
	{
		return 2.3283064E-10f * (float)GenerateUint();
	}

	public float GenerateRangeFloat()
	{
		uint num = GenerateUint();
		return 4.656613E-10f * (float)(int)num;
	}

	public double GenerateDouble()
	{
		return 2.3283064370807974E-10 * (double)GenerateUint();
	}

	public double GenerateRangeDouble()
	{
		uint num = GenerateUint();
		return 4.656612874161595E-10 * (double)(int)num;
	}

	public void SetSeed(uint val)
	{
		a = val;
		b = val ^ 0x6DD259C7u;
		c = (val >> 5) ^ 0x50F12457u;
		d = (val >> 7) ^ 0x104AA1ADu;
		for (uint num = 0u; num < 4; num++)
		{
			a = GenerateUint();
		}
	}
}
