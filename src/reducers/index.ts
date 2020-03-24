import {combineReducers} from 'redux';
import SplashReducer from '../ui/screens/splash/SplashReducer';
import MainReducer from '../ui/screens/main/MainReducer';
const reducer = combineReducers({
  splash: SplashReducer,
  main: MainReducer,
});

const appReducer = (state: any, action: any) => {
  return reducer(state, action);
};

export default appReducer;
