const String buildEnv = String.fromEnvironment('build.env');

const devConfig = {
  'baseUrl': '',
};

const stageConfig = {
  'baseUrl': '',
};

const productionConfig = {
  'baseUrl': '',
};

const environment = buildEnv == 'production'
    ? productionConfig
    : buildEnv == 'dev'
        ? devConfig
        : buildEnv == 'stage'
            ? stageConfig
            : productionConfig;
