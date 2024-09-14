import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: provider.appTheme == ThemeMode.light
            ? MyTheme.whiteColor
            : MyTheme.blackDark,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.changeLanguage("en");
            },
            child: provider.appLanguage == 'en'
                ? selectedLanguage(
                    context, AppLocalizations.of(context)!.english)
                : unSelectedLanguage(
                    context, AppLocalizations.of(context)!.english),
          ),
          InkWell(
            onTap: () {
              provider.changeLanguage("ar");
            },
            child: provider.appLanguage == "ar"
                ? selectedLanguage(
                    context, AppLocalizations.of(context)!.arabic)
                : unSelectedLanguage(
                    context, AppLocalizations.of(context)!.arabic),
          )
        ],
      ),
    );
  }

  Widget selectedLanguage(BuildContext context, String language) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            language,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: MyTheme.primaryLightColor),
          ),
          Icon(
            Icons.check,
            size: 30,
            color: MyTheme.primaryLightColor,
          ),
        ],
      ),
    );
  }

  Widget unSelectedLanguage(BuildContext context, String language) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(language, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
