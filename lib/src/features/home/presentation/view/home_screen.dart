part of '../imports/home_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(actions: [
          InkWell(onTap: (){
            Go.to(NotificationsScreen());
          },
          child:IconWidget(
            icon: Icons.notifications_none,
            color: AppColors.primary,
            height:AppSize.sH25,
          ).paddingSymmetric(horizontal: AppPadding.pH12),
          )

        ],),
      body: _HomeBody(),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Go.to(NewRequestScreen());
      },
      backgroundColor: AppColors.primary,
      elevation: 4,
      child:  Icon(Icons.add, color: Color(0xFF587300), size: 28),
    ),
    );
  }
}
