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
    final flag = CurrencyUtils.flagForCurrency(currencyCode);
    final symbol = CurrencyUtils.symbolForCurrency(currencyCode);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currencyName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          '$currencyCode → BRL',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.gold.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            symbol,
                            style: const TextStyle(
                              color: AppTheme.gold,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(duration: 300.ms),
          const SizedBox(height: 24),
          RateCard(
            label: 'Compra',
            value: numberFormat.format(quote.buyRate),
            icon: Icons.south_west_rounded,
            color: AppTheme.greenBuy,
            delay: 150,
          ),
          const SizedBox(height: 12),
          RateCard(
            label: 'Venda',
            value: numberFormat.format(quote.sellRate),
            icon: Icons.north_east_rounded,
            color: AppTheme.redSell,
            delay: 250,
          ),
          const SizedBox(height: 12),
          Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.swap_vert_rounded,
                        color: AppTheme.gold,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spread',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.textSecondary),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          numberFormat.format(spread),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.gold,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 350.ms)
              .slideY(begin: 0.1, end: 0, duration: 400.ms, delay: 350.ms),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'INFORMAÇÕES',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.textSecondary,
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
                      label: 'Data/hora',
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
                      icon: Icons.flag_rounded,
                      label: 'Par',
                      value: '$currencyCode / BRL',
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms, delay: 450.ms)
              .slideY(begin: 0.1, end: 0, duration: 400.ms, delay: 450.ms),
        ],
      ),
    );
  }
}
