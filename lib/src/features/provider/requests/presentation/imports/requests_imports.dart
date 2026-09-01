library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/network/error/failures.dart';
import '../../../../../core/shared/extensions/base_state.dart';
import '../../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../../core/shared/extensions/widgets/padding_extension.dart';
import '../../../../../core/shared/extensions/widgets/widget_extentions.dart';
import '../../../../../core/state/async/async.dart';
import '../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../core/widgets/custom_messages.dart';
import '../../../../../core/widgets/handling_views/empty_widget.dart';
import '../../../../../core/widgets/icon_widget.dart';
import '../../../../new_request/presentation/imports/new_request_imports.dart';
import '../../../../orders/data/mappers/orders_mapper.dart';
import '../../../../orders/presentation/imports/orders_imports.dart';
import '../../../../orders/domain/entities/leave_request_entity.dart';
import '../../../../home/presentation/imports/home_imports.dart';
import '../../../employee_details/domain/entities/employee_details_entity.dart';
import '../../../employee_details/presentation/imports/employee_details_imports.dart';
import '../../../request_details/presentation/imports/request_details_imports.dart';


part '../controllers/requests_view_controller.dart';
part '../view/requests_screen.dart';
part '../widget/requests_body.dart';
part '../widget/requests_tabs.dart';
part '../widget/request_card.dart';
part '../widget/request_status.dart';
part '../widget/request_status_chip.dart';
