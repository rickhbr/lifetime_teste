import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/core.dart';

class NoDataWidget extends StatelessWidget {
  final String currencyName;

  const NoDataWidget({super.key, required this.currencyName});

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
                border: Border.all(color: AppTheme.border),
              ),
              child: const Icon(
                Icons.event_busy_rounded,
                size: 40,
                color: AppTheme.textSecondary,
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 400.ms),
            const SizedBox(height: 16),
            Text(
              'Sem cotação disponível',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
            ).animate().fadeIn(delay: 150.ms, duration: 300.ms),
            const SizedBox(height: 8),
            Text(
              'Não há cotação para $currencyName hoje.\n'
              'Isso pode ocorrer em fins de semana ou feriados.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
          ],
        ),
      ),
    );
  }
}
