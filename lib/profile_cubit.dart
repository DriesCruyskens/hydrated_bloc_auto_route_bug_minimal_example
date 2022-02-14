import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'profile_state.dart';

class ProfileCubit extends HydratedCubit<ProfileState> {
  ProfileCubit() : super(InitialProfileState());

  Future<void> fetchProfile() async {
    emit(LoadingProfileState());
    await Future.delayed(const Duration(seconds: 4));
    emit(LoadedProfileState());
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    return InitialProfileState();
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    return {};
  }
}

