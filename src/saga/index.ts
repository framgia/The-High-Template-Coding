import {call, put, takeLeading} from 'redux-saga/effects';
import request from '../networking/ReqHelper';
import Config, {API} from '../networking/Config';
import Actions, {SagaAction} from './Action';

/**
 * Take request with server side
 * To active saga dispatch an action as:
 *             {
 *               type: ref #SagaAction the action for active saga
 *               headers custom header for special api
 *               params for GET request
 *               data for Post, Put.. request
 *             }
 * @param sagaAction action to active saga
 * @param api server info
 * @return a dispatch action
 *          - action success: with server response success with data
 *          - action fail: with server response fail with message
 * */
function* doAsync(sagaAction: SagaAction, api: API) {
  return yield takeLeading(sagaAction.value, function*(action: any) {
    try {
      const {data} = yield call(
        request,
        api,
        action.headers,
        action.params,
        action.data,
      );
      yield put({type: sagaAction.getSuccess(), data});
    } catch (e) {
      yield put({type: sagaAction.getFail(), error: e.message});
    }
  });
}

/**
 * List #SagaAction for register saga listener
 * */
export default function*() {
  yield doAsync(Actions.MOVIES, Config.API.Movies);
}
