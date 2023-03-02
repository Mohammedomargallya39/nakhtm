import 'package:meta/meta.dart';


@immutable
abstract class HomeState{}

class Empty extends HomeState {}
class ChangeBottomNavBarState extends HomeState {}
class HideCardValueState extends HomeState {}
class AyahOnPressedValueState extends HomeState {}
class ChangeCurrentTasbeehNumber extends HomeState {}
class ChangeRepetitionSleepingNumber extends HomeState {}
class ChangeRepetitionMorningNumber extends HomeState {}
class ChangeRepetitionEveningNumber extends HomeState {}
class ChangeRepetitionMasgedNumber extends HomeState {}
class ChangeRepetitionSalahNumber extends HomeState {}
class ResetCurrentTasbeehNumber extends HomeState {}
class GetTotalTasbeeh extends HomeState {}
class AlarmChangeState extends HomeState {}

class AdanLoadingState extends HomeState{}
class AdanErrorState extends HomeState{}
class AdanSuccessState extends HomeState{}

class TafseerLoadingState extends HomeState{}
class TafseerErrorState extends HomeState{}
class TafseerSuccessState extends HomeState{}

class HadithLoadingState extends HomeState{}
class HadithErrorState extends HomeState{}
class HadithSuccessState extends HomeState{}

class GetSavedDataSuccessState extends HomeState{}

class NextPageState extends HomeState{}
class PrevPageState extends HomeState{}
class ScrollTopState extends HomeState{}
class TurnOnSoundState extends HomeState{}
class GetLocationState extends HomeState{}
class LoadingGetLocationState extends HomeState{}
class RestAzkarListState extends HomeState{}
class ShowGuideState extends HomeState{}