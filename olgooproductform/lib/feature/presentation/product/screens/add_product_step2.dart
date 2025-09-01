import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:olgooproductform/config/asset/svg_path.dart';
import 'package:olgooproductform/config/extentions/gap_space_extension.dart';
import 'package:olgooproductform/core/widgets/primary_button.dart';
import 'package:olgooproductform/core/widgets/primary_textbox.dart';
import 'package:olgooproductform/core/widgets/snackbar.dart';
import 'package:olgooproductform/feature/domain/product/entity/product_entity.dart';
import 'package:olgooproductform/feature/presentation/product/bloc/product.bloc.dart';
import 'package:olgooproductform/feature/presentation/product/bloc/product_status.dart';

class AddProductStep2 extends StatefulWidget {
  final TempProduct tempProduct;
  AddProductStep2({super.key, required this.tempProduct});

  @override
  State<AddProductStep2> createState() => _AddProductStep2State();
}

class _AddProductStep2State extends State<AddProductStep2> {
  TextEditingController countProductController = TextEditingController();

  TextEditingController priceProductController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                controller: countProductController,
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
             
              //!button---------------------------------------
              Spacer(),
              BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                   if (mounted) {
                        if (state.status is CreatedProductStatus) {
                          var data = (state.status as CreatedProductStatus).data;
                          SnackBars.successSnackBar(context, widget.tempProduct.title, "محصول با موفقیت ثبت شد");
                              context.pushNamed('/dashboard');
                           
                        }
                       else if (state.status is ErrorProductStatus) {
                        SnackBars.errorSnackBar(context, "error",
                            (state.status as ErrorProductStatus).msg);
                      }
                      
                      }
                },
                builder: (context, state) {
                  return Align(
                    alignment: Alignment.center,
                    child: PrimaryButton(
                      isPrimaryColor: true,
                      action: () {
                         if (widget.tempProduct.title.isEmpty) {
                              SnackBars.errorSnackBar(
                                  context, "خطا", "نام محصول را وارد کنید");
                            } else {
                               BlocProvider.of<ProductBloc>(context)
                                  .add(CreateNewProductEvent(data:widget.tempProduct.toJson()));
                          
                               }
                      },
                      child: Text(
                        "ادامه ",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  );
                },
              ),
          
              25.0.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
