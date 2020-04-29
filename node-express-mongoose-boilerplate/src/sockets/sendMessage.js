import app from 'app';
import logger from 'logger';

export default data => {
  logger.info(`Reveiced message ${data}`);
  app.io.emit('messageSent', data);
};
