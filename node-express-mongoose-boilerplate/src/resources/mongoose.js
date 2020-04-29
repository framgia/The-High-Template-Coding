import config from 'config';
import os from 'os';
import { delay, size } from 'lodash/fp';
import { set } from 'lodash';
import mongoose from 'mongoose';
import logger from 'logger';

export default () => {
  mongoose.Promise = global.Promise;
  mongoose.set('useCreateIndex', true);
  mongoose.set('useNewUrlParser', true);
  mongoose.set('useUnifiedTopology', true);
  // Mongoose warns to set `useUnifiedTopology` to `true`, but it causes the
  // following issues on MongoDB Atlas clusters after primary election triggered
  // by maintenance window scheduled at every Sunday 00:00 +0900:
  //   https://github.com/Automattic/mongoose/issues/8180
  //   https://jira.mongodb.org/browse/NODE-2123
  // mongoose.set('useUnifiedTopology', true);
  const options = {
    poolSize: process.env.UV_THREADPOOL_SIZE || size(os.cpus()) * 2,
  };
  if (process.env.NODE_ENV === 'production') {
    set(options, 'config.autoIndex', false);
  } else {
    mongoose.set('debug', true);
  }
  const mongodbURL = config.get('mongodbURL');
  const mongodbURLObject = new URL(mongodbURL);
  mongodbURLObject.password = process.env.MONGODB_PASSWORD || '';
  const mongodbURLWithPassword = mongodbURLObject.toString();
  logger.info(`Mongoose connecting to ${mongodbURL}`);
  mongoose.connect(mongodbURLWithPassword, options);
  mongoose.connection.on('connected', () =>
    logger.info(`Mongoose connected to ${mongodbURL}`),
  );
  mongoose.connection.on('disconnected', () =>
    logger.info(`Mongoose disconnected from ${mongodbURL}`),
  );
  mongoose.connection.on('error', error => {
    const errorString = error.toString();
    logger.error(`Mongoose connection error: ${errorString}`);
    if (errorString.includes('ECONNREFUSED')) {
      logger.info('Mongoose waiting for 5 seconds to reconnect');
      delay(5000)(() => {
        logger.info(`Mongoose reconnecting to ${mongodbURL}`);
        mongoose.connect(mongodbURLWithPassword, options);
      });
    }
  });
  process.on('beforeExit', () => {
    logger.info(`Mongoose disconnecting from ${mongodbURL}`);
    mongoose.disconnect();
  });
  return mongoose;
};
