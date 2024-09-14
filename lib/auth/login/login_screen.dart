import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/register/register_screen.dart';
import 'package:todo/dialog_utils/dialog_utils.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/home/home_screen.dart';
import '../../my_theme.dart';
import '../../provider/auth_provider.dart';
import '../components/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mailController =
      TextEditingController(text: "matrix511997@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "01155704252");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/background.png",
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                    ),
                    Text(
                      AppLocalizations.of(context)!.login,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: MyTheme.whiteColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.17,
                    ),
                    CustomTextFormField(
                      password: false,
                      label: AppLocalizations.of(context)!.email_address,
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: mailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!.enter_mail;
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return "E-mail should be like this example123@gmail.com";
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      password: true,
                      label: AppLocalizations.of(context)!.password,
                      keyboardType: TextInputType.visiblePassword,
                      textEditingController: passwordController,
                      isPassword: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!.enter_password;
                        }
                        if (text.length < 6) {
                          return "Password should be at least 6 char";
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          login();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.primaryLightColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: MyTheme.whiteColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dont_have_account,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(RegisterScreen.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.signup,
                              style: const TextStyle(fontSize: 18),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void login() async {
    if (_formKey.currentState!.validate() == true) {
      DialogUtils.showLoading(context, AppLocalizations.of(context)!.loading);
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mailController.text,
          password: passwordController.text,
        );
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? "");
        if (user == null) {
          return;
        }
        var authProvider = Provider.of<AuthProvider1>(context, listen: false);
        authProvider.updateUser(user);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context, AppLocalizations.of(context)!.login_successfully,
            title: AppLocalizations.of(context)!.success,
            posActionName: AppLocalizations.of(context)!.ok,
            barrierDismissible: false, posAction: () {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context, 'No user found for that email.',
              barrierDismissible: false, title: "Faild");
        } else if (e.code == 'wrong-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context, 'Wrong password provided for that user.',
              barrierDismissible: false, title: "Faild");
        } else {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context, AppLocalizations.of(context)!.not_valid,
              barrierDismissible: false,
              title: AppLocalizations.of(context)!.failed,
              posActionName: AppLocalizations.of(context)!.ok);
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(context, e.toString(),
            barrierDismissible: false,
            title: AppLocalizations.of(context)!.failed);
      }
    }
  }
}
