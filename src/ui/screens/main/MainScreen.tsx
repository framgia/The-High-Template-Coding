import React from 'react';
import {Button, View} from 'react-native';
import {BaseComponent, BaseProps} from '../../components';

interface Props extends BaseProps {
  getMovies();
}

export default class MainScreen extends BaseComponent<Props> {
  componentDidMount(): void {
    super.componentDidMount();
  }

  renderViewContent() {
    return (
      <View>
        <Button
          title={'Get'}
          onPress={() => {
            this.props.getMovies();
          }}
        />
      </View>
    );
  }

  headerTitle(): string {
    return 'Main';
  }
}
