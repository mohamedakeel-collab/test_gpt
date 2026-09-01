part of '../imports/employees_imports.dart';

class _EmployeesBody extends StatefulWidget {
  const _EmployeesBody({required this.controller});

  final EmployeesViewController controller;

  @override
  State<_EmployeesBody> createState() => _EmployeesBodyState();
}

class _EmployeesBodyState extends State<_EmployeesBody> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 100) {
      context.read<EmployeesCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<EmployeesCubit, List<EmployeeEntity>>(
      onRetry: () => context.read<EmployeesCubit>().getEmployees(perPage: 15),

      builder: (context, employees) {
        return ValueListenableBuilder<String>(
          valueListenable: widget.controller.searchQuery,
          builder: (context, query, _) {
            final filteredEmployees = widget.controller.filterEmployees(
              employees,
            );

            final pendingCount = widget.controller.pendingCount(
              filteredEmployees,
            );

            final cubit = context.read<EmployeesCubit>();

            return RefreshIndicator(
              onRefresh: () => cubit.getEmployees(perPage: 15),

              child: ListView(
                controller: _scrollController,

                physics: const AlwaysScrollableScrollPhysics(),

                children: [
                  16.szH,

                  _EmployeesHeader(
                    totalCount: filteredEmployees.length,
                  ).paddingSymmetric(horizontal: AppPadding.pH16),

                  16.szH,

                  _EmployeesSummaryCard(
                    totalCount: filteredEmployees.length,

                    pendingCount: pendingCount,
                  ).paddingSymmetric(horizontal: AppPadding.pH16),

                  16.szH,

                  Row(
                    children: [
                      Expanded(
                        child: _EmployeesSearch(controller: widget.controller),
                      ),

                      8.szW,

                      _EmployeesFilter(controller: widget.controller),
                    ],
                  ).paddingSymmetric(horizontal: AppPadding.pH16),

                  16.szH,

                  if (filteredEmployees.isEmpty)
                    EmptyWidget(
                      title: LocaleKeys.noEmployees,

                      desc: LocaleKeys.errorexceptionNotcontaindesc,
                    ).paddingSymmetric(horizontal: AppPadding.pH16)
                  else
                    ...filteredEmployees.map(
                      (employee) =>
                          _EmployeeCard(
                            employee: employee,

                            controller: widget.controller,

                            onTap: () {
                               Go.to(EmployeesDetailsScreen(id: employee.id));
                            },
                          ).paddingOnly(
                            left: AppPadding.pH16,

                            right: AppPadding.pH16,

                            bottom: AppPadding.pH12,
                          ),
                    ),

                  if (cubit.isLoadingMore)
                    Center(
                      child: SizedBox.square(
                        dimension: AppSize.sH24,

                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),

                  24.szH,
                ],
              ),
            );
          },
        );
      },
    );
  }
}
