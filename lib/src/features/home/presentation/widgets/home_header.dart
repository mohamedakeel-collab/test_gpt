part of '../imports/home_imports.dart';

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.pW20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          AppSize.sH16.szH,
          Text(
            '${LocaleKeys.homeWelcome} أحمد ',
            style: const TextStyle().setMainTextColor.s24.bold,
          ),
          AppSize.sH6.szH,
          Text(
            LocaleKeys.homePendingRequests(count: '3'),
            style: const TextStyle().subHintColor.s16.regular,
          ),
        ],
      ),
    );
  }
}
