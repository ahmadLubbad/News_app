import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/network/local/cache_helper.dart';

class ModeCubit extends Cubit<ModeStates> {
  ModeCubit() :super(ModeMainState());
  static ModeCubit get(context) => BlocProvider.of(context);

  bool isDark=false;

  void changeAppMode({bool fromShared}) {

    if(fromShared !=null){
      isDark=fromShared;
      emit(NewsAppChangeModeState());
    }
    else{
      isDark=!isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value){
        emit(NewsAppChangeModeState());
        print(isDark);
      });
    }


  }


}