part of '../imports/intro_imports.dart';

class _IntroBody extends StatelessWidget {
  final PageController pageController;
  final ValueNotifier<int> currentPageNotifier;
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final void Function(int) onPageChanged;
  final VoidCallback onGetStarted;

  const _IntroBody({
    required this.pageController,
    required this.currentPageNotifier,
    required this.onNext,
    required this.onSkip,
    required this.onPageChanged,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.splashBackground,
      child: Column(
        children: [

          Align(
            alignment: AlignmentDirectional.topStart,
            child: _IntroSkipButton(
              onTap: onSkip,
            ),
          ).paddingStart(
            AppPadding.pW32,
          ).paddingTop(
            AppPadding.pH45,
          ),


          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                _IntroPageWidget(
                  imagePath: AppAssets.svg.baseSvg.onBoarding1,
                  titleKey: LocaleKeys.introTitle1,
                  descKey: LocaleKeys.introDesc1,
                ),

                _IntroPageWidget(
                  imagePath: AppAssets.svg.baseSvg.onBoarding2,
                  titleKey: LocaleKeys.introTitle2,
                  descKey: LocaleKeys.introDesc2,
                ),

                _IntroPageWidget(
                  imagePath: AppAssets.svg.baseSvg.onBoarding3,
                  titleKey: LocaleKeys.introTitle3,
                  descKey: LocaleKeys.introDesc3,
                ),
              ],
            ),
          ),


          ValueListenableBuilder<int>(
            valueListenable: currentPageNotifier,
            builder: (_, page, _) {
              return Column(
                children: [

                  _IntroDotsIndicator(
                    currentPage: page,
                    totalDots: 3,
                  ),

                  28.szH,

                  _IntroGetStartedButton(
                    isLastPage: page == 2,
                    onNext: onNext,
                    onGetStarted: onGetStarted,
                  ),

                  32.szH,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}