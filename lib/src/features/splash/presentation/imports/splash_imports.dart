library;

import 'package:clean_arch_base/src/core/navigation/navigator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';

import '../../../../core/shared/cubits/base_url/base_url_cubit.dart';
import '../../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../../core/shared/extensions/text_style_extensions.dart';

import '../../../../core/shared/extensions/widgets/padding_extension.dart';
import '../../../intro/presentation/imports/intro_imports.dart';
import '../../../login/presentation/imports/login_imports.dart';

part '../view/splash_screen.dart';
part '../widgets/splash_body.dart';
part '../widgets/splash_loading_indicator.dart';
