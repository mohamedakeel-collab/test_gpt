import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/home/presentation/imports/home_imports.dart';
import '../../features/home/presentation/keys/main_tap_key.dart';
import '../navigation/navigator.dart';

sealed class NotificationAction {
  const NotificationAction();
}

final class NavigateToChat extends NotificationAction {
  final String chatId;

  const NavigateToChat(this.chatId);
}

final class NavigateToScreen extends NotificationAction {
  final String route;

  const NavigateToScreen(this.route);
}

final class OpenUrl extends NotificationAction {
  final Uri url;

  const OpenUrl(this.url);
}

final class DismissAction extends NotificationAction {
  const DismissAction();
}

abstract interface class NotificationRouter {
  Future<void> route(NotificationAction action);
}

final class AppNotificationRouter implements NotificationRouter {
  const AppNotificationRouter();

  NavigatorState? get _navigator => Go.navigatorKey.currentState;

  @override
  Future<void> route(NotificationAction action) async {
    switch (action) {
      case NavigateToScreen(:final route):
        if (route == '/requests') {
          // open Requests tab inside BottomNavigation
          mainTapKey.currentState?.changeTab(1);

          return;
        }

        if (route == '/orders') {
          // open Requests tab inside BottomNavigation
          mainTapKey.currentState?.changeTab(1);

          return;
        }
        if (route == '/home') {
          // open Requests tab inside BottomNavigation
          mainTapKey.currentState?.changeTab(1);

          return;
        }

        await _navigator?.pushNamed(route);

      case NavigateToChat(:final chatId):
        await _navigator?.pushNamed('/chat', arguments: chatId);

      case OpenUrl(:final url):
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }

      case DismissAction():
        break;
    }
  }
}
