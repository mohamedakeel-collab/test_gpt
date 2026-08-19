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
import '../../../features/new_request/presentation/imports/new_request_imports.dart'
    as _i91;
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
    gh.lazySingleton<_i523.HomeRemoteDataSource>(
      () => _i814.HomeRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i517.NewRequestRemoteDataSource>(
      () => _i272.NewRequestRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i834.HomeRepository>(
      () => _i955.HomeRepositoryImpl(gh<_i523.HomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i947.ProductsRemoteDataSource>(
      () => _i126.ProductsRemoteDataSourceImpl(),
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
    gh.factory<_i143.CreateNewRequestUseCase>(
      () => _i143.CreateNewRequestUseCase(gh<_i875.NewRequestRepository>()),
    );
    gh.factory<_i485.HomeCubit>(
      () => _i485.HomeCubit(gh<_i885.GetHomeUseCase>()),
    );
    gh.lazySingleton<_i1053.LoginRepository>(
      () => _i928.LoginRepositoryImpl(gh<_i1009.LoginRemoteDataSource>()),
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
    gh.factory<_i121.ProductsCubit>(
      () => _i121.ProductsCubit(
        gh<_i533.GetProductsUseCase>(),
        gh<_i1024.CreateProductUseCase>(),
        gh<_i975.DeleteProductUseCase>(),
      ),
    );
    gh.factory<_i91.NewRequestCubit>(
      () => _i91.NewRequestCubit(gh<_i143.CreateNewRequestUseCase>()),
    );
    gh.factory<_i1051.LoginUseCase>(
      () => _i1051.LoginUseCase(gh<_i1053.LoginRepository>()),
    );
    gh.factory<_i1051.LoginCubit>(
      () => _i1051.LoginCubit(
        gh<_i1051.LoginUseCase>(),
        gh<_i235.TokenStorage>(),
      ),
    );
    return this;
  }
}
