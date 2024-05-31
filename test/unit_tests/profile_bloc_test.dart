import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:one/Application/bloc/profile_bloc.dart';
import 'package:one/Domain/models/profile.dart';
import 'package:one/Domain/Repositories/profile_repository.dart';
import 'package:one/presentation/Events/profile_event.dart';
import 'package:one/presentation/State/profile_state.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  group('ProfileBloc', () {
    late ProfileBloc profileBloc;
    late MockProfileRepository mockProfileRepository;

    setUp(() {
      mockProfileRepository = MockProfileRepository();
      profileBloc = ProfileBloc(profileRepository: mockProfileRepository);
    });

    tearDown(() {
      profileBloc.close();
    });

    test('initial state is ProfileInitial', () {
      expect(profileBloc.state, equals(ProfileInitial()));
    });

    group('FetchProfile event', () {
      final mockProfile = Profile(
        id: '1',
        email: 'test@example.com',
        password: 'password',
        phoneNumber: '1234567890',
      );

      test('emits [ProfileLoading, ProfileSuccess] when successful', () {
        when(mockProfileRepository.fetchProfile()).thenAnswer((_) async => [mockProfile]);

        final expectedResponse = [
          ProfileLoading(),
          ProfileSuccess([mockProfile]),
        ];
        expectLater(profileBloc.stream, emitsInOrder(expectedResponse)).then((_) {
          verify(mockProfileRepository.fetchProfile()).called(1);
        });

        profileBloc.add(FetchProfile());
      });

      test('emits [ProfileLoading, ProfileFailure] when unsuccessful', () {
        final error = 'Failed to fetch profile';
        when(mockProfileRepository.fetchProfile()).thenThrow(error);

        final expectedResponse = [
          ProfileLoading(),
          ProfileFailure(error),
        ];
        expectLater(profileBloc.stream, emitsInOrder(expectedResponse)).then((_) {
          verify(mockProfileRepository.fetchProfile()).called(1);
        });

        profileBloc.add(FetchProfile());
      });
    });

    group('UpdateProfile event', () {
      final mockUpdatedProfile = Profile(
        id: '1',
        email: 'updated@example.com',
        password: 'newpassword',
        phoneNumber: '0987654321',
      );

      test('emits [ProfileLoading, ProfileSuccess] when successful', () {
        when(mockProfileRepository.updateProfile(mockUpdatedProfile)).thenAnswer((_) async => null);
        when(mockProfileRepository.fetchProfile()).thenAnswer((_) async => [mockUpdatedProfile]);

        final expectedResponse = [
          ProfileLoading(),
          ProfileSuccess([mockUpdatedProfile]),
        ];
        expectLater(profileBloc.stream, emitsInOrder(expectedResponse)).then((_) {
          verify(mockProfileRepository.updateProfile(mockUpdatedProfile)).called(1);
          verify(mockProfileRepository.fetchProfile()).called(1);
        });

        profileBloc.add(UpdateProfile(id: mockUpdatedProfile.id, updatedProfile: mockUpdatedProfile));
      });

      test('emits [ProfileLoading, ProfileFailure] when unsuccessful', () {
        final error = 'Failed to update profile';
        when(mockProfileRepository.updateProfile(mockUpdatedProfile)).thenThrow(error);

        final expectedResponse = [
          ProfileLoading(),
          ProfileFailure(error),
        ];
        expectLater(profileBloc.stream, emitsInOrder(expectedResponse)).then((_) {
          verify(mockProfileRepository.updateProfile(mockUpdatedProfile)).called(1);
        });

        profileBloc.add(UpdateProfile(id: mockUpdatedProfile.id, updatedProfile: mockUpdatedProfile));
      });
    });

    group('DeleteProfile event', () {
      final mockProfileId = '1';

      test('emits [ProfileLoading, ProfileSuccess] when successful', () {
        when(mockProfileRepository.deleteProfile(mockProfileId)).thenAnswer((_) async => null);
        when(mockProfileRepository.fetchProfile()).thenAnswer((_) async => []);

        final expectedResponse = [
          ProfileLoading(),
          ProfileSuccess([]),
        ];
        expectLater(profileBloc.stream, emitsInOrder(expectedResponse)).then((_) {
          verify(mockProfileRepository.deleteProfile(mockProfileId)).called(1);
          verify(mockProfileRepository.fetchProfile()).called(1);
        });

        profileBloc.add(DeleteProfile(id: mockProfileId));
      });

      test('emits [ProfileLoading, ProfileFailure] when unsuccessful', () {
        final error = 'Failed to delete profile';
        when(mockProfileRepository.deleteProfile(mockProfileId)).thenThrow(error);

        final expectedResponse = [
          ProfileLoading(),
          ProfileFailure(error),
        ];
        expectLater(profileBloc.stream, emitsInOrder(expectedResponse)).then((_) {
          verify(mockProfileRepository.deleteProfile(mockProfileId)).called(1);
        });

        profileBloc.add(DeleteProfile(id: mockProfileId));
      });
    });
  });
}
