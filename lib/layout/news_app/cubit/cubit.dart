import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sport_screen.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems =[
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center_sharp),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> screens=[
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index){
    if(index==1)
      getSports();
    if(index==2)
      getScience();
    currentIndex=index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business=[];

  void getBusiness(){
    
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apiKey': '26cebc680ed34ba795ed972cb49a6c6c'
      },
    ).then((value){
      // print("Value Data ::: ${value.data.toString()}");
      // print("Value  ::: ${value}");
      business=value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print("Error : ${error.toString()}");
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }


  List<dynamic> sports=[];

  void getSports(){

    emit(NewsGetSportsLoadingState());

    if(sports.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apiKey': '26cebc680ed34ba795ed972cb49a6c6c'
        },
      ).then((value){
        // print("Value Data ::: ${value.data.toString()}");
        // print("Value  ::: ${value}");
        sports=value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print("Error : ${error.toString()}");
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }



  List<dynamic> science=[];

  void getScience(){

    emit(NewsGetScienceLoadingState());

    if(science.length==0){
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apiKey': '26cebc680ed34ba795ed972cb49a6c6c'
        },
      ).then((value){
        // print("Value Data ::: ${value.data.toString()}");
        // print("Value  ::: ${value}");
        science=value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print("Error : ${error.toString()}");
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }


  }


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