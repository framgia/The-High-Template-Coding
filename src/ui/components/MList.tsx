import {FlatList, FlatListProps} from 'react-native';
import React, {PureComponent} from 'react';

interface Props extends FlatListProps<any> {
  loadMore?: Function;
}

export default class SSKList extends PureComponent<Props> {
  render() {
    return (
      <FlatList
        keyExtractor={(item, index) => item + index}
        {...this.props}
        onEndReached={() => {
          this.props.loadMore && this.props.loadMore();
        }}
        onEndReachedThreshold={0}
      />
    );
  }
}
