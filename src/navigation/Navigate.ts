import {StackActions} from '@react-navigation/native';
import React from 'react';

const navigationRef: any = React.createRef();

const navigateAndRest = (routeName: string, params: any = {}) => {
  params = {
    ...params,
    needTransit: true,
  };
  const resetAction = StackActions.replace(routeName, params);
  navigationRef.current && navigationRef.current.dispatch(resetAction);
};

const navigateTo = (routeName: string, params: any = {}) => {
  const navigateAction = StackActions.push(routeName, params);
  navigationRef.current && navigationRef.current.dispatch(navigateAction);
};

const goBack = () => {
  const backAction = StackActions.pop();
  navigationRef.current && navigationRef.current.dispatch(backAction);
};

const popToRoot = () => {
  navigationRef.current &&
    navigationRef.current.dispatch(StackActions.popToTop());
};

export {navigateAndRest, navigateTo, goBack, popToRoot, navigationRef};
