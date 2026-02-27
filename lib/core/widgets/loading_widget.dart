import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const CircularProgressIndicator()
          .animate()
          .fadeIn(duration: 300.ms),
    );
  }
}
