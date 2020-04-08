import Config from 'react-native-config';

export class API {
  url: string;
  method: string;
  constructor(url: string, method: 'post' | 'get' | 'put' | 'delete') {
    this.url = url;
    this.method = method;
  }
}
/**
 * Declare apis usage in project
 * */
export default {
  BASE: Config.BASE_URL,
  API: {
    Movies: new API('/movies.json', 'get'),
  },
};
