enum Environment { DEV, STAGING, PROD }

class Constants {
  static Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = _Config.qaConstants;
        break;
      case Environment.PROD:
        _config = _Config.prodConstants;
        break;
    }
  }

  static get WHERE_AM_I {
    return _config[_Config.WHERE_AM_I];
  }

  static get APP_NAME {
    return _config[_Config.APP_NAME];
  }

  static String get ENVIRONMENT {
    return _config[_Config.ENVIRONMENT];
  }

  static String get USERS_COLLECTION {
    return _config[_Config.USERS_COLLECTION];
  }

  static String get DATABASE_COLLECTION {
    return _config[_Config.DATABASE_COLLECTION];
  }
}

class _Config {
  static const WHERE_AM_I = "WHERE_AM_I";
  static const APP_NAME = "APP_NAME";
  static const ENVIRONMENT = "ENVIRONMENT";
  static const USERS_COLLECTION = "USERS_COLLECTION";
  static const DATABASE_COLLECTION = "DATABASE_COLLECTION";

  static Map<String, dynamic> baseConstants = {
    USERS_COLLECTION: "users",
    DATABASE_COLLECTION: "sharlist"
  };

  static Map<String, dynamic> debugConstants = baseConstants
    ..addAll({
      WHERE_AM_I: "local",
      APP_NAME: "Sharlist dev",
      ENVIRONMENT: "dev",
    });

  static Map<String, dynamic> qaConstants = baseConstants
    ..addAll({
      WHERE_AM_I: "staging",
      APP_NAME: "Sharlist staging",
      ENVIRONMENT: "staging",
    });

  static Map<String, dynamic> prodConstants = baseConstants
    ..addAll({
      WHERE_AM_I: "prod",
      APP_NAME: "Sharlist",
      ENVIRONMENT: "prod",
    });
}
