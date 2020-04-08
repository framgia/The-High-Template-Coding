import axios from 'axios';
import Config, {API} from './Config';

/**
 * @param api config with information server
 * @param headers custom header for special api
 * @param params for GET request
 * @param data for Post, Put.. request
 * */
export default async function(
  api: API,
  headers = {},
  params = null,
  data = null,
) {
  let url = Config.BASE + api.url;
  /*
   * Header for verification with server
   * Config:
   *         - Authorization
   *         - content-type
   *         - ...
   * */
  headers = {
    ...headers,
    'content-type': 'application/json',
  };
  // @ts-ignore
  return axios({
    method: api.method,
    url,
    timeout: 20000,
    headers,
    data,
    params,
  });
}
