enum ItemConsumptionLevel {
  safe(text: 'Safe', minPercentage: 70, maxPercentage: 100),
  moderate(text: 'Moderate', minPercentage: 40, maxPercentage: 69),
  severe(text: 'Severe', minPercentage: 39, maxPercentage: 20),
  critical(text: 'Critical', minPercentage: 0, maxPercentage: 19);

  final String text;
  final int minPercentage;
  final int maxPercentage;

  const ItemConsumptionLevel({
    required this.text,
    required this.minPercentage,
    required this.maxPercentage,
  });
}
