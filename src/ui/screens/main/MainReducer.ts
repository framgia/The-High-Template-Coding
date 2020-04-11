import SagaAction from '../../../saga/Action';

export const initialState: any = {
  isLoading: false,
  data: null,
  error: null,
};
export default function(state = initialState, action: any) {
  switch (action.type) {
    case SagaAction.MOVIES.value:
      return {
        ...state,
        isLoading: true,
        error: null,
      };
    case SagaAction.MOVIES.getSuccess():
      return {
        ...state,
        isLoading: false,
        data: action.data,
      };
    case SagaAction.MOVIES.getFail():
      return {
        ...state,
        isLoading: false,
        error: action.error,
      };
    default:
      return state;
  }
}
