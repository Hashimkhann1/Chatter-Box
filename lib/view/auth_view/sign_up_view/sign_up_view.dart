import 'package:chatter_box/res/constatnt/constant.dart';
import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:chatter_box/res/widgets/my_text_button.dart';
import 'package:chatter_box/res/widgets/my_text_form_field.dart';
import 'package:chatter_box/view/auth_view/sign_in_view/sign_in_view.dart';
import 'package:chatter_box/view/bottom_navigator_view/bottom_navigator_view.dart';
import 'package:chatter_box/view_model/auth_view_model/auth_view_model.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_bloc/loading_bloc.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_state/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColor.backgroundColor,
        elevation: 0,
        toolbarHeight: height * 0.06,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                /// login title
                MyText(
                  title: "Register",
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: MyColor.whiteColor,
                ),
                SizedBox(
                  height: height * 0.04,
                ),

                /// email and password form
                Form(
                  key: _formKey,
                    child: Column(
                      children: [
                        /// name text form field
                        MyTextFormField(
                          controller: userNameController,
                          hintText: 'Name',
                          hintTextColor: MyColor.whiteColor,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Enter Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),

                        /// email text form field
                        MyTextFormField(
                          controller: emailController,
                          hintText: 'Email',
                          hintTextColor: MyColor.whiteColor,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Enter Email";
                            }else if(!value.contains('@gmail.com')){
                              return "Invalid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),

                        /// passwrd text form field
                        MyTextFormField(
                          controller: passwordController,
                          hintText: 'Password',
                          hintTextColor: MyColor.whiteColor,
                          obscureText: true,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Enter password";
                            }else if(value.length <= 7){
                              return "Password must be greater than 7 characters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),

                        /// confirm password tect form field
                        MyTextFormField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm password',
                          hintTextColor: MyColor.whiteColor,
                          obscureText: true,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Enter Confirm passsword";
                            }else if(value != passwordController.text.toString()){
                              return "Confirm password not matched";
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                SizedBox(
                  height: height * 0.04,
                ),

                /// sign In Button
                BlocBuilder<LoadingBloc , LoadingState>(builder: (_ , state) {
                  return MyTextButton(
                    title: 'Sign up',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    backgroundColor: MyColor.blueColor,
                    borderRadius: BorderRadius.circular(16),
                    width: width * 0.35,
                    height: height * 0.05,
                    isLoading: state.isLoading,
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        authViewModel.SignUp(context, emailController.text.toString(), passwordController.text.toString(), userNameController.text.toString());
                      }
                    },
                  );
                }),
                SizedBox(
                  height: height * 0.02,
                ),

                /// signUp screen buttton
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      title: "Already have an account",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    MyTextButton(
                      title: 'Sign In',
                      color: MyColor.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView()));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
