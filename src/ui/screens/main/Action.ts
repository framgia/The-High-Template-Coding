import Action from '../../../saga/Action';
const getMovies = () => {
  return {
    type: Action.MOVIES.value,
  };
};

export {getMovies};
