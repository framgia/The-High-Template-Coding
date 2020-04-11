export class SagaAction {
  readonly value: string;
  /**
   * action for active an saga
   * */
  constructor(value: string) {
    this.value = value;
  }
  /**
   * action will dispatch when saga success
   * */
  getSuccess = () => `${this.value}_SUCCESS`;
  /**
   * action will dispatch when saga fail
   * */
  getFail = () => `${this.value}_FAIL`;
  getInvalid = () => `${this.value}_INVALID`;
  getInputChange = () => `${this.value}_INPUT_CHANGE`;
  /**
   * action for clear state on reducer
   * */
  clear = () => `${this.value}_CLEAR_STATE`;
}

export default {
  MOVIES: new SagaAction('MOVIES'),
};
