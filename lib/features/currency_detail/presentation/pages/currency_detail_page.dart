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
    return BlocProvider(
      create: (_) =>
          getIt<CurrencyDetailCubit>()..loadQuote(currencyCode, currencyName),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            currencyName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: AppTheme.textPrimary,
            ),
          ),
          backgroundColor: AppTheme.scaffoldBg,
          foregroundColor: AppTheme.textPrimary,
          surfaceTintColor: Colors.transparent,
        ),
        body: BlocBuilder<CurrencyDetailCubit, CurrencyDetailState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              duration: 300.ms,
              child: switch (state) {
                CurrencyDetailLoading() => const CurrencyDetailShimmer(),
                CurrencyDetailLoaded(:final quote, :final currencyName) =>
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                    child: QuoteInfoCard(
                      quote: quote,
                      currencyName: currencyName,
                      currencyCode: currencyCode,
                    ).animate().fadeIn(duration: 400.ms),
                  ),
                CurrencyDetailNoData(:final currencyName) => NoDataWidget(
                  currencyName: currencyName,
                ),
                CurrencyDetailError(:final message) => AppErrorWidget(
                  message: message,
                  onRetry: () => context.read<CurrencyDetailCubit>().loadQuote(
                    currencyCode,
                    currencyName,
                  ),
                ),
              },
            );
          },
        ),
      ),
    );
  }
}
