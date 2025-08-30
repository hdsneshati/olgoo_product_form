import 'package:flutter/material.dart';
import 'package:olgooproductform/config/asset/svg_path.dart';
import 'package:olgooproductform/config/extentions/gap_space_extension.dart';
import 'package:olgooproductform/core/widgets/primary_button.dart';
import 'package:olgooproductform/core/widgets/primary_textbox.dart';

class SignupStep4Order extends StatelessWidget {
   SignupStep4Order({super.key});
  TextEditingController nameProductController = TextEditingController();
  TextEditingController priceProductController = TextEditingController();

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
              action: () {},
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