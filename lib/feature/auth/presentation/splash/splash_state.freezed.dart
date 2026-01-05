// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SplashState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState()';
}


}

/// @nodoc
class $SplashStateCopyWith<$Res>  {
$SplashStateCopyWith(SplashState _, $Res Function(SplashState) __);
}


/// Adds pattern-matching-related methods to [SplashState].
extension SplashStatePatterns on SplashState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SplashLoading value)?  loading,TResult Function( SplashGoHome value)?  goHome,TResult Function( SplashGoOnboarding value)?  goOnboarding,TResult Function( SplashGoLogin value)?  goLogin,TResult Function( SplashForceUpdate value)?  forceUpdate,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SplashLoading() when loading != null:
return loading(_that);case SplashGoHome() when goHome != null:
return goHome(_that);case SplashGoOnboarding() when goOnboarding != null:
return goOnboarding(_that);case SplashGoLogin() when goLogin != null:
return goLogin(_that);case SplashForceUpdate() when forceUpdate != null:
return forceUpdate(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SplashLoading value)  loading,required TResult Function( SplashGoHome value)  goHome,required TResult Function( SplashGoOnboarding value)  goOnboarding,required TResult Function( SplashGoLogin value)  goLogin,required TResult Function( SplashForceUpdate value)  forceUpdate,}){
final _that = this;
switch (_that) {
case SplashLoading():
return loading(_that);case SplashGoHome():
return goHome(_that);case SplashGoOnboarding():
return goOnboarding(_that);case SplashGoLogin():
return goLogin(_that);case SplashForceUpdate():
return forceUpdate(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SplashLoading value)?  loading,TResult? Function( SplashGoHome value)?  goHome,TResult? Function( SplashGoOnboarding value)?  goOnboarding,TResult? Function( SplashGoLogin value)?  goLogin,TResult? Function( SplashForceUpdate value)?  forceUpdate,}){
final _that = this;
switch (_that) {
case SplashLoading() when loading != null:
return loading(_that);case SplashGoHome() when goHome != null:
return goHome(_that);case SplashGoOnboarding() when goOnboarding != null:
return goOnboarding(_that);case SplashGoLogin() when goLogin != null:
return goLogin(_that);case SplashForceUpdate() when forceUpdate != null:
return forceUpdate(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  goHome,TResult Function()?  goOnboarding,TResult Function()?  goLogin,TResult Function()?  forceUpdate,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SplashLoading() when loading != null:
return loading();case SplashGoHome() when goHome != null:
return goHome();case SplashGoOnboarding() when goOnboarding != null:
return goOnboarding();case SplashGoLogin() when goLogin != null:
return goLogin();case SplashForceUpdate() when forceUpdate != null:
return forceUpdate();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  goHome,required TResult Function()  goOnboarding,required TResult Function()  goLogin,required TResult Function()  forceUpdate,}) {final _that = this;
switch (_that) {
case SplashLoading():
return loading();case SplashGoHome():
return goHome();case SplashGoOnboarding():
return goOnboarding();case SplashGoLogin():
return goLogin();case SplashForceUpdate():
return forceUpdate();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  goHome,TResult? Function()?  goOnboarding,TResult? Function()?  goLogin,TResult? Function()?  forceUpdate,}) {final _that = this;
switch (_that) {
case SplashLoading() when loading != null:
return loading();case SplashGoHome() when goHome != null:
return goHome();case SplashGoOnboarding() when goOnboarding != null:
return goOnboarding();case SplashGoLogin() when goLogin != null:
return goLogin();case SplashForceUpdate() when forceUpdate != null:
return forceUpdate();case _:
  return null;

}
}

}

/// @nodoc


class SplashLoading implements SplashState {
  const SplashLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.loading()';
}


}




/// @nodoc


class SplashGoHome implements SplashState {
  const SplashGoHome();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashGoHome);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.goHome()';
}


}




/// @nodoc


class SplashGoOnboarding implements SplashState {
  const SplashGoOnboarding();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashGoOnboarding);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.goOnboarding()';
}


}




/// @nodoc


class SplashGoLogin implements SplashState {
  const SplashGoLogin();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashGoLogin);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.goLogin()';
}


}




/// @nodoc


class SplashForceUpdate implements SplashState {
  const SplashForceUpdate();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SplashForceUpdate);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SplashState.forceUpdate()';
}


}




// dart format on
