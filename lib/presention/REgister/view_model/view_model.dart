// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:advanced_flutter/App/functions.dart';
import 'package:advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/base/base_view_model.dart';
import 'package:advanced_flutter/presention/common/freez.dart';
import 'package:advanced_flutter/presention/common/state_render/state_render.dart';
import 'package:advanced_flutter/presention/common/state_render/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController mobileStreamController =
      StreamController<String>.broadcast();
  final StreamController emailStreamController =
      StreamController<String>.broadcast();
  final StreamController passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController profilePictureStreamController =
      StreamController<File>.broadcast();
  final StreamController areAllInputValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserRegisterStreamController = StreamController<bool>();



  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("", "", "", "", "", "");
  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    userNameStreamController.close();
    mobileStreamController.close();
    emailStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    areAllInputValidStreamController.close();
    isUserRegisterStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputEmail => emailStreamController.sink;

  @override
  Sink get inputMobile => mobileStreamController.sink;

  @override
  Sink get inputPassword => passwordStreamController.sink;

  @override
  Sink get inputProfilePicture => profilePictureStreamController.sink;

  @override
  Sink get inputUserName => userNameStreamController.sink;

  // output
  @override
  Stream<bool> get outIsInputEmail =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outErrorEmailValid => outIsInputEmail
      .map((isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail);

  @override
  Stream<bool> get outIsInputMobile =>
      mobileStreamController.stream.map((mobile) => isMobileValid(mobile));

  @override
  Stream<bool> get outIsInputPassword => passwordStreamController.stream
      .map((password) => isPasswordValid(password));

  @override
  Stream<File> get outIsInputProfilePicture =>
      profilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outIsUserNameValid => userNameStreamController.stream
      .map((userName) => isUsernameValid(userName));

  @override
  Stream<String?> get outErrorMobileValid => outIsInputMobile
      .map((isMobileValid) => isMobileValid ? null : AppStrings.invalidMobile);

  @override
  Stream<String?> get outErrorPasswordValid => outIsInputPassword.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.invalidPassword);

  @override
  Stream<String?> get outErrorUserNameValid => outIsUserNameValid
      .map((isUsername) => isUsername ? null : AppStrings.invalidUsername);
// private functions
  bool isUsernameValid(String userName) {
    return userName.length >= 8;
  }

  bool isMobileValid(String mobile) {
    return mobile.length >= 10;
  }

  bool isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool areAllInputValid() {
    return registerObject.email.isNotEmpty &&
        registerObject.userName.isNotEmpty&&
           registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty &&
        registerObject.mobile.isNotEmpty;
  }

  Validate(){
    allInputValid.add(null);
  }

  @override
  Register() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: AppStrings.loading));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerObject.email,
            registerObject.password,
            registerObject.userName,
            registerObject.countryMobileCode,
            registerObject.mobile,
            registerObject.profilePicture)))
        .fold((failure) {
      print(failure.code);
      inputState.add(
          ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
      if (failure.code == -7) {
        inputState.add(ContentState());
        isUserRegisterStreamController.add(true);
      }
    }, (data) {
      inputState.add(ContentState());
      isUserRegisterStreamController.add(true);

    });
  }

  @override
  setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    Validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    Validate();
  }

  @override
  setMobile(String mobile) {
    inputMobile.add(mobile);
    if (isMobileValid(mobile)) {
      registerObject = registerObject.copyWith(mobile: mobile);
    } else {
      registerObject = registerObject.copyWith(mobile: "");
    }
    Validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    Validate();

  }

  @override
  setProfilePicture(File profilePicture) {
    inputProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    Validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    if (isUsernameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    Validate();
  }

  @override
  Sink get allInputValid => areAllInputValidStreamController.sink;


  @override
  Stream<bool> get isAllInputValid => areAllInputValidStreamController.stream.map((_) => areAllInputValid());






}

abstract class RegisterViewModelInput {
  Sink get inputUserName;
  Sink get inputMobile;
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputProfilePicture;
  Sink get allInputValid;


  Register();

  setUserName(String userName);
  setMobile(String mobile);
  setCountryCode(String countryCode);
  setPassword(String password);
  setEmail(String email);
  setProfilePicture(File profilePicture);
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outIsUserNameValid;
  Stream<String?> get outErrorUserNameValid;

  Stream<bool> get outIsInputMobile;
  Stream<String?> get outErrorMobileValid;

  Stream<bool> get outIsInputEmail;
  Stream<String?> get outErrorEmailValid;

  Stream<bool> get outIsInputPassword;
  Stream<String?> get outErrorPasswordValid;

  Stream<File> get outIsInputProfilePicture;

  Stream<bool> get isAllInputValid;


}
