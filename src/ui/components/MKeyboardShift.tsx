import React, {PureComponent} from 'react';
import {
  Animated,
  Dimensions,
  Keyboard,
  Platform,
  ScrollView,
  StyleSheet,
  TextInput,
  UIManager,
  View,
  ViewProps,
} from 'react-native';
import {Size} from '../../assets';
const {State: TextInputState} = TextInput;

interface Props extends ViewProps {
  contentContainerStyle: any;
  scrollRefs(scrollView);
  usingScrollView: boolean;
}

export default class MKeyboardShift extends PureComponent<Props> {
  state = {
    shift: new Animated.Value(0),
    bottom: 0,
  };
  // listen keyboard for handling scroll view
  keyboardDidShowSub;
  keyboardDidHideSub;
  // ScrollView instance
  scrollView;
  // Scroll handler
  scrollY = 0;
  append;
  scrollYBefore;
  isHideKeyboard;
  y;
  //=====
  // check child scrollable
  parentHeight = 0;
  childHeight = 0;
  componentDidMount() {
    this.keyboardDidShowSub = Keyboard.addListener(
      'keyboardDidShow',
      this.handleKeyboardDidShow,
    );
    this.keyboardDidHideSub = Keyboard.addListener(
      Platform.OS === 'ios' ? 'keyboardWillHide' : 'keyboardDidHide',
      this.handleKeyboardDidHide,
    );
  }

  componentWillUnmount() {
    this.keyboardDidShowSub.remove();
    this.keyboardDidHideSub.remove();
  }

  render() {
    return (
      <View
        style={styles.container}
        onLayout={e => {
          this.parentHeight = e.nativeEvent.layout.height;
        }}>
        {this.props.usingScrollView ? (
          <ScrollView
            onScroll={event => {
              if (this.state.bottom) {
                this.append = event.nativeEvent.contentOffset.y - this.y;
              }
              this.scrollY = event.nativeEvent.contentOffset.y;
              if (
                this.isHideKeyboard &&
                this.scrollY === 0 &&
                this.state.bottom > 0
              ) {
                this.setState({
                  bottom: 0,
                });
              }
            }}
            scrollEventThrottle={1}
            ref={ref => {
              this.scrollView = ref;
              this.props.scrollRefs(ref);
            }}
            alwaysBounceVertical={false}
            keyboardShouldPersistTaps="handled"
            keyboardDismissMode="interactive"
            contentContainerStyle={this.props.contentContainerStyle}>
            {this.props.children}
            <View
              onLayout={e => {
                this.childHeight = e.nativeEvent.layout.y;
              }}
              style={{height: Platform.OS === 'ios' ? this.state.bottom : 0}}
            />
          </ScrollView>
        ) : (
          this.props.children
        )}
      </View>
    );
  }

  handleKeyboardDidShow = event => {
    this.scrollYBefore = 0;
    try {
      if (!this.scrollView) {
        return;
      }
      const keyboardHeight = event.endCoordinates.height;
      this.setState({
        bottom: keyboardHeight,
      });
      const {height: windowHeight} = Dimensions.get('window');
      const currentlyFocusedField = TextInputState.currentlyFocusedField();
      if (currentlyFocusedField) {
        UIManager.measure(
          currentlyFocusedField,
          (originX, originY, width, height, pageX, pageY) => {
            const fieldHeight = height;
            const fieldTop = pageY;
            const gap =
              windowHeight - keyboardHeight - (fieldTop + fieldHeight);
            if (gap >= 0) {
              return;
            }
            this.y =
              this.scrollY +
              keyboardHeight -
              (windowHeight - pageY) +
              Size.SIZE_40;
            this.scrollYBefore = this.scrollY;
            this.scrollView.scrollTo({
              x: 0,
              y: this.y,
              animated: true,
            });
          },
        );
      }
    } catch (e) {
      this.handleKeyboardDidHide();
    }
  };
  handleKeyboardDidHide = () => {
    this.isHideKeyboard = true;
    if (
      this.scrollView &&
      Platform.OS === 'ios' &&
      this.childHeight <= this.parentHeight
    ) {
      this.scrollView.scrollTo({
        x: 0,
        y: 0,
        animated: true,
      });
      return;
    }
    this.setState({
      bottom: 0,
    });
  };

  componentDidUpdate(): void {
    if (this.scrollYBefore && this.isHideKeyboard) {
      this.isHideKeyboard = false;
      setTimeout(() => {
        this.scrollY = this.scrollYBefore + this.append;
        this.scrollView.scrollTo({
          x: 0,
          y: this.scrollY,
          animated: true,
        });
      }, 0);
    }
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
