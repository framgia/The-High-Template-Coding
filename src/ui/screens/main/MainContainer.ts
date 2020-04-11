import {connect} from 'react-redux';
import MainScreen from './MainScreen';
import {getMovies} from './Action';
const mapStateToProps = (state: any) => ({
  isLoading: state.main.isLoading,
  data: state.main.data,
});

const mapDispatchToProps = (dispatch: any) => ({
  getMovies: () => dispatch(getMovies()),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(MainScreen);
