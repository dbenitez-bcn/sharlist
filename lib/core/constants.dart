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
}

class _Config {
  static const WHERE_AM_I = "WHERE_AM_I";
  static const APP_NAME = "APP_NAME";

  static Map<String, dynamic> debugConstants = {
    WHERE_AM_I: "local",
    APP_NAME: "Sharlist dev"
  };

  static Map<String, dynamic> qaConstants = {
    WHERE_AM_I: "staging",
    APP_NAME: "Sharlist staging"
  };

  static Map<String, dynamic> prodConstants = {
    WHERE_AM_I: "prod",
    APP_NAME: "Sharlist"
  };
}
