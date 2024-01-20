import 'package:grorange/models/ItemConsumptionLevel.dart';

class ItemService {

  static ItemConsumptionLevel getLevelFromPercentage(double consumption){
    if (consumption >= .75) {
      return ItemConsumptionLevel.FULL;
    }

    if (consumption >= .50) {
      return ItemConsumptionLevel.ALMOST_FULL;
    }

    if (consumption >= .25) {
      return ItemConsumptionLevel.ALMOST_EMPTY;
    }

    return ItemConsumptionLevel.EMPTY;
  }

  static String itemConsumptionLevelString(ItemConsumptionLevel? level){
    switch (level) {
      case ItemConsumptionLevel.FULL:
        return "Full";
      case ItemConsumptionLevel.ALMOST_FULL:
        return "Almost Full";
      case ItemConsumptionLevel.ALMOST_EMPTY:
        return "Almost Empty";
      case ItemConsumptionLevel.EMPTY:
        return "Empty";
      default:
        return "-";
    }
  }
}