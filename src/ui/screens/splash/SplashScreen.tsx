import React from 'react';
import {View} from 'react-native';
import Splash from 'react-native-splash-screen';
import {BaseComponent, BaseProps} from '../../components';
interface Props extends BaseProps {
  goToMain();
}

/**
 * for ui show on loading app: https://github.com/crazycodeboy/react-native-splash-screen
 * */
export default class SplashScreen extends BaseComponent<Props> {
  componentDidMount(): void {
    this.getAppReady();
  }

  /**
   * Tracking status app
   * e.g: check authentication, get any resource...
   * */
  getAppReady = () => {
    Splash.hide();
    setTimeout(() => {
      this.props.goToMain();
    }, 1000);
  };

  render() {
    return <View />;
  }
}
