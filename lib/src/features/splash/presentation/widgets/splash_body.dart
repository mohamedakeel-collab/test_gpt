part of '../imports/splash_imports.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.2, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _glowAnimation,
            builder: (context, child) {
              return Container(
                width: 256.w,
                height: 256.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  image: DecorationImage(
                    image: AssetImage(AppAssets.svg.baseSvg.tagLogo.path),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFC6FF00)
                          .withOpacity(_glowAnimation.value),
                      blurRadius: 20 + (_glowAnimation.value * 15),
                      spreadRadius: 4 + (_glowAnimation.value * 8),
                    ),
                  ],
                ),
              );
            },
          ),
          Text(
              LocaleKeys.splashTitle.tr(),
            textAlign: TextAlign.center,
            style: const TextStyle().setWhiteColor.s18.semiBold,
          ).paddingSymmetric(vertical: AppPadding.pH35),
          SplashLoadingIndicator()
        ],
      ),
    );
  }
}