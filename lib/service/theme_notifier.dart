import 'dart:ui';

import 'package:blog_app/service/storage_manager.dart';
import 'package:flutter/material.dart';

class BrightnessNotifier extends ChangeNotifier {

  static final BrightnessNotifier _instance = BrightnessNotifier();
  static BrightnessNotifier get instance => _instance;

  Brightness _brightness = Brightness.light;
  Brightness get brightness => _brightness;

  BrightnessNotifier() {
    StorageManager.getData('brightness').then((value) {
      if (value == null || value is! bool) {
        Brightness systemBrightness = PlatformDispatcher.instance.platformBrightness;

        setBrightness(systemBrightness == Brightness.dark);

        _brightness = systemBrightness;
      }
      else {
        _brightness = _getBrightness(value);
      }
      notifyListeners();
    });
  }

  _getBrightness ( bool isDarkMode ) {
    if( isDarkMode ) {
      return Brightness.dark;
    }
    else {
      return Brightness.light;
    }
  }

  Future<void> setBrightness(bool value) async {
    _brightness = _getBrightness(value);
    notifyListeners();

    StorageManager.saveData('brightness', value);
  }
}