import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_theme.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.redSell.withValues(alpha: 0.3),
                ),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: AppTheme.redSell,
              ),
            )
                .animate()
                .fadeIn(duration: 300.ms)
                .shake(delay: 300.ms, duration: 500.ms, hz: 3),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  onRetry!();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.gold),
                  foregroundColor: AppTheme.gold,
                ),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Tentar novamente'),
              ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
            ],
          ],
        ),
      ),
    );
  }
}
