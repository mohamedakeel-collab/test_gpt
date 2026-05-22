import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../extensions/context_extension.dart';
import '../../../../extensions/text_style_extensions.dart';
import '../../../../helpers/validators.dart';
import '../../text_fields/default_text_field.dart';
import 'dropdown_layout.dart';
import 'widgets/widgets.dart';

/// Production-grade dropdown supporting:
///   - single & multi-select modes (toggled via [isMultiSelect])
///   - optional searchable list
///   - optional "select all" tile (multi-select only)
///   - loading / error states (driven by [isLoading] / [isFailer])
///   - readonly mode
///   - dynamic sheet height (capped at 75% of screen, never covered by
///     the on-screen keyboard)
///
/// All visual constants live in `DropdownLayout` (see `_internals.dart`)
/// so the dropdown follows the design system end-to-end.
class AppDropdown<T> extends StatefulWidget {
  const AppDropdown({
    super.key,
    required this.onChanged,
    required List<T> items,
    required this.itemAsString,
    this.value,
    this.hint,
    this.label,
    this.validator,
    this.formKey,
    this.autovalidateMode,
    // Visual
    this.style,
    this.labelTextStyle,
    this.hintTextStyle,
    this.fillColor,
    this.suffixIconColor,
    this.borderRadius,
    this.contentPadding,
    this.height,
    this.maxHeight,
    this.isBordered = true,
    this.isOptional = false,
    // Sheet behaviour
    this.showSearchBox = true,
    this.showHeader = false,
    this.itemHeight = 56,
    this.minBottomSheetHeight = 200,
    // State flags
    this.isFailer = false,
    this.isLoading = false,
    this.readonly = false,
    // Multi-select
    this.isMultiSelect = false,
    this.selectedValues,
    this.onMultiChanged,
    this.maxSelectableItems,
    this.selectAllText = 'Select All',
    this.showSelectAll = false,
    // Custom header message
    this.showCustomHeaderMessage = false,
    this.customHeaderMessage,
  })  : _items = items,
        assert(
          !isMultiSelect ||
              (selectedValues != null && onMultiChanged != null),
          'selectedValues and onMultiChanged must be provided when isMultiSelect is true',
        );

  // ── Public API ───────────────────────────────────────────────────
  final List<T> _items;
  final T? value;
  final String? hint;
  final String? label;
  final String Function(T) itemAsString;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T?>? validator;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;

  // Visual
  final TextStyle? style;
  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final Color? fillColor;
  final Color? suffixIconColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final double? maxHeight;
  final bool isBordered;
  final bool isOptional;

  // Sheet behaviour
  final bool showSearchBox;
  final bool showHeader;
  final double itemHeight;
  final double minBottomSheetHeight;

  // State flags
  final bool isFailer;
  final bool isLoading;
  final bool readonly;

  // Multi-select
  final bool isMultiSelect;
  final List<T>? selectedValues;
  final ValueChanged<List<T>>? onMultiChanged;
  final int? maxSelectableItems;
  final String? selectAllText;
  final bool showSelectAll;

  // Custom header message
  final bool showCustomHeaderMessage;
  final String? customHeaderMessage;

  @override
  State<AppDropdown<T>> createState() => _AppDropdownState<T>();
}

class _AppDropdownState<T> extends State<AppDropdown<T>> {
  // ── State holders (ValueNotifier so the sheet rebuilds only the
  //    affected sub-tree, not the whole sheet on every selection). ─
  late final ValueNotifier<T?> _singleSelectedNotifier;
  late final ValueNotifier<List<T>> _multiSelectedNotifier;
  late final ValueNotifier<List<T>> _filteredItemsNotifier;
  final TextEditingController _searchController = TextEditingController();

  // ════════════════════════════════════════════════════════════════
  // Lifecycle
  // ════════════════════════════════════════════════════════════════

  @override
  void initState() {
    super.initState();
    _singleSelectedNotifier = ValueNotifier<T?>(widget.value);
    _multiSelectedNotifier =
        ValueNotifier<List<T>>(widget.selectedValues ?? []);
    _filteredItemsNotifier = ValueNotifier<List<T>>(widget._items);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void didUpdateWidget(AppDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _singleSelectedNotifier.value = widget.value;
    }
    if (widget.selectedValues != oldWidget.selectedValues) {
      _multiSelectedNotifier.value = widget.selectedValues ?? [];
    }
    if (widget._items != oldWidget._items) {
      _filteredItemsNotifier.value = widget._items;
      _searchController.clear();
    }
  }

  @override
  void dispose() {
    _singleSelectedNotifier.dispose();
    _multiSelectedNotifier.dispose();
    _filteredItemsNotifier.dispose();
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  // ════════════════════════════════════════════════════════════════
  // Internal helpers
  // ════════════════════════════════════════════════════════════════

  void _onSearchChanged() {
    final q = _searchController.text.toLowerCase();
    _filteredItemsNotifier.value = q.isEmpty
        ? widget._items
        : widget._items
            .where((e) => widget.itemAsString(e).toLowerCase().contains(q))
            .toList();
  }

  /// Dynamic sheet height — sized to content, capped at [maxHeight]
  /// (or 75% of screen), and shrunk further if the keyboard would
  /// otherwise cover the bottom of the sheet.
  double _calculateSheetHeight(BuildContext context, int itemCount) {
    final screen = MediaQuery.of(context).size.height;
    final keyboard = MediaQuery.of(context).viewInsets.bottom;
    final available = screen - keyboard;

    final double headerH = widget.showHeader ? DropdownLayout.headerHeight : 0;
    final double customH = widget.showCustomHeaderMessage &&
            widget.customHeaderMessage != null
        ? DropdownLayout.customHeaderHeight
        : 0;
    final double searchH =
        widget.showSearchBox ? DropdownLayout.searchBoxHeight : 0;
    final double itemH = widget.itemHeight + DropdownLayout.itemExtraSpacing;
    final double itemsTotal = itemCount * itemH;

    final double content = DropdownLayout.topHandleAndPadding +
        headerH +
        customH +
        searchH +
        itemsTotal +
        DropdownLayout.confirmButtonHeight;

    final double maxAllowed = widget.maxHeight ??
        (screen * DropdownLayout.sheetMaxHeightFactor);
    final double clamped =
        content.clamp(widget.minBottomSheetHeight, maxAllowed);

    return clamped > available ? available : clamped;
  }

  bool _isValueEmpty(dynamic value) {
    if (widget.isMultiSelect) {
      return value == null || (value as List<T>).isEmpty;
    }
    return value == null;
  }

  String _getDisplayText(dynamic value) {
    if (widget.isLoading) return LocaleKeys.loading;
    if (widget.isFailer) return LocaleKeys.exceptionError;

    if (widget.isMultiSelect) {
      final selected = value as List<T>? ?? [];
      if (selected.isEmpty) return widget.hint ?? LocaleKeys.selectAnOption;
      return selected.map(widget.itemAsString).join(', ');
    }

    if (value == null) return widget.hint ?? LocaleKeys.selectAnOption;
    return widget.itemAsString(value);
  }

  Widget _buildSuffix() {
    if (widget.isLoading) {
      return SizedBox(
        width: DropdownLayout.selectionWidgetSize.w,
        height: DropdownLayout.selectionWidgetSize.h,
        child: const CircularProgressIndicator(
          strokeWidth: DropdownLayout.loadingIndicatorStroke,
          color: AppColors.primary,
        ),
      );
    }
    if (widget.isFailer) {
      return Icon(
        Icons.error_outline,
        color: AppColors.error,
        size: DropdownLayout.errorIconSize.h,
      );
    }
    if (widget.readonly) return const SizedBox.shrink();

    return AppAssets.svg.baseSvg.arrowDown.svg(
      colorFilter: ColorFilter.mode(
        widget.suffixIconColor ?? AppColors.black,
        BlendMode.srcIn,
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════
  // Build
  // ════════════════════════════════════════════════════════════════

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<dynamic>(
      valueListenable: widget.isMultiSelect
          ? _multiSelectedNotifier
          : _singleSelectedNotifier,
      builder: (context, value, _) {
        return FormField<dynamic>(
          key: widget.formKey,
          autovalidateMode:
              widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
          enabled: !widget.readonly,
          initialValue: value,
          validator: (v) {
            if (widget.validator == null) return null;
            if (widget.isMultiSelect) {
              final selected = value as List<T>? ?? [];
              return widget.validator!(
                selected.isEmpty ? null : selected.first,
              );
            }
            return widget.validator!(value);
          },
          builder: (state) => _buildFieldChrome(context, state, value),
        );
      },
    );
  }

  Widget _buildFieldChrome(
    BuildContext context,
    FormFieldState<dynamic> state,
    dynamic value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          _buildLabel(context),
          SizedBox(height: AppSize.sH6),
        ],
        _buildTrigger(context, state, value),
        if (state.hasError && state.errorText != null)
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: DropdownLayout.errorTopGap.h,
              start: DropdownLayout.errorStartGap.w,
            ),
            child: Text(
              state.errorText!,
              style: context.textStyle.s12.regular.setColor(AppColors.error),
            ),
          ),
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.label,
            style: widget.labelTextStyle ??
                context.textStyle.s14.regular.setBlackColor,
          ),
          if (widget.isOptional)
            TextSpan(
              text: ' (${LocaleKeys.optional})',
              style: context.textStyle.s12.regular.setHintColor,
            ),
        ],
      ),
    );
  }

  Widget _buildTrigger(
    BuildContext context,
    FormFieldState<dynamic> state,
    dynamic value,
  ) {
    final borderRadius = widget.borderRadius ??
        BorderRadius.circular(DropdownLayout.fieldBorderRadius.r);
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: state.hasError
            ? Border.all(
                width: 0.5,
                color: AppColors.error.withValues(alpha: 0.65),
              )
            : null,
      ),
      child: GestureDetector(
        onTap: widget.readonly ? null : () => _openSheet(state),
        child: Container(
          padding: widget.contentPadding ?? EdgeInsets.all(AppPadding.pH12),
          decoration: BoxDecoration(
            color: widget.readonly
                ? AppColors.grey2.withValues(alpha: 0.3)
                : widget.fillColor ?? AppColors.white,
            borderRadius: borderRadius,
            border: Border.all(
              color: state.hasError
                  ? AppColors.error
                  : (widget.isBordered
                      ? AppColors.border
                      : Colors.transparent),
              width: state.hasError ? 1.0 : 0.5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _getDisplayText(value),
                  overflow: TextOverflow.ellipsis,
                  style: widget.style ??
                      (_isValueEmpty(value)
                          ? (widget.hintTextStyle ??
                              context.textStyle.s12.regular.setHintColor)
                          : context.textStyle.s14.regular.setColor(
                              widget.readonly
                                  ? AppColors.grey1
                                  : AppColors.black,
                            )),
                ),
              ),
              _buildSuffix(),
            ],
          ),
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════
  // Open sheet (dispatch to single- or multi-select)
  // ════════════════════════════════════════════════════════════════

  Future<void> _openSheet(FormFieldState<dynamic> state) async {
    if (widget.isMultiSelect) {
      final result = await _showMultiSelectSheet(_multiSelectedNotifier.value);
      if (result != null) {
        _multiSelectedNotifier.value = result;
        widget.onMultiChanged?.call(result);
        state
          ..didChange(result)
          ..validate();
      }
    } else {
      final result =
          await _showSingleSelectSheet(_singleSelectedNotifier.value);
      if (result != null) {
        _singleSelectedNotifier.value = result;
        widget.onChanged?.call(result);
        state
          ..didChange(result)
          ..validate();
      }
    }
  }

  // ════════════════════════════════════════════════════════════════
  // Sheets
  // ════════════════════════════════════════════════════════════════

  Future<T?> _showSingleSelectSheet(T? current) {
    if (widget.isLoading || widget.isFailer || widget.readonly) {
      return Future.value(null);
    }

    _searchController.clear();
    _filteredItemsNotifier.value = widget._items;
    _singleSelectedNotifier.value = current;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
        ),
        child: ValueListenableBuilder<List<T>>(
          valueListenable: _filteredItemsNotifier,
          builder: (_, filteredItems, _) => DropdownSheetContainer(
            height: _calculateSheetHeight(sheetCtx, filteredItems.length),
            child: Column(
              children: [
                const DropdownDragHandle(),
                if (widget.showHeader)
                  DropdownSheetHeader(
                    title: widget.label ?? LocaleKeys.selectAnOption,
                    titleStyle: widget.labelTextStyle,
                  ),
                if (widget.showSearchBox) _buildSearchBox(),
                Expanded(child: _buildSingleSelectList(filteredItems)),
                ValueListenableBuilder<T?>(
                  valueListenable: _singleSelectedNotifier,
                  builder: (_, selected, _) => DropdownConfirmButton(
                    label: LocaleKeys.confirm,
                    enabled: selected != null,
                    onPressed: () => Navigator.pop(sheetCtx, selected),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<T>?> _showMultiSelectSheet(List<T> current) {
    if (widget.isLoading || widget.isFailer || widget.readonly) {
      return Future.value(null);
    }

    _searchController.clear();
    _filteredItemsNotifier.value = widget._items;
    _multiSelectedNotifier.value = List<T>.from(current);

    return showModalBottomSheet<List<T>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(sheetCtx).viewInsets.bottom,
        ),
        child: ValueListenableBuilder<List<T>>(
          valueListenable: _filteredItemsNotifier,
          builder: (_, filteredItems, _) {
            final totalItems =
                filteredItems.length + (widget.showSelectAll ? 1 : 0);
            return DropdownSheetContainer(
              height: _calculateSheetHeight(sheetCtx, totalItems),
              child: Column(
                children: [
                  const DropdownDragHandle(),
                  if (widget.showHeader)
                    DropdownSheetHeader(
                      title: widget.label ?? LocaleKeys.selectAnOption,
                      titleStyle: widget.labelTextStyle,
                      trailing: ValueListenableBuilder<List<T>>(
                        valueListenable: _multiSelectedNotifier,
                        builder: (_, selected, _) => Text(
                          '${selected.length} ',
                          style:
                              context.textStyle.s14.regular.setHintColor,
                        ),
                      ),
                    ),
                  if (widget.showCustomHeaderMessage &&
                      widget.customHeaderMessage != null)
                    _buildCustomHeaderMessage(),
                  if (widget.showSearchBox) _buildSearchBox(),
                  Expanded(child: _buildMultiSelectList(filteredItems)),
                  ValueListenableBuilder<List<T>>(
                    valueListenable: _multiSelectedNotifier,
                    builder: (_, selected, _) => DropdownConfirmButton(
                      label: '${LocaleKeys.confirm} (${selected.length})',
                      enabled: true,
                      onPressed: () => Navigator.pop(sheetCtx, selected),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════
  // Sheet sub-widgets (kept inline so they share `widget._*` access)
  // ════════════════════════════════════════════════════════════════

  Widget _buildSearchBox() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pH16,
        vertical: AppPadding.pH8,
      ),
      child: DefaultTextField(
        title: LocaleKeys.search,
        suffixIcon: AppAssets.svg.baseSvg.search.svg(),
        controller: _searchController,
        inputType: TextInputType.text,
        action: TextInputAction.search,
        validator: (value) => Validators.noValidate(value ?? ''),
      ),
    );
  }

  Widget _buildCustomHeaderMessage() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppPadding.pH16,
        vertical: AppPadding.pH8,
      ),
      padding: EdgeInsets.all(AppPadding.pH12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        children: [
          Text(
            widget.hint ?? '',
            style: context.textStyle.s16.bold.setColor(AppColors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            widget.customHeaderMessage!,
            style: context.textStyle.s12.regular.setColor(AppColors.hintText),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSingleSelectList(List<T> items) {
    if (items.isEmpty) return _buildEmptyState();
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pH16,
        vertical: 10.h,
      ),
      itemCount: items.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (_, i) => ValueListenableBuilder<T?>(
        valueListenable: _singleSelectedNotifier,
        builder: (_, selected, _) {
          final isSelected = items[i] == selected;
          return DropdownItemTile(
            label: widget.itemAsString(items[i]),
            selected: isSelected,
            itemHeight: widget.itemHeight,
            onTap: () => _singleSelectedNotifier.value = items[i],
            trailing: DropdownRadio(selected: isSelected),
          );
        },
      ),
    );
  }

  Widget _buildMultiSelectList(List<T> items) {
    if (items.isEmpty &&
        _searchController.text.isEmpty &&
        !widget.showSelectAll) {
      return _buildEmptyState();
    }
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pH16,
        vertical: 10.h,
      ),
      itemCount: items.length + (widget.showSelectAll ? 1 : 0),
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (_, i) {
        if (widget.showSelectAll && i == 0) {
          return _buildSelectAllTile(items);
        }
        final itemIndex = widget.showSelectAll ? i - 1 : i;
        if (itemIndex >= items.length) return const SizedBox.shrink();
        return _buildMultiSelectItemTile(items[itemIndex]);
      },
    );
  }

  Widget _buildSelectAllTile(List<T> filteredItems) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: _multiSelectedNotifier,
      builder: (_, selected, _) {
        final isAllSelected = filteredItems.isNotEmpty &&
            filteredItems.every(selected.contains);

        return DropdownItemTile(
          label: widget.selectAllText ?? '',
          selected: isAllSelected,
          itemHeight: widget.itemHeight,
          trailing: DropdownCheckbox(selected: isAllSelected),
          onTap: () {
            final next = List<T>.from(_multiSelectedNotifier.value);
            if (isAllSelected) {
              next.removeWhere(filteredItems.contains);
            } else {
              for (final item in filteredItems) {
                if (next.contains(item)) continue;
                if (widget.maxSelectableItems == null ||
                    next.length < widget.maxSelectableItems!) {
                  next.add(item);
                }
              }
            }
            _multiSelectedNotifier.value = next;
          },
        );
      },
    );
  }

  Widget _buildMultiSelectItemTile(T item) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: _multiSelectedNotifier,
      builder: (_, selected, _) {
        final isSelected = selected.contains(item);
        final canSelect = widget.maxSelectableItems == null ||
            selected.length < widget.maxSelectableItems! ||
            isSelected;
        return DropdownItemTile(
          label: widget.itemAsString(item),
          selected: isSelected,
          enabled: canSelect,
          itemHeight: widget.itemHeight,
          trailing: DropdownCheckbox(selected: isSelected),
          onTap: () {
            final next = List<T>.from(selected);
            isSelected ? next.remove(item) : next.add(item);
            _multiSelectedNotifier.value = next;
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        _searchController.text.isNotEmpty
            ? LocaleKeys.noResultFound
            : LocaleKeys.noOptionsFound,
        style: context.textStyle.s14.regular.setHintColor,
      ),
    );
  }
}

// `DropdownSheetContainer` moved to `widgets/dropdown_sheet_container.dart`.
