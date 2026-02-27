import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/core.dart';
import 'social_button.dart';

class DeveloperCredits extends StatelessWidget {
  const DeveloperCredits({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Desenvolvido por',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary.withValues(alpha: 0.6),
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Rick Ramos',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              icon: Icons.code_rounded,
              label: 'GitHub',
              onTap: () => launchUrl(
                Uri.parse('https://github.com/rickhbr'),
                mode: LaunchMode.externalApplication,
              ),
            ),
            const SizedBox(width: 16),
            SocialButton(
              icon: Icons.business_center_rounded,
              label: 'LinkedIn',
              onTap: () => launchUrl(
                Uri.parse('https://www.linkedin.com/in/rick-ramos-00a94a138/'),
                mode: LaunchMode.externalApplication,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 400.ms, delay: 600.ms);
  }
}
