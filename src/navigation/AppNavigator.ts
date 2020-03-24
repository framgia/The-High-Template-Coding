import {createLogger} from 'redux-logger';
import {applyMiddleware, createStore} from 'redux';
import {connect} from 'react-redux';
import Router from './Router';
import appReducer from '../reducers';
const loggerMiddleware = createLogger({
  predicate: () => __DEV__,
});
const mapStateToProps = (state: any) => ({
  state: state.nav,
});

export const store = createStore(appReducer, applyMiddleware(loggerMiddleware));
// export const store = createStore(appReducer);

// @ts-ignore
const AppNavigator = connect(mapStateToProps)(Router);
export default AppNavigator;
