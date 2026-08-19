part of '../imports/home_imports.dart';

class _RequestsSection extends StatelessWidget {
  const _RequestsSection({required this.requests});

  final List<RecentRequestEntity> requests;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.homeLatestRequests,
          style: const TextStyle().setMainTextColor.s18.bold,
        ).paddingSymmetric(vertical: AppPadding.pH16),
        if (requests.isEmpty)
          EmptyWidget(
            title: LocaleKeys.noResultFound,
            desc: LocaleKeys.errorexceptionNotcontaindesc,
          )
        else
          ...requests.map(
            (request) => Padding(
              padding: EdgeInsets.only(bottom: AppPadding.pH12),
              child: _RequestCard(request: request),
            ),
          ),
      ],
    ).paddingSymmetric(horizontal: AppPadding.pH16);
  }
}
