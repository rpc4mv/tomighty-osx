//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TYEventType)
{
    APP_INIT                  = 0,
    
    TIMER_START               = 1,
    TIMER_TICK                = 2,
    TIMER_STOP                = 3,
    TIMER_ABORT               = 4,
    TIMER_GOES_OFF            = 5,
    TIMER_PAUSED              = 6,
    TIMER_RESUMED             = 7,
    
    POMODORO_START            = 8,
    BREAK_START               = 9,
    SHORT_BREAK_START         = 10,
    LONG_BREAK_START          = 11,
    
    POMODORO_COMPLETE         = 12,
    POMODORO_COUNT_CHANGE     = 13,
    
    PREFERENCE_CHANGE         = 14
};

typedef void (^TYEventSubscriber)(id eventData);

@protocol TYEventBus <NSObject>

- (void)subscribeTo:(TYEventType)eventType subscriber:(TYEventSubscriber)subscriber;
- (void)publish:(TYEventType)eventType data:(id)data;

@end
