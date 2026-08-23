part of '../imports/orders_imports.dart';

/// Small pill showing the request status with the canonical color mapping:
///   - approved → success
///   - rejected → error
///   - pending  → warning
///
/// The label comes straight from the backend's `status_text` (localized),
/// falling back to a generic label when empty.
class _OrderStatusBadge extends StatelessWidget {
  const _OrderStatusBadge({
    required this.status,
    required this.statusText,
  });

  final String status;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (status) {
      'approved' => (AppColors.successSurface, AppColors.success),
      'rejected' => (AppColors.dangerSurface, AppColors.error),
      'pending' => (AppColors.warningSurface, AppColors.warning),
      _ => (AppColors.fill, AppColors.labelText),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW12,
        vertical: AppPadding.pH6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),
      child: Text(
        statusText.isEmpty ? LocaleKeys.failureUnknown : statusText,
        style: const TextStyle().s12.semiBold.copyWith(color: foreground),
      ),
    );
  }
}