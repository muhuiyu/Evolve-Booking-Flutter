import 'package:evolve_flutter/constants/all_constants.dart';
import 'package:flutter/material.dart';

// enum MainTabItem { dashboard, booking, account }
enum MainTabItem { dashboard, booking }

extension MainTabItemExtension on MainTabItem {
  Icon get icon {
    switch (this) {
      case MainTabItem.dashboard:
        return const Icon(Icons.home);
      case MainTabItem.booking:
        return const Icon(Icons.timeline);
      // case MainTabItem.account:
      //   return const Icon(Icons.person);
    }
  }

  String get name {
    switch (this) {
      case MainTabItem.dashboard:
        return TextConstant.tabHome;
      case MainTabItem.booking:
        return TextConstant.tabBooking;
      // case MainTabItem.account:
      //   return TextConstant.tabAccount;
    }
  }

  BottomNavigationBarItem get bottomNavigationBarItem {
    return BottomNavigationBarItem(icon: icon, label: name);
  }
}
