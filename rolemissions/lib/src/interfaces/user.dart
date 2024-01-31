import 'package:rolemissions/src/errors/not_initialized.dart';
import 'package:rolemissions/src/models/models.dart';
import 'package:rolemissions/src/rolemissions.dart';

/// An interface pretended for being implemented in the user class of your
/// system.
abstract class RolemissionUser {
  /// The [Rolemissions] instance that is used for checking and persisting
  /// permissions.
  RolemissionPermissions get rolemissions;

  bool _isInitialized = false;

  /// A method that should be called when the user's roles and privileges are
  /// intended
  /// for being queried.
  void initRolemissions(List<Role> roles, String serializedPrivileges) {
    _roles = roles;
    _privileges = rolemissions.deserialization(serializedPrivileges);
    _isInitialized = true;
  }

  /// The roles of the user.
  List<Role> _roles = [];

  /// The roles of the user.
  List<Role> get roles =>
      _isInitialized ? _roles : throw NotInitializedRolemissions.roles();

  /// The permissions of the user that gets bypassing his roles.
  List<List<Enum>> _privileges = [];

  /// The permissions of the user that gets bypassing his roles.
  List<List<Enum>> get privileges => _isInitialized
      ? _privileges
      : throw NotInitializedRolemissions.privileges();
}
