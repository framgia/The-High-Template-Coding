import {StackActions} from '@react-navigation/native';

const navigateAndRest = (
  dispatch: any,
  routeName: string,
  params: any = {},
) => {
  params = {
    ...params,
    needTransit: true,
  };
  const resetAction = StackActions.replace(routeName, params);
  dispatch(resetAction);
};

const navigateTo = (dispatch: any, routeName: string, params: any = {}) => {
  const navigateAction = StackActions.push(routeName, params);
  dispatch(navigateAction);
};

const goBack = (dispatch: any) => {
  const backAction = StackActions.pop();
  dispatch(backAction);
};

const popToRoot = (dispatch: any) => {
  dispatch(StackActions.popToTop());
};

export {navigateAndRest, navigateTo, goBack, popToRoot};
