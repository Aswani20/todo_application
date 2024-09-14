import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/app_config_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
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
              provider.changeTheme(ThemeMode.light);
            },
            child: provider.appTheme == ThemeMode.light
                ? selectedLanguage(
                    context, AppLocalizations.of(context)!.light_mode)
                : unSelectedLanguage(
                    context, AppLocalizations.of(context)!.light_mode),
          ),
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.dark);
            },
            child: provider.appTheme == ThemeMode.dark
                ? selectedLanguage(
                    context, AppLocalizations.of(context)!.dark_mode)
                : unSelectedLanguage(
                    context, AppLocalizations.of(context)!.dark_mode),
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
