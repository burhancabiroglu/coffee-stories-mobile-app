// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeLoading value)?  loading,TResult Function( HomeReady value)?  ready,TResult Function( HomeEmpty value)?  empty,TResult Function( HomeError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeLoading() when loading != null:
return loading(_that);case HomeReady() when ready != null:
return ready(_that);case HomeEmpty() when empty != null:
return empty(_that);case HomeError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeLoading value)  loading,required TResult Function( HomeReady value)  ready,required TResult Function( HomeEmpty value)  empty,required TResult Function( HomeError value)  error,}){
final _that = this;
switch (_that) {
case HomeLoading():
return loading(_that);case HomeReady():
return ready(_that);case HomeEmpty():
return empty(_that);case HomeError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeLoading value)?  loading,TResult? Function( HomeReady value)?  ready,TResult? Function( HomeEmpty value)?  empty,TResult? Function( HomeError value)?  error,}){
final _that = this;
switch (_that) {
case HomeLoading() when loading != null:
return loading(_that);case HomeReady() when ready != null:
return ready(_that);case HomeEmpty() when empty != null:
return empty(_that);case HomeError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( int credits,  List<RecentChat> recentChats)?  ready,TResult Function( int credits)?  empty,TResult Function( String message,  int creditsFallback,  List<RecentChat> recentChatsFallback)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeLoading() when loading != null:
return loading();case HomeReady() when ready != null:
return ready(_that.credits,_that.recentChats);case HomeEmpty() when empty != null:
return empty(_that.credits);case HomeError() when error != null:
return error(_that.message,_that.creditsFallback,_that.recentChatsFallback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( int credits,  List<RecentChat> recentChats)  ready,required TResult Function( int credits)  empty,required TResult Function( String message,  int creditsFallback,  List<RecentChat> recentChatsFallback)  error,}) {final _that = this;
switch (_that) {
case HomeLoading():
return loading();case HomeReady():
return ready(_that.credits,_that.recentChats);case HomeEmpty():
return empty(_that.credits);case HomeError():
return error(_that.message,_that.creditsFallback,_that.recentChatsFallback);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( int credits,  List<RecentChat> recentChats)?  ready,TResult? Function( int credits)?  empty,TResult? Function( String message,  int creditsFallback,  List<RecentChat> recentChatsFallback)?  error,}) {final _that = this;
switch (_that) {
case HomeLoading() when loading != null:
return loading();case HomeReady() when ready != null:
return ready(_that.credits,_that.recentChats);case HomeEmpty() when empty != null:
return empty(_that.credits);case HomeError() when error != null:
return error(_that.message,_that.creditsFallback,_that.recentChatsFallback);case _:
  return null;

}
}

}

/// @nodoc


class HomeLoading implements HomeState {
  const HomeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.loading()';
}


}




/// @nodoc


class HomeReady implements HomeState {
  const HomeReady({required this.credits, required final  List<RecentChat> recentChats}): _recentChats = recentChats;
  

 final  int credits;
 final  List<RecentChat> _recentChats;
 List<RecentChat> get recentChats {
  if (_recentChats is EqualUnmodifiableListView) return _recentChats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentChats);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeReadyCopyWith<HomeReady> get copyWith => _$HomeReadyCopyWithImpl<HomeReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeReady&&(identical(other.credits, credits) || other.credits == credits)&&const DeepCollectionEquality().equals(other._recentChats, _recentChats));
}


@override
int get hashCode => Object.hash(runtimeType,credits,const DeepCollectionEquality().hash(_recentChats));

@override
String toString() {
  return 'HomeState.ready(credits: $credits, recentChats: $recentChats)';
}


}

/// @nodoc
abstract mixin class $HomeReadyCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeReadyCopyWith(HomeReady value, $Res Function(HomeReady) _then) = _$HomeReadyCopyWithImpl;
@useResult
$Res call({
 int credits, List<RecentChat> recentChats
});




}
/// @nodoc
class _$HomeReadyCopyWithImpl<$Res>
    implements $HomeReadyCopyWith<$Res> {
  _$HomeReadyCopyWithImpl(this._self, this._then);

  final HomeReady _self;
  final $Res Function(HomeReady) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? credits = null,Object? recentChats = null,}) {
  return _then(HomeReady(
credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int,recentChats: null == recentChats ? _self._recentChats : recentChats // ignore: cast_nullable_to_non_nullable
as List<RecentChat>,
  ));
}


}

/// @nodoc


class HomeEmpty implements HomeState {
  const HomeEmpty({required this.credits});
  

 final  int credits;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeEmptyCopyWith<HomeEmpty> get copyWith => _$HomeEmptyCopyWithImpl<HomeEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEmpty&&(identical(other.credits, credits) || other.credits == credits));
}


@override
int get hashCode => Object.hash(runtimeType,credits);

@override
String toString() {
  return 'HomeState.empty(credits: $credits)';
}


}

/// @nodoc
abstract mixin class $HomeEmptyCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeEmptyCopyWith(HomeEmpty value, $Res Function(HomeEmpty) _then) = _$HomeEmptyCopyWithImpl;
@useResult
$Res call({
 int credits
});




}
/// @nodoc
class _$HomeEmptyCopyWithImpl<$Res>
    implements $HomeEmptyCopyWith<$Res> {
  _$HomeEmptyCopyWithImpl(this._self, this._then);

  final HomeEmpty _self;
  final $Res Function(HomeEmpty) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? credits = null,}) {
  return _then(HomeEmpty(
credits: null == credits ? _self.credits : credits // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class HomeError implements HomeState {
  const HomeError({required this.message, this.creditsFallback = 0, final  List<RecentChat> recentChatsFallback = const <RecentChat>[]}): _recentChatsFallback = recentChatsFallback;
  

 final  String message;
@JsonKey() final  int creditsFallback;
 final  List<RecentChat> _recentChatsFallback;
@JsonKey() List<RecentChat> get recentChatsFallback {
  if (_recentChatsFallback is EqualUnmodifiableListView) return _recentChatsFallback;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentChatsFallback);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeErrorCopyWith<HomeError> get copyWith => _$HomeErrorCopyWithImpl<HomeError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeError&&(identical(other.message, message) || other.message == message)&&(identical(other.creditsFallback, creditsFallback) || other.creditsFallback == creditsFallback)&&const DeepCollectionEquality().equals(other._recentChatsFallback, _recentChatsFallback));
}


@override
int get hashCode => Object.hash(runtimeType,message,creditsFallback,const DeepCollectionEquality().hash(_recentChatsFallback));

@override
String toString() {
  return 'HomeState.error(message: $message, creditsFallback: $creditsFallback, recentChatsFallback: $recentChatsFallback)';
}


}

/// @nodoc
abstract mixin class $HomeErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeErrorCopyWith(HomeError value, $Res Function(HomeError) _then) = _$HomeErrorCopyWithImpl;
@useResult
$Res call({
 String message, int creditsFallback, List<RecentChat> recentChatsFallback
});




}
/// @nodoc
class _$HomeErrorCopyWithImpl<$Res>
    implements $HomeErrorCopyWith<$Res> {
  _$HomeErrorCopyWithImpl(this._self, this._then);

  final HomeError _self;
  final $Res Function(HomeError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? creditsFallback = null,Object? recentChatsFallback = null,}) {
  return _then(HomeError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,creditsFallback: null == creditsFallback ? _self.creditsFallback : creditsFallback // ignore: cast_nullable_to_non_nullable
as int,recentChatsFallback: null == recentChatsFallback ? _self._recentChatsFallback : recentChatsFallback // ignore: cast_nullable_to_non_nullable
as List<RecentChat>,
  ));
}


}

// dart format on
