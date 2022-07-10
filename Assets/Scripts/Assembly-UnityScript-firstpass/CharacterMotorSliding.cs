using System;

[Serializable]
public class CharacterMotorSliding
{
	public bool enabled;

	public float slidingSpeed;

	public float sidewaysControl;

	public float speedControl;

	public CharacterMotorSliding()
	{
		enabled = true;
		slidingSpeed = 15f;
		sidewaysControl = 1f;
		speedControl = 0.4f;
	}
}
