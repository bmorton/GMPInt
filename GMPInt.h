//
//  GMPInt.h
//
//  Created by Brian Morton on 4/4/11.
//  Copyright 2011 The San Diego Reader. All rights reserved.
//
//  Modeled afer: http://www.roard.com/docs/cookbook/cbsu4.html
//

#import <Foundation/Foundation.h>
#import "/usr/local/Cellar/gmp/5.0.1/include/gmp.h"

@interface GMPInt : NSObject {
    mpz_t value;
}

+ (GMPInt *)zeroObj; 
+ (GMPInt *)oneObj; 

- (GMPInt *)initWithSignedLong:(signed long)signedLong;
- (GMPInt *)initWithUnsignedLong:(unsigned long)unsignedLong;
- (GMPInt *)initWithValue:(mpz_t)val;

- (void)setUnsignedLongValue:(unsigned long)unsignedLong;

- (void)addWithGMP:(GMPInt *)op;
- (void)subtractWithGMP:(GMPInt *)op;
- (void)multiplyWithGMP:(GMPInt *)op; 
- (void)divideWithGMP:(GMPInt *)op;
- (void)modulusWithGMP:(GMPInt *)op;
- (void)powerWithUnsignedLong:(unsigned long)op;
- (void)factorial;
- (void)nextPrime;

- (NSString *)stringValue;
- (NSString *)description;
- (NSArray *)arrayValue;
- (NSNumber *)numberValue;

- (BOOL)isZero;
- (BOOL)isOne;
- (BOOL)isPrime;

- (mpz_t *)valPtr;

@end
