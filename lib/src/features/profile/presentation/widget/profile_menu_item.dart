part of '../imports/profile_imports.dart';

class _ProfileMenuItem extends StatelessWidget {
  const _ProfileMenuItem({required this.title, required this.icon});

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,

      leading: IconWidget(icon: icon, height: AppSize.sH22),

      title: Text(
        title,
        textAlign: TextAlign.right,
        style: const TextStyle().setMainTextColor.s14.medium,
      ),

      trailing: Icon(Icons.arrow_forward_ios_rounded, size: AppSize.sH14),
    );
  }
}
