// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:chatapp1/helper/constans.dart';
import 'package:chatapp1/helper/show_snack_bar.dart';
import 'package:chatapp1/views/chat_view.dart';
import 'package:chatapp1/views/register_view.dart';
import 'package:chatapp1/widgets/login/custom_text_field.dart';
import 'package:chatapp1/widgets/login/question_account.dart';
import 'package:chatapp1/widgets/login/custom_boutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email, password;

  bool isloaded = false;

  final GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isloaded,
        child: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 100,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      kLogoSignIn,
                      height: 100,
                      width: 100,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Scholar chat',
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontFamily: 'SingleDay',
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomTextFormField(
                      label: 'Email',
                      icon: Icons.email_outlined,
                      keyboard: TextInputType.emailAddress,
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    CustomTextFormField(
                      label: 'Password',
                      icon: Icons.remove_red_eye,
                      keyboard: TextInputType.number,
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                    CustomBoutton(
                      text: 'Sign In',
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          isloaded = true;
                          setState(() {});
                          try {
                            await signInUser();

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChatView(
                                    email: email,
                                  );
                                },
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(
                                  context, 'No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context,
                                  'Wrong password provided for that user.');
                            }
                          } catch (e) {
                            log(e.toString());
                            showSnackBar(
                                context, 'there was an error ,try again');
                          }
                          isloaded = false;
                          setState(() {});
                        }
                      },
                    ),
                    QuestionAccount(
                      question: "don't have an account",
                      tapText: 'Sign Up',
                      screenView: Register(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future signInUser() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
