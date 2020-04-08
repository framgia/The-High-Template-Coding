import {createLogger} from 'redux-logger';
import {applyMiddleware, createStore} from 'redux';
import {connect} from 'react-redux';
import createSagaMiddleware from 'redux-saga';
import Router from './Router';
import appReducer from '../reducers';
import saga from '../saga';
const loggerMiddleware = createLogger({
  predicate: () => __DEV__,
});
const sagaMiddleware = createSagaMiddleware();
export const store = createStore(
  appReducer,
  applyMiddleware(loggerMiddleware, sagaMiddleware),
);
sagaMiddleware.run(saga);
const AppNavigator = connect()(Router);
export default AppNavigator;
