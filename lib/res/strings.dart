import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//需要在MaterialApp下设置
/*
  localizationsDelegates: {
  GlobalWidgetsLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  CustomLocalizationsDelete.delete,
  },
  supportedLocales: {
  const Locale('en', 'US'),
  const Locale('zh', 'CH'),
},*/
//使用
// LocalStrings.getString(context,'your String name'或者 LocalStrings.home);
class LocalStrings {
  static const String home = 'home';
  static const String recently_status = 'recently_status';

  static String getString(BuildContext context, String id,
      {String languageCode}) {
    return CustomLocalizations.of(context).getString(id);
  }
}

///自定义本地化支持
class CustomLocalizations {
  final Locale locale;

  CustomLocalizations(this.locale);

  static Map<String, Map<String, String>> _localizedValues = {
    'zh': {
      'home': '首页',
    },
    'en': {
      'home': 'home',
    }
  };

  static CustomLocalizations of(BuildContext context) {
    return Localizations.of(context, CustomLocalizations);
  }

  ///获取字符串
  String getString(String id, {String languageCode}) {
    String _languageCode = languageCode ?? locale.languageCode;
    return _localizedValues[_languageCode][id];
  }
}

///语言初始化代理
class CustomLocalizationsDelete
    extends LocalizationsDelegate<CustomLocalizations> {
  CustomLocalizationsDelete();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<CustomLocalizations> load(Locale locale) {
    return SynchronousFuture<CustomLocalizations>(CustomLocalizations(locale));
  }

  ///app内部切换需要语言实现此方法
  @override
  bool shouldReload(LocalizationsDelegate<CustomLocalizations> old) {
    return false;
  }

  static CustomLocalizationsDelete delete = CustomLocalizationsDelete();
}
