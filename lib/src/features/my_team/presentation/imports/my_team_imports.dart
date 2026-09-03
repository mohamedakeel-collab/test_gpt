/// `part / part of` hub for the My Team feature presentation layer.
library;

// ── Framework ────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// ── App-level helpers ────────────────────────────────────────────────
import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/network/error/failures.dart';
import '../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../core/shared/extensions/widgets/padding_extension.dart';
import '../../../../core/shared/extensions/widgets/widget_extentions.dart';
import '../../../../core/state/async/async.dart';
import '../../../../core/widgets/handling_views/empty_widget.dart';
import '../../../../core/widgets/icon_widget.dart';

// ── Feature domain ───────────────────────────────────────────────────
import '../../../home/presentation/imports/home_imports.dart';
import '../../../new_request/presentation/imports/new_request_imports.dart';
import '../../../orders/domain/entities/leave_request_entity.dart';
import '../../../provider/request_details/presentation/imports/request_details_imports.dart';
import '../../domain/usecases/get_my_team_requests_use_case.dart';

// ── Cubits ───────────────────────────────────────────────────────────
part '../cubits/my_team_cubit.dart';

// ── ViewControllers ──────────────────────────────────────────────────
part '../controllers/my_team_view_controller.dart';

// ── Screens ──────────────────────────────────────────────────────────
part '../view/my_team_screen.dart';

// ── Widgets ──────────────────────────────────────────────────────────
part '../widgets/my_team_body.dart';
part '../widgets/team_filter_tabs.dart';
part '../widgets/team_request_card.dart';
part '../widgets/team_status_badge.dart';
part '../widgets/pagination/my_team_header_skeleton.dart';
part '../widgets/pagination/team_filter_tabs_skeleton.dart';
part '../widgets/pagination/team_request_card_skeleton.dart';