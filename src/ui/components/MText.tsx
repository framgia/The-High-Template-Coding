import React, {PureComponent} from 'react';
import {Text, TextProps} from 'react-native';

interface Props extends TextProps {
  isRequired?: boolean;
}

export default class SSKText extends PureComponent<Props> {
  render(): React.ReactNode {
    return <Text {...this.props}>{this.props.children}</Text>;
  }
}
