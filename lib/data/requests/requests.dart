class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

class RegisterRequest {
  String userName;
  String countryMobileCode;
  String mobile;
  String email;
  String password;
  String profilePicture;
  RegisterRequest(this.email, this.password, this.userName,
      this.countryMobileCode, this.mobile, this.profilePicture);
}
