import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olgooproductform/config/asset/svg_path.dart';
import 'package:olgooproductform/config/theme/color_pallet.dart';
import 'package:size_config/size_config.dart';

class IconPicker extends StatefulWidget {
  IconPicker({super.key, this.onImageSelected});
  final ValueChanged<XFile?>? onImageSelected;

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
      widget.onImageSelected?.call(_image);
    }
  }

  void _showPickOptionsDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text("انتخاب از گالری"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("گرفتن عکس با دوربین"),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _showPickOptionsDialog,
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 0, top: 2),
          margin: const EdgeInsets.only(top: 8, right: 8, left: 8),
          width: MediaQuery.of(context).size.width * 0.8,

          height: 83.h,
          child: Row(
            children: [
              _image == null
                  ? Container(
                      width: 90.w,
                      height: 83.h,
                      decoration: BoxDecoration(
                        color: Color(0xffECECEC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              SvgPath.profile,
                              width: 53,
                              height: 52,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: SvgPicture.asset(
                                SvgPath.editSquare,
                                width: 18.5,
                                height: 18.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: kIsWeb
                          ? Image.network(_image!.path, fit: BoxFit.cover)
                          : Image.file(File(_image!.path), fit: BoxFit.cover),
                    ),

              Padding(
                padding: const EdgeInsets.all(3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'تصویر لوگوی خود را بارگذاری کنید',
                      style: TextStyle(
                        fontFamily: "dana",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                     margin: EdgeInsets.only(right: 3),
                      width: 93.w,
                      height: 31.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff3280FF),
                      ),
                      child: Center(
                        child: Text(
                          'بارگذاری عکس',
                          style: TextStyle(
                            fontFamily: "dana",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorPallet.lightColorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
