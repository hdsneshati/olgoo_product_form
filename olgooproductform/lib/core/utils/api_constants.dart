class ApiConstants {
  static const String domainName = "https://api2-dev.olgooapp.ir/";
  static const String login = "otp/"; //send phone number as param
  static const String signup = "user";
  static const String verfiyOtp =
      "otpVerify"; //takes jason body -- phoneNumber , otp
  static const String refreshToken =
      "refresh/"; //takes jason body -- phoneNumber , otp
  //! otpverfiy ex : 9391556862  -- no 0 in first of phone number
  static const String getCompany =
      "company/"; //takes jason body -- phoneNumber , otp
  static const String getGroup = "group/";

  static const String privacy =
      "privacy-policy";

  static const String docs = "https://docs.olgooapp.ir/";

  static const String customersGroup = "group";

  static const String summary = "summary";

  static const String order = "order";

  static const String product = "product";

  static const String sms = "sms";

  static const String subscription = "subscription";

  static const String sendResignOtp = "resign/";

  static const String verfiyResignOtp = "resignVerify/" ; //send phone number as param

}
