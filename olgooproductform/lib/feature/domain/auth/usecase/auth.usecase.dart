import 'package:olgooproductform/feature/date/auth/impl/auth_impl_repository.dart';
import 'package:olgooproductform/feature/domain/auth/entity/user.entity.dart';

import '../../../../core/resource/data_state.dart';

class AuthUseCases {
  AuthRepositoryIMPL authRepository;
  AuthUseCases(this.authRepository);

  Future<DataState<dynamic>> loginUsecase(String phoneNumber) {
    return authRepository.login(phoneNumber);
  }

  Future<DataState<UserEntity>> verfiyOtp(String phoneNumebr, String code) {
    return authRepository.verifyOTP(phoneNumebr, code);
  }

  Future<DataState<UserEntity>> registerUser(
      String username, String companyName) {
    return authRepository.registerUser(username, companyName);
  }

  void reciveGiftSubscription() {
    authRepository.reciveGiftSubscription();
  }

  void logout() {
    authRepository.logout();
  }

  Future<DataState<dynamic>> sendResignOtp() {
    return authRepository.sendResignOtp();
  }

  Future<DataState<dynamic>>  verfiyResignOtp(String phoneNumber, String code) {
    return authRepository.verfiyResignOtp(phoneNumber, code);
  }
}
