abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeNavigation extends AppStates {}

class DBGetTypeLoading extends AppStates {}

class DBGetTypeSuccess extends AppStates {}

class DBGetTypeFailed extends AppStates {}

class DBInsertLoading extends AppStates {}

class DBInsertSuccess extends AppStates {}

class DBInsertFailed extends AppStates {}