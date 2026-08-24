part of '../imports/login_imports.dart';

/// Body of [LoginScreen].
///
/// Two concerns:
///   1. [BlocListener] — reacts to the login outcome: on success persist the
///      token (the cubit already did that) and navigate to [MainTapScreen];
///      on failure surface the localized error via snackbar.
///   2. [AsyncBlocBuilder] — renders logo / form / footer. The form stays put
///      on every state; only the submit button reflects loading (LoadingButton
///      owns its own spinner), so we keep the layout stable for the user.
class _LoginBody extends StatelessWidget {
  const _LoginBody({required this.vc});

  final LoginViewController vc;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, AsyncState<LoginEntity>>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        switch (state) {
          case AsyncSuccess<LoginEntity>():
            // Token already saved inside LoginCubit.login — just enter the app.
            Go.offAll(const MainTapScreen());
          case AsyncFailure<LoginEntity>(:final failure):
            if (failure is! CancelledFailure) {
              MessageUtils.showSnackBar(
                context: context,
                baseStatus: BaseStatus.error,
                message: failure.userMessage,
              );
            }
          default:
            break;
        }
      },
      child: AsyncBlocBuilder<LoginCubit, LoginEntity>(
        loadingBuilder: (_) => _buildScreen(context),
        errorBuilder: (_, _) => _buildScreen(context),
        builder: (_, _) => _buildScreen(context),
        initialBuilder: (_) => _buildScreen(context),
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight:
              MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              const _LoginLogoSec(),
              Expanded(child: _LoginFormSec(vc: vc)),
              const _LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
