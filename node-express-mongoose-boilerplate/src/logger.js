import winston from 'winston';

export default winston.createLogger({
  exitOnError: false,
  format:
    process.env.NODE_ENV === 'production'
      ? winston.format.combine(
          winston.format.splat(),
          winston.format.uncolorize(),
          winston.format.printf(info => `[${info.level}] ${info.message}`),
        )
      : winston.format.combine(
          winston.format.colorize(),
          winston.format.splat(),
          winston.format.timestamp(),
          winston.format.printf(
            info => `${info.timestamp} [${info.level}] ${info.message}`,
          ),
        ),
  levels: { error: 0, warn: 1, info: 2, debug: 3 },
  level: process.env.NODE_ENV === 'production' ? 'info' : 'debug',
  transports: [new winston.transports.Console()],
});
