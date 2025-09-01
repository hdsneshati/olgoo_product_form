import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:size_config/size_config.dart';

import '../../config/asset/svg_path.dart';

class EmptyState extends StatelessWidget {
  const EmptyState(
      {super.key,
      required this.title,
      this.actionButton,
      required this.isError,
      this.action});

  static const animationDuration = 2;
  static const animationTranslate = 10.0;

  final Function? action;
  final String title;
  final Widget? actionButton;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => action?.call(),
            child: SvgPicture.asset(
              isError ? SvgPath.connection : SvgPath.noResult,
              width: 150.h,
              height: 150.h,
            )
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: true))
                .moveY(
                    begin: -animationTranslate,
                    end: animationTranslate,
                    duration: animationDuration.seconds,
                    curve: Curves.easeInOut),
          ),
          Text(title),
          16.h.verticalSpacer,
          actionButton ?? const SizedBox()
        ],
      ),
    );
  }
}
