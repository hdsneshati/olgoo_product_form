import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:olgooproductform/config/asset/theme/color_pallet.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:size_config/size_config.dart';

class PrimaryTextBox extends StatefulWidget {
  const PrimaryTextBox({
    super.key,
    required this.controller,
    this.isObsecure = false,
    required this.iconPath,
    required this.title,
    required this.hint,
    this.isNumbricKeyboard = false,
    this.countText = " ",
  });
  final TextEditingController controller;
  final bool isObsecure;
  final String iconPath;
  final bool? isNumbricKeyboard;
  final String title;
  final String hint;
  final String countText;
  @override
  State<PrimaryTextBox> createState() => _PrimaryTextBoxState();
}

class _PrimaryTextBoxState extends State<PrimaryTextBox> {
  bool isFocusedIcon = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 42, top: 8),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.titleSmall,
              )),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8, right: 0, top: 2),
          margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
          width: MediaQuery.of(context).size.width * 0.79,
          height: 48,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.surface),
          child: Align(
              alignment: Alignment.center,
              child: TextField(
                keyboardType: (widget.isNumbricKeyboard == true ||
                        widget.isObsecure == true)
                    ? TextInputType.number
                    : TextInputType.text,
                style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.surfaceBright),
                obscureText: widget.isObsecure,
                controller: widget.controller,
               
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorPallet.lightColorScheme.surfaceBright,
                        width: 1.0), // Custom border
                    borderRadius: BorderRadius.circular(
                        10.0), // Optional: round the border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: ColorPallet.lightColorScheme.primary,
                        width: 1), // Focused border style
                  ),
                  hintText: widget.hint,
                  prefixText:widget.countText,
                  hintStyle: TextStyle(
                      fontFamily: "dana",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.surfaceBright),
                  prefixIcon: SvgPicture.asset(
                    widget.iconPath,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.surfaceBright,
                        BlendMode.srcIn),
                    fit: BoxFit.scaleDown,
                  ),
                  border: InputBorder.none,
                ),
              )),
        ),
      ],
    );
  }
}

class FormTextBox extends StatelessWidget {
  const FormTextBox(
      {super.key,
      this.controller,
      this.suffix,
      required this.isObsecure,
      required this.iconPath,
      this.pricingType = false,
      this.isNumbricKeyboard,
      required this.title,
      required this.hint,
      this.action,
      this.onChanged});
  final TextEditingController? controller;
  final bool isObsecure;
  final bool? pricingType;
  final String iconPath;
  final bool? isNumbricKeyboard;
  final String title;
  final String hint;
  final Widget? suffix;
  final Function? action;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 16.h, top: 8.h),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              )),
        ),
        Container(
          padding: EdgeInsets.only(left: 0, right: 0, top: 0.h, bottom: 0),
          margin: EdgeInsets.only(top: 2.h, right: 16.h, left: 16.h),
          width: double.maxFinite,
          height: 40.h,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.surface),
          child: TextField(
            onChanged: (value) {
              if (pricingType == true) {
              final formattedValue = value.replaceAll(',', '').seRagham();
              controller!.value = controller!.value.copyWith(
                text: formattedValue,
                selection:
                    TextSelection.collapsed(offset: formattedValue.length),
              );
              }

            },
            onSubmitted: (value) {
              if (action != null) {
                action!();
              }
            },
            textAlignVertical: TextAlignVertical.center,
            textDirection: TextDirection.rtl,
            maxLines: 1,
            textAlign: TextAlign.right,
            keyboardType: (isNumbricKeyboard == true || isObsecure == true)
                ? TextInputType.number
                : TextInputType.text,
            style: TextStyle(
                fontFamily: "dana",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.surfaceBright),
            obscureText: isObsecure,
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 4.h),
              suffixIcon: suffix,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: ColorPallet.lightColorScheme.surfaceBright,
                    width: 1.0), // Custom border
                borderRadius:
                    BorderRadius.circular(4.0), // Optional: round the border
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(
                    color: ColorPallet.lightColorScheme.primary,
                    width: 1), // Focused border style
              ),
              hintText: hint,
              hintStyle: TextStyle(
                  fontFamily: "dana",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.surfaceBright),
              prefixIcon: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.surfaceBright,
                    BlendMode.srcIn),
                fit: BoxFit.scaleDown,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
