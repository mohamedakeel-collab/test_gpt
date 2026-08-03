part of '../imports/orders_imports.dart';

class _OrdersBody extends StatelessWidget {
  _OrdersBody();

  final ValueNotifier<int> selectedTab = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          14.szH,
          const _OrdersHeader(),

          16.szH,

          _OrdersTabs(selectedTab: selectedTab),

          16.szH,

          _OrderCard(
            type: LocaleKeys.annualLeave,
            date: '14 أكتوبر - 18 أكتوبر',
            status: LocaleKeys.pending,
            reason: 'إجازة عائلية خاصة',
            approver: 'أحمد السعدي',
            icon: AppAssets.svg.baseSvg.holiday.path,
          ),

          12.szH,

          _OrderCard(
            type: 'إجازة سنوية',
            date: '10 أكتوبر 2:00 م',
            status: LocaleKeys.approved,
            reason: 'موعد طبي',
            approver: 'سارة محمود',
            icon: AppAssets.svg.baseSvg.permission.path,
          ),

          12.szH,

          _OrderCard(
            type: 'إجازة مرضية',
            date: '05 أكتوبر',
            status: LocaleKeys.rejected,
            reason:
                'نزلة برد حادةنزلة برد حادةنزلة برد حادةنزلة برد حادةنزلة برد حادةنزلة برد حادة',
            approver: 'النظام الآلي',
            icon: AppAssets.svg.baseSvg.reject.path,
            rejectionReason: 'سبب رفض الطلب المعتمد لإعادة النظر',
          ),

          80.szH,
        ],
      ).paddingSymmetric(horizontal: AppPadding.pH16),
    );
  }
}
