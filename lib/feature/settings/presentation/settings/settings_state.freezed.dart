// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState()';
}


}

/// @nodoc
class $SettingsStateCopyWith<$Res>  {
$SettingsStateCopyWith(SettingsState _, $Res Function(SettingsState) __);
}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SettingsLoading value)?  loading,TResult Function( SettingsReady value)?  ready,TResult Function( SettingsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SettingsLoading() when loading != null:
return loading(_that);case SettingsReady() when ready != null:
return ready(_that);case SettingsError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SettingsLoading value)  loading,required TResult Function( SettingsReady value)  ready,required TResult Function( SettingsError value)  error,}){
final _that = this;
switch (_that) {
case SettingsLoading():
return loading(_that);case SettingsReady():
return ready(_that);case SettingsError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SettingsLoading value)?  loading,TResult? Function( SettingsReady value)?  ready,TResult? Function( SettingsError value)?  error,}){
final _that = this;
switch (_that) {
case SettingsLoading() when loading != null:
return loading(_that);case SettingsReady() when ready != null:
return ready(_that);case SettingsError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( String displayName,  String email,  String initials,  int credits,  bool isLoggingOut)?  ready,TResult Function( String message,  String displayNameFallback,  String emailFallback,  String initialsFallback,  int creditsFallback)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SettingsLoading() when loading != null:
return loading();case SettingsReady() when ready != null:
return ready(_that.displayName,_that.email,_that.initials,_that.credits,_that.isLoggingOut);case SettingsError() when error != null:
return error(_that.message,_that.displayNameFallback,_that.emailFallback,_that.initialsFallback,_that.creditsFallback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( String displayName,  String email,  String initials,  int credits,  bool isLoggingOut)  ready,required TResult Function( String message,  String displayNameFallback,  String emailFallback,  String initialsFallback,  int creditsFallback)  error,}) {final _that = this;
switch (_that) {
case SettingsLoading():
return loading();case SettingsReady():
return ready(_that.displayName,_that.email,_that.initials,_that.credits,_that.isLoggingOut);case SettingsError():
return error(_that.message,_that.displayNameFallback,_that.emailFallback,_that.initialsFallback,_that.creditsFallback);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( String displayName,  String email,  String initials,  int credits,  bool isLoggingOut)?  ready,TResult? Function( String message,  String displayNameFallback,  String emailFallback,  String initialsFallback,  int creditsFallback)?  error,}) {final _that = this;
switch (_that) {
case SettingsLoading() when loading != null:
return loading();case SettingsReady() when ready != null:
return ready(_that.displayName,_that.email,_that.initials,_that.credits,_that.isLoggingOut);case SettingsError() when error != null:
return error(_that.message,_that.displayNameFallback,_that.emailFallback,_that.initialsFallback,_that.creditsFallback);case _:
  return null;

}
}

}

/// @nodoc


class SettingsLoading implements SettingsState {
  const SettingsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.loading()';
}


}




/// @nodoc


class SettingsReady implements SettingsState {
  const SettingsReady({required this.displayName, required this.email, required this.initials, required this.credits, this.isLoggingOut = false});
  

 final  String displayName;
 final  String email;
 final  String initials;
 final  int credits;
@JsonKey() final  bool isLoggingOut;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsReadyCopyWith<SettingsReady> get copyWith => _$SettingsReadyCopyWithImpl<SettingsReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsReady&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.credits, credits) || other.credits == credits)&&(identical(other.isLoggingOut, isLoggingOut) || other.isLoggingOut == isLoggingOut));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,email,initials,credits,isLoggingOut);

@override
String toString() {
  return 'SettingsState.ready(displayName: $displayName, email: $email, initials: $initials, credits: $credits, isLoggingOut: $isLoggingOut)';
}


}

/// @nodoc
abstract mixin class $SettingsReadyCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory $SettingsReadyCopyWith(SettingsReady value, $Res Function(SettingsReady) _then) = _$SettingsReadyCopyWithImpl;
@useResult
$Res call({
 String displayName, String email, String initials, int credits, bool isLoggingOut
});




}
/// @nodoc
class _$SettingsReadyCopyWithImpl<$Res>
    implements $SettingsReadyCopyWith<$Res> {
  _$SettingsReadyCopyWithImpl(this._self, this._then);

  final SettingsReady _self;
  final $Res Function(SettingsReady) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? email = null,Object? initials = null,Object? credits = null,Object? isLoggingOut = null,}) {
  return _then(SettingsReady(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int,isLoggingOut: null == isLoggingOut ? _self.isLoggingOut : isLoggingOut // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SettingsError implements SettingsState {
  const SettingsError({required this.message, this.displayNameFallback = '', this.emailFallback = '', this.initialsFallback = '', this.creditsFallback = 0});
  

 final  String message;
// Error ekranında da user bilgisi gösterilebilsin diye fallback’ler
@JsonKey() final  String displayNameFallback;
@JsonKey() final  String emailFallback;
@JsonKey() final  String initialsFallback;
@JsonKey() final  int creditsFallback;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsErrorCopyWith<SettingsError> get copyWith => _$SettingsErrorCopyWithImpl<SettingsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsError&&(identical(other.message, message) || other.message == message)&&(identical(other.displayNameFallback, displayNameFallback) || other.displayNameFallback == displayNameFallback)&&(identical(other.emailFallback, emailFallback) || other.emailFallback == emailFallback)&&(identical(other.initialsFallback, initialsFallback) || other.initialsFallback == initialsFallback)&&(identical(other.creditsFallback, creditsFallback) || other.creditsFallback == creditsFallback));
}


@override
int get hashCode => Object.hash(runtimeType,message,displayNameFallback,emailFallback,initialsFallback,creditsFallback);

@override
String toString() {
  return 'SettingsState.error(message: $message, displayNameFallback: $displayNameFallback, emailFallback: $emailFallback, initialsFallback: $initialsFallback, creditsFallback: $creditsFallback)';
}


}

/// @nodoc
abstract mixin class $SettingsErrorCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory $SettingsErrorCopyWith(SettingsError value, $Res Function(SettingsError) _then) = _$SettingsErrorCopyWithImpl;
@useResult
$Res call({
 String message, String displayNameFallback, String emailFallback, String initialsFallback, int creditsFallback
});




}
/// @nodoc
class _$SettingsErrorCopyWithImpl<$Res>
    implements $SettingsErrorCopyWith<$Res> {
  _$SettingsErrorCopyWithImpl(this._self, this._then);

  final SettingsError _self;
  final $Res Function(SettingsError) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? displayNameFallback = null,Object? emailFallback = null,Object? initialsFallback = null,Object? creditsFallback = null,}) {
  return _then(SettingsError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,displayNameFallback: null == displayNameFallback ? _self.displayNameFallback : displayNameFallback // ignore: cast_nullable_to_non_nullable
as String,emailFallback: null == emailFallback ? _self.emailFallback : emailFallback // ignore: cast_nullable_to_non_nullable
as String,initialsFallback: null == initialsFallback ? _self.initialsFallback : initialsFallback // ignore: cast_nullable_to_non_nullable
as String,creditsFallback: null == creditsFallback ? _self.creditsFallback : creditsFallback // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
