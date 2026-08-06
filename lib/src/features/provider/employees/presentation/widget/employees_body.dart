part of '../imports/employees_imports.dart';

class _EmployeesBody extends StatelessWidget {
  const _EmployeesBody();

  @override
  Widget build(BuildContext context) {
    final employees = [
      const _EmployeeData(
        name: 'أحمد المنصوري',
        job: 'مطور موبايل',
        status: 'طلب معلق',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZvzcHwf_E84xtTdBJclC4gsogNLWekM0qXQ&s',
      ),

      const _EmployeeData(
        name: 'سارة الحربي',
        job: 'مصممة واجهة المستخدم',
        status: 'طلب معلق',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZvzcHwf_E84xtTdBJclC4gsogNLWekM0qXQ&s',
      ),

      const _EmployeeData(
        name: 'يوسف العتيبي',
        job: 'مطور Flutter',
        status: 'على رأس العمل',
        image:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZvzcHwf_E84xtTdBJclC4gsogNLWekM0qXQ&s',
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.szH,

          const _EmployeesHeader(),

          16.szH,

          const _EmployeesSummaryCard(),

          16.szH,

          Row(
            children: [
              Expanded(child: _EmployeesSearch()),

              8.szW,

              const _EmployeesFilter(),
            ],
          ),

          16.szH,

          ...employees.map(
            (employee) => Padding(
              padding: EdgeInsets.only(bottom: AppPadding.pH12),

              child: _EmployeeCard(
                name: employee.name,
                job: employee.job,
                status: employee.status,
                image: employee.image,
                onTap: () {
                  Go.to(
                    EmployeesDetailsScreen(

                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: AppPadding.pH16),
    );
  }
}

class _EmployeeData {
  const _EmployeeData({
    required this.name,
    required this.job,
    required this.status,
    required this.image,
  });

  final String name;
  final String job;
  final String status;
  final String image;
}
