import 'package:flutter/material.dart';

class MountObserver extends StatefulWidget {
  const MountObserver({super.key, required this.onMount, required this.child});

  final void Function() onMount;
  final Widget child;

  @override
  State<MountObserver> createState() => _MountObserverState();
}

class _MountObserverState extends State<MountObserver> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onMount();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
