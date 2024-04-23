import 'package:flutter/material.dart';
import 'package:patrimony/uikit/components/base/app_store.dart';

class AppScopedBuilder extends StatefulWidget {
  final AppStore store;
  final Widget child;
  const AppScopedBuilder({super.key, required this.child, required this.store});

  @override
  State<AppScopedBuilder> createState() => _AppScopedBuilderState();
}

class _AppScopedBuilderState extends State<AppScopedBuilder> {

  @override
  void initState() {
    widget.store.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Visibility(
            visible: widget.store.isLoading,
            child: const Center(child: CircularProgressIndicator())
        ),
        Visibility(
            visible: widget.store.isError,
            child: const SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Center(
                    child: Text('Ocorreu um erro, tente novamente mais tarde'),
                ),
            ),
        )
      ],
    );
  }
}