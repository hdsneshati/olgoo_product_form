import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:olgooproductform/config/asset/svg_path.dart';
import 'package:size_config/size_config.dart';

class PrimaryAvatar extends StatelessWidget {
  const PrimaryAvatar({super.key, required this.onTap, required this.file});

  final VoidCallback? onTap;
  final  file;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
           padding: const EdgeInsets.only(left: 8, right: 0, top: 2),
          margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
         
          child: file == null
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.79,
                height: 145.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff367CFF)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        SvgPath.leadingAdornment,
                        width: 62,
                        height: 62,
                        color: Color(0xff367CFF)
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        " تصویر محصول را بارگذاری کنید",
                         style: TextStyle(
                    fontFamily: "dana",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,color: Color(0xff367CFF)),
                      ),
                    ],
                  ),
              )
              : Image.file(file, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
