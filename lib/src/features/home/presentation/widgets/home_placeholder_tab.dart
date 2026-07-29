part of '../imports/home_imports.dart';

class _HomePlaceholderTab extends StatelessWidget {
  const _HomePlaceholderTab({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EmptyWidget(
        title: message,
        desc: LocaleKeys.noResultFound,
      ),
    );
  }
}
