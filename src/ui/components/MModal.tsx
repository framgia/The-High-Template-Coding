import React, {FunctionComponent} from 'react';
import {StyleSheet, View} from 'react-native';

interface SSKModalProps {
  visible: boolean;
  customStyle?: any;
}

const MModal: FunctionComponent<SSKModalProps> = props => {
  let styleModalContainer = props.customStyle || styles.container;
  return props.visible ? (
    <View style={styleModalContainer}>{props.children}</View>
  ) : null;
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    width: '100%',
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center',
    position: 'absolute',
    zIndex: 999,
    backgroundColor: 'rgba(52,52,52,0.5)',
  },
});

export default MModal;
