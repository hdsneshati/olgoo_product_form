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
import 'package:olgooproductform/feature/presentation/product/widgets/primary_avatar.dart';
import 'package:size_config/size_config.dart';

class SignupStep3Product extends StatefulWidget {
 const SignupStep3Product({super.key});

  @override
  State<SignupStep3Product> createState() => _SignupStep3ProductState();
}

class _SignupStep3ProductState extends State<SignupStep3Product> {
  TextEditingController nameProductController = TextEditingController();

  TextEditingController ProductController = TextEditingController();
 ImageHandler imageHandler = ImageHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
            controller: nameProductController,
            iconPath: SvgPath.leadingAdornment,
            title: "  عنوان محصول ",
            hint: "عنوان محصول رو وارد کنید",
          ),
          8.0.verticalSpace,
          TextFieldMaxLine(
            title: 'توضیحاتی درباره ی محصول',
            hint: 'مثلا جنسش چیه یا رنگبندی هاش چیه',
            controller: ProductController,
          ),
          30.0.h.verticalSpace,
          //!image--------------------------
          PrimaryAvatar(
            onTap: () async {
              await imageHandler
                  .pickAndCropImage(source: ImageSource.gallery)
                  .then((ValueKey) {
                    setState(() {});
                  });
            },
            file: imageHandler.getImage,
          ),
          //!button---------------------------------------
            (MediaQuery.of(context).size.height * 0.1).verticalSpace,
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: PrimaryButton(
              isPrimaryColor: true,
              action: () {
                  final tempProduct = TempProduct(
                title: nameProductController.text,
                description: priceProductController.text,
                imgPath: imageHandler.getImage?.path ?? '',
              );

              context.pushNamed(
                '/signupstep4order',
                extra: tempProduct,
              );
              },
              child: Text(
                "ادامه ",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
            (MediaQuery.of(context).size.height * 0.05).verticalSpace,
        
           ],
      ),
    );
  }
}
