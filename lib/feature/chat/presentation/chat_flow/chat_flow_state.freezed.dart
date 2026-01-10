// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_flow_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatFlowState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatFlowState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatFlowState()';
}


}

/// @nodoc
class $ChatFlowStateCopyWith<$Res>  {
$ChatFlowStateCopyWith(ChatFlowState _, $Res Function(ChatFlowState) __);
}


/// Adds pattern-matching-related methods to [ChatFlowState].
extension ChatFlowStatePatterns on ChatFlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatFlowLoading value)?  loading,TResult Function( ChatFlowCamera value)?  camera,TResult Function( ChatFlowPhotoReview value)?  photoReview,TResult Function( ChatFlowChat value)?  chat,TResult Function( ChatFlowResult value)?  result,TResult Function( ChatFlowExitToHome value)?  exitToHome,TResult Function( ChatFlowError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatFlowLoading() when loading != null:
return loading(_that);case ChatFlowCamera() when camera != null:
return camera(_that);case ChatFlowPhotoReview() when photoReview != null:
return photoReview(_that);case ChatFlowChat() when chat != null:
return chat(_that);case ChatFlowResult() when result != null:
return result(_that);case ChatFlowExitToHome() when exitToHome != null:
return exitToHome(_that);case ChatFlowError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatFlowLoading value)  loading,required TResult Function( ChatFlowCamera value)  camera,required TResult Function( ChatFlowPhotoReview value)  photoReview,required TResult Function( ChatFlowChat value)  chat,required TResult Function( ChatFlowResult value)  result,required TResult Function( ChatFlowExitToHome value)  exitToHome,required TResult Function( ChatFlowError value)  error,}){
final _that = this;
switch (_that) {
case ChatFlowLoading():
return loading(_that);case ChatFlowCamera():
return camera(_that);case ChatFlowPhotoReview():
return photoReview(_that);case ChatFlowChat():
return chat(_that);case ChatFlowResult():
return result(_that);case ChatFlowExitToHome():
return exitToHome(_that);case ChatFlowError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatFlowLoading value)?  loading,TResult? Function( ChatFlowCamera value)?  camera,TResult? Function( ChatFlowPhotoReview value)?  photoReview,TResult? Function( ChatFlowChat value)?  chat,TResult? Function( ChatFlowResult value)?  result,TResult? Function( ChatFlowExitToHome value)?  exitToHome,TResult? Function( ChatFlowError value)?  error,}){
final _that = this;
switch (_that) {
case ChatFlowLoading() when loading != null:
return loading(_that);case ChatFlowCamera() when camera != null:
return camera(_that);case ChatFlowPhotoReview() when photoReview != null:
return photoReview(_that);case ChatFlowChat() when chat != null:
return chat(_that);case ChatFlowResult() when result != null:
return result(_that);case ChatFlowExitToHome() when exitToHome != null:
return exitToHome(_that);case ChatFlowError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  camera,TResult Function( String photoPath)?  photoReview,TResult Function( ChatStrategy strategy,  String? sessionId)?  chat,TResult Function( ChatStrategy strategy,  String? sessionId)?  result,TResult Function()?  exitToHome,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatFlowLoading() when loading != null:
return loading();case ChatFlowCamera() when camera != null:
return camera();case ChatFlowPhotoReview() when photoReview != null:
return photoReview(_that.photoPath);case ChatFlowChat() when chat != null:
return chat(_that.strategy,_that.sessionId);case ChatFlowResult() when result != null:
return result(_that.strategy,_that.sessionId);case ChatFlowExitToHome() when exitToHome != null:
return exitToHome();case ChatFlowError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  camera,required TResult Function( String photoPath)  photoReview,required TResult Function( ChatStrategy strategy,  String? sessionId)  chat,required TResult Function( ChatStrategy strategy,  String? sessionId)  result,required TResult Function()  exitToHome,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ChatFlowLoading():
return loading();case ChatFlowCamera():
return camera();case ChatFlowPhotoReview():
return photoReview(_that.photoPath);case ChatFlowChat():
return chat(_that.strategy,_that.sessionId);case ChatFlowResult():
return result(_that.strategy,_that.sessionId);case ChatFlowExitToHome():
return exitToHome();case ChatFlowError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  camera,TResult? Function( String photoPath)?  photoReview,TResult? Function( ChatStrategy strategy,  String? sessionId)?  chat,TResult? Function( ChatStrategy strategy,  String? sessionId)?  result,TResult? Function()?  exitToHome,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ChatFlowLoading() when loading != null:
return loading();case ChatFlowCamera() when camera != null:
return camera();case ChatFlowPhotoReview() when photoReview != null:
return photoReview(_that.photoPath);case ChatFlowChat() when chat != null:
return chat(_that.strategy,_that.sessionId);case ChatFlowResult() when result != null:
return result(_that.strategy,_that.sessionId);case ChatFlowExitToHome() when exitToHome != null:
return exitToHome();case ChatFlowError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ChatFlowLoading implements ChatFlowState {
  const ChatFlowLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatFlowLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatFlowState.loading()';
}


}




/// @nodoc


class ChatFlowCamera implements ChatFlowState {
  const ChatFlowCamera();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatFlowCamera);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatFlowState.camera()';
}


}




/// @nodoc


class ChatFlowPhotoReview implements ChatFlowState {
  const ChatFlowPhotoReview({required this.photoPath});
  

 final  String photoPath;

/// Create a copy of ChatFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatFlowPhotoReviewCopyWith<ChatFlowPhotoReview> get copyWith => _$ChatFlowPhotoReviewCopyWithImpl<ChatFlowPhotoReview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatFlowPhotoReview&&(identical(other.photoPath, photoPath) || other.photoPath == photoPath));
}


@override
int get hashCode => Object.hash(runtimeType,photoPath);

@override
String toString() {
  return 'ChatFlowState.photoReview(photoPath: $photoPath)';
}


}

/// @nodoc
abstract mixin class $ChatFlowPhotoReviewCopyWith<$Res> implements $ChatFlowStateCopyWith<$Res> {
  factory $ChatFlowPhotoReviewCopyWith(ChatFlowPhotoReview value, $Res Function(ChatFlowPhotoReview) _then) = _$ChatFlowPhotoReviewCopyWithImpl;
@useResult
$Res call({
 String photoPath
});




}
/// @nodoc
class _$ChatFlowPhotoReviewCopyWithImpl<$Res>
    implements $ChatFlowPhotoReviewCopyWith<$Res> {
  _$ChatFlowPhotoReviewCopyWithImpl(this._self, this._then);

  final ChatFlowPhotoReview _self;
  final $Res Function(ChatFlowPhotoReview) _then;

/// Create a copy of ChatFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? photoPath = null,}) {
  return _then(ChatFlowPhotoReview(
photoPath: null == photoPath ? _self.photoPath : photoPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChatFlowChat implements ChatFlowState {
  const ChatFlowChat({required this.strategy, this.sessionId});
  

 final  ChatStrategy strategy;
 final  String? sessionId;

/// Create a copy of ChatFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatFlowChatCopyWith<ChatFlowChat> get copyWith => _$ChatFlowChatCopyWithImpl<ChatFlowChat>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatFlowChat&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}


@override
int get hashCode => Object.hash(runtimeType,strategy,sessionId);

@override
String toString() {
  return 'ChatFlowState.chat(strategy: $strategy, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class $ChatFlowChatCopyWith<$Res> implements $ChatFlowStateCopyWith<$Res> {
  factory $ChatFlowChatCopyWith(ChatFlowChat value, $Res Function(ChatFlowChat) _then) = _$ChatFlowChatCopyWithImpl;
@useResult
$Res call({
 ChatStrategy strategy, String? sessionId
});




}
/// @nodoc
class _$ChatFlowChatCopyWithImpl<$Res>
    implements $ChatFlowChatCopyWith<$Res> {
  _$ChatFlowChatCopyWithImpl(this._self, this._then);

  final ChatFlowChat _self;
  final $Res Function(ChatFlowChat) _then;

/// Create a copy of ChatFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? strategy = null,Object? sessionId = freezed,}) {
  return _then(ChatFlowChat(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as ChatStrategy,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ChatFlowResult implements ChatFlowState {
  const ChatFlowResult({required this.strategy, this.sessionId});
  

 final  ChatStrategy strategy;
 final  String? sessionId;

/// Create a copy of ChatFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatFlowResultCopyWith<ChatFlowResult> get copyWith => _$ChatFlowResultCopyWithImpl<ChatFlowResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatFlowResult&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}


@override
int get hashCode => Object.hash(runtimeType,strategy,sessionId);

@override
String toString() {
  return 'ChatFlowState.result(strategy: $strategy, sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class $ChatFlowResultCopyWith<$Res> implements $ChatFlowStateCopyWith<$Res> {
  factory $ChatFlowResultCopyWith(ChatFlowResult value, $Res Function(ChatFlowResult) _then) = _$ChatFlowResultCopyWithImpl;
@useResult
$Res call({
 ChatStrategy strategy, String? sessionId
});




}
/// @nodoc
class _$ChatFlowResultCopyWithImpl<$Res>
    implements $ChatFlowResultCopyWith<$Res> {
  _$ChatFlowResultCopyWithImpl(this._self, this._then);

  final ChatFlowResult _self;
  final $Res Function(ChatFlowResult) _then;

/// Create a copy of ChatFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? strategy = null,Object? sessionId = freezed,}) {
  return _then(ChatFlowResult(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as ChatStrategy,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ChatFlowExitToHome implements ChatFlowState {
  const ChatFlowExitToHome();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatFlowExitToHome);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatFlowState.exitToHome()';
}


}




/// @nodoc


class ChatFlowError implements ChatFlowState {
  const ChatFlowError({required this.message});
  

 final  String message;

/// Create a copy of ChatFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatFlowErrorCopyWith<ChatFlowError> get copyWith => _$ChatFlowErrorCopyWithImpl<ChatFlowError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatFlowError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChatFlowState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ChatFlowErrorCopyWith<$Res> implements $ChatFlowStateCopyWith<$Res> {
  factory $ChatFlowErrorCopyWith(ChatFlowError value, $Res Function(ChatFlowError) _then) = _$ChatFlowErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ChatFlowErrorCopyWithImpl<$Res>
    implements $ChatFlowErrorCopyWith<$Res> {
  _$ChatFlowErrorCopyWithImpl(this._self, this._then);

  final ChatFlowError _self;
  final $Res Function(ChatFlowError) _then;

/// Create a copy of ChatFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ChatFlowError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
