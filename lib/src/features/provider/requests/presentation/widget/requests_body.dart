part of '../imports/requests_imports.dart';

class _RequestsBody extends StatelessWidget {
   _RequestsBody();
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
        createdAt: 'تمت الموافقة بواسطة: سارة الشهري',
        date: 'الأحد 22 سبتمبر (ساعتان - 10 صباحاً)',
      ),

      const RequestData(
        id: 38,
        title: 'إجازة مرضية',
        status: 'مرفوض',
        statusType: RequestStatus.rejected,
        createdAt: 'تم إرفاق التقرير الطبي',
        date: '12 يناير (يوم واحد)',
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          16.szH,


          _RequestsTabs(
            selectedTab: selectedTab,
          ),
          16.szH,

          ...requests.map(
            (request) => Padding(
              padding: EdgeInsets.only(bottom: AppPadding.pH12),

              child: RequestCard(
                data: request,

                onTap: () {
                  Go.to(
                    RequestDetailsScreen(
                      id: 12,
                    ),
                  );
                },
              ),
            ),
          ),

          80.szH,
        ],
      ).paddingSymmetric(horizontal: AppPadding.pH16),
    );
  }
}
