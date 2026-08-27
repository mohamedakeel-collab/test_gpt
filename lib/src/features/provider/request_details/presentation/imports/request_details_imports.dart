/// `part / part of` hub for the Request Details feature presentation layer.
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../home/presentation/imports/home_imports.dart';
import '../../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../../core/shared/extensions/widgets/widget_extentions.dart';
import '../../../../../core/state/async/async.dart';
import '../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../core/widgets/handling_views/empty_widget.dart';
import '../../../../../core/widgets/icon_widget.dart';
import '../../../../login/domain/entities/employee_entity.dart';
import '../../../../order_details/presentation/imports/order_details_imports.dart';
import '../../../../orders/domain/entities/comment_entity.dart';
import '../../../../orders/domain/entities/leave_request_entity.dart';
import '../../domain/usecases/get_request_comments_use_case.dart';
import '../../domain/usecases/get_request_details_use_case.dart';

part '../cubits/request_comments_cubit.dart';
part '../cubits/request_details_cubit.dart';
part '../view/request_details_screen.dart';
part '../view/pdf_viewer_screen.dart';
part '../widget/request_details_body.dart';
part '../widget/request_employee_card.dart';
part '../widget/request_balance_card.dart';
part '../widget/request_info_card.dart';
part '../widget/request_notes_card.dart';
part '../widget/request_notes_bottom_sheet.dart';
part '../widget/request_attachment_card.dart';
part '../widget/request_action_buttons.dart';
