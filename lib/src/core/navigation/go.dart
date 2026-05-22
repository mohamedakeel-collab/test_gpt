// Re-exports the animation option classes from every transition family so a
// single import gives callers ergonomic access to `FadeAnimationOptions`,
// `SlideAnimationOption`, etc. The `Go` class itself lives in
// `navigator.dart`.
export 'Transition/implementation/cupertino/Options/cupertino_animation_option.dart';
export 'Transition/implementation/fade/Option/fade_animation_option.dart';
export 'Transition/implementation/rotation/Option/rotation_animation_option.dart';
export 'Transition/implementation/scale/Options/scale_animation_option.dart';
export 'Transition/implementation/size/Option/size_animation_option.dart';
export 'Transition/implementation/slide/Option/slide_animation_option.dart';
