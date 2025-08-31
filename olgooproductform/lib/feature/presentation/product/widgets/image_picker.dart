import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olgooproductform/config/asset/svg_path.dart';

class ImagePickerContainer extends StatefulWidget {
   ImagePickerContainer({super.key, this.onImageSelected});
  final ValueChanged<XFile?>? onImageSelected;

  @override
  State<ImagePickerContainer> createState() => _ImagePickerContainerState();
}



class _ImagePickerContainerState extends State<ImagePickerContainer> {
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
                
           height: 150,
          child: _image == null
              ? Container(
                width: MediaQuery.of(context).size.width * 0.79,
                  height: 145,
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
                ): ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                  child: kIsWeb
                    ? Image.network(_image!.path, fit: BoxFit.cover)
                    : Image.file(File(_image!.path), fit: BoxFit.cover),
                ),
        ),
      ),
    );
  }
}
