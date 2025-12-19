          // Convert backend data to SubscriptionTier format
          final tier = SubscriptionTier(
            title: planData['title'] ?? '',
            monthlyCost: '\$${planData['monthlyCost'] ?? '0.00'}',
            annualCost: '\$${planData['annualCost'] ?? '0.00'}',
            monthlyPrice: (planData['monthlyCost'] ?? 0.0).toDouble(),
            yearlyPrice: (planData['annualCost'] ?? 0.0).toDouble(),
            adSupported: planData['adSupported'] ?? '',
            audioFileType: planData['audioFileType'] ?? '',
            offlineDownloads: planData['offlineDownloads'] ?? '',
            binauralTracks: planData['binauralTracks'] ?? '',
            soundscapeTracks: planData['soundscapeTracks'] ?? '',
            dynamicAudioFeatures: planData['dynamicAudioFeatures'] ?? '',
            customTrackRequests: planData['customTrackRequests'] ?? '',
            priceId: planData['stripePriceId'] ?? '',
            monthlyPriceId: planData['stripeMonthlyPriceId'] ?? '',
            yearlyPriceId: planData['stripeYearlyPriceId'] ?? '',
          );