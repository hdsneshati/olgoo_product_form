import 'package:olgooproductform/core/dependency_injection/locator.dart';
import 'package:olgooproductform/feature/domain/auth/entity/user.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesOperator {
  SharedPreferences preferences;
  PreferencesOperator(this.preferences) {
    preferences = locator<SharedPreferences>();
  }
  String? getAccToken() {
    String? token = preferences.getString('acctoken');
    return token;
  }

  Future<String?> getRefToken() async {
    String? token = preferences.getString('reftoken');
    return token;
  }

  Future<void> refreshAccessToken(String acctoken, String reftoken) async {
    await preferences.setString('acctoken', acctoken);
    await preferences.setString('reftoken', reftoken);
  }

  void logout() {
    preferences.clear();
    preferences.setBool("onboarding-seen", true);
  }

  void saveUserData(UserEntity user) {
    preferences.setString('userName', user.name!);
    preferences.setString('userPhone', user.phone!);
    preferences.setString('userId', user.id!.toString());
    preferences.setString('role', user.role![0].toString());
    preferences.setString('acctoken', user.accToken!);
    //preferences.setString('company-name', user.company!.title);
    //preferences.setString('company-name', user.company!.title);

    preferences.setString('reftoken', user.refToken!);
  }

  void updateUserData(UserEntity user) {
    preferences.setString('userName', user.name!);
   // preferences.setString('company-name', user.company!.title);
  }

  Map<String, dynamic> getUserData() {
    final String? name = preferences.getString('userName');
    final String? phoneNumber = preferences.getString('userPhone');
    final String? id = preferences.getString('userId');
    final String? role = preferences.getString('role');
    return {
      'name': name ?? '',
      'phoneNumber': phoneNumber ?? '',
      'id': id ?? '',
      'role': role ?? '',
    };
  }

  bool isUserWatchedOnboarding() {
    return preferences.getBool('onboarding-seen') ?? false;
  }

  void userSeenOnboarding() {
    preferences.setBool('onboarding-seen', true);
  }

  void saveCompanyInfo(String id, String name) {
    preferences.setString('company-name', name);
    preferences.setString('company-id', id);
  }

  Map<String, dynamic> getCompanyInfo() {
    final String? name = preferences.getString('company-name');
    final String? id = preferences.getString('company-id');
    return {
      'name': name ?? '',
      'id': id ?? '',
    };
  }

  bool isUserLoggedInBefor() {
    String? result = preferences.getString('reftoken');
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  void recivedGift() {
    preferences.setBool("giftRecived", true);
  }

  void isRecivedGiftSubscription() {
    preferences.getBool("giftRecived");
  }
}
