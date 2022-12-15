import 'package:amazon_clone_tutorial/constants/global_variables.dart';
import 'package:amazon_clone_tutorial/common/widgets/custom_button.dart';
import 'package:amazon_clone_tutorial/common/widgets/custom_text_field.dart';
import 'package:amazon_clone_tutorial/features/auth/services/auth_service.dart';

import 'package:flutter/material.dart';

enum Auth {
  signup,
  signin,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  /// [Enum] to track the state of the Authentication
  /// whether user click on singup form or signin form.
  Auth _auth = Auth.signup;

  /// Global key to uniquely identify the [Form] of signUp and SignIn.
  final _singUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  /// TextEditingController for email , password and name Text Field.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  /// Instance of AuthService form service folder to handle logic singup/loginup
  final AuthService authService = AuthService();

  /// I dont know why need to write the boilerplate of signing up
  /// the user always but will come back when i figure it out ToDo .
  void signUpUser() {
    authService.singUpUser(
        context: context,
        // We dont need to trim the text because youtuber saying
        // that our monogoose class in nodeje is already trimming it for out.
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  // Sing In user
  void signInUser() {
    authService.singInUser(
      context: context,
      // We dont need to trim the text because youtuber saying
      // that our monogoose class in nodeje is already trimming it for out.
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  /// To avoid any leak we dispose the all controller in dispose method.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                    value: Auth.signup,
                    groupValue: _auth,
                    activeColor: GlobalVariables.secondaryColor,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _singUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButoon(
                          text: 'Sing Up',
                          onTap: () {
                            if (_singUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.signin
                    ? GlobalVariables.backgroundColor
                    : GlobalVariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign-In.',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                    value: Auth.signin,
                    groupValue: _auth,
                    activeColor: GlobalVariables.secondaryColor,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    }),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButoon(
                          text: 'Sing In',
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
