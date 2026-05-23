import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/res/config_imports.dart';
import '../../../shared/extensions/text_style_extensions.dart';

/// Project-wide text input widget.
///
/// Wraps a `TextFormField` with the visual defaults the design system
/// expects (rounded border, hint/error typography, password toggle, …).
/// Every styling primitive (color, radius, spacing) comes from the
/// design tokens in `config/res/` — no inline hex colors or magic
/// numbers — so a token change ripples to every field in the app.
///
/// Example
///   ```dart
///   DefaultTextField(
///     title: LocaleKeys.email,
///     controller: _email,
///     inputType: TextInputType.emailAddress,
///     validator: Validators.email,
///   )
///   ```
class DefaultTextField extends StatefulWidget {
  // ── Content ────────────────────────────────────────────────────
  final String? title;
  final String? label;
  final String? suffixText;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final List<TextInputFormatter>? inputFormatters;

  // ── Decoration ─────────────────────────────────────────────────
  final Color? fillColor;
  final Color? borderColor;
  final bool? hasBorderColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final Widget? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final bool filled;

  // ── Behaviour ──────────────────────────────────────────────────
  final TextInputType inputType;
  final TextInputAction action;
  final TextAlign? textAlign;
  final int? maxLength;
  final int? maxLines;
  final bool secure;
  final bool? isPassword;
  final bool readOnly;
  final bool autoFocus;
  final bool closeWhenTapOutSide;
  final FocusNode? focusNode;

  // ── Callbacks ──────────────────────────────────────────────────
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final GestureTapCallback? onTap;

  const DefaultTextField({
    super.key,
    this.title,
    this.label,
    this.suffixText,
    this.controller,
    this.validator,
    this.inputFormatters,
    // Decoration
    this.fillColor,
    this.borderColor,
    this.hasBorderColor = true,
    this.borderRadius,
    this.contentPadding,
    this.style,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
    this.filled = true,
    // Behaviour
    this.inputType = TextInputType.text,
    this.action = TextInputAction.next,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.maxLines,
    this.secure = false,
    this.isPassword = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.closeWhenTapOutSide = true,
    this.focusNode,
    // Callbacks
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
  });

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  /// Visual config — kept private so callers don't accidentally tweak the
  /// design system from a single field.
  static const int _multilineDefaultMaxLines = 7;
  static const String _obscuringCharacter = '*';

  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword == true;
  }

  @override
  Widget build(BuildContext context) {
    final bool hasLabel = widget.label != null;

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.autoFocus == true ? widget.focusNode : null,
      keyboardType: widget.inputType,
      textInputAction: widget.action,
      textAlign: widget.textAlign!,
      autofocus: widget.autoFocus,
      readOnly: widget.onTap != null ? true : widget.readOnly,
      obscureText: widget.isPassword == true ? _isObscured : widget.secure,
      obscuringCharacter: _obscuringCharacter,
      style: widget.style,
      cursorColor: AppColors.main,
      maxLength: widget.maxLength,
      maxLines: widget.inputType == TextInputType.multiline
          ? widget.maxLines ?? _multilineDefaultMaxLines
          : 1,
      autocorrect: true,
      enableSuggestions: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofillHints: _autofillHintsFor(widget.inputType),
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      onTapOutside: (_) {
        if (widget.closeWhenTapOutSide) {
          FocusScope.of(context).unfocus();
        }
      },
      decoration: _decoration(hasLabel: hasLabel),
    );
  }

  InputDecoration _decoration({required bool hasLabel}) {
    final border = widget.borderRadius ??
        BorderRadius.circular(AppCircular.r10);

    OutlineInputBorder outline(Color color) => OutlineInputBorder(
          borderRadius: border,
          borderSide: BorderSide(color: color),
        );

    return InputDecoration(
      isDense: true,
      errorMaxLines: 2,
      counterText: ConstantManager.emptyText,
      filled: widget.filled,
      fillColor: widget.fillColor ?? AppColors.white,
      contentPadding: widget.contentPadding,
      // Content
      hintText: widget.title,
      label: hasLabel ? Text(widget.label!) : null,
      suffixText: widget.suffixText,
      prefix: widget.prefixWidget,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
      // Typography
      hintStyle: const TextStyle().setHintColor.s13.regular,
      labelStyle:
          hasLabel ? const TextStyle().setSecondryColor.s12.medium : null,
      errorStyle: const TextStyle().setErrorColor.s12.regular,
      // Borders
      enabledBorder: widget.hasBorderColor == true
          ? outline(widget.borderColor ?? AppColors.border)
          : OutlineInputBorder(
              borderRadius: border,
              borderSide: BorderSide.none,
            ),
      focusedBorder: outline(AppColors.border),
      errorBorder: outline(AppColors.error),
      focusedErrorBorder: outline(AppColors.error),
    );
  }
}

/// Maps a [TextInputType] to the system autofill suggestions the platform
/// can offer (e.g. iOS keychain emails, Android Smart Lock phone numbers).
List<String> _autofillHintsFor(TextInputType type) {
  if (type == TextInputType.emailAddress) return const [AutofillHints.email];
  if (type == TextInputType.datetime) return const [AutofillHints.birthday];
  if (type == TextInputType.phone) {
    return const [AutofillHints.telephoneNumber];
  }
  if (type == TextInputType.url) return const [AutofillHints.url];
  return const [AutofillHints.name, AutofillHints.username];
}
