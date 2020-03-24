import React from 'react';
import {View} from 'react-native';
import {BaseComponent, BaseProps} from '../../components';
interface Props extends BaseProps {
  goToMain();
}
export default class SplashScreen extends BaseComponent<Props> {
  componentDidMount(): void {
    this.props.goToMain();
  }

  render() {
    return <View />;
  }
}
