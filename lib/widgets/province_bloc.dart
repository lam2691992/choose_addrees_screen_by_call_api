// province_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chon_tinh/model/province_model.dart';
import 'package:chon_tinh/services/province_service.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ProvinceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProvinces extends ProvinceEvent {}

class SelectProvince extends ProvinceEvent {
  final String provinceId;

  SelectProvince(this.provinceId);

  @override
  List<Object?> get props => [provinceId];
}

// States
abstract class ProvinceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceLoaded extends ProvinceState {
  final List<Data> provinces;

  ProvinceLoaded(this.provinces);

  @override
  List<Object?> get props => [provinces];
}

class ProvinceSelected extends ProvinceState {
  final String provinceId;
  final String provinceName;

  ProvinceSelected(this.provinceId, this.provinceName);

  @override
  List<Object?> get props => [provinceId, provinceName];
}

// Bloc
class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final ProvinceService provinceService;

  ProvinceBloc(this.provinceService) : super(ProvinceInitial()) {
    on<LoadProvinces>((event, emit) async {
      emit(ProvinceLoading());
      try {
        final provinces = await provinceService.fetchProvinces();
        emit(ProvinceLoaded(provinces));
      } catch (e) {
        emit(ProvinceInitial()); // Xử lý lỗi theo nhu cầu của bạn
      }
    });

    on<SelectProvince>((event, emit) {
      final province = (state as ProvinceLoaded).provinces
          .firstWhere((province) => province.id == event.provinceId);
      emit(ProvinceSelected(event.provinceId, province.name ?? ''));
    });
  }
}
