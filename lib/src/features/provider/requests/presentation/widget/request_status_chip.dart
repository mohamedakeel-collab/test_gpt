part of '../imports/requests_imports.dart';

class _RequestStatusChip extends StatelessWidget {
  const _RequestStatusChip({required this.status, required this.type});

  final String status;
  final RequestStatus type;

  @override
  Widget build(BuildContext context) {
    final color = switch (type) {
      RequestStatus.pending => Colors.orange,

      RequestStatus.approved => Color(0xFF587300),

      RequestStatus.rejected => AppColors.error,
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH4,
      ),

      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(AppCircular.r20),
      ),

      child: Text(
        status,

        style: const TextStyle().s12.medium.copyWith(color: color),
      ),
    );
  }
}
