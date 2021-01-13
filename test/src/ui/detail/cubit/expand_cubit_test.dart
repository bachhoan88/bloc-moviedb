import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc_base/src/ui/detail/cubit/expand_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test ExpandCubit', () {
    ExpandCubit expandCubit;

    setUp(() {
      expandCubit = ExpandCubit();
    });

    test('Test default is expanded text', () {
      expect(expandCubit.state, false);
    });

    tearDown(() {
      expandCubit.close();
    });

    group('toggle text', () {
      blocTest(
        'ExpandCubit toggle',
        build: () => ExpandCubit(),
        act: (ExpandCubit cubit) => cubit.toggle(),
        expect: <bool>[true],
      );
    });
  });
}
