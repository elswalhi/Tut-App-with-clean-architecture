import 'dart:io';
import 'package:advanced_flutter/App/constance.dart';
import 'package:advanced_flutter/App/di.dart';
import 'package:advanced_flutter/App/shared_pref.dart';
import 'package:advanced_flutter/presention/REgister/view_model/view_model.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/Resourses/ValuesManger.dart';
import 'package:advanced_flutter/presention/Resourses/assets%20manger.dart';
import 'package:advanced_flutter/presention/Resourses/colors.dart';
import 'package:advanced_flutter/presention/Resourses/routs%20manger.dart';
import 'package:advanced_flutter/presention/common/state_render/state_renderer_impl.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController =
  TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _mobileEditingController =
      TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();


  _bind() {
    _viewModel.start();
    _userNameEditingController.addListener(() {
      _viewModel.setUserName(_userNameEditingController.text);
    });
    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });
    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });
    _mobileEditingController.addListener(() {
      _viewModel.setMobile(_mobileEditingController.text);
    });
    _viewModel.isUserRegisterStreamController.stream.listen((isRegister){
      if(isRegister){
        //navigate to screen
        SchedulerBinding.instance.addPersistentFrameCallback((_) {
          _appPreferences.setLoginScreenViewed();
          Navigator.of(context).pushReplacementNamed(Routs.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManger.white,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.Register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsetsDirectional.only(top: AppPadding.p22),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage(ImageAssets.splashLogo)),
              const SizedBox(
                height: AppSize.s22,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                child: Column(
                  children: [
                    //username
                    StreamBuilder<String?>(
                        stream: _viewModel.outErrorUserNameValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            controller: _userNameEditingController,
                            decoration: InputDecoration(
                                hintText: AppStrings.username.tr(),
                                labelText: AppStrings.username.tr(),
                                errorText: snapshot.data),
                          );
                        }),
                    const SizedBox(
                      height: AppSize.s18,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (country) {
                              _viewModel.setCountryCode(
                                  country.dialCode ?? Constance.token);
                            },
                            initialSelection: "+20",
                            showCountryOnly: true,
                            showOnlyCountryWhenClosed: true,
                            hideMainText: true,
                            favorite: const ["+39", 'FR', "+966"],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: StreamBuilder<String?>(
                              stream: _viewModel.outErrorMobileValid,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _mobileEditingController,
                                  decoration: InputDecoration(
                                      hintText: AppStrings.mobile.tr(),
                                      labelText: AppStrings.mobile.tr(),
                                      errorText: snapshot.data),
                                );
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s18,
                    ),
                    //email
                    StreamBuilder<String?>(
                        stream: _viewModel.outErrorEmailValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailEditingController,
                            decoration: InputDecoration(
                                hintText: AppStrings.email.tr(),
                                labelText: AppStrings.email.tr(),
                                errorText: snapshot.data),
                          );
                        }),
                    const SizedBox(
                      height: AppSize.s18,
                    ),
                    //password
                    StreamBuilder<String?>(
                        stream: _viewModel.outErrorPasswordValid,
                        builder: (context, snapshot) {
                          return TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordEditingController,
                            decoration: InputDecoration(
                                hintText: AppStrings.password.tr(),
                                labelText: AppStrings.password.tr(),
                                errorText: snapshot.data),
                          );
                        }),
                    const SizedBox(
                      height: AppSize.s18,
                    ),
                    Container(
                      height: AppSize.s40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all( Radius.circular(AppSize.s8)),
                          border: Border.all(color: ColorManger.grey)
                      ),
                      child: GestureDetector(
                         child: _getMediaWidget() ,
                        onTap:(){
                           _showPicker(context);
                        } ,
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s22,
                    ),
                    StreamBuilder<bool>(
                        stream: _viewModel.isAllInputValid,
                        builder: (context, snapshot) {
                          // ignore: sized_box_for_whitespace
                          return Container(
                            height: AppSize.s52,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: const ButtonStyle(),
                                onPressed:(snapshot.data??false)? (){
                                        _viewModel.Register();
                                      }:null,
                                child:  Text(AppStrings.register.tr())),
                          );
                        }),
                    const SizedBox(
                      height: AppSize.s18,
                    ),
                    Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppStrings.alreadyHaveAccount.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontSize: AppSize.s14))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
  _showPicker(BuildContext context){
    showModalBottomSheet(context: context, builder: (context){
      return SafeArea(child:
      Wrap(
        children:  [
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.camera),
            onTap: (){
              _imageFromGallery();
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(Icons.camera_alt_outlined),
            title:  Text(AppStrings.photoCamera.tr()),
            onTap: (){
              _imageFromCamera();
              Navigator.pop(context);
            },
          ),

        ],
      ),
      );
    });
  }
  _imageFromGallery() async{
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path??""));
  }
  _imageFromCamera()async{
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path??""));
  }
  Widget _getMediaWidget(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
           Flexible(child: Text(AppStrings.profilePicture.tr())),
          Flexible(child: StreamBuilder<File>(
            stream:_viewModel.outIsInputProfilePicture ,
              builder:(context,snapshot){
              return _imagePickerFile(snapshot.data);
              } )),
           const Flexible(child: Icon(Icons.camera_alt_outlined)),
        ],
      ),
    );
  }
  Widget _imagePickerFile(File? image){
    if(image !=null && image.path.isNotEmpty){
      return Image.file(image);
    }else {
      return Container();
    }
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
