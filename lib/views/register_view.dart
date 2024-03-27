import 'package:chatapp1/helper/constans.dart';
import 'package:chatapp1/helper/show_snack_bar.dart';
import 'package:chatapp1/views/chat_view.dart';
import 'package:chatapp1/widgets/login/custom_text_field.dart';
import 'package:chatapp1/widgets/login/custom_boutton.dart';
import 'package:chatapp1/widgets/login/question_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email, password;

  bool isloaded = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isloaded,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formkey,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 100),
              children: [
                Image.asset(
                  kLogoRegister,
                  height: 180,
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
                const SizedBox(height: 77),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
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
                  text: 'Sign Up',
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isloaded = true;
                      setState(() {});
                      try {
                        await registerUser();
                        showSnackBar(context, 'Register Success');
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ChatView(email: email);
                            },
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'weak-password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'Email Already in Use exists');
                        } else {
                          showSnackBar(context, ' Check an Internet');
                        }
                      } catch (e) {
                        showSnackBar(context, 'there was an error ,try again');
                      }
                      isloaded = false;
                      setState(() {});
                    }
                  },
                ),
                const QuestionAccount(
                  question: 'Already have an account',
                  tapText: 'Sign in',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
