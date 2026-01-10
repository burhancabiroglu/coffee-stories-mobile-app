// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credit_purchase_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreditPurchaseState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditPurchaseState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreditPurchaseState()';
}


}

/// @nodoc
class $CreditPurchaseStateCopyWith<$Res>  {
$CreditPurchaseStateCopyWith(CreditPurchaseState _, $Res Function(CreditPurchaseState) __);
}


/// Adds pattern-matching-related methods to [CreditPurchaseState].
extension CreditPurchaseStatePatterns on CreditPurchaseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CreditPurchaseLoading value)?  loading,TResult Function( CreditPurchaseReady value)?  ready,TResult Function( CreditPurchaseError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CreditPurchaseLoading() when loading != null:
return loading(_that);case CreditPurchaseReady() when ready != null:
return ready(_that);case CreditPurchaseError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CreditPurchaseLoading value)  loading,required TResult Function( CreditPurchaseReady value)  ready,required TResult Function( CreditPurchaseError value)  error,}){
final _that = this;
switch (_that) {
case CreditPurchaseLoading():
return loading(_that);case CreditPurchaseReady():
return ready(_that);case CreditPurchaseError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CreditPurchaseLoading value)?  loading,TResult? Function( CreditPurchaseReady value)?  ready,TResult? Function( CreditPurchaseError value)?  error,}){
final _that = this;
switch (_that) {
case CreditPurchaseLoading() when loading != null:
return loading(_that);case CreditPurchaseReady() when ready != null:
return ready(_that);case CreditPurchaseError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( int currentCredits,  List<CreditPackage> packages,  int selectedPackageId,  bool isPurchasing,  bool isWatchingAd,  String? message)?  ready,TResult Function( String message,  int creditsFallback,  List<CreditPackage> packagesFallback,  int selectedPackageIdFallback)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CreditPurchaseLoading() when loading != null:
return loading();case CreditPurchaseReady() when ready != null:
return ready(_that.currentCredits,_that.packages,_that.selectedPackageId,_that.isPurchasing,_that.isWatchingAd,_that.message);case CreditPurchaseError() when error != null:
return error(_that.message,_that.creditsFallback,_that.packagesFallback,_that.selectedPackageIdFallback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( int currentCredits,  List<CreditPackage> packages,  int selectedPackageId,  bool isPurchasing,  bool isWatchingAd,  String? message)  ready,required TResult Function( String message,  int creditsFallback,  List<CreditPackage> packagesFallback,  int selectedPackageIdFallback)  error,}) {final _that = this;
switch (_that) {
case CreditPurchaseLoading():
return loading();case CreditPurchaseReady():
return ready(_that.currentCredits,_that.packages,_that.selectedPackageId,_that.isPurchasing,_that.isWatchingAd,_that.message);case CreditPurchaseError():
return error(_that.message,_that.creditsFallback,_that.packagesFallback,_that.selectedPackageIdFallback);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( int currentCredits,  List<CreditPackage> packages,  int selectedPackageId,  bool isPurchasing,  bool isWatchingAd,  String? message)?  ready,TResult? Function( String message,  int creditsFallback,  List<CreditPackage> packagesFallback,  int selectedPackageIdFallback)?  error,}) {final _that = this;
switch (_that) {
case CreditPurchaseLoading() when loading != null:
return loading();case CreditPurchaseReady() when ready != null:
return ready(_that.currentCredits,_that.packages,_that.selectedPackageId,_that.isPurchasing,_that.isWatchingAd,_that.message);case CreditPurchaseError() when error != null:
return error(_that.message,_that.creditsFallback,_that.packagesFallback,_that.selectedPackageIdFallback);case _:
  return null;

}
}

}

/// @nodoc


class CreditPurchaseLoading implements CreditPurchaseState {
  const CreditPurchaseLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditPurchaseLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CreditPurchaseState.loading()';
}


}




/// @nodoc


class CreditPurchaseReady implements CreditPurchaseState {
  const CreditPurchaseReady({required this.currentCredits, required final  List<CreditPackage> packages, required this.selectedPackageId, this.isPurchasing = false, this.isWatchingAd = false, this.message}): _packages = packages;
  

 final  int currentCredits;
 final  List<CreditPackage> _packages;
 List<CreditPackage> get packages {
  if (_packages is EqualUnmodifiableListView) return _packages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_packages);
}

 final  int selectedPackageId;
// UI flags
@JsonKey() final  bool isPurchasing;
@JsonKey() final  bool isWatchingAd;
// Optional inline message (snackbar vs.)
 final  String? message;

/// Create a copy of CreditPurchaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditPurchaseReadyCopyWith<CreditPurchaseReady> get copyWith => _$CreditPurchaseReadyCopyWithImpl<CreditPurchaseReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditPurchaseReady&&(identical(other.currentCredits, currentCredits) || other.currentCredits == currentCredits)&&const DeepCollectionEquality().equals(other._packages, _packages)&&(identical(other.selectedPackageId, selectedPackageId) || other.selectedPackageId == selectedPackageId)&&(identical(other.isPurchasing, isPurchasing) || other.isPurchasing == isPurchasing)&&(identical(other.isWatchingAd, isWatchingAd) || other.isWatchingAd == isWatchingAd)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,currentCredits,const DeepCollectionEquality().hash(_packages),selectedPackageId,isPurchasing,isWatchingAd,message);

@override
String toString() {
  return 'CreditPurchaseState.ready(currentCredits: $currentCredits, packages: $packages, selectedPackageId: $selectedPackageId, isPurchasing: $isPurchasing, isWatchingAd: $isWatchingAd, message: $message)';
}


}

/// @nodoc
abstract mixin class $CreditPurchaseReadyCopyWith<$Res> implements $CreditPurchaseStateCopyWith<$Res> {
  factory $CreditPurchaseReadyCopyWith(CreditPurchaseReady value, $Res Function(CreditPurchaseReady) _then) = _$CreditPurchaseReadyCopyWithImpl;
@useResult
$Res call({
 int currentCredits, List<CreditPackage> packages, int selectedPackageId, bool isPurchasing, bool isWatchingAd, String? message
});




}
/// @nodoc
class _$CreditPurchaseReadyCopyWithImpl<$Res>
    implements $CreditPurchaseReadyCopyWith<$Res> {
  _$CreditPurchaseReadyCopyWithImpl(this._self, this._then);

  final CreditPurchaseReady _self;
  final $Res Function(CreditPurchaseReady) _then;

/// Create a copy of CreditPurchaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currentCredits = null,Object? packages = null,Object? selectedPackageId = null,Object? isPurchasing = null,Object? isWatchingAd = null,Object? message = freezed,}) {
  return _then(CreditPurchaseReady(
currentCredits: null == currentCredits ? _self.currentCredits : currentCredits // ignore: cast_nullable_to_non_nullable
as int,packages: null == packages ? _self._packages : packages // ignore: cast_nullable_to_non_nullable
as List<CreditPackage>,selectedPackageId: null == selectedPackageId ? _self.selectedPackageId : selectedPackageId // ignore: cast_nullable_to_non_nullable
as int,isPurchasing: null == isPurchasing ? _self.isPurchasing : isPurchasing // ignore: cast_nullable_to_non_nullable
as bool,isWatchingAd: null == isWatchingAd ? _self.isWatchingAd : isWatchingAd // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class CreditPurchaseError implements CreditPurchaseState {
  const CreditPurchaseError({required this.message, this.creditsFallback = 0, final  List<CreditPackage> packagesFallback = const <CreditPackage>[], this.selectedPackageIdFallback = 2}): _packagesFallback = packagesFallback;
  

 final  String message;
@JsonKey() final  int creditsFallback;
 final  List<CreditPackage> _packagesFallback;
@JsonKey() List<CreditPackage> get packagesFallback {
  if (_packagesFallback is EqualUnmodifiableListView) return _packagesFallback;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_packagesFallback);
}

@JsonKey() final  int selectedPackageIdFallback;

/// Create a copy of CreditPurchaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreditPurchaseErrorCopyWith<CreditPurchaseError> get copyWith => _$CreditPurchaseErrorCopyWithImpl<CreditPurchaseError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreditPurchaseError&&(identical(other.message, message) || other.message == message)&&(identical(other.creditsFallback, creditsFallback) || other.creditsFallback == creditsFallback)&&const DeepCollectionEquality().equals(other._packagesFallback, _packagesFallback)&&(identical(other.selectedPackageIdFallback, selectedPackageIdFallback) || other.selectedPackageIdFallback == selectedPackageIdFallback));
}


@override
int get hashCode => Object.hash(runtimeType,message,creditsFallback,const DeepCollectionEquality().hash(_packagesFallback),selectedPackageIdFallback);

@override
String toString() {
  return 'CreditPurchaseState.error(message: $message, creditsFallback: $creditsFallback, packagesFallback: $packagesFallback, selectedPackageIdFallback: $selectedPackageIdFallback)';
}


}

/// @nodoc
abstract mixin class $CreditPurchaseErrorCopyWith<$Res> implements $CreditPurchaseStateCopyWith<$Res> {
  factory $CreditPurchaseErrorCopyWith(CreditPurchaseError value, $Res Function(CreditPurchaseError) _then) = _$CreditPurchaseErrorCopyWithImpl;
@useResult
$Res call({
 String message, int creditsFallback, List<CreditPackage> packagesFallback, int selectedPackageIdFallback
});




}
/// @nodoc
class _$CreditPurchaseErrorCopyWithImpl<$Res>
    implements $CreditPurchaseErrorCopyWith<$Res> {
  _$CreditPurchaseErrorCopyWithImpl(this._self, this._then);

  final CreditPurchaseError _self;
  final $Res Function(CreditPurchaseError) _then;

/// Create a copy of CreditPurchaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? creditsFallback = null,Object? packagesFallback = null,Object? selectedPackageIdFallback = null,}) {
  return _then(CreditPurchaseError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,creditsFallback: null == creditsFallback ? _self.creditsFallback : creditsFallback // ignore: cast_nullable_to_non_nullable
as int,packagesFallback: null == packagesFallback ? _self._packagesFallback : packagesFallback // ignore: cast_nullable_to_non_nullable
as List<CreditPackage>,selectedPackageIdFallback: null == selectedPackageIdFallback ? _self.selectedPackageIdFallback : selectedPackageIdFallback // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
