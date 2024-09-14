import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/components/custom_text_form_field.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/dialog_utils/dialog_utils.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "RegisterScreen";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                      AppLocalizations.of(context)!.create_account,
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
                      label: AppLocalizations.of(context)!.user_name,
                      keyboardType: TextInputType.name,
                      textEditingController: nameController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!.enter_username;
                        }
                        return null;
                      },
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
                    CustomTextFormField(
                      password: true,
                      label: AppLocalizations.of(context)!.confirm_password,
                      keyboardType: TextInputType.visiblePassword,
                      textEditingController: confirmPasswordController,
                      isPassword: true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return AppLocalizations.of(context)!.enter_password;
                        }
                        if (text != passwordController.text) {
                          return AppLocalizations.of(context)!
                              .password_dont_match;
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          register();
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.primaryLightColor,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Text(
                          AppLocalizations.of(context)!.create_account,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: MyTheme.whiteColor),
                        ),
                      ),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.titleSmall),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                        child: Text(
                            AppLocalizations.of(context)!.already_have_account))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void register() async {
    if (_formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context, AppLocalizations.of(context)!.loading);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: mailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? "",
            name: nameController.text,
            mail: mailController.text);
        var authProvider = Provider.of<AuthProvider1>(context, listen: false);
        authProvider.updateUser(myUser);
        await FirebaseUtils.addUserToFireStore(myUser);
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
            context, AppLocalizations.of(context)!.register_successfully,
            title: AppLocalizations.of(context)!.success,
            posActionName: AppLocalizations.of(context)!.ok,
            barrierDismissible: false, posAction: () {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
              context, AppLocalizations.of(context)!.weak_password,
              barrierDismissible: false,
              title: AppLocalizations.of(context)!.failed);
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(
            context,
            AppLocalizations.of(context)!.mail_exist,
            title: AppLocalizations.of(context)!.failed,
            posActionName: AppLocalizations.of(context)!.ok,
            barrierDismissible: false,
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context);
        DialogUtils.showMessage(
          context,
          e.toString(),
          title: AppLocalizations.of(context)!.failed,
          posActionName: AppLocalizations.of(context)!.ok,
          barrierDismissible: false,
        );
      }
    }
  }
}
