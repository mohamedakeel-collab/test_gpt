/// `part / part of` hub for the Products feature presentation layer.
///
/// All `view/`, `widgets/`, `cubits/`, and `controllers/` files declare
/// `part of '../imports/products_imports.dart';` at their top.
///
/// Benefits
///   - Every file inherits this library's imports — no boilerplate at the
///     top of each file.
///   - Private classes (`_ProductsBody`, `_ProductCard`, …) can be used
///     across the whole feature without exposing them outside it.
///
/// Rule of thumb
///   - `part`/`part of` is for **presentation only**. Domain and data
///     layers use normal imports so they stay portable and testable.
library;

// ── Framework ────────────────────────────────────────────────────────
import 'dart:async';

// dartz exports a `State` class that collides with Flutter's. Cherry-pick
// just the bits we use in the presentation layer.
import 'package:dartz/dartz.dart' show Either, Left, Right, Unit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

// ── App-level helpers ────────────────────────────────────────────────
import '../../../../config/res/config_imports.dart';

// ── Cross-cutting core (network result + async state machinery) ──────
import '../../../../core/state/async/async.dart';

// ── Feature domain (entities, enums, use-cases, failures) ────────────
import '../../../../core/network/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/enums/product_status.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/get_product_details_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';

// ── Cubits ───────────────────────────────────────────────────────────
part '../cubits/products_cubit.dart';
part '../cubits/product_details_cubit.dart';

// ── ViewControllers (non-bloc UI state holders) ──────────────────────
part '../controllers/products_view_controller.dart';

// ── Screens (public entry points) ────────────────────────────────────
part '../view/products_screen.dart';
part '../view/product_details_screen.dart';

// ── Widgets (private to the feature, used by screens above) ─────────
part '../widgets/products_body.dart';
part '../widgets/products_search_field.dart';
part '../widgets/product_card.dart';
part '../widgets/product_details_body.dart';
part '../widgets/product_delete_dialog.dart';
part '../widgets/products_filter_sheet.dart';
