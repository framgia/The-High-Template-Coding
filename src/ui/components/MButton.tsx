import React, {PureComponent} from 'react';
import {StyleSheet, View, ViewProps} from 'react-native';
import {MTouchable, MText} from '../components';
import {Colors, Size} from '../../assets';

interface Props extends ViewProps {
  onPress?: any;
  text?: string;
  textStyles?: any;
  disable?: boolean;
  needDelay?: boolean;
}

export default class MButton extends PureComponent<Props> {
  static defaultProps = {
    onPress: f => f,
  };

  render(): React.ReactNode {
    return (
      <MTouchable
        disabled={this.props.disable}
        {...this.props}
        style={[styles.defaultButton, this.props.style]}
        onPress={() => {
          this.props.onPress();
        }}>
        <View style={[styles.viewInside, {backgroundColor: Colors.blue}]}>
          <MText style={styles.title} numberOfLines={1}>
            {this.props.text}
          </MText>
        </View>
      </MTouchable>
    );
  }
}

const styles = StyleSheet.create({
  viewInside: {
    width: '100%',
    padding: Size.SIZE_20,
    justifyContent: 'center',
    borderRadius: Size.SIZE_8,
  },
  defaultButton: {
    backgroundColor: Colors.white,
    justifyContent: 'center',
    borderRadius: Size.SIZE_8,
  },
  title: {
    textAlign: 'center',
    color: Colors.white,
  },
});
