enum ItemConsumptionLevel {
  safe(text: 'Full', minPercentage: 75, maxPercentage: 100),
  moderate(text: 'Almost Full', minPercentage: 50, maxPercentage: 75),
  severe(text: 'Almost Empty', minPercentage: 25, maxPercentage: 50),
  critical(text: 'Empty', minPercentage: 0, maxPercentage: 25);

  final String text;
  final int minPercentage;
  final int maxPercentage;

  const ItemConsumptionLevel({
    required this.text,
    required this.minPercentage,
    required this.maxPercentage,
  });

  static ItemConsumptionLevel getLevelFromPercentage(double consumption){
    if (consumption >= .75) {
      return ItemConsumptionLevel.safe;
    }

    if (consumption >= .50) {
      return ItemConsumptionLevel.moderate;
    }

    if (consumption >= .25) {
      return ItemConsumptionLevel.severe;
    }

    return ItemConsumptionLevel.critical;
  }
}
