part of '../imports/employee_details_imports.dart';

class _EmployeeDetailsBody extends StatefulWidget {
  const _EmployeeDetailsBody({
    required this.controller,
    required this.employeeId,
    required this.onEmployeeUpdated,
  });

  final EmployeeDetailsViewController controller;

  final int employeeId;

  final VoidCallback onEmployeeUpdated;

  @override
  State<_EmployeeDetailsBody> createState() => _EmployeeDetailsBodyState();
}

class _EmployeeDetailsBodyState extends State<_EmployeeDetailsBody> {
  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<EmployeeDetailsCubit, EmployeeDetailsEntity>(
      onRetry: () => context.read<EmployeeDetailsCubit>().getEmployeeDetails(
        widget.employeeId,
      ),
      loadingBuilder: (_) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              16.szH,

              const _EmployeeDetailsHeaderSkeleton(),

              16.szH,

              Row(
                children: [
                  Expanded(child: _EmployeeBalanceSkeleton()),

                  12.szW,

                  Expanded(child: _EmployeeBalanceSkeleton()),

                  12.szW,

                  Expanded(child: _EmployeeBalanceSkeleton()),
                ],
              ),

              16.szH,

              ...List.generate(
                4,
                (_) => Padding(
                  padding: EdgeInsets.only(bottom: AppPadding.pH12),
                  child: const _EmployeeRequestSkeleton(),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: AppPadding.pH16),
        );
      },
      builder: (context, employee) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.szH,
              _EmployeeDetailsHeaderCard(
                employee: employee,

                onEmployeeUpdated: widget.onEmployeeUpdated,
              ),
              16.szH,
              Row(
                children: [
                  Expanded(
                    child: _EmployeeDetailsBalanceCard(
                      title: LocaleKeys.leaveBalance,
                      value: widget.controller.balanceLabel(
                        employee.leaveBalance,
                      ),
                      subtitle: LocaleKeys.remainingBalance,
                    ),
                  ),
                  12.szW,
                  Expanded(
                    child: _EmployeeDetailsBalanceCard(
                      title: LocaleKeys.permissionHours,
                      value: widget.controller.balanceLabel(
                        employee.permissionHours,
                      ),
                      subtitle: LocaleKeys.leaveBalance,
                    ),
                  ),
                  12.szW,
                  Expanded(
                    child: _EmployeeDetailsBalanceCard(
                      title: LocaleKeys.remainingBalance,
                      value: widget.controller.balanceLabel(
                        employee.remainingLeaveBalance,
                      ),
                      subtitle: LocaleKeys.leaveBalance,
                    ),
                  ),
                ],
              ),
              16.szH,
              ...employee.leaveRequests.map(
                (request) => Padding(
                  padding: EdgeInsets.only(bottom: AppPadding.pH12),

                  child: RequestCard(
                    onTap: () {
                      Go.to(RequestDetailsScreen(id: request.id));
                    },
                    request: request,
                    controller: widget.controller,
                  ),
                ),
              ),
              80.szH,
            ],
          ).paddingSymmetric(horizontal: AppPadding.pH16),
        );
      },
    );
  }
}
