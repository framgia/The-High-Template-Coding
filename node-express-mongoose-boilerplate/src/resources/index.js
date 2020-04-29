import mongoose from './mongoose';
import redis from './redis';

export default () => {
  mongoose();
  redis();
};
