//
//  UIControl+DNSound.m
//  DNCategory
//
//  Created by mainone on 16/6/6.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "UIControl+DNSound.h"
#import <objc/runtime.h>

static char const * const SoundsKey = "DNSoundsKey";

@implementation UIControl (DNSound)

- (void)setSoundName:(NSString *)name forControlEvent:(UIControlEvents)controlEvent {
    NSString *oldSoundKey   = [NSString stringWithFormat:@"%lu", (unsigned long)controlEvent];
    AVAudioPlayer *oldSound = [self sounds][oldSoundKey];
    [self removeTarget:oldSound action:@selector(play) forControlEvents:controlEvent];

    [[AVAudioSession sharedInstance] setCategory:@"AVAudioSessionCategoryAmbient" error:nil];
    
    NSString *file      = [name stringByDeletingPathExtension];
    NSString *extension = [name pathExtension];
    NSURL *soundFileURL = [[NSBundle mainBundle] URLForResource:file withExtension:extension];
    
    NSError *error              = nil;
    AVAudioPlayer *tapSound     = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    NSString *controlEventKey   = [NSString stringWithFormat:@"%lu", (unsigned long)controlEvent];
    NSMutableDictionary *sounds = [self sounds];
    [sounds setObject:tapSound forKey:controlEventKey];
    [tapSound prepareToPlay];
    if (!tapSound) {
        NSLog(@"Couldn't add sound - error: %@", error);
        return;
    }
    [self addTarget:tapSound action:@selector(play) forControlEvents:controlEvent];
}

#pragma mark - Associated objects setters/getters
- (void)setSounds:(NSMutableDictionary *)sounds {
    objc_setAssociatedObject(self, SoundsKey, sounds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)sounds {
    NSMutableDictionary *sounds = objc_getAssociatedObject(self, SoundsKey);
    if (!sounds) {
        sounds = [[NSMutableDictionary alloc] initWithCapacity:2];
        [self setSounds:sounds];
    }
    return sounds;
}


@end
