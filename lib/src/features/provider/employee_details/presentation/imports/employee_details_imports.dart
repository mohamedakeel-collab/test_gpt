library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../../core/shared/extensions/widgets/padding_extension.dart';
import '../../../../../core/shared/extensions/widgets/widget_extentions.dart';
import '../../../../../core/state/async/async.dart';
import '../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../core/widgets/image_widgets/cached_image.dart';
import '../../../../home/presentation/imports/home_imports.dart';
import '../../../add_employee/presentation/imports/add_employee_imports.dart';
import '../../../request_details/presentation/imports/request_details_imports.dart';
import '../../domain/entities/employee_details_entity.dart';
import '../../domain/usecases/get_employee_details_use_case.dart';

import '../../../requests/presentation/imports/requests_imports.dart';
part '../view/employee_details_screen.dart';
part '../controllers/employee_details_view_controller.dart';
part '../widget/employee_details_body.dart';
part '../widget/employee_details_header_card.dart';
part '../cubits/employee_details_cubit.dart';
part '../widget/employee_details_balance_card.dart';
part '../widget/pagination/employee_details_header_skeleton.dart';
part '../widget/pagination/employee_balance_skeleton.dart';
part '../widget/pagination/employee_request_skeleton.dart';