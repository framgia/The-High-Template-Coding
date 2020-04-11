import React from 'react';
import {createStackNavigator} from '@react-navigation/stack';
import {NavigationContainer} from '@react-navigation/native';
import SCREEN_NAME from '../ui/screens/Const';
import SplashContainer from '../ui/screens/splash/SplashContainer';
import MainContainer from '../ui/screens/main/MainContainer';
import {navigationRef} from '../navigation/Navigate';

/**
 * Declare all screen on your project
 * To navigate between screens using functions on #Navigate
 * */
const AppStackNavigator = () => {
  const Stack = createStackNavigator();
  return (
    // @ts-ignore
    <NavigationContainer ref={navigationRef}>
      <Stack.Navigator
        initialRouteName={SCREEN_NAME.SPLASH_SCREEN}
        screenOptions={{
          headerShown: false,
        }}>
        <Stack.Screen
          name={SCREEN_NAME.SPLASH_SCREEN}
          component={SplashContainer}
        />
        <Stack.Screen
          name={SCREEN_NAME.MAIN_SCREEN}
          component={MainContainer}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
};

export default AppStackNavigator;
