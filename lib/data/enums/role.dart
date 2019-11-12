enum Role {
  user,
  admin,
  developer
}

Role roleFromString(String value) {
  value = value.toLowerCase();
  if(value == 'admin') return Role.admin;
  else if(value == 'developer') return Role.developer;
  else return Role.user;
}

String roleToString(Role value) {
  if(value == Role.admin) return 'admin';
  else if(value == Role.developer) return 'developer';
  else return 'user';
}
