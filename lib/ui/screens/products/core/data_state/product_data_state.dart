abstract class ProductDataState<T> {
  final T? data;
  final Exception? exception;

  const ProductDataState({this.data, this.exception});
}

class DataSuccess<T> extends ProductDataState<T> {
  const DataSuccess({super.data});
}

class DataError<T> extends ProductDataState<T> {
  const DataError({super.exception});
}
