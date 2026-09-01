library;

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/network/error/failures.dart';
import '../../../../../core/shared/extensions/base_state.dart';
import '../../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../../core/shared/extensions/widgets/padding_extension.dart';
import '../../../../../core/shared/extensions/widgets/widget_extentions.dart';
import '../../../../../core/shared/helpers/validators.dart';
import '../../../../../core/state/async/async.dart';
import '../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../core/widgets/custom_messages.dart';
import '../../../../../core/widgets/fields/drop_downs/app_drop_down/app_dropdown.dart';
import '../../../../../core/widgets/fields/text_fields/default_text_field.dart';
import '../../../../../core/widgets/handling_views/empty_widget.dart';
import '../../../../home/presentation/imports/home_imports.dart';

import '../../../employee_details/domain/entities/employee_details_entity.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/params/create_employee_params.dart';
import '../../domain/usecases/create_employee_use_case.dart';
import '../../domain/usecases/get_department_managers_use_case.dart';
import '../../domain/usecases/get_departments_use_case.dart';
import '../../domain/usecases/update_employee_use_case.dart';
import '../../../employees/domain/entities/employee_entity.dart';

part '../controllers/add_employee_view_controller.dart';
part '../cubits/add_employee_cubit.dart';
part '../cubits/departments_cubit.dart';
part '../cubits/department_managers_cubit.dart';
part '../view/add_employee_screen.dart';
part '../widget/add_employee_body.dart';
part '../widget/employee_image_picker.dart';
part '../widget/employee_form_section.dart';
part '../widget/login_data_section.dart';
part '../widget/add_employee_button.dart';
