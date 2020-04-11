import {combineReducers} from 'redux';
import SplashReducer from '../ui/screens/splash/SplashReducer';
import MainReducer from '../ui/screens/main/MainReducer';

/**
 * Declare all reducers using on app
 * It'll active and receive new state after dispatch function called
 * follow struct:
 *       name: Reducer
 *       @name: name of reducer declare on store. effect to state in #mapStateToProps on container of screens
 *       @Reducer: object whose values correspond to different reducer functions that need to be combined into one
 *       @Example splash: SplashReducer
 * */
const reducer = combineReducers({
  splash: SplashReducer,
  main: MainReducer,
});

const appReducer = (state: any, action: any) => {
  return reducer(state, action);
};

export default appReducer;
