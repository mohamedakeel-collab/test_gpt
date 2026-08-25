library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../core/shared/extensions/widgets/widget_extentions.dart';
import '../../../../core/state/async/async.dart';
import '../../../../core/widgets/handling_views/empty_widget.dart';
import '../../../../core/widgets/icon_widget.dart';
import '../../../home/presentation/imports/home_imports.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/enums/notification_type.dart';
import '../../domain/usecases/get_notifications_use_case.dart';

part '../controllers/notifications_view_controller.dart';
part '../cubits/notifications_cubit.dart';
part '../view/notifications_screen.dart';
part '../widgets/notification_card.dart';
part '../widgets/notification_chip.dart';
part '../widgets/notification_icon.dart';
part '../widgets/notifications_body.dart';
