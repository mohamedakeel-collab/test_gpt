part of '../imports/requests_imports.dart';

class _RequestsBody extends StatelessWidget {
  _RequestsBody();

  final ValueNotifier<int> selectedTab = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    final requests = [
      const EmployeeDetailsLeaveRequestEntity(
        requestType: 'leave',
        date: 'من 20 أكتوبر إلى 25 أكتوبر (5 أيام)',
        status: 'pending',
        id: 1,
        duration: "0.75 ساعات",
        reason: 'هوعوغةةفةفةل هوعوغةةفةفةل',
        statusText: "تمت الموافقة",
      ),

      const EmployeeDetailsLeaveRequestEntity(
        requestType: 'permission',
        date: 'الأحد 22 سبتمبر (ساعتان - 10 صباحاً)',
        status: 'approved',
        duration: "0.75 ساعات",
        id: 2,
        reason: 'هوعوغةةفةفةل هوعوغةةفةفةل',
        statusText: "تمت الموافقة",
      ),

      const EmployeeDetailsLeaveRequestEntity(
        requestType: 'sick',
        date: '12 يناير (يوم واحد)',
        status: 'rejected',
        duration: "0.75 ساعات",
        id: 3,
        reason: 'هوعوغةةفةفةل هوعوغةةفةفةل',
        statusText: "تمت الموافقة",
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          16.szH,

          _RequestsTabs(selectedTab: selectedTab),
          16.szH,

          ...requests.map(
            (request) => Padding(
              padding: EdgeInsets.only(bottom: AppPadding.pH12),

              child: RequestCard(
                onTap: () {
                  Go.to(RequestDetailsScreen(id: 12));
                },
                request: request,
                controller: EmployeeDetailsViewController(),
              ),
            ),
          ),

          80.szH,
        ],
      ).paddingSymmetric(horizontal: AppPadding.pH16),
    );
  }
}
