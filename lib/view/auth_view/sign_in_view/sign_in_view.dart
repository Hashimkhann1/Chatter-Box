import 'package:chatter_box/res/my_colors.dart';
import 'package:chatter_box/res/widgets/my_text.dart';
import 'package:chatter_box/res/widgets/my_text_button.dart';
import 'package:chatter_box/res/widgets/my_text_form_field.dart';
import 'package:chatter_box/view/auth_view/sign_up_view/sign_up_view.dart';
import 'package:chatter_box/view_model/auth_view_model/auth_view_model.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_bloc/loading_bloc.dart';
import 'package:chatter_box/view_model/bloc/loading_bloc/loading_state/loading_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final AuthViewModel authViewModel = AuthViewModel();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MyColor.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(CupertinoIcons.chat_bubble_fill,color: MyColor.blueColor,size: 30,),
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          SystemNavigator.pop();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  /// login title
                  const MyText(
                    title: "Login",
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: MyColor.whiteColor,
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),

                  /// email and password form
                  Form(
                    key: _formKey,
                      child: Column(
                    children: [
                      /// email text form field
                      MyTextFormField(
                        controller: emailController,
                        hintText: 'Email',
                        hintTextColor: MyColor.whiteColor,
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
                      ),
                    ],
                  )),
                  SizedBox(
                    height: height * 0.02,
                  ),

                  /// sign In Button
                  BlocBuilder<LoadingBloc , LoadingState>(
                      builder: (context , state) {
                        return MyTextButton(
                      title: 'Sign In',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      backgroundColor: MyColor.blueColor,
                      borderRadius: BorderRadius.circular(16),
                      width: width * 0.35,
                      height: height * 0.05,
                          isLoading: state.isLoading,
                          onTap: () {
                            authViewModel.signIn(context, emailController.text.toString(), passwordController.text.toString());
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
                      const MyText(
                        title: "Dont't have an account",
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      MyTextButton(
                        title: 'Sign up',
                        color: MyColor.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpView()));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
