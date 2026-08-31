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
import '../../../features/logout/data/datasources/logout_remote_data_source.dart'
    as _i355;
import '../../../features/logout/data/repositories/logout_repository_impl.dart'
    as _i583;
import '../../../features/logout/domain/repositories/logout_repository.dart'
    as _i245;
import '../../../features/logout/domain/usecases/logout_use_case.dart' as _i528;
import '../../../features/logout/presentation/imports/logout_imports.dart'
    as _i259;
import '../../../features/my_team/data/datasources/my_team_remote_data_source.dart'
    as _i420;
import '../../../features/my_team/data/repositories/my_team_repository_impl.dart'
    as _i1021;
import '../../../features/my_team/domain/repositories/my_team_repository.dart'
    as _i676;
import '../../../features/my_team/domain/usecases/get_my_team_requests_use_case.dart'
    as _i455;
import '../../../features/my_team/presentation/imports/my_team_imports.dart'
    as _i477;
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
import '../../../features/new_request/domain/usecases/update_provider_request_use_case.dart'
    as _i65;
import '../../../features/new_request/domain/usecases/update_request_use_case.dart'
    as _i213;
import '../../../features/new_request/presentation/imports/new_request_imports.dart'
    as _i91;
import '../../../features/notifications/data/datasources/notifications_remote_data_source.dart'
    as _i1066;
import '../../../features/notifications/data/repositories/notifications_repository_impl.dart'
    as _i466;
import '../../../features/notifications/domain/repositories/notifications_repository.dart'
    as _i1007;
import '../../../features/notifications/domain/usecases/get_notifications_use_case.dart'
    as _i176;
import '../../../features/notifications/presentation/imports/notifications_imports.dart'
    as _i281;
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
import '../../../features/provider/add_employee/data/datasources/departments_remote_data_source.dart'
    as _i710;
import '../../../features/provider/add_employee/data/datasources/add_employee_remote_data_source.dart'
    as _i717;
import '../../../features/provider/add_employee/data/repositories/departments_repository_impl.dart'
    as _i711;
import '../../../features/provider/add_employee/data/repositories/add_employee_repository_impl.dart'
    as _i718;
import '../../../features/provider/add_employee/domain/datasources/departments_remote_data_source.dart'
    as _i712;
import '../../../features/provider/add_employee/domain/repositories/add_employee_repository.dart'
    as _i719;
import '../../../features/provider/add_employee/domain/repositories/departments_repository.dart'
    as _i713;
import '../../../features/provider/add_employee/domain/usecases/get_departments_use_case.dart'
    as _i714;
import '../../../features/provider/add_employee/domain/usecases/create_employee_use_case.dart'
    as _i720;
import '../../../features/provider/add_employee/domain/usecases/get_department_managers_use_case.dart'
    as _i716;
import '../../../features/provider/add_employee/presentation/imports/add_employee_imports.dart'
    as _i715;
import '../../../features/profile/data/datasources/language_remote_data_source.dart'
    as _i193;
import '../../../features/profile/data/datasources/profile_remote_data_source.dart'
    as _i214;
import '../../../features/profile/data/repositories/language_repository_impl.dart'
    as _i415;
import '../../../features/profile/data/repositories/profile_repository_impl.dart'
    as _i695;
import '../../../features/profile/domain/repositories/language_repository.dart'
    as _i52;
import '../../../features/profile/domain/repositories/profile_repository.dart'
    as _i919;
import '../../../features/profile/domain/usecases/get_profile_use_case.dart'
    as _i493;
import '../../../features/profile/domain/usecases/set_language_use_case.dart'
    as _i247;
import '../../../features/profile/presentation/imports/profile_imports.dart'
    as _i41;
import '../../../features/provider/employees/data/datasources/employees_remote_data_source.dart'
    as _i396;
import '../../../features/provider/employees/data/repositories/employees_repository_impl.dart'
    as _i660;
import '../../../features/provider/employees/domain/datasources/employees_remote_data_source.dart'
    as _i929;
import '../../../features/provider/employees/domain/repositories/employees_repository.dart'
    as _i705;
import '../../../features/provider/employees/domain/usecases/get_employees_use_case.dart'
    as _i656;
import '../../../features/provider/employees/presentation/imports/employees_imports.dart'
    as _i903;
import '../../../features/provider/request_details/data/datasources/request_details_remote_data_source.dart'
    as _i406;
import '../../../features/provider/request_details/data/repositories/request_details_repository_impl.dart'
    as _i235;
import '../../../features/provider/request_details/domain/repositories/request_details_repository.dart'
    as _i376;
import '../../../features/provider/request_details/domain/usecases/add_request_comment_use_case.dart'
    as _i696;
import '../../../features/provider/request_details/domain/usecases/get_request_comments_use_case.dart'
    as _i991;
import '../../../features/provider/request_details/domain/usecases/get_request_details_use_case.dart'
    as _i353;
import '../../../features/provider/request_details/domain/usecases/review_request_use_case.dart'
    as _i314;
import '../../../features/provider/request_details/presentation/imports/request_details_imports.dart'
    as _i969;
import '../../../features/remote_work/data/datasources/attendance_remote_data_source.dart'
    as _i546;
import '../../../features/remote_work/data/repositories/attendance_repository_impl.dart'
    as _i111;
import '../../../features/remote_work/domain/repositories/attendance_repository.dart'
    as _i499;
import '../../../features/remote_work/domain/usecases/check_in_use_case.dart'
    as _i962;
import '../../../features/remote_work/domain/usecases/check_out_use_case.dart'
    as _i600;
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
    gh.lazySingleton<_i712.DepartmentsRemoteDataSource>(
      () => _i710.DepartmentsRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i717.AddEmployeeRemoteDataSource>(
      () => _i717.AddEmployeeRemoteDataSource(),
    );
    gh.lazySingleton<_i499.AttendanceRepository>(
      () => _i111.AttendanceRepositoryImpl(
        gh<_i546.AttendanceRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i834.HomeRepository>(
      () => _i955.HomeRepositoryImpl(gh<_i523.HomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i1066.NotificationsRemoteDataSource>(
      () => _i1066.NotificationsRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i947.ProductsRemoteDataSource>(
      () => _i126.ProductsRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i420.MyTeamRemoteDataSource>(
      () => _i420.MyTeamRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i193.LanguageRemoteDataSource>(
      () => _i193.LanguageRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i355.LogOutRemoteDataSource>(
      () => _i355.LogOutRemoteDataSourceImpl(),
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
    gh.lazySingleton<_i406.RequestDetailsRemoteDataSource>(
      () => _i406.RequestDetailsRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i929.EmployeesRemoteDataSource>(
      () => _i396.EmployeesRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i1009.LoginRemoteDataSource>(
      () => _i670.LoginRemoteDataSourceImpl(),
    );
    gh.lazySingleton<_i996.UserCubit>(
      () => _i996.UserCubit(gh<_i235.TokenStorage>()),
    );
    gh.lazySingleton<_i705.EmployeesRepository>(
      () =>
          _i660.EmployeesRepositoryImpl(gh<_i929.EmployeesRemoteDataSource>()),
    );
    gh.lazySingleton<_i875.NewRequestRepository>(
      () => _i255.NewRequestRepositoryImpl(
        gh<_i517.NewRequestRemoteDataSource>(),
      ),
    );
    gh.factory<_i885.GetHomeUseCase>(
      () => _i885.GetHomeUseCase(gh<_i834.HomeRepository>()),
    );
    gh.lazySingleton<_i245.LogOutRepository>(
      () => _i583.LogOutRepositoryImpl(gh<_i355.LogOutRemoteDataSource>()),
    );
    gh.lazySingleton<_i239.ProductsRepository>(
      () => _i50.ProductsRepositoryImpl(gh<_i947.ProductsRemoteDataSource>()),
    );
    gh.lazySingleton<_i713.DepartmentsRepository>(
      () => _i711.DepartmentsRepositoryImpl(
        gh<_i712.DepartmentsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i719.AddEmployeeRepository>(
      () => _i718.AddEmployeeRepositoryImpl(gh<_i717.AddEmployeeRemoteDataSource>()),
    );
    gh.factory<_i213.UpdateRequestUseCase>(
      () => _i213.UpdateRequestUseCase(gh<_i875.NewRequestRepository>()),
    );
    gh.lazySingleton<_i1007.NotificationsRepository>(
      () => _i466.NotificationsRepositoryImpl(
        gh<_i1066.NotificationsRemoteDataSource>(),
      ),
    );
    gh.factory<_i143.CreateNewRequestUseCase>(
      () => _i143.CreateNewRequestUseCase(gh<_i875.NewRequestRepository>()),
    );
    gh.factory<_i65.UpdateProviderRequestUseCase>(
      () => _i65.UpdateProviderRequestUseCase(gh<_i875.NewRequestRepository>()),
    );
    gh.lazySingleton<_i287.OrdersRepository>(
      () => _i493.OrdersRepositoryImpl(gh<_i161.OrdersRemoteDataSource>()),
    );
    gh.factory<_i962.CheckInUseCase>(
      () => _i962.CheckInUseCase(gh<_i499.AttendanceRepository>()),
    );
    gh.factory<_i600.CheckOutUseCase>(
      () => _i600.CheckOutUseCase(gh<_i499.AttendanceRepository>()),
    );
    gh.factory<_i361.GetAttendanceUseCase>(
      () => _i361.GetAttendanceUseCase(gh<_i499.AttendanceRepository>()),
    );
    gh.factory<_i485.HomeCubit>(
      () => _i485.HomeCubit(gh<_i885.GetHomeUseCase>()),
    );
    gh.factory<_i91.NewRequestCubit>(
      () => _i91.NewRequestCubit(
        gh<_i143.CreateNewRequestUseCase>(),
        gh<_i213.UpdateRequestUseCase>(),
        gh<_i65.UpdateProviderRequestUseCase>(),
      ),
    );
    gh.lazySingleton<_i1053.LoginRepository>(
      () => _i928.LoginRepositoryImpl(gh<_i1009.LoginRemoteDataSource>()),
    );
    gh.lazySingleton<_i676.MyTeamRepository>(
      () => _i1021.MyTeamRepositoryImpl(gh<_i420.MyTeamRemoteDataSource>()),
    );
    gh.factory<_i574.GetOrdersUseCase>(
      () => _i574.GetOrdersUseCase(gh<_i287.OrdersRepository>()),
    );
    gh.lazySingleton<_i904.OrderDetailsRepository>(
      () => _i154.OrderDetailsRepositoryImpl(
        gh<_i521.OrderDetailsRemoteDataSource>(),
      ),
    );
    gh.factory<_i948.AttendanceCubit>(
      () => _i948.AttendanceCubit(
        gh<_i361.GetAttendanceUseCase>(),
        gh<_i962.CheckInUseCase>(),
        gh<_i600.CheckOutUseCase>(),
      ),
    );
    gh.lazySingleton<_i52.LanguageRepository>(
      () => _i415.LanguageRepositoryImpl(gh<_i193.LanguageRemoteDataSource>()),
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
    gh.factory<_i714.GetDepartmentsUseCase>(
      () => _i714.GetDepartmentsUseCase(gh<_i713.DepartmentsRepository>()),
    );
    gh.factory<_i720.CreateEmployeeUseCase>(
      () => _i720.CreateEmployeeUseCase(gh<_i719.AddEmployeeRepository>()),
    );
    gh.factory<_i716.GetDepartmentManagersUseCase>(
      () => _i716.GetDepartmentManagersUseCase(
        gh<_i713.DepartmentsRepository>(),
      ),
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
    gh.factory<_i455.GetMyTeamRequestsUseCase>(
      () => _i455.GetMyTeamRequestsUseCase(gh<_i676.MyTeamRepository>()),
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
    gh.factory<_i715.DepartmentsCubit>(
      () => _i715.DepartmentsCubit(gh<_i714.GetDepartmentsUseCase>()),
    );
    gh.factory<_i715.AddEmployeeCubit>(
      () => _i715.AddEmployeeCubit(gh<_i720.CreateEmployeeUseCase>()),
    );
    gh.factory<_i715.DepartmentManagersCubit>(
      () => _i715.DepartmentManagersCubit(
        gh<_i716.GetDepartmentManagersUseCase>(),
      ),
    );
    gh.lazySingleton<_i376.RequestDetailsRepository>(
      () => _i235.RequestDetailsRepositoryImpl(
        gh<_i406.RequestDetailsRemoteDataSource>(),
      ),
    );
    gh.factory<_i656.GetEmployeesUseCase>(
      () => _i656.GetEmployeesUseCase(gh<_i705.EmployeesRepository>()),
    );
    gh.factory<_i528.LogoutUseCase>(
      () => _i528.LogoutUseCase(gh<_i245.LogOutRepository>()),
    );
    gh.factory<_i176.GetNotificationsUseCase>(
      () => _i176.GetNotificationsUseCase(gh<_i1007.NotificationsRepository>()),
    );
    gh.factory<_i1051.LoginUseCase>(
      () => _i1051.LoginUseCase(gh<_i1053.LoginRepository>()),
    );
    gh.factory<_i696.AddRequestCommentUseCase>(
      () =>
          _i696.AddRequestCommentUseCase(gh<_i376.RequestDetailsRepository>()),
    );
    gh.factory<_i991.GetRequestCommentsUseCase>(
      () =>
          _i991.GetRequestCommentsUseCase(gh<_i376.RequestDetailsRepository>()),
    );
    gh.factory<_i353.GetRequestDetailsUseCase>(
      () =>
          _i353.GetRequestDetailsUseCase(gh<_i376.RequestDetailsRepository>()),
    );
    gh.factory<_i314.ReviewRequestUseCase>(
      () => _i314.ReviewRequestUseCase(gh<_i376.RequestDetailsRepository>()),
    );
    gh.factory<_i477.MyTeamCubit>(
      () => _i477.MyTeamCubit(gh<_i455.GetMyTeamRequestsUseCase>()),
    );
    gh.factory<_i281.NotificationsCubit>(
      () => _i281.NotificationsCubit(gh<_i176.GetNotificationsUseCase>()),
    );
    gh.factory<_i247.SetLanguageUseCase>(
      () => _i247.SetLanguageUseCase(gh<_i52.LanguageRepository>()),
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
    gh.factory<_i969.RequestCommentsCubit>(
      () => _i969.RequestCommentsCubit(
        gh<_i991.GetRequestCommentsUseCase>(),
        gh<_i696.AddRequestCommentUseCase>(),
      ),
    );
    gh.factory<_i903.EmployeesCubit>(
      () => _i903.EmployeesCubit(gh<_i656.GetEmployeesUseCase>()),
    );
    gh.factory<_i17.OrdersCubit>(
      () => _i17.OrdersCubit(
        gh<_i574.GetOrdersUseCase>(),
        gh<_i342.DeleteRequestUseCase>(),
      ),
    );
    gh.factory<_i259.LogoutCubit>(
      () => _i259.LogoutCubit(gh<_i528.LogoutUseCase>(), gh<_i996.UserCubit>()),
    );
    gh.factory<_i969.RequestDetailsCubit>(
      () => _i969.RequestDetailsCubit(
        gh<_i353.GetRequestDetailsUseCase>(),
        gh<_i314.ReviewRequestUseCase>(),
      ),
    );
    gh.factory<_i41.ProfileCubit>(
      () => _i41.ProfileCubit(gh<_i493.GetProfileUseCase>()),
    );
    gh.factory<_i41.LanguageCubit>(
      () => _i41.LanguageCubit(gh<_i247.SetLanguageUseCase>()),
    );
    return this;
  }
}
