import {createLogger} from 'redux-logger';
import {applyMiddleware, createStore} from 'redux';
import {connect} from 'react-redux';
import Router from './Router';
import appReducer from '../reducers';
const loggerMiddleware = createLogger({
  predicate: () => __DEV__,
});

export const store = createStore(appReducer, applyMiddleware(loggerMiddleware));

const AppNavigator = connect()(Router);
export default AppNavigator;
