library;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/language/languages.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/network/auth/token_storage.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/shared/extensions/base_state.dart';
import '../../../../core/shared/extensions/form_mixin.dart';
import '../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../core/shared/extensions/widgets/padding_extension.dart';
import '../../../../core/shared/extensions/widgets/widget_extentions.dart';
import '../../../../core/shared/helpers/validators.dart';
import '../../../../core/state/async/async.dart';
import '../../../../core/widgets/buttons/loading_button.dart';
import '../../../../core/widgets/custom_messages.dart';
import '../../../../core/widgets/fields/text_fields/default_text_field.dart';
import '../../../../core/widgets/icon_widget.dart';
import '../../../home/presentation/imports/home_imports.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/usecases/login_usecase.dart';

part '../cubits/login_cubit.dart';
part '../controllers/login_view_controller.dart';
part '../view/login_screen.dart';
part '../widgets/login_body.dart';
part '../widgets/login_logo_section.dart';
part '../widgets/login_form_section.dart';
part '../widgets/login_footer.dart';
part '../widgets/choose_language_pop_up.dart';