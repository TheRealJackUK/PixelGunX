public class AdminSettingsController
{
	public struct Avard
	{
		public int coin;

		public int expierense;
	}

	public static int minScoreDeathMath = 50;

	public static int[][] coinAvardDeathMath = new int[3][]
	{
		new int[8] { 2, 1, 1, 0, 0, 0, 0, 0 },
		new int[8] { 4, 2, 1, 0, 0, 0, 0, 0 },
		new int[8] { 6, 4, 2, 0, 0, 0, 0, 0 }
	};

	public static int[][] expAvardDeathMath = new int[3][]
	{
		new int[8] { 10, 8, 5, 3, 2, 1, 0, 0 },
		new int[8] { 20, 10, 6, 4, 3, 2, 0, 0 },
		new int[8] { 30, 15, 10, 6, 4, 2, 0, 0 }
	};

	public static int minScoreTeamFight = 50;

	public static int[][] coinAvardTeamFight = new int[3][]
	{
		new int[8] { 2, 1, 1, 0, 0, 0, 0, 0 },
		new int[8] { 4, 3, 2, 0, 0, 0, 0, 0 },
		new int[8] { 6, 4, 3, 0, 0, 0, 0, 0 }
	};

	public static int[][] expAvardTeamFight = new int[3][]
	{
		new int[8] { 10, 8, 5, 3, 0, 0, 0, 0 },
		new int[8] { 20, 10, 6, 4, 0, 0, 0, 0 },
		new int[8] { 30, 15, 10, 6, 0, 0, 0, 0 }
	};

	public static int minScoreFlagCapture = 50;

	public static int[][] coinAvardFlagCapture = new int[3][]
	{
		new int[8] { 2, 1, 1, 0, 0, 0, 0, 0 },
		new int[8] { 4, 3, 2, 0, 0, 0, 0, 0 },
		new int[8] { 6, 4, 3, 0, 0, 0, 0, 0 }
	};

	public static int[][] expAvardFlagCapture = new int[3][]
	{
		new int[8] { 10, 8, 5, 3, 0, 0, 0, 0 },
		new int[8] { 20, 10, 6, 4, 0, 0, 0, 0 },
		new int[8] { 30, 15, 10, 6, 0, 0, 0, 0 }
	};

	public static int minScoreTimeBattle = 2000;

	public static int[] coinAvardTimeBattle = new int[8] { 3, 2, 1, 1, 1, 1, 1, 1 };

	public static int[] expAvardTimeBattle = new int[8] { 20, 15, 10, 5, 5, 5, 5, 5 };

	public static int[] coinAvardDeadlyGames = new int[8] { 0, 2, 3, 4, 5, 6, 8, 10 };

	public static int[] expAvardDeadlyGames = new int[8] { 0, 10, 10, 11, 12, 13, 14, 15 };

	public static int minScoreCapturePoint = 50;

	public static int[][] coinAvardCapturePoint = new int[3][]
	{
		new int[8] { 2, 1, 1, 0, 0, 0, 0, 0 },
		new int[8] { 4, 3, 2, 0, 0, 0, 0, 0 },
		new int[8] { 6, 4, 3, 0, 0, 0, 0, 0 }
	};

	public static int[][] expAvardCapturePoint = new int[3][]
	{
		new int[8] { 10, 8, 5, 3, 0, 0, 0, 0 },
		new int[8] { 20, 10, 6, 4, 0, 0, 0, 0 },
		new int[8] { 30, 15, 10, 6, 0, 0, 0, 0 }
	};

	public static Avard GetAvardAfterMatch(ConnectSceneNGUIController.RegimGame regim, int timeGame, int place, int score, int countKills, bool isWin)
	{
		Avard result = default(Avard);
		result.coin = 0;
		result.expierense = 0;
		switch (regim)
		{
		case ConnectSceneNGUIController.RegimGame.Deathmatch:
			if (score < minScoreDeathMath)
			{
				return result;
			}
			switch (timeGame)
			{
			case 3:
				result.coin = coinAvardDeathMath[0][place];
				result.expierense = expAvardDeathMath[0][place];
				break;
			case 5:
				result.coin = coinAvardDeathMath[1][place];
				result.expierense = expAvardDeathMath[1][place];
				break;
			case 7:
				result.coin = coinAvardDeathMath[2][place];
				result.expierense = expAvardDeathMath[2][place];
				break;
			default:
				result.coin = coinAvardDeathMath[0][place];
				result.expierense = expAvardDeathMath[0][place];
				break;
			}
			result.coin *= GetMultiplyerRewardWithBoostEvent(true);
			result.expierense *= GetMultiplyerRewardWithBoostEvent(false);
			return result;
		case ConnectSceneNGUIController.RegimGame.TeamFight:
			if (score < minScoreTeamFight)
			{
				return result;
			}
			switch (timeGame)
			{
			case 3:
				result.coin = coinAvardTeamFight[0][place];
				result.expierense = expAvardTeamFight[0][place];
				break;
			case 5:
				result.coin = coinAvardTeamFight[1][place];
				result.expierense = expAvardTeamFight[1][place];
				break;
			case 7:
				result.coin = coinAvardTeamFight[2][place];
				result.expierense = expAvardTeamFight[2][place];
				break;
			default:
				result.coin = coinAvardTeamFight[0][place];
				result.expierense = expAvardTeamFight[0][place];
				break;
			}
			result.coin *= GetMultiplyerRewardWithBoostEvent(true);
			result.expierense *= GetMultiplyerRewardWithBoostEvent(false);
			return result;
		case ConnectSceneNGUIController.RegimGame.FlagCapture:
			if (score < minScoreFlagCapture)
			{
				return result;
			}
			switch (timeGame)
			{
			case 3:
				result.coin = coinAvardFlagCapture[0][place];
				result.expierense = expAvardFlagCapture[0][place];
				break;
			case 5:
				result.coin = coinAvardFlagCapture[1][place];
				result.expierense = expAvardFlagCapture[1][place];
				break;
			case 7:
				result.coin = coinAvardFlagCapture[2][place];
				result.expierense = expAvardFlagCapture[2][place];
				break;
			default:
				result.coin = coinAvardFlagCapture[0][place];
				result.expierense = expAvardFlagCapture[0][place];
				break;
			}
			result.coin *= GetMultiplyerRewardWithBoostEvent(true);
			result.expierense *= GetMultiplyerRewardWithBoostEvent(false);
			return result;
		case ConnectSceneNGUIController.RegimGame.TimeBattle:
			if (score < minScoreTimeBattle)
			{
				return result;
			}
			result.coin = coinAvardTimeBattle[place] * PremiumAccountController.Instance.RewardCoeff;
			result.expierense = expAvardTimeBattle[place] * PremiumAccountController.Instance.RewardCoeff;
			return result;
		case ConnectSceneNGUIController.RegimGame.DeadlyGames:
			if (!isWin)
			{
				return result;
			}
			result.coin = coinAvardDeadlyGames[countKills] * PremiumAccountController.Instance.RewardCoeff;
			result.expierense = coinAvardDeadlyGames[countKills] * PremiumAccountController.Instance.RewardCoeff;
			return result;
		case ConnectSceneNGUIController.RegimGame.CapturePoints:
			if (score < minScoreCapturePoint)
			{
				return result;
			}
			switch (timeGame)
			{
			case 3:
				result.coin = coinAvardCapturePoint[0][place];
				result.expierense = expAvardCapturePoint[0][place];
				break;
			case 5:
				result.coin = coinAvardCapturePoint[1][place];
				result.expierense = expAvardCapturePoint[1][place];
				break;
			case 7:
				result.coin = coinAvardCapturePoint[2][place];
				result.expierense = expAvardCapturePoint[2][place];
				break;
			default:
				result.coin = coinAvardCapturePoint[0][place];
				result.expierense = expAvardCapturePoint[0][place];
				break;
			}
			result.coin *= GetMultiplyerRewardWithBoostEvent(true);
			result.expierense *= GetMultiplyerRewardWithBoostEvent(false);
			return result;
		default:
			return result;
		}
	}

	public static int GetMultiplyerRewardWithBoostEvent(bool isMoney)
	{
		int num = 1;
		PromoActionsManager sharedManager = PromoActionsManager.sharedManager;
		PremiumAccountController instance = PremiumAccountController.Instance;
		int num2 = ((!isMoney) ? sharedManager.DayOfValorMultiplyerForExp : sharedManager.DayOfValorMultiplyerForMoney);
		if (sharedManager.IsDayOfValorEventActive && instance.IsActiveOrWasActiveBeforeStartMatch())
		{
			num = num2 + instance.GetRewardCoeffByActiveOrActiveBeforeMatch();
		}
		else if (sharedManager.IsDayOfValorEventActive)
		{
			num *= num2;
		}
		else if (instance.IsActiveOrWasActiveBeforeStartMatch())
		{
			num *= instance.GetRewardCoeffByActiveOrActiveBeforeMatch();
		}
		return num;
	}
}
