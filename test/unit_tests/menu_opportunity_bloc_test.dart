import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:one/Application/bloc/menu_opportunity_bloc.dart';
import 'package:one/Domain/Repositories/menuOpportunity_Repository.dart';
import 'package:one/Domain/models/menu_opportunity_model.dart';
import 'package:one/presentation/Events/menu_opportunity_event.dart';
import 'package:one/presentation/State/menu_opportunity_state.dart';

class MockMenuOpportunityRepository extends Mock
    implements MenuOpportunityRepository {}

void main() {
  late MenuOpportunityBloc menuOpportunityBloc;
  late MockMenuOpportunityRepository mockMenuOpportunityRepository;

  setUp(() {
    mockMenuOpportunityRepository = MockMenuOpportunityRepository();
    menuOpportunityBloc = MenuOpportunityBloc(
      menuOpportunityRepository: mockMenuOpportunityRepository,
    );
  });

  tearDown(() {
    menuOpportunityBloc.close();
  });

  group('MenuOpportunityBloc', () {
    final mockMenuOpportunity = MenuOpportunity(id: '1', name: 'Test Opportunity');

    blocTest<MenuOpportunityBloc, MenuOpportunityState>(
      'emits [MenuOpportunityLoading, MenuOpportunitySuccess] when FetchOpportunity is added',
      build: () => menuOpportunityBloc,
      act: (bloc) => bloc.add(FetchOpportunity()),
      expect: () => [
        MenuOpportunityLoading(),
        MenuOpportunitySuccess([mockMenuOpportunity]),
      ],
      verify: (_) {
        verify(mockMenuOpportunityRepository.fetchOpportunity()).called(1);
      },
    );

    blocTest<MenuOpportunityBloc, MenuOpportunityState>(
      'emits [MenuOpportunityLoading, MenuOpportunitySuccess] when RegisterOpportunity is added',
      build: () => menuOpportunityBloc,
      act: (bloc) => bloc.add(RegisterOpportunity(mockMenuOpportunity)),
      expect: () => [
        MenuOpportunityLoading(),
        MenuOpportunitySuccess([mockMenuOpportunity]),
      ],
      verify: (_) {
        verify(mockMenuOpportunityRepository.registerOpportunity(mockMenuOpportunity)).called(1);
        verify(mockMenuOpportunityRepository.fetchOpportunity()).called(1);
      },
    );

    blocTest<MenuOpportunityBloc, MenuOpportunityState>(
      'emits [MenuOpportunityLoading, MenuOpportunityFailure] when RegisterOpportunity fails',
      build: () => menuOpportunityBloc,
      act: (bloc) {
        when(mockMenuOpportunityRepository.registerOpportunity(any))
            .thenThrow(Exception('Failed to register opportunity'));
        bloc.add(RegisterOpportunity(mockMenuOpportunity));
      },
      expect: () => [
        MenuOpportunityLoading(),
        MenuOpportunityFailure('Exception: Failed to register opportunity'),
      ],
      verify: (_) {
        verify(mockMenuOpportunityRepository.registerOpportunity(mockMenuOpportunity)).called(1);
        verifyNever(mockMenuOpportunityRepository.fetchOpportunity());
      },
    );
  });
}
