part of '../imports/splash_imports.dart';

class SplashLoadingIndicator extends StatefulWidget {
  const SplashLoadingIndicator({super.key});

  @override
  State<SplashLoadingIndicator> createState() => _SplashLoadingIndicatorState();
}

class _SplashLoadingIndicatorState extends State<SplashLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  static const Color _neonGreen = Color(0xFFC6FF00);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 50.0.h),
          child: SizedBox(
            width: 240.w,
            height: 3.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: [
                  Container(color: _neonGreen.withOpacity(0.15)),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      return AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          final double trackWidth = constraints.maxWidth;
                          final double segmentWidth = trackWidth * 0.35;
                          final double position =
                              (_controller.value * (trackWidth + segmentWidth)) -
                              segmentWidth;

                          return Stack(
                            children: [
                              Positioned(
                                left: position,
                                child: Container(
                                  width: segmentWidth,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        _neonGreen.withOpacity(0),
                                        _neonGreen,
                                        _neonGreen.withOpacity(0),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: _neonGreen.withOpacity(0.6),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),

        Text(
          'INITIALIZING SYSTEM',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[400],
            letterSpacing: 3,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
