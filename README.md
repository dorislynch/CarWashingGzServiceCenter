
# react-native-car-washing-gz-service-center

## Getting started

`$ npm install react-native-car-washing-gz-service-center --save`

### Mostly automatic installation

`$ react-native link react-native-car-washing-gz-service-center`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-car-washing-gz-service-center` and add `RNCarWashingGzServiceCenter.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNCarWashingGzServiceCenter.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNCarWashingGzServiceCenterPackage;` to the imports at the top of the file
  - Add `new RNCarWashingGzServiceCenterPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-car-washing-gz-service-center'
  	project(':react-native-car-washing-gz-service-center').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-car-washing-gz-service-center/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-car-washing-gz-service-center')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNCarWashingGzServiceCenter.sln` in `node_modules/react-native-car-washing-gz-service-center/windows/RNCarWashingGzServiceCenter.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Car.Washing.Gz.Service.Center.RNCarWashingGzServiceCenter;` to the usings at the top of the file
  - Add `new RNCarWashingGzServiceCenterPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNCarWashingGzServiceCenter from 'react-native-car-washing-gz-service-center';

// TODO: What to do with the module?
RNCarWashingGzServiceCenter;
```
  