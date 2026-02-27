import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/presentation/presentation.dart';
import '../../features/currencies/presentation/presentation.dart';
import '../../features/currency_detail/presentation/presentation.dart';
import 'go_router_refresh_stream.dart';
import 'route_names.dart';

@lazySingleton
class AppRouter {
  final AuthCubit _authCubit;

  AppRouter(this._authCubit);

  late final GoRouter router = GoRouter(
    initialLocation: RouteNames.currencies,
    refreshListenable: GoRouterRefreshStream(_authCubit.stream),
    redirect: (context, state) {
      final isAuthenticated = _authCubit.state is Authenticated;
      final isLoggingIn = state.matchedLocation == RouteNames.login;

      if (!isAuthenticated && !isLoggingIn) {
        return RouteNames.login;
      }
      if (isAuthenticated && isLoggingIn) {
        return RouteNames.currencies;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.currencies,
        builder: (context, state) => const CurrenciesPage(),
      ),
      GoRoute(
        path: RouteNames.currencyDetail,
        builder: (context, state) {
          final code = state.pathParameters['code']!;
          final name = state.extra as String? ?? code;
          return CurrencyDetailPage(
            currencyCode: code,
            currencyName: name,
          );
        },
      ),
    ],
  );
}
