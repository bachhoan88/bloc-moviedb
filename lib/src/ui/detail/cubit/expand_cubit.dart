import 'package:flutter_bloc/flutter_bloc.dart';

class ExpandCubit extends Cubit<bool> {
  ExpandCubit() : super(false);

  void toggle() => emit(!state);
}