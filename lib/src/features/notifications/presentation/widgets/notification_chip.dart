part of '../imports/notifications_imports.dart';

class _NotificationChip extends StatelessWidget {
  const _NotificationChip({
    required this.label,
    required this.color,
    required this.textColor,
    required this.borderColor,
  });

  final String label;
  final Color color;
  final Color textColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppCircular.r20),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle().s12.medium.copyWith(color: textColor),
      ),
    );
  }
}
