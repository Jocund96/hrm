import 'package:flutter/material.dart';

class LinearProgress extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LinearProgress({super.key, required this.child, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading) const LinearProgressIndicator(backgroundColor: Colors.transparent),
        // if (isLoading) const  Center(child: CircularProgressIndicator())
      ],
    );
  }
}
