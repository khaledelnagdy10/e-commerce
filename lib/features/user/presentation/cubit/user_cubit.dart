import 'package:e_commerce_app/features/user/data/models/user_model.dart';
import 'package:e_commerce_app/features/user/data/repository/user_repository.dart';
import 'package:e_commerce_app/features/user/presentation/cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  UserModel? user;

  UserCubit({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(UserInitial()) {
    getUser();
  }

  Future<void> getUser() async {
    emit(UserLoading());
    try {
      user = await _userRepository.getUser();
      emit(UserLoaded());
    } catch (e) {
      emit(UserError());
    }
  }
}
