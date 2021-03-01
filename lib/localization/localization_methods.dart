import 'package:flutter/cupertino.dart';
import 'package:sanchika/localization/localization.dart';

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).gettranslatedvalue(key);
}
