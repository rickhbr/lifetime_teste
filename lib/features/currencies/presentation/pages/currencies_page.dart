import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../../../injection.dart';
import '../../../auth/presentation/presentation.dart';
import '../cubit/currencies_cubit.dart';
import '../cubit/currencies_state.dart';
import '../widgets/currency_list_tile.dart';
import '../widgets/currency_search_field.dart';

class CurrenciesPage extends StatelessWidget {
  const CurrenciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CurrenciesCubit>()..loadCurrencies(),
      child: const _CurrenciesView(),
    );
  }
}

class _CurrenciesView extends StatelessWidget {
  const _CurrenciesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Câmbio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => context.read<AuthCubit>().signOut(),
            tooltip: 'Sair',
          ),
        ],
      ),
      body: BlocBuilder<CurrenciesCubit, CurrenciesState>(
        builder: (context, state) {
          return switch (state) {
            CurrenciesInitial() || CurrenciesLoading() =>
              const CurrenciesListShimmer(),
            CurrenciesError(:final message) => AppErrorWidget(
                message: message,
                onRetry: () =>
                    context.read<CurrenciesCubit>().loadCurrencies(),
              ),
            CurrenciesLoaded(:final filteredCurrencies) => Column(
                children: [
                  CurrencySearchField(
                    onChanged: (query) =>
                        context.read<CurrenciesCubit>().filterCurrencies(query),
                  ),
                  Expanded(
                    child: filteredCurrencies.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.search_off_rounded,
                                  size: 56,
                                  color: AppTheme.textSecondary,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Nenhuma moeda encontrada.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: AppTheme.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: filteredCurrencies.length,
                            itemBuilder: (context, index) {
                              final currency = filteredCurrencies[index];
                              return CurrencyListTile(
                                currency: currency,
                                index: index,
                                onTap: () => context.push(
                                  '${RouteNames.currencies}/${currency.symbol}',
                                  extra: currency.name,
                                ),
                              )
                                  .animate()
                                  .fadeIn(
                                    duration: 300.ms,
                                    delay: Duration(
                                        milliseconds:
                                            (index * 50).clamp(0, 600)),
                                  )
                                  .slideY(
                                    begin: 0.1,
                                    end: 0,
                                    duration: 300.ms,
                                    delay: Duration(
                                        milliseconds:
                                            (index * 50).clamp(0, 600)),
                                  );
                            },
                          ),
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}
