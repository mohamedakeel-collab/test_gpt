part of '../imports/login_imports.dart';

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              const _LoginLogoSec(),
              Expanded(child: const _LoginFormSec(),),
              const _LoginFooter(),
            ],
          ),
        ),
      ),
    );

  }
}
