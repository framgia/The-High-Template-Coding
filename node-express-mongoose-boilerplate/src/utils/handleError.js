import createError from 'http-errors';
import { isNumber } from 'lodash/fp';
import statusCodes from 'statusCodes';

export default (error, req, res, next) => {
  let { message, status } = error;
  let err = error;
  if (!isNumber(status)) {
    message = error.toString();
    status = statusCodes.InternalServerError;
    err = new createError.InternalServerError(message);
  }
  res.error = err;
  res.status(status);
  res.json(err);
  next();
};
