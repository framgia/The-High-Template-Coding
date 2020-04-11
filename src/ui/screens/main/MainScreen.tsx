import React from 'react';
import {View, StyleSheet} from 'react-native';
import {
  BaseComponent,
  BaseProps,
  MList,
  MText,
  MButton,
} from '../../components';
import {Colors, FontSize, Size} from '../../../assets';
import i18next from '../../../lang';
interface Props extends BaseProps {
  getMovies();
  data: any;
}

export default class MainScreen extends BaseComponent<Props> {
  usingScrollView(): boolean {
    return false;
  }

  renderViewContent() {
    const {movies = []} = this.props.data || {};
    return (
      <View style={styles.container}>
        <MButton
          text={i18next.t('Get')}
          onPress={() => {
            this.props.getMovies();
          }}
        />
        <MList data={movies} renderItem={this.renderItemMovies} />
      </View>
    );
  }

  renderItemMovies = ({item}) => {
    return (
      <MText style={styles.item}>{`${item.title} - ${item.releaseYear}`}</MText>
    );
  };

  headerTitle(): string {
    return i18next.t('Main');
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: Size.SIZE_10,
  },
  button: {
    flex: 1,
    backgroundColor: Colors.red,
    padding: Size.SIZE_16,
    alignContent: 'center',
    textAlign: 'center',
  },
  item: {
    padding: Size.SIZE_10,
    fontSize: FontSize.FONT_SIZE_15,
  },
});
