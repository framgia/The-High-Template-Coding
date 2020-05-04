import app from 'app';
import config from 'config';
import logger from 'logger';
import socket from 'socket';

export default () => {
  const port = config.get('port');
  const server = app.listen(port, () => {
    logger.info(`App listening on ${port}`);
  });
  app.io = socket(server);
};
