//
//  GMPInt.m
//
//  Created by Brian Morton on 4/4/11.
//  Copyright 2011 The San Diego Reader. All rights reserved.
//
//  Modeled afer: http://www.roard.com/docs/cookbook/cbsu4.html
//

#import "GMPInt.h"


@implementation GMPInt

+ (GMPInt *)zeroObj {
	return [[GMPInt alloc] initWithSignedLong:0];
} 

+ (GMPInt *)oneObj {
	return [[GMPInt alloc] initWithSignedLong:1];
}

- (GMPInt *)initWithSignedLong:(signed long)signedLong {
	self = [self init];
	mpz_init_set_si(value, signedLong);
	return self;
}

- (GMPInt *)initWithUnsignedLong:(unsigned long)unsignedLong {
	self = [self init];
	mpz_init_set_si(value, unsignedLong);
	return self;
}

- (GMPInt *)initWithValue:(mpz_t)val {
	mpz_set(value, val);
	[self autorelease];
	return self;
}

- (void)addWithGMP:(GMPInt *)op {
	mpz_t *rptr = [self valPtr];
	mpz_add(*rptr, value, *[op valPtr]);
}

- (void)subtractWithGMP:(GMPInt *)op {
	mpz_t *rptr = [self valPtr];
	mpz_sub(*rptr, value, *[op valPtr]);
}

- (void)multiplyWithGMP:(GMPInt *)op {
	mpz_t *rptr = [self valPtr];
	mpz_mul(*rptr, value, *[op valPtr]);
}

- (void)divideWithGMP:(GMPInt *)op {
	mpz_t *rptr = [self valPtr];
	mpz_tdiv_q(*rptr, value, *[op valPtr]);
}

- (void)modulusWithGMP:(GMPInt *)op {
	mpz_t *rptr = [self valPtr];
	mpz_mod(*rptr, value, *[op valPtr]);
}

- (void)powerWithUnsignedLong:(unsigned long)op {
	mpz_t *rptr = [self valPtr];
	mpz_pow_ui(*rptr, value, op);
}

- (void)factorial {
	mpz_t *rptr = [self valPtr];
	mpz_fac_ui(*rptr, mpz_get_ui(*rptr));
}

- (void)nextPrime {
	mpz_t *valuePointer = [self valPtr];
	mpz_nextprime(*valuePointer, *valuePointer);
}

- (NSString *)stringValue {
	NSZone *dz = NSDefaultMallocZone();
	
	char *buf = NSZoneMalloc(dz, mpz_sizeinbase(value, 10)+2);
	mpz_get_str(buf, 10, value);
	NSString *integerString = [NSString stringWithCString:buf encoding:NSUTF8StringEncoding];
	
	NSZoneFree(dz, buf);
	
	return integerString;
}

- (NSString *)description {
	return [self stringValue];
}

- (NSArray *)arrayValue {
	NSString *digits = [self stringValue];
	char ch;
	NSMutableArray *digitsArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < [digits length]; i++) {
		ch = [digits characterAtIndex:i];
		[digitsArray addObject:[NSNumber numberWithInt:((int)ch - '0')]];
	}
	
	return [[NSArray alloc] initWithArray:digitsArray];
}

- (NSNumber *)numberValue {
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *numberValue = [formatter numberFromString:[self stringValue]];
	[formatter release];
	return numberValue;
}

- (BOOL)isZero {
	return (!mpz_cmp_ui(value, 0) ? YES : NO);
}

- (BOOL)isOne {
	return (!mpz_cmp_ui(value, 1) ? YES : NO);
}

- (mpz_t *)valPtr {
	return &value;
}

- (void)dealloc {
	mpz_clear(value);
	[super dealloc];
}

@end
