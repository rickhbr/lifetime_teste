import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/core.dart';
import '../widgets/developer_credits.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.gold, AppTheme.goldLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.gold.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.currency_exchange,
                    size: 44,
                    color: AppTheme.scaffoldBg,
                  ),
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      duration: 500.ms,
                    ),
                const SizedBox(height: 20),
                Text(
                  'FX Câmbio',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.gold,
                      ),
                )
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 150.ms)
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      duration: 400.ms,
                      delay: 150.ms,
                    ),
                const SizedBox(height: 8),
                Text(
                  'Câmbio em tempo real',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                ).animate().fadeIn(duration: 400.ms, delay: 300.ms),
                const SizedBox(height: 48),
                const LoginForm(),
                const SizedBox(height: 40),
                const DeveloperCredits(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
