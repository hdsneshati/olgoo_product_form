import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:olgooproductform/config/extentions/gap_space_extension.dart';
import 'package:olgooproductform/config/extentions/string_extensions.dart';
import 'package:olgooproductform/core/dependency_injection/locator.dart';
import 'package:olgooproductform/core/widgets/primary_button.dart';
import 'package:olgooproductform/core/widgets/snackbar.dart';
import 'package:olgooproductform/feature/presentation/authentication/bloc/auth/auth.bloc.dart';
import 'package:olgooproductform/feature/presentation/authentication/bloc/auth/auth_status.dart';
import 'package:olgooproductform/feature/presentation/product/bloc/product.bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:size_config/size_config.dart';

import '../../../../config/asset/icons_path.dart';
import '../../../../config/asset/svg_path.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.userPhoneNumber});
  final String userPhoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const timerDuration = 180;
  int _start = timerDuration;
  Timer? _timer;
  bool _canResend = false;

  TextEditingController pinController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    setState(() {
      _canResend = false;
    });
    _canResend = false;
    _start = timerDuration;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(locator()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //! Header ---------------------------------------------------------
              SvgPicture.asset(SvgPath.message),
              Text("کد فعالسازی به شماره ی ${widget.userPhoneNumber} ارسال شد"),
              //! text button for changing number
              TextButton(
                onPressed: () {
                  context.goNamed("/login");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconPath.edit,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    4.0.horizontalSpace,
                    Text(
                      "ویرایش شماره",
                      style: TextStyle(
                        fontFamily: "dana",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              50.h.verticalSpace,
              //! pin put --------------------------------------------------------
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (mounted) {
                    if (state.status is ErrorAuthStatus) {
                      SnackBars.errorSnackBar(
                        context,
                        "به مشکلی بر خوردیم",
                        (state.status as ErrorAuthStatus).errorMessage,
                      );
                    }
                  }
                },
                builder: (context, state) {
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      controller: pinController,
                      key: globalKey,
                      onSubmitted: (value) {
                        //todo call event
                        BlocProvider.of<AuthBloc>(context).add(
                          VerifyOtpEvent(
                            code: pinController.text,
                            phoneNumber: widget.userPhoneNumber,
                          ),
                        );
                      },
                      pinAnimationType: PinAnimationType.slide,
                      length: 5,
                      errorPinTheme: PinTheme(
                        textStyle: TextStyle(
                          fontFamily: "dana",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                      errorTextStyle: TextStyle(
                        fontFamily: "dana",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      defaultPinTheme: PinTheme(
                        textStyle: TextStyle(
                          fontFamily: "dana",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              11.0.verticalSpace,
              //!send again button -----------------------------------------------
              TextButton(
                onPressed: () {
                  if (_canResend) {
                    startTimer();
                    BlocProvider.of<AuthBloc>(context).add(
                      SendOtpEvent(widget.userPhoneNumber.removeLeadingZero()),
                    );
                  }
                },
                child: _canResend
                    ? Text(
                        "دریافت نکردید؟ ارسال مجدد",
                        style: TextStyle(
                          fontFamily: "dana",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : Text(
                        'دریافت نکردید؟ $timerText تا ارسال مجدد',
                        style: TextStyle(
                          fontFamily: "dana",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.surfaceBright,
                        ),
                      ),
              ),
              //! action button --------------------------------------------------
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status is SuccessAuthStatus) {
                      if ((state.status as SuccessAuthStatus).user.status ==
                          "ثبت نام نشده") {
                        context.goNamed(
                          "/signup",
                          extra: widget.userPhoneNumber,
                        );
                      } else if ((state.status as SuccessAuthStatus)
                              .user
                              .status ==
                          "تعلیق شده") {
                        SnackBars.errorSnackBar(
                          context,
                          "دسترسی شما محدود شده",
                          "اگر حس میکنید مشکلی پیش اومده با پشتیبانی تماس بگیرید.",
                        );
                      } else {
                        BlocProvider.of<ProductBloc>(
                          context,
                        ).add(LoadProductsFirstTimeEvent(type: "همه"));

                        context.goNamed("/dashboard");
                      }
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton(
                      isPrimaryColor: true,
                      action: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          VerifyOtpEvent(
                            code: pinController.text,
                            phoneNumber: widget.userPhoneNumber
                                .removeLeadingZero(),
                          ),
                        );
                      },
                      child: state.status is LoadingAuthStatus
                          ? Center(
                              child: LoadingAnimationWidget.threeArchedCircle(
                                color: Theme.of(context).colorScheme.surface,
                                size: 35,
                              ),
                            )
                          : Text(
                              "ورود",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
