// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../features/home/data/datasources/home_remote_data_source.dart'
    as _i814;
import '../../../features/home/data/repositories/home_repository_impl.dart'
    as _i955;
import '../../../features/home/domain/datasources/home_remote_data_source.dart'
    as _i523;
import '../../../features/home/domain/repositories/home_repository.dart'
    as _i834;
import '../../../features/home/domain/usecases/get_home_usecase.dart' as _i885;
import '../../../features/home/presentation/imports/home_imports.dart' as _i485;
import '../../../features/login/data/datasources/login_remote_data_source_impl.dart'
    as _i670;
import '../../../features/login/data/repositories/login_repository_impl.dart'
    as _i928;
import '../../../features/login/domain/datasources/login_remote_data_source.dart'
    as _i1009;
import '../../../features/login/domain/repositories/login_repository.dart'
    as _i1053;
import '../../../features/login/domain/usecases/login_usecase.dart' as _i1051;
import '../../../features/login/presentation/imports/login_imports.dart'
    as _i1051;
import '../../../features/new_request/data/datasources/new_request_remote_data_source.dart'
    as _i272;
import '../../../features/new_request/data/repositories/new_request_repository_impl.dart'
    as _i255;
import '../../../features/new_request/domain/datasources/new_request_remote_data_source.dart'
    as _i517;
import '../../../features/new_request/domain/repositories/new_request_repository.dart'
    as _i875;
import '../../../features/new_request/domain/usecases/create_new_request_use_case.dart'
    as _i143;
import '../../../features/new_request/domain/usecases/update_request_use_case.dart'
    as _i213;
import '../../../features/new_request/presentation/imports/new_request_imports.dart'
    as _i91;
import '../../../features/order_details/data/datasources/order_details_remote_data_source.dart'
    as _i521;
import '../../../features/order_details/data/repositories/order_details_repository_impl.dart'
    as _i154;
import '../../../features/order_details/domain/repositories/order_details_repository.dart'
    as _i904;
import '../../../features/order_details/domain/usecases/get_order_details_use_case.dart'
    as _i919;
import '../../../features/order_details/presentation/imports/order_details_imports.dart'
    as _i1033;
import '../../../features/orders/data/datasources/orders_remote_data_source.dart'
    as _i688;
import '../../../features/orders/data/repositories/orders_repository_impl.dart'
    as _i493;
import '../../../features/orders/domain/datasources/orders_remote_data_source.dart'
    as _i161;
import '../../../features/orders/domain/repositories/orders_repository.dart'
    as _i287;
import '../../../features/orders/domain/usecases/delete_request_use_case.dart'
    as _i342;
import '../../../features/orders/domain/usecases/get_orders_usecase.dart'
    as _i574;
import '../../../features/orders/presentation/imports/orders_imports.dart'
    as _i17;
import '../../../features/products/data/datasources/products_remote_data_source_impl.dart'
    as _i126;
import '../../../features/products/data/repositories/products_repository_impl.dart'
    as _i50;
import '../../../features/products/domain/datasources/products_remote_data_source.dart'
    as _i947;
import '../../../features/products/domain/repositories/products_repository.dart'
    as _i239;
import '../../../features/products/domain/usecases/create_product_usecase.dart'
    as _i1024;
import '../../../features/products/domain/usecases/delete_product_usecase.dart'
    as _i975;
import '../../../features/products/domain/usecases/get_product_details_usecase.dart'
    as _i173;
import '../../../features/products/domain/usecases/get_products_usecase.dart'
    as _i533;
import '../../../features/products/presentation/imports/products_imports.dart'
    as _i121;
import '../../../features/profile/data/datasources/profile_remote_data_source.dart'
    as _i214;
import '../../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i695;
import '../../../features/profile/domain/repositories/profile_repository.dart'
    as _i919;
import '../../../features/profile/domain/usecases/get_profile_use_case.dart'
    as _i493;
import '../../../features/profile/presentation/imports/profile_imports.dart'
    as _i41;
import '../../../features/remote_work/data/datasources/attendance_remote_data_source.dart'
    as _i546;
import '../../../features/remote_work/data/repositories/attendance_repository_impl.dart'
    as _i111;
import '../../../features/remote_work/domain/repositories/attendance_repository.dart'
    as _i499;
import '../../../features/remote_work/domain/usecases/get_attendance_use_case.dart'
    as _i361;
import '../../../features/remote_work/presentation/imports/remote_work_imports.dart'
    as _i948;
import '../../network/auth/token_storage.dart' as _i235;
import '../cubits/base_url/base_url_cubit.dart' as _i200;
import '../cubits/user_cubit/user_cubit.dart' as _i996;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i200.BaseUrlCubit>(() => _i200.BaseUrlCubit());
    gh.lazySingleton<_i546.AttendanceRemoteDataSource>(
      () => _i546.AttendanceRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i523.HomeRemoteDataSource>(
      () => _i814.HomeRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i517.NewRequestRemoteDataSource>(
      () => _i272.NewRequestRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i499.AttendanceRepository>(
      () => _i111.AttendanceRepositoryImpl(
        gh<_i546.AttendanceRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i834.HomeRepository>(
      () => _i955.HomeRepositoryImpl(gh<_i523.HomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i947.ProductsRemoteDataSource>(
      () => _i126.ProductsRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i161.OrdersRemoteDataSource>(
      () => _i688.OrdersRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i521.OrderDetailsRemoteDataSource>(
      () => _i521.OrderDetailsRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i214.ProfileRemoteDataSource>(
      () => _i214.ProfileRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i1009.LoginRemoteDataSource>(
      () => _i670.LoginRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i996.UserCubit>(
      () => _i996.UserCubit(gh<_i235.TokenStorage>()),
    );
    gh.lazySingleton<_i875.NewRequestRepository>(
      () => _i255.NewRequestRepositoryImpl(
        gh<_i517.NewRequestRemoteDataSource>(),
      ),
    );
    gh.factory<_i885.GetHomeUseCase>(
      () => _i885.GetHomeUseCase(gh<_i834.HomeRepository>()),
    );
    gh.lazySingleton<_i239.ProductsRepository>(
      () => _i50.ProductsRepositoryImpl(gh<_i947.ProductsRemoteDataSource>()),
    );
    gh.factory<_i213.UpdateRequestUseCase>(
      () => _i213.UpdateRequestUseCase(gh<_i875.NewRequestRepository>()),
    );
    gh.factory<_i143.CreateNewRequestUseCase>(
      () => _i143.CreateNewRequestUseCase(gh<_i875.NewRequestRepository>()),
    );
    gh.factory<_i91.NewRequestCubit>(
      () => _i91.NewRequestCubit(
        gh<_i143.CreateNewRequestUseCase>(),
        gh<_i213.UpdateRequestUseCase>(),
      ),
    );
    gh.lazySingleton<_i287.OrdersRepository>(
      () => _i493.OrdersRepositoryImpl(gh<_i161.OrdersRemoteDataSource>()),
    );
    gh.factory<_i361.GetAttendanceUseCase>(
      () => _i361.GetAttendanceUseCase(gh<_i499.AttendanceRepository>()),
    );
    gh.factory<_i485.HomeCubit>(
      () => _i485.HomeCubit(gh<_i885.GetHomeUseCase>()),
    );
    gh.lazySingleton<_i1053.LoginRepository>(
      () => _i928.LoginRepositoryImpl(gh<_i1009.LoginRemoteDataSource>()),
    );
    gh.factory<_i948.AttendanceCubit>(
      () => _i948.AttendanceCubit(gh<_i361.GetAttendanceUseCase>()),
    );
    gh.factory<_i574.GetOrdersUseCase>(
      () => _i574.GetOrdersUseCase(gh<_i287.OrdersRepository>()),
    );
    gh.lazySingleton<_i904.OrderDetailsRepository>(
      () => _i154.OrderDetailsRepositoryImpl(
        gh<_i521.OrderDetailsRemoteDataSource>(),
      ),
    );
    gh.factory<_i1024.CreateProductUseCase>(
      () => _i1024.CreateProductUseCase(gh<_i239.ProductsRepository>()),
    );
    gh.factory<_i975.DeleteProductUseCase>(
      () => _i975.DeleteProductUseCase(gh<_i239.ProductsRepository>()),
    );
    gh.factory<_i173.GetProductDetailsUseCase>(
      () => _i173.GetProductDetailsUseCase(gh<_i239.ProductsRepository>()),
    );
    gh.factory<_i533.GetProductsUseCase>(
      () => _i533.GetProductsUseCase(gh<_i239.ProductsRepository>()),
    );
    gh.factory<_i121.ProductDetailsCubit>(
      () => _i121.ProductDetailsCubit(gh<_i173.GetProductDetailsUseCase>()),
    );
    gh.lazySingleton<_i919.ProfileRepository>(
      () => _i695.ProfileRepositoryImpl(gh<_i214.ProfileRemoteDataSource>()),
    );
    gh.factory<_i919.GetOrderDetailsUseCase>(
      () => _i919.GetOrderDetailsUseCase(gh<_i904.OrderDetailsRepository>()),
    );
    gh.factory<_i1033.OrderDetailsCubit>(
      () => _i1033.OrderDetailsCubit(gh<_i919.GetOrderDetailsUseCase>()),
    );
    gh.factory<_i121.ProductsCubit>(
      () => _i121.ProductsCubit(
        gh<_i533.GetProductsUseCase>(),
        gh<_i1024.CreateProductUseCase>(),
        gh<_i975.DeleteProductUseCase>(),
      ),
    );
    gh.factory<_i1051.LoginUseCase>(
      () => _i1051.LoginUseCase(gh<_i1053.LoginRepository>()),
    );
    gh.factory<_i493.GetProfileUseCase>(
      () => _i493.GetProfileUseCase(gh<_i919.ProfileRepository>()),
    );
    gh.factory<_i1051.LoginCubit>(
      () => _i1051.LoginCubit(
        gh<_i1051.LoginUseCase>(),
        gh<_i235.TokenStorage>(),
        gh<_i996.UserCubit>(),
      ),
    );
    gh.factory<_i342.DeleteRequestUseCase>(
      () => _i342.DeleteRequestUseCase(gh<_i287.OrdersRepository>()),
    );
    gh.factory<_i17.OrdersCubit>(
      () => _i17.OrdersCubit(
        gh<_i574.GetOrdersUseCase>(),
        gh<_i342.DeleteRequestUseCase>(),
      ),
    );
    gh.factory<_i41.ProfileCubit>(
      () => _i41.ProfileCubit(gh<_i493.GetProfileUseCase>()),
    );
    return this;
  }
}
