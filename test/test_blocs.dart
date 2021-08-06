
import 'package:bloc/bloc.dart';

abstract class PersonState {}
class PersonStateRunning extends PersonState {}
class PersonStateSleeping extends PersonState {}
class PersonStateAwake extends PersonState {}

abstract class PersonEvent {}
class PersonEventRun extends PersonEvent {}
class PersonEventGoToBed extends PersonEvent {}
class PersonEventWakeUp extends PersonEvent {}

class PersonBloc extends Bloc<PersonEvent, PersonState> {

  PersonBloc(PersonState initialState) : super(initialState);

  @override
  PersonState get initialState => PersonStateSleeping();

  @override
  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    
    if (event is PersonEventWakeUp) {
      yield PersonStateAwake();
    }

    else if (event is PersonEventRun) {
      yield PersonStateRunning();
    }

    else if (event is PersonEventGoToBed) {
      yield PersonStateSleeping();
    }
  }
}

abstract class DogState {}
class DogStateBarking extends DogState {}
class DogStateSleeping extends DogState {}
class DogStateRunning extends DogState {}

abstract class DogEvent {}
class DogEventBark extends DogEvent {}
class DogEventGoToBed extends DogEvent {}
class DogEventRun extends DogEvent {}

class DogBloc extends Bloc<DogEvent, DogState> {

  DogBloc(DogState initialState) : super(initialState);

  @override
  DogState get initialState => DogStateSleeping();

  @override
  Stream<DogState> mapEventToState(DogEvent event) async* {
    
    if (event is DogEventBark) {
      yield DogStateBarking();
    }

    else if (event is DogEventGoToBed) {
      yield DogStateSleeping();
    }

    else if (event is DogEventRun) {
      yield DogStateRunning();
    }
  }
}