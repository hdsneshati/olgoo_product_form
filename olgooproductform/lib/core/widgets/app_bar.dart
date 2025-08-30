import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({super.key, required this.child});

  @override
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          height: preferredSize.height,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
             
               ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: child,
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
