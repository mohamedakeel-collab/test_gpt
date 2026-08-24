library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../core/shared/extensions/widgets/padding_extension.dart';
import '../../../../core/shared/extensions/widgets/widget_extentions.dart';
import '../../../../core/state/async/async.dart';
import '../../../../core/widgets/buttons/loading_button.dart';
import '../../../../core/widgets/handling_views/empty_widget.dart';
import '../../../../core/widgets/icon_widget.dart';
import '../../../home/presentation/imports/home_imports.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/usecases/get_attendance_use_case.dart';

part '../controllers/remote_work_view_controller.dart';
part '../cubits/attendance_cubit.dart';
part '../view/remote_work_screen.dart';
part '../widgets/attendance_card.dart';
part '../widgets/attendance_history_section.dart';
part '../widgets/remote_work_body.dart';
part '../widgets/remote_timer_card.dart';
