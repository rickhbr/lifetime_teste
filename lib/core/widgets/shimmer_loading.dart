import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_theme.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

class CurrenciesListShimmer extends StatelessWidget {
  const CurrenciesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.surfaceLight,
      highlightColor: AppTheme.surfaceDark.withValues(alpha: 0.7),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ShimmerBox(
              width: double.infinity,
              height: 52,
              borderRadius: 12,
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 8,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (_, _) => const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: _ShimmerTile(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerTile extends StatelessWidget {
  const _ShimmerTile();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ShimmerBox(width: 44, height: 44, borderRadius: 12),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ShimmerBox(width: 160, height: 14),
              SizedBox(height: 8),
              ShimmerBox(width: 80, height: 12),
            ],
          ),
        ),
        const ShimmerBox(width: 20, height: 20, borderRadius: 10),
      ],
    );
  }
}

class CurrencyDetailShimmer extends StatelessWidget {
  const CurrencyDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.surfaceLight,
      highlightColor: AppTheme.surfaceDark.withValues(alpha: 0.7),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerBox(width: 200, height: 20),
            const SizedBox(height: 24),
            Row(
              children: const [
                Expanded(
                  child: ShimmerBox(
                    width: double.infinity,
                    height: 100,
                    borderRadius: 16,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ShimmerBox(
                    width: double.infinity,
                    height: 100,
                    borderRadius: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const ShimmerBox(
              width: double.infinity,
              height: 72,
              borderRadius: 16,
            ),
          ],
        ),
      ),
    );
  }
}
