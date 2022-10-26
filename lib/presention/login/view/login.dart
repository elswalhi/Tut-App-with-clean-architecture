
import 'package:advanced_flutter/App/di.dart';
import 'package:advanced_flutter/App/shared_pref.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/Resourses/ValuesManger.dart';
import 'package:advanced_flutter/presention/Resourses/assets%20manger.dart';
import 'package:advanced_flutter/presention/Resourses/colors.dart';
import 'package:advanced_flutter/presention/Resourses/routs%20manger.dart';
import 'package:advanced_flutter/presention/common/state_render/state_renderer_impl.dart';
import 'package:advanced_flutter/presention/login/view_model/login_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}
final _formKey=GlobalKey<FormState>();

final LoginViewModel _viewModel = instance<LoginViewModel>();
final TextEditingController _userNameController=TextEditingController();
final TextEditingController _passwordController=TextEditingController();
final AppPreferences _appPreferences = instance<AppPreferences>();


 _bind(context){
   _viewModel.start(); // start your job
   _userNameController.addListener(()=>_viewModel.setUserName(_userNameController.text));
   _passwordController.addListener(()=>_viewModel.setUserPassword(_passwordController.text));
   _viewModel.isUserLoginStreamController.stream.listen((isLoggedIn){
     if(isLoggedIn){
       //navigate to screen
       SchedulerBinding.instance.addPersistentFrameCallback((_) {
         _appPreferences.setLoginScreenViewed();
         Navigator.of(context).pushReplacementNamed(Routs.mainRoute);
       });
     }
   });

 }

class _LoginViewState extends State<LoginView> {
   @override
  void initState() {
     _bind(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context,snapshot){
          return snapshot.data?.getScreenWidget(context,_getContentWidget(),(){}) ?? _getContentWidget();
        },
      ),
    );
  }
  Widget _getContentWidget(){
     return Container(
         padding: const EdgeInsetsDirectional.only(top:AppPadding.p100 ),
         child:  SingleChildScrollView(
           child: Form(key:_formKey ,
             child:Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children:  [
                 const Image(image:  AssetImage(ImageAssets.splashLogo)),
                 const SizedBox(height: AppSize.s22,),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p22),
                   child: Column(
                     children: [
                       StreamBuilder<bool>(stream:_viewModel.OutIsUserNameValid ,
                           builder: (context,snapshot){
                         return TextFormField(
                           keyboardType: TextInputType.emailAddress,
                           controller: _userNameController,
                           decoration: InputDecoration(
                             hintText:AppStrings.username.tr(),
                             labelText: AppStrings.username.tr(),
                             errorText:(snapshot.data?? true)?
                             null :
                             AppStrings.usernameError.tr()
                           ) ,
                         );
                           }),
                       const SizedBox(height: AppSize.s30,),
                       StreamBuilder<bool>(stream:_viewModel.OutIsPasswordValid ,
                           builder: (context,snapshot){
                             return TextFormField(
                               keyboardType: TextInputType.visiblePassword,
                               controller: _passwordController,
                               decoration: InputDecoration(
                                   hintText:AppStrings.password.tr(),
                                   labelText: AppStrings.password.tr(),
                                   errorText:(snapshot.data?? true)?
                                   null :
                                   AppStrings.passwordError.tr()
                               ) ,

                             );
                           }),
                       const SizedBox(height: AppSize.s30,),
                       StreamBuilder<bool>(stream:_viewModel.OutputValidation ,
                           builder: (context,snapshot){
                             // ignore: sized_box_for_whitespace
                             return Container(
                               height: AppSize.s52,
                               width:double.infinity ,
                               child: ElevatedButton(
                                 style:  const ButtonStyle(
                                 ),
                                   onPressed:(snapshot.data??false)? (){
                                 _viewModel.Login();
                               }:null, child:  Text(AppStrings.login.tr())),
                             );
                           }),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           TextButton(onPressed: (){
                             Navigator.pushReplacementNamed(context, Routs.forgetPasswordRoute);
                           }, child: Text(AppStrings.forgetPassword.tr(),style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s14))),
                           TextButton(onPressed: (){
                             Navigator.pushReplacementNamed(context, Routs.registerRoute);

                           }, child: Text(AppStrings.registerText.tr(),style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSize.s14))),

                         ],
                       )
                     ],
                   ),

                 ),
               ],
             ) ,),
         ),
       );
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
