import React, {PureComponent} from 'react';
import {View, StyleSheet, ViewProps} from 'react-native';
import {Device} from '../../const/Device';
import {FontSize, Colors} from '../../assets';
import {MText} from './index';

interface Props extends ViewProps {
  title?: string;
}

export default class Header extends PureComponent<Props> {
  render(): React.ReactNode {
    return (
      <View style={styles.container}>
        <View style={styles.viewTitle}>
          <MText numberOfLines={1} style={styles.title}>
            {this.props.title}
          </MText>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    marginTop: Device.statusBarHeight,
    height: Device.topBarHeight,
    justifyContent: 'space-between',
    flexDirection: 'row',
    backgroundColor: Colors.black,
  },
  title: {
    color: Colors.white,
    fontSize: FontSize.FONT_SIZE_16,
    textAlign: 'center',
    fontWeight: 'bold',
    flex: 1,
  },
  viewTitle: {
    flex: 1,
    position: 'absolute',
    justifyContent: 'center',
  },
});
