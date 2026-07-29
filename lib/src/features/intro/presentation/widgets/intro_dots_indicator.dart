part of '../imports/intro_imports.dart';

class _IntroDotsIndicator extends StatelessWidget {
  final int currentPage;
  final int totalDots;

  const _IntroDotsIndicator({
    required this.currentPage,
    required this.totalDots,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (i) {
        final isActive = i == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsetsDirectional.only(end: 8.w),
          width: isActive ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.border,
            borderRadius: BorderRadius.circular(AppCircular.r5),
          ),
        );
      }),
    );
  }
}
