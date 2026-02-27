import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';
import 'core/routes/app_router.dart';
import 'features/auth/presentation/presentation.dart';
import 'injection.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthCubit>(),
      child: MaterialApp.router(
        title: 'FX Câmbio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: getIt<AppRouter>().router,
      ),
    );
  }
}
