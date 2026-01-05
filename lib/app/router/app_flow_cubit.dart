import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppFlowState extends Equatable {
  final bool isBootstrapped;   // initial load bitti mi?
  final bool onboardingSeen;
  final bool isAuthed;

  const AppFlowState({
    required this.isBootstrapped,
    required this.onboardingSeen,
    required this.isAuthed,
  });

  AppFlowState copyWith({
    bool? isBootstrapped,
    bool? onboardingSeen,
    bool? isAuthed,
  }) {
    return AppFlowState(
      isBootstrapped: isBootstrapped ?? this.isBootstrapped,
      onboardingSeen: onboardingSeen ?? this.onboardingSeen,
      isAuthed: isAuthed ?? this.isAuthed,
    );
  }

  @override
  List<Object?> get props => [isBootstrapped, onboardingSeen, isAuthed];

  static const initial = AppFlowState(
    isBootstrapped: false,
    onboardingSeen: false,
    isAuthed: false,
  );
}

class AppFlowCubit extends Cubit<AppFlowState> {
  AppFlowCubit() : super(AppFlowState.initial);

  /// App açılışında storage'dan onboarding/auth durumunu oku.
  Future<void> bootstrap() async {
    // TODO: shared_preferences + secure_storage’dan oku
    // final onboardingSeen = ...
    // final isAuthed = ...
    emit(state.copyWith(
      isBootstrapped: true,
      onboardingSeen: false,
      isAuthed: false,
    ));
  }

  void markOnboardingSeen() => emit(state.copyWith(onboardingSeen: true));
  void setAuthed(bool value) => emit(state.copyWith(isAuthed: value));
}