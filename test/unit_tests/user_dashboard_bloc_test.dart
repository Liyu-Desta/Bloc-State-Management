import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:one/Application/bloc/userDashboard_bloc.dart';

import 'package:one/Domain/Repositories/userDashbord.dart';

import 'package:one/Domain/models/userDashboard_model.dart';
import 'package:one/presentation/Events/userDashboard_event.dart';

import 'package:one/presentation/State/userDashboard_state.dart';


class MockUserDashboardRepository extends Mock
    implements UserDashboardRepository {}

void main() {
  late UserDashboardBloc userDashboardBloc;
  late MockUserDashboardRepository mockUserDashboardRepository;

  setUp(() {
    mockUserDashboardRepository = MockUserDashboardRepository();
    userDashboardBloc = UserDashboardBloc(
      userDashboardRepository: mockUserDashboardRepository,
    );
  });

  tearDown(() {
    userDashboardBloc.close();
  });

  group('UserDashboardBloc', () {
    final mockUserOpportunity = UserOpportunity(id: '1', name: 'Test Opportunity');

    blocTest<UserDashboardBloc, UserDashboardState>(
      'emits [UserDashboardLoading, UserDashboardSuccess] when FetchUserOpportunities is added',
      build: () => userDashboardBloc,
      act: (bloc) => bloc.add(FetchUserOpportunities()),
      expect: () => [
        UserDashboardLoading(),
        UserDashboardSuccess([mockUserOpportunity]),
      ],
      verify: (_) {
        verify(mockUserDashboardRepository.fetchUserOpportunities()).called(1);
      },
    );

    blocTest<UserDashboardBloc, UserDashboardState>(
      'emits [UserDashboardLoading, UserDashboardSuccess] when UpdateUserOpportunity is added',
      build: () => userDashboardBloc,
      act: (bloc) => bloc.add(UpdateUserOpportunity(mockUserOpportunity)),
      expect: () => [
        UserDashboardLoading(),
        UserDashboardSuccess([mockUserOpportunity]),
      ],
      verify: (_) {
        verify(mockUserDashboardRepository.updateUserOpportunity(mockUserOpportunity)).called(1);
        verify(mockUserDashboardRepository.fetchUserOpportunities()).called(1);
      },
    );

    blocTest<UserDashboardBloc, UserDashboardState>(
      'emits [UserDashboardLoading, UserDashboardSuccess] when DeleteUserOpportunity is added',
      build: () => userDashboardBloc,
      act: (bloc) => bloc.add(DeleteUserOpportunity('1')),
      expect: () => [
        UserDashboardLoading(),
        UserDashboardSuccess([mockUserOpportunity]), // Assuming success state returns the updated list
      ],
      verify: (_) {
        verify(mockUserDashboardRepository.deleteUserOpportunity('1')).called(1);
        verify(mockUserDashboardRepository.fetchUserOpportunities()).called(1);
      },
    );

    blocTest<UserDashboardBloc, UserDashboardState>(
      'emits [UserDashboardLoading, UserDashboardFailure] when DeleteUserOpportunity fails',
      build: () => userDashboardBloc,
      act: (bloc) {
        when(mockUserDashboardRepository.deleteUserOpportunity(any))
            .thenThrow(Exception('Failed to delete user opportunity'));
        bloc.add(DeleteUserOpportunity('1'));
      },
      expect: () => [
        UserDashboardLoading(),
        UserDashboardFailure('Exception: Failed to delete user opportunity'),
      ],
      verify: (_) {
        verify(mockUserDashboardRepository.deleteUserOpportunity('1')).called(1);
        verifyNever(mockUserDashboardRepository.fetchUserOpportunities());
      },
    );
  });
}
