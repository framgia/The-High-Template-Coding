export class SagaAction {
  readonly value: string;

  constructor(value: string) {
    this.value = value;
  }

  getSuccess = () => `${this.value}_SUCCESS`;
  getFail = () => `${this.value}_FAIL`;
  getInvalid = () => `${this.value}_INVALID`;
  getInputChange = () => `${this.value}_INPUT_CHANGE`;
  clear = () => `${this.value}_CLEAR_STATE`;
}

export default {
  MOVIES: new SagaAction('MOVIES'),
  MOVIES1: new SagaAction('MOVIES1'),
};
