import 'package:flutter/material.dart';
import 'package:olgooproductform/config/asset/theme/color_pallet.dart';


     

class TextFieldMaxLine extends StatefulWidget {
  const TextFieldMaxLine({
    super.key,
    required this.controller,      
    required this.title,
    required this.hint,
    
  });
  final TextEditingController controller;
  
  final String title;
  final String hint;

  @override
  State<TextFieldMaxLine> createState() => _TextFieldMaxLineState();
}

class _TextFieldMaxLineState extends State<TextFieldMaxLine> {
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
          height: 128,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.surface),
          child: Align(
              alignment: Alignment.center,
              child: TextField(
                maxLines: 5,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.surfaceBright),
             //   obscureText: widget.isObsecure,
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
                  hintStyle: TextStyle(
                      fontFamily: "dana",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.surfaceBright),
                
                  border: InputBorder.none,
                ),
              )),
        ),
      ],
    );
  }
}

