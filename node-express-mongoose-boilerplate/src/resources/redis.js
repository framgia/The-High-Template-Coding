import bluebird from 'bluebird';
import config from 'config';
import logger from 'logger';
import redis from 'redis';

bluebird.promisifyAll(redis);

export default () => {
  const redisURL = config.get('redisURL');
  logger.info(`Redis client connecting to ${redisURL}`);
  const client = redis.createClient(redisURL);
  client.on('ready', () =>
    logger.info(`Redis client connected to ${redisURL}`),
  );
  client.on('end', () =>
    logger.info(`Redis client disconnected from ${redisURL}`),
  );
  client.on('error', error =>
    logger.error(`Redis client error: ${error.toString()}`),
  );
  process.on('beforeExit', () => {
    logger.info(`Redis client disconnecting from ${redisURL}`);
    client.quit();
  });
};
