part of '../imports/order_details_imports.dart';

@injectable
class OrderDetailsCubit extends AsyncCubit<LeaveRequestDetailsEntity> {
  OrderDetailsCubit(this._useCase);

  final GetOrderDetailsUseCase _useCase;

  Future<void> getDetails(int id) => execute(() => _useCase(id));
}
