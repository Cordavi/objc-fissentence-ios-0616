//
//  FISSentence.m
//  objc-fissentence
//
//  Created by Michael Amundsen on 6/9/16.
//  Copyright © 2016 The Flatiron School. All rights reserved.
//

#import "FISSentence.h"

@interface FISSentence ()

- (void)assembleSentence;
- (BOOL)validWord:(NSString *)word;
- (BOOL)validPunctuation:(NSString *)punctuation;
- (BOOL)validIndex:(NSUInteger)index;

@property (strong, nonatomic, readwrite) NSString *sentence;

@end

@implementation FISSentence

- (void)assembleSentence {
    NSString *spacedWords = [self.words componentsJoinedByString:@" "];
    self.sentence = [spacedWords stringByAppendingString:self.punctuation];
}

- (BOOL)validWord:(NSString *)word {
    if (!([word length] == 0 || [word isEqualToString:@" "])) {
        return YES;
    }
    return NO;
}

- (BOOL)validPunctuation:(NSString *)punctuation {
    NSArray *validPunctuation = @[@".", @"?", @"!", @",", @";", @":", @"-"];
    if ([validPunctuation containsObject:punctuation]) {
        return YES;
    }
    return NO;
}

- (BOOL)validIndex:(NSUInteger)index {
    if (index < [self.words count]) {
        return YES;
    }
    return NO;
}

- (void)addWord:(NSString *)word {
    if ([self validWord:word]) {
        [self.words addObject:word];
    }
    [self assembleSentence];
}

- (void)addWords:(NSArray *)words withPunctuation:(NSString *)punctuation {
    if ([self validPunctuation:punctuation]) {
        for (NSString *word in words) {
            if ([self validWord:word]) {
                self.punctuation = punctuation;
                [self.words addObject:word];
            }
        }
    }
    [self assembleSentence];
}

- (void)removeWordAtIndex:(NSUInteger)index {
    if ([self validIndex:index]) {
        [self.words removeObjectAtIndex:index];
    }
    [self assembleSentence];
}

- (void)insertWord:(NSString *)word atIndex:(NSUInteger)index {
    if ([self validIndex:index] && [self validWord:word]) {
        [self.words insertObject:word atIndex:index];
    }
    [self assembleSentence];
}

- (void)replacePunctuationWithPunctuation:(NSString *)punctuation {
    if ([self validPunctuation:punctuation]) {
        self.punctuation = punctuation;
    }
    [self assembleSentence];
}

- (void)replaceWordAtIndex:(NSUInteger)index withWord:(NSString *)word {
    if ([self validIndex:index] && [self validWord:word]) {
        [self.words replaceObjectAtIndex:index withObject:word];
    }
    [self assembleSentence];
}

@end
