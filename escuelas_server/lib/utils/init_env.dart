// import 'package:prlab_server/env/env.dart';

// /// Mapa con las variables de entorno para reemplazar en el YAML.
// late final Map<String, dynamic> env;

// /// Inicializa las variables de entorno.
// void initEnv(String mode) {
//   switch (mode) {
//     case 'development':
//       env = <String, dynamic>{
//         'DB_HOST': EnvDev.dbHost,
//         'DB_PORT': EnvDev.dbPort,
//         'DB_NAME': EnvDev.dbName,
//         'DB_USER': EnvDev.dbUser,
//         'DB_PASS': EnvDev.dbPass,
//         'CLOUDINARY_APIKEY': EnvDev.cloudinaryApiKey,
//         'CLOUDINARY_APISECRET': EnvDev.cloudinaryApiSecret,
//         'CLOUDINARY_CLOUDNAME': EnvDev.cloudinaryCloudName,
//       };
//     case 'staging':
//       env = <String, dynamic>{
//         'DB_HOST': EnvStg.dbHost,
//         'DB_PORT': EnvStg.dbPort,
//         'DB_NAME': EnvStg.dbName,
//         'DB_USER': EnvStg.dbUser,
//         'DB_PASS': EnvStg.dbPass,
//         'CLOUDINARY_APIKEY': EnvStg.cloudinaryApiKey,
//         'CLOUDINARY_APISECRET': EnvStg.cloudinaryApiSecret,
//         'CLOUDINARY_CLOUDNAME': EnvStg.cloudinaryCloudName,
//       };
//     case 'production':
//       env = <String, dynamic>{
//         'DB_HOST': EnvProd.dbHost,
//         'DB_PORT': EnvProd.dbPort,
//         'DB_NAME': EnvProd.dbName,
//         'DB_USER': EnvProd.dbUser,
//         'DB_PASS': EnvProd.dbPass,
//         'CLOUDINARY_APIKEY': EnvProd.cloudinaryApiKey,
//         'CLOUDINARY_APISECRET': EnvProd.cloudinaryApiSecret,
//         'CLOUDINARY_CLOUDNAME': EnvProd.cloudinaryCloudName,
//       };
//     default:
//       env = <String, dynamic>{
//         'DB_HOST': EnvDev.dbHost,
//         'DB_PORT': EnvDev.dbPort,
//         'DB_NAME': EnvDev.dbName,
//         'DB_USER': EnvDev.dbUser,
//         'DB_PASS': EnvDev.dbPass,
//         'CLOUDINARY_APIKEY': EnvDev.cloudinaryApiKey,
//         'CLOUDINARY_APISECRET': EnvDev.cloudinaryApiSecret,
//         'CLOUDINARY_CLOUDNAME': EnvDev.cloudinaryCloudName,
//       };
//       break;
//   }
// }
