import {connect} from 'react-redux';
import MainScreen from './MainScreen';
import {getMovies} from './Action';
const mapStateToProps = (state: any) => ({});

const mapDispatchToProps = (dispatch: any) => ({
  getMovies: () => dispatch(getMovies()),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(MainScreen);
