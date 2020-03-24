import React, {Component} from 'react';
import {Provider} from 'react-redux';
import AppNavigator, {store} from './navigation/AppNavigator';

interface Props {}

export default class App extends Component<Props> {
  render() {
    return (
      <Provider store={store}>
        <AppNavigator />
      </Provider>
    );
  }
}
