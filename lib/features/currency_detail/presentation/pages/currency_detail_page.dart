import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../injection.dart';
import '../cubit/currency_detail_cubit.dart';
import '../cubit/currency_detail_state.dart';
import '../widgets/no_data_widget.dart';
import '../widgets/quote_info_card.dart';

class CurrencyDetailPage extends StatelessWidget {
  final String currencyCode;
  final String currencyName;

  const CurrencyDetailPage({
    super.key,
    required this.currencyCode,
    required this.currencyName,
  });

  @override
  Widget build(BuildContext context) {
    final flag = CurrencyUtils.flagForCurrency(currencyCode);
    final symbol = CurrencyUtils.symbolForCurrency(currencyCode);

    return BlocProvider(
      create: (_) =>
          getIt<CurrencyDetailCubit>()..loadQuote(currencyCode, currencyName),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 220,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  currencyCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppTheme.gold,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppTheme.scaffoldBg, AppTheme.surfaceDark],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceLight,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppTheme.gold.withValues(alpha: 0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.gold.withValues(alpha: 0.15),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            flag,
                            style: const TextStyle(fontSize: 40),
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 500.ms)
                            .scale(
                              begin: const Offset(0.8, 0.8),
                              end: const Offset(1, 1),
                              duration: 500.ms,
                            ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.gold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            symbol,
                            style: const TextStyle(
                              color: AppTheme.gold,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 400.ms, delay: 200.ms),
                      ],
                    ),
                  ),
                ),
              ),
              backgroundColor: AppTheme.scaffoldBg,
              foregroundColor: AppTheme.gold,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: BlocBuilder<CurrencyDetailCubit, CurrencyDetailState>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: 300.ms,
                    child: switch (state) {
                      CurrencyDetailLoading() =>
                        const CurrencyDetailShimmer(),
                      CurrencyDetailLoaded(
                        :final quote,
                        :final currencyName
                      ) =>
                        QuoteInfoCard(
                          quote: quote,
                          currencyName: currencyName,
                          currencyCode: currencyCode,
                        ).animate().fadeIn(duration: 400.ms),
                      CurrencyDetailNoData(:final currencyName) =>
                        NoDataWidget(currencyName: currencyName),
                      CurrencyDetailError(:final message) => AppErrorWidget(
                          message: message,
                          onRetry: () => context
                              .read<CurrencyDetailCubit>()
                              .loadQuote(currencyCode, currencyName),
                        ),
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
