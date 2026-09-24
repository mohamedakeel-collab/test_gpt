import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../flavors.dart';

import '../../features/home/presentation/imports/home_imports.dart';
import '../../features/home/presentation/keys/main_tap_key.dart';
import '../navigation/navigator.dart';
import '../shared/cubits/user_cubit/user_cubit.dart';

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
        final main = mainTapKey.currentState;
        if (main == null) return;

        final isUser = F.appFlavor == Flavor.user;
        final isManager = isUser && UserCubit.instance.user.role == 'manager';

        final tab = switch (route) {
          '/requests' => isUser ? null : 1,                   // HR → Requests
          '/my-team'  => isManager ? 1 : null,                // Manager → My Team
          '/orders'   => isUser ? (isManager ? 2 : 1) : 1,    // Orders
          '/home'     => 0,
          _           => null,
        };

        if (tab != null) {
          _navigator?.popUntil((r) => r.isFirst);
          main.changeTab(tab, refresh: true);
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
