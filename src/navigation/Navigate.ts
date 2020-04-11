import {StackActions} from '@react-navigation/native';
import React from 'react';

const navigationRef: any = React.createRef();

/**
 * Reset all route and make current route to root
 * @param routeName Name of the route to push onto the stack
 * @param params Screen params to merge into the destination route (found in the pushed screen through route.params).
 * */
const navigateAndRest = (routeName: string, params: any = {}) => {
  params = {
    ...params,
    needTransit: true,
  };
  const resetAction = StackActions.replace(routeName, params);
  navigationRef.current && navigationRef.current.dispatch(resetAction);
};

/**
 * action adds a route on top of the stack and navigates forward to it.
 * This differs from navigate in that navigate will pop back to earlier in the stack if a route of the given name is already present there.
 * push will always add on top, so a route can be present multiple times.
 * @param routeName Name of the route to push onto the stack
 * @param params Screen params to merge into the destination route (found in the pushed screen through route.params).
 * */
const navigateTo = (routeName: string, params: any = {}) => {
  const navigateAction = StackActions.push(routeName, params);
  navigationRef.current && navigationRef.current.dispatch(navigateAction);
};

/**
 * The pop action takes you back to a previous screen in the stack.
 * @param count one optional argument, which allows you to specify how many screens to pop back by.
 * */
const goBack = (count: number = 1) => {
  const backAction = StackActions.pop(count);
  navigationRef.current && navigationRef.current.dispatch(backAction);
};

/**
 * The popToTop action takes you back to the first screen in the stack, dismissing all the others.
 * It's functionally identical to StackActions.pop({n: currentIndex})
 * */
const popToRoot = () => {
  navigationRef.current &&
    navigationRef.current.dispatch(StackActions.popToTop());
};

export {navigateAndRest, navigateTo, goBack, popToRoot, navigationRef};
