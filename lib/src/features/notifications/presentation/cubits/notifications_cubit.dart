part of '../imports/notifications_imports.dart';


@injectable
class NotificationsCubit
    extends AsyncCubit<List<NotificationEntity>> {

  NotificationsCubit(this._getNotifications);


  final GetNotificationsUseCase _getNotifications;


  int _currentPage = 1;

  int _perPage = 20;


  bool _hasMore = true;

  bool _isLoadingMore = false;

  bool _isFetching = false;



  bool get hasMore => _hasMore;

  bool get isLoadingMore => _isLoadingMore;



  Future<void> getNotifications({
    int? perPage,
  }) async {


    if(_isFetching){
      return;
    }


    _isFetching = true;


    _currentPage = 1;

    _perPage = perPage ?? 20;

    _hasMore = true;

    _isLoadingMore = false;


    clearData();



    try {

      final result = await _getNotifications(

        page: 1,

        perPage: _perPage,

      );



      result.fold(

            (failure){

          setFailure(failure);

        },


            (data){

          _hasMore = data.isNotEmpty;

          setData(data);

        },

      );


    } finally {

      _isFetching = false;

    }

  }





  Future<void> loadMore() async {


    if(
    _isLoadingMore ||
        !_hasMore ||
        _isFetching
    ){

      return;

    }



    final nextPage =
        _currentPage + 1;



    _isLoadingMore = true;

    _isFetching = true;



    try {


      final result = await _getNotifications(

        page: nextPage,

        perPage: _perPage,

      );



      result.fold(

            (failure){

          emit(
            AsyncFailure<List<NotificationEntity>>(
              failure,
              previous: lastData,
            ),
          );

        },


            (data){


          if(data.isEmpty){

            _hasMore = false;


            emit(
              AsyncSuccess(
                lastData ?? [],
              ),
            );


            return;

          }



          _currentPage = nextPage;



          setData(

            [

              ...lastData ?? [],

              ...data,

            ],

          );


        },

      );


    } finally {

      _isLoadingMore = false;

      _isFetching = false;

    }


  }

}