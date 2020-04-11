import React, {PureComponent} from 'react';
import {
  Keyboard,
  TouchableOpacity,
  TouchableOpacityProps,
  ViewProps,
} from 'react-native';

interface Props extends TouchableOpacityProps {}

interface Props extends ViewProps {
  onPress?: any;
  needDelay?: boolean;
}
/**
 * A component base on #TouchableOpacity
 * - Handle dismiss keyboard before do action
 * - Handle delay between press
 * */
export default class MTouchable extends PureComponent<Props> {
  disabled = false;
  keyboardDidShowListener;
  keyboardDidHideListener;
  keyboardIsShowing = false;
  componentDidMount(): void {
    this.keyboardDidShowListener = Keyboard.addListener(
      'keyboardDidShow',
      () => (this.keyboardIsShowing = true),
    );
    this.keyboardDidHideListener = Keyboard.addListener(
      'keyboardDidHide',
      () => (this.keyboardIsShowing = false),
    );
  }

  componentWillUnmount(): void {
    this.keyboardDidShowListener.remove();
    this.keyboardDidHideListener.remove();
  }

  doAction = () => {
    this.props.onPress && this.props.onPress();
    if (this.props.needDelay) {
      setTimeout(() => (this.disabled = false), 1000);
    }
  };

  render(): React.ReactNode {
    return (
      <TouchableOpacity
        accessibilityTraits={'button'}
        activeOpacity={0.8}
        {...this.props}
        onPress={() => {
          if (this.disabled && this.props.needDelay) {
            return;
          }
          this.disabled = true;
          const timeOut = this.keyboardIsShowing ? 50 : 0;
          Keyboard.dismiss();
          setTimeout(() => {
            this.doAction();
          }, timeOut);
        }}>
        {this.props.children}
      </TouchableOpacity>
    );
  }
}
