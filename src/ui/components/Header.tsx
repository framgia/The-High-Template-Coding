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
        <View style={styles.headerContainer}>
          <View style={styles.viewTitle}>
            <MText numberOfLines={1} style={styles.title}>
              {this.props.title}
            </MText>
          </View>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    paddingTop: Device.statusBarHeight,
    height: Device.headerHeight,
    justifyContent: 'space-between',
    flexDirection: 'row',
    backgroundColor: Colors.black,
  },
  headerContainer: {
    flex: 1,
    height: Device.topBarHeight,
  },
  title: {
    color: Colors.white,
    fontSize: FontSize.FONT_SIZE_16,
    textAlign: 'center',
    fontWeight: 'bold',
  },
  viewTitle: {
    flex: 1,
    width: '100%',
    height: '100%',
    position: 'absolute',
    justifyContent: 'center',
  },
});
