// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:advanced_flutter/App/di.dart';
import 'package:advanced_flutter/App/shared_pref.dart';
import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/base/base_view_model.dart';
import 'package:advanced_flutter/presention/common/freez.dart';
import 'package:advanced_flutter/presention/common/state_render/state_render.dart';
import 'package:advanced_flutter/presention/common/state_render/state_renderer_impl.dart';


class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserLoginStreamController = StreamController<bool>();


  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _passwordStreamController.close();
    _userNameStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoginStreamController.close();
  }

  @override
  void start() {
    // view model should tell view please show content state
    inputState.add(ContentState());
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputValidation.add(null);
  }

  @override
  setUserPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputValidation.add(null);
  }

  @override
  Login() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE,message: AppStrings.loading));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure){
                  print(failure.code);
              inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message));
              if(failure.code==-7){
                inputState.add(ContentState());
                isUserLoginStreamController.add(true);
              }
                },
            (data){
              inputState.add(ContentState());
              isUserLoginStreamController.add(true);
            });
  }

  @override
  Stream<bool> get OutIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get OutIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;
  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  @override
  Stream<bool> get OutputValidation =>
      _areAllInputsValidStreamController.stream.map((_) => _areAllInputValid());

  @override
  Sink get inputValidation => _areAllInputsValidStreamController.sink;

  bool _areAllInputValid(){
    return _isUserNameValid(loginObject.userName)&&_isPasswordValid(loginObject.password);
  }
}

abstract class LoginViewModelInput {
  setUserName(String userName);
  setUserPassword(String password);
  Login();
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputValidation;
}

abstract class LoginViewModelOutput {
  Stream<bool> get OutIsUserNameValid;
  Stream<bool> get OutIsPasswordValid;
  Stream<bool> get OutputValidation;
}
