//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>

@protocol TYTomighty <NSObject>

- (void)startPomodoro;
- (void)startShortBreak;
- (void)startLongBreak;
- (void)stopTimer;
- (void)pauseTimer;
- (void)resetPomodoroCount;

@end
