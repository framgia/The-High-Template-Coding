import cors from 'cors';
import compress from 'compression';
import cookieParser from 'cookie-parser';
import express from 'express';
import helmet from 'helmet';
import utils from 'utils';
import services from 'services';
import resources from 'resources';

const app = express();

app
  .use(cookieParser())
  .use(express.json({}))
  .use(express.urlencoded({ extended: true }))
  .use(cors({ origin: true, exposedHeaders: ['Express-Template'] }))
  .options('*', cors({ origin: true, exposedHeaders: ['Express-Template'] }))
  .use(compress())
  .use(helmet())
  .use(utils.logRequest)
  .use(utils.logResponse)
  .use(utils.logError)
  .use(services)
  .use(utils.handleError);

resources();

export default app;
