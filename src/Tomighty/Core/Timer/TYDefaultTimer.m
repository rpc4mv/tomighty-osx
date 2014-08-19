//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYEventBus.h"
#import "TYDefaultTimer.h"
#import "TYTimerContext.h"

@implementation TYDefaultTimer
{
    id<TYEventBus> eventBus;
    id<TYSystemTimer> systemTimer;
    id<TYTimerContext> currentTimerContext;
    BOOL isPaused;
}

+ (id)createWith:(id<TYEventBus>)anEventBus systemTimer:(id<TYSystemTimer>)aSystemTimer
{
    return [[TYDefaultTimer alloc] initWith:anEventBus systemTimer:aSystemTimer];
}

- (id)initWith:(id<TYEventBus>)anEventBus systemTimer:(id<TYSystemTimer>)aSystemTimer
{
    self = [super init];
    if(self)
    {
        eventBus = anEventBus;
        systemTimer = aSystemTimer;
    }
    return self;
}

- (void)start:(id<TYTimerContext>)context
{
    currentTimerContext = context;
    
    [self setTrigger];
    
    [eventBus publish:TIMER_START data:context];
}

- (void)stop
{
    [systemTimer interrupt];
    [eventBus publish:TIMER_STOP data:currentTimerContext];
}

- (void)togglePause
{
    isPaused ? [self resume] : [self pause];
    
    isPaused = !isPaused;
}

- (void)pause
{
    if(!isPaused) [systemTimer interrupt];
}

- (void)resume
{
    if(isPaused) [self setTrigger];
}

- (void)setTrigger
{
    TYSystemTimerTrigger trigger = ^()
    {
        [currentTimerContext addSeconds:-1];
        
        if([currentTimerContext getRemainingSeconds] > 0)
        {
            [eventBus publish:TIMER_TICK data:currentTimerContext];
        }
        else
        {
            [self stop];
        }
    };
    [systemTimer triggerRepeatedly:trigger intervalInSeconds:1];
}

@end
