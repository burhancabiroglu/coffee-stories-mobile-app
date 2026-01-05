import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/router/app_flow_cubit.dart';
import 'splash_state.dart';

/// SplashCubit sorumluluğu:
/// - Minimum splash süresi (örn: 2500ms) boyunca beklemek
/// - AppFlow bootstrap tamamlandığında (isBootstrapped=true) devam edebilmek
///
/// Navigation (route geçişi) burada yapılmaz; sadece state üretir.
class SplashCubit extends Cubit<SplashState> {
  final AppFlowCubit _flow;

  Timer? _minTimer;
  StreamSubscription? _flowSub;

  bool _minDelayDone = false;
  bool _bootstrapped = false;

  SplashCubit({required AppFlowCubit flow})
      : _flow = flow,
        super(const SplashState.loading()) {
    _start();
  }

  void _start() {
    // 1) Minimum splash süresi
    _minTimer = Timer(const Duration(milliseconds: 2500), () {
      _minDelayDone = true;
      _tryReady();
    });

    // 2) Bootstrap durumunu dinle
    _bootstrapped = _flow.state.isBootstrapped;

    _flowSub = _flow.stream.listen((s) {
      if (s.isBootstrapped == _bootstrapped) return;
      _bootstrapped = s.isBootstrapped;
      _tryReady();
    });
  }

  /// TODO: Token validity & session refresh check
  ///
  /// Şu an bilinçli olarak ALWAYS TRUE döner.
  /// İleride:
  /// - token süresi dolmuş mu?
  /// - refresh gerekir mi?
  /// - session snapshot güncellenecek mi?
  /// gibi kontroller burada yapılacak.
  bool _checkTokenStillValid() {
    return true;
  }

  void _tryReady() {
    // loading dışındaki herhangi bir niyet state'ine geçtiysek tekrar emit etme
    final alreadyDecided = state.maybeWhen(
      goHome: () => true,
      goOnboarding: () => true,
      goLogin: () => true,
      forceUpdate: () => true,
      orElse: () => false,
    );
    if (alreadyDecided) return;

    if (_minDelayDone && _bootstrapped) {
      final tokenValid = _checkTokenStillValid();

      if (tokenValid) {
        emit(const SplashState.goHome());
        return;
      }

      // Token geçersizse akış AppFlow durumuna göre ilerler
      if (!_flow.state.onboardingSeen) {
        emit(const SplashState.goOnboarding());
        return;
      }

      emit(const SplashState.goLogin());
    }
  }

  @override
  Future<void> close() async {
    _minTimer?.cancel();
    await _flowSub?.cancel();
    return super.close();
  }
}