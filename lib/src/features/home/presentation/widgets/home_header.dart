part of '../imports/home_imports.dart';

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.home});

  final HomeEntity home;

  @override
  Widget build(BuildContext context) {
    final name = context.read<UserCubit>().user.fullName;
    return Padding(
      padding: EdgeInsets.all(AppPadding.pW20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSize.sH16.szH,
          Text(
            '${LocaleKeys.homeWelcome} $name',
            style: const TextStyle().setMainTextColor.s24.bold,
          ),
          AppSize.sH6.szH,
          Text(
            LocaleKeys.homePendingRequests(count: '${home.requests.pending}'),
            style: const TextStyle().subHintColor.s16.regular,
          ),
        ],
      ),
    );
  }
}
