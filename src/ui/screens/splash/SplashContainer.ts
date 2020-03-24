import {connect} from 'react-redux';
import SplashScreen from './SplashScreen';
import {navigateTo} from '../../../navigation/Navigate';
import SCREEN_NAME from '../../screens/Const';
const mapStateToProps = (state: any) => ({});

const mapDispatchToProps = (dispatch: any, ownProps: any) => ({
  goToMain: () => navigateTo(ownProps.navigation.dispatch, SCREEN_NAME.MAIN_SCREEN),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(SplashScreen);
