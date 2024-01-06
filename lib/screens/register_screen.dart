// ignore_for_file: prefer_const_constructors

import 'package:chat_app/constance.dart';
import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snackbar.dart';
import '../widgets/custom_buttton.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {

  @override
  String? email;
  String? password;
  static String id = 'RegisterPage';
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoaded = true;
        }
        else if(state is RegisterSuccess)
          {
            Navigator.pushNamed(context,  LoginPage.id,arguments: email);
            isLoaded =false;
            return showSnackBar((context),'success');

          }
        else if(state is RegisterFailur){
          isLoaded =false;
          return showSnackBar((context),state.errorMessage);
        }
      },
      builder:(context,state)=> ModalProgressHUD(
        inAsyncCall: isLoaded,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Image.asset(kLogo),
                    Text(
                      'Scholar chat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Row(
                      children: const [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      keybordType: TextInputType.emailAddress,
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Password',
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      buttonName: 'Register',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                        BlocProvider.of<RegisterCubit>(context).registerUser(email: email!, password: password!);

                        } else {

                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'already have an account',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
