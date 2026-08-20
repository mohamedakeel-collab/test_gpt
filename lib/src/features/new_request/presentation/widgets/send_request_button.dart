part of '../imports/new_request_imports.dart';

class _SendRequestButton extends StatelessWidget {
  const _SendRequestButton({this.onSubmit});

  final Future<void> Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewRequestCubit, AsyncState<NewRequestResultEntity>>(
      listenWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      listener: (context, state) {
        switch (state) {
          case AsyncSuccess<NewRequestResultEntity>():
            MessageUtils.showSnackBar(
              context: context,
              baseStatus: BaseStatus.success,
              message: LocaleKeys.requestSubmittedSuccessfully,
            );
            Go.back();
          case AsyncFailure<NewRequestResultEntity>(:final failure):
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
      child: BlocBuilder<NewRequestCubit, AsyncState<NewRequestResultEntity>>(
        builder: (context, state) {
          return LoadingButton(
            title: LocaleKeys.sendRequest,
            color: AppColors.primary,
            textColor: AppColors.splashBackground,
            borderRadius: AppCircular.r30,
            isDisabled: state.isLoading,
            onTap: onSubmit ?? () async {},
          ).paddingAll(AppPadding.pH16);
        },
      ),
    );
  }
}
