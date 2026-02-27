import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'meta_data_row.dart';
import 'rate_card.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class QuoteInfoCard extends StatelessWidget {
  final CurrencyQuoteEntity quote;
  final String currencyName;
  final String currencyCode;

  const QuoteInfoCard({
    super.key,
    required this.quote,
    required this.currencyName,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm', 'pt_BR');
    final spread = quote.sellRate - quote.buyRate;
    final symbol = CurrencyUtils.symbolForCurrency(currencyCode);
    final midRate = (quote.buyRate + quote.sellRate) / 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero: currency name + main rate
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.surfaceDark,
                AppTheme.surfaceDark.withValues(alpha: 0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      currencyName,
                      style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppTheme.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      symbol,
                      style: const TextStyle(
                        color: AppTheme.gold,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                numberFormat.format(midRate),
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                      letterSpacing: -1,
                      fontSize: 36,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Cotação média  •  ${dateFormat.format(quote.quoteDateTime)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.05, end: 0, duration: 400.ms),

        const SizedBox(height: 16),

        // Buy / Sell side by side
        Row(
          children: [
            Expanded(
              child: RateCard(
                label: 'Compra',
                value: numberFormat.format(quote.buyRate),
                icon: Icons.south_west_rounded,
                color: AppTheme.greenBuy,
                delay: 150,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RateCard(
                label: 'Venda',
                value: numberFormat.format(quote.sellRate),
                icon: Icons.north_east_rounded,
                color: AppTheme.redSell,
                delay: 250,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Spread
        Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.swap_vert_rounded,
                      color: AppTheme.gold,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Spread',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    numberFormat.format(spread),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.gold,
                        ),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms, delay: 350.ms)
            .slideY(begin: 0.05, end: 0, duration: 400.ms, delay: 350.ms),

        const SizedBox(height: 24),

        // Info section
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            'DETALHES',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.textSecondary.withValues(alpha: 0.6),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ).animate().fadeIn(duration: 300.ms, delay: 400.ms),
        Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.border),
              ),
              child: Column(
                children: [
                  MetadataRow(
                    icon: Icons.access_time_rounded,
                    label: 'Última atualização',
                    value: dateFormat.format(quote.quoteDateTime),
                  ),
                  Divider(
                    height: 1,
                    color: AppTheme.border.withValues(alpha: 0.5),
                    indent: 56,
                  ),
                  MetadataRow(
                    icon: Icons.description_outlined,
                    label: 'Boletim',
                    value: quote.bulletinType,
                  ),
                  Divider(
                    height: 1,
                    color: AppTheme.border.withValues(alpha: 0.5),
                    indent: 56,
                  ),
                  MetadataRow(
                    icon: Icons.swap_horiz_rounded,
                    label: 'Par',
                    value: '$currencyCode / BRL',
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 400.ms, delay: 450.ms)
            .slideY(begin: 0.05, end: 0, duration: 400.ms, delay: 450.ms),
      ],
    );
  }
}
