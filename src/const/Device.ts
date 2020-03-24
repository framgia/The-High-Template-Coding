import {Dimensions, Platform} from 'react-native';
import {Size} from '../assets';

const topBarHeight = Size.SIZE_50;
const screenWidth = Dimensions.get('window').width;
const screenHeight = Dimensions.get('window').height;
const isIphoneX = !!(
  Platform.OS === 'ios' &&
  (screenHeight > Size.SIZE_800 || screenWidth > Size.SIZE_800)
);
const statusBarHeight =
  Platform.OS === 'ios' && isIphoneX ? Size.SIZE_30 : Size.SIZE_20;

const headerHeight = statusBarHeight + topBarHeight;

export const Device = {
  statusBarHeight,
  topBarHeight,
  screenWidth,
  screenHeight,
  isIphoneX,
  headerHeight,
};
