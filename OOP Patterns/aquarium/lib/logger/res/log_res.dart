import 'package:aquarium/pool/pool_state.dart';
import 'package:aquarium/res/strings.dart';

/// Строки для логирования
class LogRes {
  static const staffCleanPool = 'Персонал почистил бассейн';
  static const staffServeFishes = 'Персонал обслужил рыб';
  static const staffSetNormalTemp =
      'Персонал установил нормальную температуру $normalTemperature ${AppStrings.celsiusDegree}';

  static String changingTemp(double temp) =>
      'Температура в бассейне стала $temp ${AppStrings.celsiusDegree}';
  static const fishBirth = 'Родилась новая рыба';

  static const oldFishDeath = 'Рыба умерла от старости';
  static const hungryFishDeath = 'Рыба умерла от голода';
  static const reactPoolFishDeath = 'Условия среды погубили рыбу';
}
