// Copyright 2018-present 650 Industries. All rights reserved.

#import <objc/runtime.h>
#import <React/RCTFont.h>

#import <ExpoModulesCore/EXDefines.h>
#import <ExpoModulesCore/EXReactFontManager.h>
#import <ExpoModulesCore/EXFontProcessorInterface.h>
#import <ExpoModulesCore/EXFontManagerInterface.h>
#import <ExpoModulesCore/EXAppLifecycleService.h>


/**
 * This class is responsible for allowing other modules to register as font processors in React Native.
 *
 * A font processor is an object conforming to EXFontProcessorInterface and is capable of
 * providing an instance of UIFont for given (family, size, weight, style, variant, scaleMultiplier).
 *
 * To be able to hook into React Native's way of processing fonts we:
 *  - add a new class method to RCTFont, `EXUpdateFont:withFamily:size:weight:style:variant:scaleMultiplier`
 *    with EXReactFontManager category.
 *  - add a new static variable `currentFontProcessors` holding an array of... font processors. This variable
 *    is shared between the RCTFont's category and EXReactFontManager class.
 *  - when EXReactFontManager is initialized, we exchange implementations of RCTFont.updateFont...
 *    and RCTFont.EXUpdateFont... After the class initialized, which happens only once, calling `RCTFont updateFont`
 *    calls in fact implementation we've defined up here and calling `RCTFont EXUpdateFont` falls back
 *    to the default implementation. (This is why we call `[self EXUpdateFont]` at the end of that function,
 *    though it seems like an endless loop, in fact we dispatch to another implementation.)
 *  - When some module adds a font processor using EXFontManagerInterface, EXReactFontManager adds a weak pointer to it
 *    to currentFontProcessors array.
 *  - Implementation logic of `RCTFont.EXUpdateFont` uses current value of currentFontProcessors when processing arguments.
 */

@interface EXReactFontManager ()

@property (nonatomic, strong) NSMutableSet *fontProcessors;

@end

@implementation EXReactFontManager

@end
