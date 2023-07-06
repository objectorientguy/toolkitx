import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/cache/customer_cache.dart';
import '../../../../di/app_module.dart';
import '../../../repositories/incident/incident_repository.dart';
import 'edit_incident_details_events.dart';
import 'edit_incident_details_states.dart';

class EditIncidentDetailsBloc
    extends Bloc<EditIncidentDetailsEvent, EditIncidentDetailsStates> {
  final IncidentRepository _incidentRepository = getIt<IncidentRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();

  EditIncidentDetailsStates get initialState => EditIncidentDetailsInitial();

  EditIncidentDetailsBloc() : super(EditIncidentDetailsInitial()) {}
}
