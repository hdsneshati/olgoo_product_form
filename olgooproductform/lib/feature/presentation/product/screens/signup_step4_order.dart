import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:olgooproductform/config/asset/svg_path.dart';
import 'package:olgooproductform/config/extentions/gap_space_extension.dart';
import 'package:olgooproductform/core/widgets/primary_button.dart';
import 'package:olgooproductform/core/widgets/primary_textbox.dart';
import 'package:olgooproductform/feature/domain/product/entity/product_entity.dart';

class SignupStep4Order extends StatefulWidget {
   final TempProduct tempProduct;
   SignupStep4Order({super.key, required this.tempProduct});

  @override
  State<SignupStep4Order> createState() => _SignupStep4OrderState();
}

class _SignupStep4OrderState extends State<SignupStep4Order> {
 TextEditingController nameProductController = TextEditingController();

  TextEditingController priceProductController = TextEditingController();

 late TextEditingController minOrderController;

  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    // مقادیر اولیه رو از TempProduct بگیر
    minOrderController =
        TextEditingController(text: widget.tempProduct.minOrder?.toString() ?? '');
    priceController =
        TextEditingController(text: widget.tempProduct.price?.toString() ?? '');
  }

  @override
  void dispose() {
    minOrderController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            title: "  حداقل میزان سفارش  ",
            hint: "عنوان محصول رو وارد کنید",
          ),
          8.0.verticalSpace,
           PrimaryTextBox(
            controller: priceProductController,
            iconPath: SvgPath.leadingAdornment,
            title: "  قیمت محصول ",
            hint: "عنوان محصول رو وارد کنید",
           // countText: "هر عدد",
          ),
         // 8.0.verticalSpace,
          //!button---------------------------------------
         //   (MediaQuery.of(context).size.height * 0.1).verticalSpace,
        Spacer(),
          Align(
            alignment: Alignment.center,
            child: PrimaryButton(
              isPrimaryColor: true,
              action: (dynamic imageHandler) {
               
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
      )
      
      );
  }
}