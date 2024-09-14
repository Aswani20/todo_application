import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/provider/app_config_provider.dart';

class CustomTextFormField extends StatefulWidget {
  String label;
  TextInputType keyboardType;
  TextEditingController textEditingController;
  String? Function(String?) validator;
  bool isPassword;
  bool password;

  CustomTextFormField(
      {super.key,
      required this.label,
      this.keyboardType = TextInputType.text,
      required this.textEditingController,
      required this.validator,
      this.isPassword = false,
      required this.password});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        style: Theme.of(context).textTheme.titleSmall,
        keyboardType: widget.keyboardType,
        controller: widget.textEditingController,
        validator: widget.validator,
        obscureText: widget.isPassword,
        decoration: InputDecoration(
            suffixIcon: widget.password == true
                ? IconButton(
                    onPressed: () {
                      widget.isPassword = !widget.isPassword;
                      setState(() {});
                    },
                    icon: Icon(
                      widget.isPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: provider.appTheme == ThemeMode.dark
                          ? MyTheme.whiteColor
                          : MyTheme.greyColor,
                    ),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                    color: provider.appTheme == ThemeMode.dark
                        ? MyTheme.whiteColor
                        : MyTheme.primaryLightColor,
                    width: 3)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: provider.appTheme == ThemeMode.dark
                      ? MyTheme.whiteColor
                      : MyTheme.primaryLightColor,
                  width: 3),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.redColor, width: 3),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: MyTheme.redColor, width: 3),
            ),
            label: Text(widget.label),
            labelStyle: TextStyle(
              color: provider.appTheme == ThemeMode.dark
                  ? MyTheme.whiteColor
                  : MyTheme.primaryLightColor,
            )),
      ),
    );
  }
}
