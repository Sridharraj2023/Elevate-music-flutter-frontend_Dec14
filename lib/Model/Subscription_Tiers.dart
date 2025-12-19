// models/subscription_tier.dart
class SubscriptionTier {
  final String title;
  final String monthlyCost;
  final String annualCost;
  final double monthlyPrice;
  final double yearlyPrice;
  final String adSupported;
  final String audioFileType;
  final String offlineDownloads;
  final String binauralTracks;
  final String soundscapeTracks;
  final String dynamicAudioFeatures;
  final String customTrackRequests;
  final String priceId; // Keep for backward compatibility
  final String monthlyPriceId;
  final String yearlyPriceId;

  SubscriptionTier({
    required this.title,
    required this.monthlyCost,
    required this.annualCost,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.adSupported,
    required this.audioFileType,
    required this.offlineDownloads,
    required this.binauralTracks,
    required this.soundscapeTracks,
    required this.dynamicAudioFeatures,
    required this.customTrackRequests,
    required this.priceId,
    required this.monthlyPriceId,
    required this.yearlyPriceId,
  });

  // Helper methods to get formatted prices
  String get formattedMonthlyPrice => '\$${monthlyPrice.toStringAsFixed(2)}';
  String get formattedYearlyPrice => '\$${yearlyPrice.toStringAsFixed(2)}';
  String get formattedMonthlyCost => monthlyCost.isNotEmpty ? monthlyCost : formattedMonthlyPrice;
  String get formattedAnnualCost => annualCost.isNotEmpty ? annualCost : formattedYearlyPrice;
}