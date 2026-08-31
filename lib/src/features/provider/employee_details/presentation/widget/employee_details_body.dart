part of '../imports/employee_details_imports.dart';

class _EmployeeDetailsBody extends StatelessWidget {
  _EmployeeDetailsBody({required this.employee});

  final EmployeeEntity employee;

  final ValueNotifier<int> selectedTab = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final requests = [
      const RequestData(
        id: 36,
        title: 'إجازة سنوية',
        status: 'قيد المراجعة',
        statusType: RequestStatus.pending,
        createdAt: 'تم الطلب في 10 أكتوبر 2023',
        date: 'من 20 أكتوبر إلى 25 أكتوبر (5 أيام)',
      ),

      const RequestData(
        id: 37,
        title: 'إذن خروج',
        status: 'تمت الموافقة',
        statusType: RequestStatus.approved,
        date: 'الأحد 22 سبتمبر (ساعتان - 10 صباحاً)',
        createdAt: 'تمت الموافقة بواسطة: سارة الشهري',
      ),

      const RequestData(
        id: 38,
        title: 'إجازة مرضية',
        status: 'مرفوض',
        statusType: RequestStatus.rejected,
        date: '12 يناير (يوم واحد)',
        createdAt: 'السبب: لم يتم إرفاق التقرير الطبي',
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          16.szH,

          _EmployeeDetailsHeaderCard(employee: employee),

          16.szH,

          Row(
            children: [
              Expanded(
                child: _EmployeeDetailsBalanceCard(
                  title: 'الرصيد السنوي',
                  value: '18 يوم',
                  subtitle: 'متاح للاستخدام',
                ),
              ),

              12.szW,

              Expanded(
                child: _EmployeeDetailsBalanceCard(
                  title: 'الأذونات الشهرية',
                  value: '4 ساعات',
                  subtitle: 'تم استهلاك : ساعتينن',
                ),
              ),
            ],
          ),

          16.szH,

          _EmployeeDetailsTabs(selectedTab: selectedTab),

          16.szH,

          ...requests.map(
            (request) => Padding(
              padding: EdgeInsets.only(bottom: AppPadding.pH12),

              child: RequestCard(data: request),
            ),
          ),

          80.szH,
        ],
      ).paddingSymmetric(horizontal: AppPadding.pH16),
    );
  }
}
