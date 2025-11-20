class DrawConfig {
  const DrawConfig({
    required this.entryFee,
    required this.maxEntriesPerDraw,
    required this.finalistsPerDraw,
  });

  final double entryFee;
  final int maxEntriesPerDraw;
  final int finalistsPerDraw;
}
