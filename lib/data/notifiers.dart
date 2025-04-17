//ValueNotifier: hold the data
//ValuelistenableHolder: listen for the data change (doesn't need the srtstate)
import 'package:flutter/material.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<bool> isDarkThemeNotifier = ValueNotifier(true);