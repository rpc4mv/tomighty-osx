//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>

extern NSString * const PREF_TIME_POMODORO;
extern NSString * const PREF_TIME_SHORT_BREAK;
extern NSString * const PREF_TIME_LONG_BREAK;
extern NSString * const PREF_PLAY_SOUND_WHEN_TIMER_STARTS;
extern NSString * const PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF;
extern NSString * const PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO;
extern NSString * const PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK;
extern NSString * const PREF_STATUS_ICON_TIME_FORMAT;
extern NSString * const PREF_AUTO_POMODORO_TRAANSITION;

extern int const PREF_STATUS_ICON_TIME_FORMAT_NONE;
extern int const PREF_STATUS_ICON_TIME_FORMAT_MINUTES;
extern int const PREF_STATUS_ICON_TIME_FORMAT_SECONDS;

@protocol TYPreferences <NSObject>

- (int)getInt:(NSString *)key;
- (void)setInt:(NSString *)key value:(int)value;

@end
