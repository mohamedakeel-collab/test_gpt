import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

/// Default router — runs on the same [Go.navigatorKey] used everywhere
/// else, so taps from the OS shade open inside the app's existing nav stack.
final class AppNotificationRouter implements NotificationRouter {
  const AppNotificationRouter();

  NavigatorState? get _navigator => Go.navigatorKey.currentState;

  @override
  Future<void> route(NotificationAction action) async {
    switch (action) {
      case NavigateToChat(:final chatId):
        await _navigator?.pushNamed('/chat', arguments: chatId);
      case NavigateToScreen(:final route):
        await _navigator?.pushNamed(route);
      case OpenUrl(:final url):
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      case DismissAction():
        break;
    }
  }
}
