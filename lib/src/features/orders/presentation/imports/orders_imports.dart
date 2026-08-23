/// `part / part of` hub for the Orders feature presentation layer.
///
/// All `view/`, `widgets/`, `cubits/`, and `controllers/` files declare
/// `part of '../imports/orders_imports.dart';` at their top.
///
/// Benefits
///   - Every file inherits this library's imports — no boilerplate at the
///     top of each file.
///   - Private classes (`_OrdersBody`, `_OrderCard`, …) can be used
///     across the whole feature without exposing them outside it.
///
/// Rule of thumb
///   - `part`/`part of` is for **presentation only**. Domain and data
///     layers use normal imports so they stay portable and testable.
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
import '../../../../core/shared/extensions/base_state.dart';
import '../../../../core/shared/extensions/text_style_extensions.dart';
import '../../../../core/shared/extensions/widgets/padding_extension.dart';
import '../../../../core/shared/extensions/widgets/widget_extentions.dart';

// ── Reusable core widgets (the building blocks every feature reuses) ──
import '../../../../core/navigation/navigator.dart';
import '../../../../core/widgets/custom_messages.dart';
import '../../../../core/widgets/handling_views/empty_widget.dart';
import '../../../../core/widgets/icon_widget.dart';
import '../../../../core/widgets/buttons/loading_button.dart';

// ── Cross-cutting core (network result + async state machinery) ──────
import '../../../../core/state/async/async.dart';
import '../../../../core/network/error/failures.dart';

// ── Existing tab-screen chrome (dark logo app bar) reused as-is ──────
import '../../../home/presentation/imports/home_imports.dart';

// ── Feature domain (entities, use-cases, failures) ───────────────────
import '../../../new_request/presentation/imports/new_request_imports.dart';
import '../../../order_details/presentation/imports/order_details_imports.dart';
import '../../domain/entities/leave_request_entity.dart';
import '../../domain/usecases/delete_request_use_case.dart';
import '../../domain/usecases/get_orders_usecase.dart';

// ── Cubits ───────────────────────────────────────────────────────────
part '../cubits/orders_cubit.dart';

// ── ViewControllers (non-bloc UI state holders) ──────────────────────
part '../controllers/orders_view_controller.dart';

// ── Screens (public entry points) ────────────────────────────────────
part '../view/orders_screen.dart';

// ── Widgets (private to the feature, used by screens above) ─────────
part '../widgets/orders_body.dart';
part '../widgets/orders_header.dart';
part '../widgets/orders_tabs.dart';
part '../widgets/order_card.dart';
part '../widgets/order_status_badge.dart';
part '../widgets/delete_request_dialog.dart';
