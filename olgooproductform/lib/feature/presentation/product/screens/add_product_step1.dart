import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olgooproductform/config/asset/svg_path.dart';
import 'package:olgooproductform/config/extentions/gap_space_extension.dart';
import 'package:olgooproductform/core/utils/image_handler.dart';
import 'package:olgooproductform/core/widgets/primary_button.dart';
import 'package:olgooproductform/core/widgets/primary_textbox.dart';
import 'package:olgooproductform/core/widgets/textfield_maxline.widget.dart';
import 'package:olgooproductform/feature/domain/product/entity/product_entity.dart';
import 'package:olgooproductform/feature/presentation/product/widgets/image_picker.dart';
import 'package:size_config/size_config.dart';

class AddProductStep1 extends StatefulWidget {
 const AddProductStep1({super.key});

  @override
  State<AddProductStep1> createState() => _AddProductStep1State();
}

class _AddProductStep1State extends State<AddProductStep1> {
  TextEditingController titleProductController = TextEditingController();

  TextEditingController descriptionProductController = TextEditingController();
 ImageHandler imageHandler = ImageHandler();
XFile? _selectedImage; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
            (MediaQuery.of(context).size.height * 0.06).verticalSpace,
            Padding(
              padding: const EdgeInsets.only(right: 20),
              //! app bar ------------------------------------------------------
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' بیشتر راجب خودتون بگید  ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  (MediaQuery.of(context).size.height * 0.013).verticalSpace,
                  Text(
                    'یک حساب کاربری بسازید و شروع کنید',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            (MediaQuery.of(context).size.height * 0.025).verticalSpace,
            //! forms ------------------------------------------------------------
            PrimaryTextBox(
              controller: titleProductController,
              iconPath: SvgPath.leadingAdornment,
              title: "  عنوان محصول ",
              hint: "عنوان محصول رو وارد کنید",
            ),
            8.0.verticalSpace,
            TextFieldMaxLine(
              title: 'توضیحاتی درباره ی محصول',
              hint: 'مثلا جنسش چیه یا رنگبندی هاش چیه',
              controller: descriptionProductController,
            ),
            30.0.h.verticalSpace,
            //!image--------------------------
           // PrimaryAvatar(
            //  onTap:() async => await imageHandler
              //                .pickAndCropImage(source: ImageSource.gallery),
                              //.then((value) => setState(() {})),
              //            file: imageHandler.getImage),
             ImagePickerContainer(
               onImageSelected: (image) {
                setState(() {
                  _selectedImage = image;
                });
              },
             ),
            //!button---------------------------------------
             
              Spacer(),
            Align(
              alignment: Alignment.center,
              child: PrimaryButton(
                isPrimaryColor: true,
                action: () {
                    final tempProduct = TempProduct(
                  title: titleProductController.text,
                  description: descriptionProductController.text,
                  imgPath:  _selectedImage!.path ?? '',
                );
                   
                context.pushNamed(
                  "addproductstep2",
                  extra: tempProduct,
                );
                },
                child: Text(
                  "ادامه ",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
              25.0.verticalSpace,
          
             ],
        ),
      ),
    );
  }
}
