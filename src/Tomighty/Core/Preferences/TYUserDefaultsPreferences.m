//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYUserDefaultsPreferences.h"
#import "TYEventBus.h"

NSString * const PREF_TIME_POMODORO            = @"org.tomighty.time.pomodoro";
NSString * const PREF_TIME_SHORT_BREAK         = @"org.tomighty.time.short_break";
NSString * const PREF_TIME_LONG_BREAK          = @"org.tomighty.time.long_break";
NSString * const PREF_PLAY_SOUND_WHEN_TIMER_STARTS        = @"org.tomighty.sound.play_on_timer_start";
NSString * const PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF         = @"org.tomighty.sound.play_on_timer_stop";
NSString * const PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO  = @"org.tomighty.sound.play_tick_tock_during_pomodoro";
NSString * const PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK     = @"org.tomighty.sound.play_tick_tock_during_break";
NSString * const PREF_STATUS_ICON_TIME_FORMAT     = @"org.tomighty.general.status_icon_time_format";
NSString * const PREF_AUTO_POMODORO_TRAANSITION = @"org.tomighty.general.auto_pomodoro_transition";


// formats must have same values as TYAppUIStatusIconTextFormat enum in TYAppUI.h
// TODO : move this values to some common place?
int const PREF_STATUS_ICON_TIME_FORMAT_NONE = 0;
int const PREF_STATUS_ICON_TIME_FORMAT_MINUTES = 1;
int const PREF_STATUS_ICON_TIME_FORMAT_SECONDS = 2;

@implementation TYUserDefaultsPreferences
{
    id <TYEventBus> eventBus;
}

- (id)initWith:(id <TYEventBus>)anEventBus
{
    self = [super init];
    if(self)
    {
        eventBus = anEventBus;
        
        NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
        
        [defaultValues setObject:@25    forKey:PREF_TIME_POMODORO];
        [defaultValues setObject:@5     forKey:PREF_TIME_SHORT_BREAK];
        [defaultValues setObject:@15    forKey:PREF_TIME_LONG_BREAK];
        [defaultValues setObject:@YES   forKey:PREF_PLAY_SOUND_WHEN_TIMER_STARTS];
        [defaultValues setObject:@YES   forKey:PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF];
        [defaultValues setObject:@YES   forKey:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO];
        [defaultValues setObject:@YES   forKey:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK];
        [defaultValues setObject:@YES   forKey:PREF_AUTO_POMODORO_TRAANSITION];
        [defaultValues setObject:[NSNumber numberWithInt:PREF_STATUS_ICON_TIME_FORMAT_NONE] forKey:PREF_STATUS_ICON_TIME_FORMAT];

        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    }
    return self;
}

- (int)getInt:(NSString *)key
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:key];
}

- (void)setInt:(NSString *)key value:(int)value
{
    int actualValue = [self getInt:key];
    if(value != actualValue)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [eventBus publish:PREFERENCE_CHANGE data:key];
    }
}

@end
