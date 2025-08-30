
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:olgooproductform/core/resource/data_state.dart';
import 'package:olgooproductform/feature/domain/auth/usecase/auth.usecase.dart';
import 'package:olgooproductform/feature/presentation/authentication/bloc/auth/auth_status.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCases useCases;
  AuthBloc(this.useCases) : super(AuthState(status: InintialAuthStatus())) {
    //! check user info event
    on<SendOtpEvent>((event, emit) async {
      emit(AuthState(status: LoadingAuthStatus()));
      DataState data = await useCases.loginUsecase(event.phoneNumber!);

      if (data is SuccessData) {
        print('data is : ${data.data}');
        emit(state.copyWith(newStatus: NeedOTPStatus()));
      } else {
        emit(state.copyWith(newStatus: ErrorAuthStatus(data.error!)));
      }
    });
    //! verfy otp code
    on<VerifyOtpEvent>(
      (event, emit) async {
        emit(AuthState(status: LoadingAuthStatus()));
        DataState data =
            await useCases.verfiyOtp(event.phoneNumber, event.code);
        if (data is SuccessData) {
          emit(state.copyWith(newStatus: SuccessAuthStatus(user: data.data)));
        } else {
          emit(state.copyWith(newStatus: ErrorAuthStatus(data.error!)));
        }
      },
    );
    //! register user
    on<RegisterUserEvent>(
      (event, emit) async {
        emit(AuthState(status: LoadingAuthStatus()));
        DataState data =
            await useCases.registerUser(event.username, event.companyName);
        if (data is SuccessData) {
          emit(state.copyWith(newStatus: SuccessRegisterUser(user: data.data)));
        } else {
          emit(state.copyWith(newStatus: ErrorAuthStatus(data.error!)));
        }
      },
    );
    on<ReciveGiftSubscription>((event, emit) {
      useCases.reciveGiftSubscription();
      emit(AuthState(status: InintialAuthStatus()));
    });    
    on<LogOutEvent>((event, emit) {
      useCases.logout();
      emit(AuthState(status: InintialAuthStatus()));
    });  

    on<SendResignOtpEvent>((event, emit) async {
      emit(AuthState(status: LoadingAuthStatus()));
      DataState data = await useCases.sendResignOtp();

      if (data is SuccessData) {
        print('data is : ${data.data}');
        emit(state.copyWith(newStatus: SuccessSendResignOTP()));
      } else {
        emit(state.copyWith(newStatus: ErrorAuthStatus(data.error!)));
      }
    });
    //! verfy otp code
    on<VerifyResignOtpEvent>(
      (event, emit) async {
        emit(AuthState(status: LoadingAuthStatus()));
        DataState data =
            await useCases.verfiyResignOtp(event.phoneNumber, event.code);
        if (data is SuccessData) {
          emit(state.copyWith(newStatus: SuccessResigned()));
        } else {
          emit(state.copyWith(newStatus: ErrorAuthStatus(data.error!)));
        }
      },
    );

  }
}
