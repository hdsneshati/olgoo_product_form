
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.isPrimaryColor,
    required this.action,
    required this.child,
  });
  final Function action;
  final Widget child;
  final bool isPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Theme.of(context).colorScheme.outline,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        action();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 48,
        
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient:  LinearGradient(colors: isPrimaryColor ? [Theme.of(context).colorScheme.primary,Theme.of(context).colorScheme.primaryFixed]: [Theme.of(context).colorScheme.secondary,Theme.of(context).colorScheme.secondary])),
        child: Center(child: child),
      ),
    );
  }
}
