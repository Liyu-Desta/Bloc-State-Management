import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:one/Application/bloc/loginbloc.dart';
import 'package:one/Domain/entities/user.dart';
import 'package:one/Infrastructure/data_providers/signInDataProvider.dart';

import 'package:one/Domain/models/user_model.dart';

// Mocking SignInDataProvider for testing purposes
class MockSignInDataProvider extends Mock implements SignInDataProvider {}

void main() {
  late AuthBloc authBloc;
  late MockSignInDataProvider mockSignInDataProvider;

  setUp(() {
    mockSignInDataProvider = MockSignInDataProvider();
    authBloc = AuthBloc(signInDataProvider: mockSignInDataProvider);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    final user = UserModel(email: 'test@test.com', role: 'user', userId: '1');
    final error = 'Error occurred while sign in';

    blocTest<AuthBloc, AuthState>(
      'emits [LoginState] when LogUserAction is added successfully',
      build: () {
        when(mockSignInDataProvider.login(any, any)).thenAnswer((_) async => user);
        return authBloc;
      },
      act: (bloc) => bloc.add(LogUserAction('test@test.com', 'password')),
      expect: () => [
        isA<LoginState>(),
      ],
      verify: (_) {
        verify(mockSignInDataProvider.login('test@test.com', 'password')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthErrorState] when LogUserAction fails',
      build: () {
        when(mockSignInDataProvider.login(any, any)).thenThrow(Exception(error));
        return authBloc;
      },
      act: (bloc) => bloc.add(LogUserAction('test@test.com', 'password')),
      expect: () => [
        AuthErrorState(message: error),
      ],
      verify: (_) {
        verify(mockSignInDataProvider.login('test@test.com', 'password')).called(1);
      },
    );

    final signUpUser = User(name: 'Test User', email: 'test@test.com', phoneNumber: '1234567890');
    final signUpError = 'Error occurred while sign up';

    blocTest<AuthBloc, AuthState>(
      'emits [SingUpState] when SingUpUserAction is added successfully',
      build: () {
        when(mockSignInDataProvider.singUp(any, any)).thenAnswer((_) async => user);
        return authBloc;
      },
      act: (bloc) => bloc.add(SingUpUserAction('test@test.com', '1234567890', 'password', 'Test User')),
      expect: () => [
        isA<SingUpState>(),
      ],
      verify: (_) {
        verify(mockSignInDataProvider.singUp(signUpUser, 'password')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthErrorState] when SingUpUserAction fails',
      build: () {
        when(mockSignInDataProvider.singUp(any, any)).thenThrow(Exception(signUpError));
        return authBloc;
      },
      act: (bloc) => bloc.add(SingUpUserAction('test@test.com', '1234567890', 'password', 'Test User')),
      expect: () => [
        AuthErrorState(message: signUpError),
      ],
      verify: (_) {
        verify(mockSignInDataProvider.singUp(signUpUser, 'password')).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthEmpty] when EmptyAction is added',
      build: () => authBloc,
      act: (bloc) => bloc.add(EmptyAction()),
      expect: () => [
        AuthEmpty(),
      ],
    );
  });
}
