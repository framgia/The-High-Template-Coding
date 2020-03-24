import React from 'react';
import {View} from 'react-native';
import {BaseComponent} from '../../components';
export default class MainScreen extends BaseComponent {
  renderViewContent() {
    return <View />;
  }

  headerTitle(): string {
    return 'Main';
  }
}
