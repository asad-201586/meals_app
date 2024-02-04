import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/api_service/api_service.dart';

final apiProvider = StateProvider<ApiService>((ref) => ApiService());