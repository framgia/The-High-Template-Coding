import React, {PureComponent} from 'react';
import {Animated, View} from 'react-native';
import {Colors, Size} from '../../assets';

interface Props {
  numberOfDots?: number;
  animationDelay?: number;
  minOpacity?: number;
  style?: any;
}

export default class SSKAnimatedEllipsis extends PureComponent<Props, any> {
  static defaultProps = {
    numberOfDots: 4,
    animationDelay: 100,
    minOpacity: 0.1,
    style: {
      alignSelf: 'center',
      flexDirection: 'row',
      width: Size.SIZE_60,
      borderRadius: Size.SIZE_30,
    },
  };

  _animation_state: any;

  constructor(props: Props) {
    super(props);
    this._animation_state = {
      dot_opacities: this.initializeDots(),
      target_opacity: 1,
      should_animate: true,
    };
  }

  initializeDots() {
    let opacities = [];
    let numDot = this.props.numberOfDots || 4;
    let minOpacity = this.props.minOpacity || 0.1;
    for (let i = 0; i < numDot; i++) {
      let dot = new Animated.Value(minOpacity);
      // @ts-ignore
      opacities.push(dot);
    }

    return opacities;
  }

  componentDidMount() {
    this.animate_dots.bind(this)(0);
  }

  componentWillUnmount() {
    this._animation_state.should_animate = false;
  }

  animate_dots(which_dot: any) {
    if (!this._animation_state.should_animate) {
      return;
    }
    if (which_dot >= this._animation_state.dot_opacities.length) {
      which_dot = 0;
      let min = this.props.minOpacity;
      this._animation_state.target_opacity =
        this._animation_state.target_opacity == min ? 1 : min;
    }

    let next_dot = which_dot + 1;

    Animated.timing(this._animation_state.dot_opacities[which_dot], {
      toValue: this._animation_state.target_opacity,
      duration: this.props.animationDelay,
    }).start(this.animate_dots.bind(this, next_dot));
  }

  render() {
    const dots = this._animation_state.dot_opacities.map((o: any, i: any) => (
      <Animated.View
        key={i}
        style={{
          opacity: o,
          margin: Size.SIZE_4,
          width: Size.SIZE_6,
          height: Size.SIZE_6,
          backgroundColor: Colors.red,
          borderRadius: Size.SIZE_4,
        }}
      />
    ));
    return <View style={this.props.style}>{dots}</View>;
  }
}
