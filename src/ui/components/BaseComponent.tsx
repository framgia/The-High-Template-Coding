import React, {PureComponent, Fragment} from 'react';
import {View, StyleSheet, StatusBar, SafeAreaView} from 'react-native';
import {Header, MKeyboardShift, MDialogLoading} from '../components';

/**
 * P: your props placeholder
 * S: your state placeholder
 * */

export interface BaseProps {
  // A base props all screen need declare ...container/mapStateToProps to auto mapping props
  isLoading?: boolean;
}

class BaseComponent<P extends BaseProps = {}, S = {}> extends PureComponent<
  P,
  S
> {
  private scrollView;
  private dialogLoading?: MDialogLoading | null;
  static navigationOptions = {
    header: null,
  };

  componentDidMount(): void {
    // TODO
  }

  /**
   * Handle common logic when store change
   * - Show/Hide loading dialog when dispatch an async action
   * */
  componentDidUpdate(prevProps: Readonly<P>): void {
    if (prevProps.isLoading !== this.props.isLoading) {
      this.dialogLoading && this.dialogLoading.show(this.props.isLoading);
    }
  }

  componentWillUnmount(): void {
    // TODO
  }

  render(): React.ReactNode {
    let contentContainerStyle;
    if (this.contentContainerStyle()) {
      contentContainerStyle = {flexGrow: 1};
    }
    return (
      <Fragment>
        <StatusBar
          backgroundColor="transparent"
          translucent
          barStyle="light-content"
        />
        <View style={styles.container}>
          {this.showHeader() && <Header title={this.headerTitle()} />}
          <SafeAreaView style={{flex: 1}}>
            <MKeyboardShift
              usingScrollView={this.usingScrollView()}
              scrollRefs={ref => (this.scrollView = ref)}
              contentContainerStyle={contentContainerStyle}>
              {this.renderViewContent()}
            </MKeyboardShift>
          </SafeAreaView>
        </View>
        <MDialogLoading ref={r => (this.dialogLoading = r)} />
      </Fragment>
    );
  }

  /**
   * These styles will be applied to the scroll view content container which
   * wraps all of the child views
   * */
  contentContainerStyle(): boolean {
    return false;
  }

  showHeader(): boolean {
    return true;
  }

  headerTitle(): string {
    return '';
  }

  usingScrollView(): boolean {
    return true;
  }
  /*
   * override this method for render your screen
   * */

  // @ts-ignore
  renderViewContent(): React.ReactNode;
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default BaseComponent;
