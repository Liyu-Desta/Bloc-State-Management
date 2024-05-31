import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:one/Application/bloc/loginbloc.dart';
import 'package:one/Domain/models/user_model.dart';
import 'package:one/presentation/screens/adminDashboard.dart';
import 'package:one/presentation/screens/loginPage.dart';

import 'package:one/presentation/screens/signup.dart';
import 'package:one/presentation/screens/userDashboard.dart';

// Mocking AuthBloc for testing purposes
class MockAuthBloc extends MockBloc<AuthAction, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  tearDown(() {
    mockAuthBloc.close();
  });

  group('LoginScreen widget', () {
    testWidgets('renders login UI when AuthEmpty state', (WidgetTester tester) async {
      when(mockAuthBloc.state).thenReturn(AuthEmpty());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockAuthBloc,
            child: LoginScreen(),
          ),
        ),
      );

      expect(find.text('Welcome back'), findsOneWidget);
      expect(find.text('Fill your credentials to log in'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text("Don't have an account? "), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets('redirects to AdminDashboard when user role is admin', (WidgetTester tester) async {
      final adminUser = UserModel(email: 'admin@test.com', role: 'admin', userId: '1');
      when(mockAuthBloc.state).thenReturn(LoginState(user: adminUser));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockAuthBloc,
            child: LoginScreen(),
          ),
        ),
      );

      expect(find.byType(Dashboard), findsOneWidget);
    });

    testWidgets('redirects to UserDashboard when user role is not admin', (WidgetTester tester) async {
      final regularUser = UserModel(email: 'user@test.com', role: 'user', userId: '2');
      when(mockAuthBloc.state).thenReturn(LoginState(user: regularUser));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockAuthBloc,
            child: LoginScreen(),
          ),
        ),
      );

      expect(find.byType(UserDashboard), findsOneWidget);
    });

    testWidgets('performs login action on button press', (WidgetTester tester) async {
      when(mockAuthBloc.state).thenReturn(AuthEmpty());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockAuthBloc,
            child: LoginScreen(),
          ),
        ),
      );

      final emailField = find.byType(TextFormField).first;
      final passwordField = find.byType(TextFormField).last;
      final loginButton = find.byType(ElevatedButton);

      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginButton, findsOneWidget);

      await tester.enterText(emailField, 'test@test.com');
      await tester.enterText(passwordField, 'password');

      await tester.tap(loginButton);
      await tester.pump();

      verify(mockAuthBloc.add(LogUserAction('test@test.com', 'password'))).called(1);
    });

    testWidgets('navigates to SignUpScreen on Sign Up link tap', (WidgetTester tester) async {
      when(mockAuthBloc.state).thenReturn(AuthEmpty());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: mockAuthBloc,
            child: LoginScreen(),
          ),
        ),
      );

      final signUpLink = find.text('Sign Up');
      expect(signUpLink, findsOneWidget);

      await tester.tap(signUpLink);
      await tester.pumpAndSettle();

      expect(find.byType(SignupScreen), findsOneWidget);
    });
  });
}
