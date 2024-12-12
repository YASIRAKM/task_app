import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = StateProvider.autoDispose<bool>(
  (ref) {
    return false;
  },
);
final indexProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);
