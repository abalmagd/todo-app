abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeNavigation extends AppStates {}

class DBGetTypeLoading extends AppStates {}

class DBGetTypeSuccess extends AppStates {}

class DBGetTypeFailed extends AppStates {}

class DBInsertLoading extends AppStates {}

class DBInsertSuccess extends AppStates {}

class DBInsertFailed extends AppStates {}

class DBDeleteLoading extends AppStates {}

class DBDeleteSuccess extends AppStates {}

class DBDeleteFailed extends AppStates {}

class DBUpdateLoading extends AppStates {}

class DBUpdateSuccess extends AppStates {}

class DBUpdateFailed extends AppStates {}

class DBCloseSuccess extends AppStates {}

class DBCloseFailed extends AppStates {}

class DBClearLoading extends AppStates {}

class DBClearSuccess extends AppStates {}

class DBClearFailed extends AppStates {}