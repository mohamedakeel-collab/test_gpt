library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/network/error/failures.dart';
import '../../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../../core/shared/extensions/widgets/padding_extension.dart';
import '../../../../../core/shared/extensions/widgets/widget_extentions.dart';
import '../../../../../core/state/async/async.dart';
import '../../../../../core/widgets/handling_views/empty_widget.dart';
import '../../../../../core/widgets/icon_widget.dart';
import '../../../../../core/widgets/image_widgets/cached_image.dart';
import '../../../../home/presentation/imports/home_imports.dart';
import '../../../../notifications/presentation/imports/notifications_imports.dart';
import '../../../add_employee/presentation/imports/add_employee_imports.dart';
import '../../../employee_details/presentation/imports/employee_details_imports.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/usecases/get_employees_use_case.dart';

part '../controllers/employees_view_controller.dart';

part '../cubits/employees_cubit.dart';

part '../view/employees_screen.dart';

part '../widget/employees_body.dart';

part '../widget/employees_header.dart';

part '../widget/employees_summary_card.dart';

part '../widget/employees_filter.dart';

part '../widget/employee_card.dart';

part '../widget/employees_search.dart';

part '../widget/pagination/employee_card_skeleton.dart';

part '../widget/pagination/employees_summary_card_skeleton.dart';

part '../widget/pagination/employees_search_skeleton.dart';
