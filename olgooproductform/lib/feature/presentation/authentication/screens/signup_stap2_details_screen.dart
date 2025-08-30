import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:olgooproductform/config/asset/icons_path.dart';
import 'package:olgooproductform/config/extentions/gap_space_extension.dart';
import 'package:olgooproductform/core/widgets/primary_button.dart';
import 'package:olgooproductform/core/widgets/primary_textbox.dart';
import 'package:olgooproductform/core/widgets/snackbar.dart';
import 'package:olgooproductform/core/widgets/textfield_maxline.widget.dart';
import 'package:olgooproductform/feature/presentation/authentication/bloc/auth/auth.bloc.dart';
import 'package:olgooproductform/feature/presentation/authentication/bloc/auth/auth_status.dart';

class SignupDetailsScreen extends StatelessWidget {
  SignupDetailsScreen({
   // required this.companyNameController,
    //required this.ownerNameController,
    
    super.key});
 final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController instagramNameController = TextEditingController();
 final TextEditingController companyNameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (MediaQuery.of(context).size.height * 0.14).verticalSpace,
            Padding(
              padding: const EdgeInsets.only(right: 20),
              //! app bar ------------------------------------------------------
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ثبت نام در الگو',
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
              controller: phonenumberController,
              iconPath: IconPath.company,
              title: "  شماره واتساپ (اگه دارید) ",
              hint: "شماره واتساپتون رو وارد کنید",
            ),
            8.0.verticalSpace,
            PrimaryTextBox(
              controller: instagramNameController,
              iconPath: IconPath.profile,
              title: " پیج اینستاگرام(اگه دارید)  ",
              hint: "اسم پیجتون رو وارد کنید",
            ),
            8.0.verticalSpace,
            TextFieldMaxLine(
                 title: 'توضیحاتی درباره ی محصول', 
            hint: 'مثلا جنسش چیه یا رنگبندی هاش چیه',
            controller: companyNameController,
         
            ),
             //! action button ----------------------------------------------
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status is ErrorAuthStatus) {
                      SnackBars.errorSnackBar(context, "یه مشکلی پیش اومده",
                          (state.status as ErrorAuthStatus).errorMessage);
                    } else if (state.status is SuccessRegisterUser) {
                      context.goNamed("/dashboard");
                    }
                  },
                  builder: (context, state) {
                    return Center(
                        child: PrimaryButton(
                            action: () {
                              if (state.status is! LoadingAuthStatus) {
                                BlocProvider.of<AuthBloc>(context).add(
                                    RegisterUserEvent(
                                        username: ownerNameController.text,
                                        companyName:
                                            companyNameController.text)
                                );
                              }
                            
                            },
                            isPrimaryColor: true,
                            child: state.status is! LoadingAuthStatus
                                ? Text(
                                    "ادامه ",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  )
                                : LoadingAnimationWidget.threeArchedCircle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: 30)));
                  },
                ),
                25.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}


