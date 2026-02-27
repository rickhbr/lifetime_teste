import 'dart:async';

import 'package:flutter/material.dart';

class CurrencySearchField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const CurrencySearchField({super.key, required this.onChanged});

  @override
  State<CurrencySearchField> createState() => _CurrencySearchFieldState();
}

class _CurrencySearchFieldState extends State<CurrencySearchField> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onChanged(value);
    });
    setState(() {});
  }

  void _clear() {
    _controller.clear();
    widget.onChanged('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        onChanged: _onChanged,
        decoration: InputDecoration(
          hintText: 'Buscar moeda...',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: _clear,
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
