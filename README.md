# react-native-gdk-ios-legacy
React Native GDK native module (legacy)

## Steps taken to make this lib
- Use [react-native-builder-bob](https://github.com/callstack/react-native-builder-bob)
  - `npx create-react-native-library@latest gdk-ios-legacy`
  - Select "Native module" > "Java & Swift"

- Replace default code with GDK code

- Create script `fetch-gdk-binaries.sh`
- Run `bash ./fetch-gdk-binaries.sh --simulator`

- In Xcode
  - Add file GreenAddress.swift
  - Add `$(SRCROOT)/../gdk-iphone/lib/iphone/libgreenaddress_full.a` to Header search paths
  - Add `$(SRCROOT)/../gdk-iphone/lib/iphone/libgreenaddress_full.a` to Other Linker Flags
  - Add `$(SRCROOT)/../gdk-iphone/lib/iphone/libgreenaddress_full.a` and `$(SRCROOT)/../gdk-iphone/include/gdk/libwally-core` to Swift Compiler - Search Paths > Import Paths

## Build project
- `cd example && bundle install && cd ios && bundle exec pod install && cd ../..` to avoid error "Could not find proper version of cocoapods (1.11.3) in any of the sources"
- yarn

## Run app
yarn example ios

## Installation

```sh
npm install react-native-gdk-ios-legacy
```

## Usage

```js
import { generateMnemonic12 } from "react-native-gdk-ios-legacy";

// ...

const result = await generateMnemonic12();
```
