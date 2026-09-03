library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../core/shared/extensions/widgets/padding_extension.dart';
import '../../../../core/shared/extensions/widgets/widget_extentions.dart';
import '../../../../core/state/async/async.dart';
import '../../../../core/widgets/buttons/loading_button.dart';
import '../../../../core/widgets/handling_views/empty_widget.dart';
import '../../../../core/widgets/icon_widget.dart';
import '../../../../core/widgets/image_widgets/cached_image.dart';
import '../../../home/presentation/imports/home_imports.dart';
import '../../../provider/request_details/presentation/imports/request_details_imports.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/entities/employee_details_entity.dart';
import '../../domain/entities/leave_request_details_entity.dart';
import '../../domain/usecases/get_order_details_use_case.dart';

part '../controllers/order_details_view_controller.dart';
part '../cubits/order_details_cubit.dart';
part '../view/order_details_screen.dart';
part '../widgets/order_details_body.dart';
part '../widgets/request_action_buttons.dart';
part '../widgets/request_attachment_card.dart';
part '../widgets/request_balance_card.dart';
part '../widgets/request_employee_card.dart';
part '../widgets/request_info_card.dart';
part '../widgets/request_notes_bottom_sheet.dart';
part '../widgets/request_notes_card.dart';
part '../widgets/attachment_preview.dart';
part '../widgets/pagination/request_employee_skeleton.dart';
part '../widgets/pagination/request_balance_skeleton.dart';
part '../widgets/pagination/request_info_skeleton.dart';
part '../widgets/pagination/request_attachment_skeleton.dart';
part '../widgets/pagination/request_notes_skeleton.dart';