import morgan from 'morgan';
import logger from 'logger';
import { get } from 'lodash/fp';

morgan.token('body', req => JSON.stringify(req.body));
morgan.token('error', (req, res) => get('error.stack')(res));
morgan.token('message', (req, res) => res.statusMessage || '');
morgan.token('params', req => JSON.stringify(req.params));
morgan.token('query', req => JSON.stringify(req.query));

const getIpFormat = () =>
  process.env.NODE_ENV === 'production' ? ':remote-addr - ' : '';

const requestFormat = `Request: ${getIpFormat()}:method :url - body: :body - params: :params - query: :query`;
const responseFormat = `Response: ${getIpFormat()}:method :url :status - :response-time ms`;
const errorFormat = `${getIpFormat()}:method :url :status - body: :body - params: :params - query: :query - :response-time ms - message: :message - stack: :error`;

const logRequest = morgan(requestFormat, {
  stream: {
    write: message => logger.debug(`${message.trim()}`),
  },
});

const logResponse = morgan(responseFormat, {
  skip: (req, res) => res.statusCode >= 400,
  stream: { write: message => logger.debug(message.trim()) },
});

const logError = morgan(errorFormat, {
  skip: (req, res) => res.statusCode < 400,
  stream: { write: message => logger.error(message.trim()) },
});

export default {
  logError,
  logRequest,
  logResponse,
};
