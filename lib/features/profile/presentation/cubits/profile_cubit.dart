import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mil/features/profile/domain/repos/profile_repo.dart';
import 'package:mil/features/profile/presentation/cubits/profile_states.dart';
import '../../domain/entities/profile_user.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User not found'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile({required String uid, String? newBio}) async {
    try {
      emit(ProfileLoading());
      final currentUser = await profileRepo.fetchUserProfile(uid);
      if (currentUser == null) {
        emit(ProfileError('User not found'));
        return;
      }

      final updatedProfile = currentUser.copyWith(
        bio: newBio ?? currentUser.bio,
      );

      await profileRepo.updateProfile(updatedProfile);
      emit(ProfileLoaded(updatedProfile));
    } catch (e) {
      emit(ProfileError("Error updating profile: $e"));
    }
  }
}
