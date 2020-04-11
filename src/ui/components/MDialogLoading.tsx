import React, {PureComponent} from 'react';
import {MModal, MAnimatedEllipsis} from '../components';
import {ViewProps} from 'react-native';

interface Props extends ViewProps {
  onClosing?: Function;
}

interface State {
  isShow: boolean;
}

export default class MDialogLoading extends PureComponent<Props, State> {
  timeOut;
  state = {
    isShow: false,
  };

  show = (isShow: boolean = false) => {
    this.timeOut && clearTimeout(this.timeOut);
    if (isShow) {
      this.timeOut = setTimeout(() => {
        this.show(false);
      }, 10000);
    }
    this.setState({
      isShow,
    });
  };

  isShowing = () => this.state.isShow;

  componentWillUnmount(): void {
    this.timeOut && clearTimeout(this.timeOut);
  }

  render(): React.ReactElement {
    return (
      <MModal visible={this.state.isShow}>
        <MAnimatedEllipsis />
      </MModal>
    );
  }
}
