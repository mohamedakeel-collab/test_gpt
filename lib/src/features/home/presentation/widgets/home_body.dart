part of '../imports/home_imports.dart';

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            _HomeHeader(),
            _BalanceCard(),
            _HomeTabs(selectedTab: ValueNotifier(0),),
            _RequestsSection()
          ],
        ).paddingOnly(bottom: AppPadding.pH10),
      ),
    );
  }
}
