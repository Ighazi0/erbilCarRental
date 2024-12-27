import 'package:erbil/utilities/locale/key/ar_key.dart';
import 'package:erbil/utilities/locale/key/en_key.dart';
import 'package:erbil/utilities/locale/key/ku_key.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class LanguageLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'en': en,
        'ku': ku,
      };
}
