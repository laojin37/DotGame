//
//  ScoreManager.m
//  fruitGame
//
//  Created by KCU on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScoreManager.h"

#define kDataBaseName	@"score.SQLite"

@implementation ScoreManager

static ScoreManager *_sharedScore = nil;

+ (ScoreManager*) sharedScoreManager 
{
	if (!_sharedScore) 
	{
		_sharedScore = [[ScoreManager alloc] init];
	}
	
	return _sharedScore;
}

+ (void) releaseScoreManager 
{
	if (_sharedScore) 
	{
		[_sharedScore release];
		_sharedScore = nil;
	}
}

- (id) init
{
	if ( (self=[super init]) )
	{
		m_sqlManager = [[SQLDatabase alloc] init];
		[m_sqlManager initWithDynamicFile: kDataBaseName];
	}
	
	return self;
}

- (NSArray*) loadZooElements {
	return [m_sqlManager lookupAllForSQL: @"select * from tbl_zoo order by z desc"];
}

- (void) deleteElement: (int) nId {
	[m_sqlManager runDynamicSQL: [NSString stringWithFormat: @"delete from tbl_zoo where id=%d", nId] 
					   forTable: @"tbl_zoo"];	
}

- (void) updateZOfElement: (int) nId z:(int) z {
	NSMutableString* strSQL = [[NSMutableString alloc] init];	
	[strSQL appendFormat: @"update '%@' set ", @"tbl_zoo"];
	[strSQL appendFormat: @"z='%d' ", z];
	[strSQL appendFormat: @" where id=%d", nId];
	
	[m_sqlManager runDynamicSQL: strSQL forTable: @"tbl_zoo"];	
	[strSQL release];		
}

- (void) resortZOfElement {
	NSMutableArray* backArray = [NSMutableArray arrayWithCapacity: 10];
	NSArray* array = [self loadZooElements];
	int i, j;
	
	for (i = 0; i < [array count]; i ++) {
		NSDictionary* dic = [array objectAtIndex: i];
		float y = [[dic objectForKey: @"y"] floatValue];
		float h = [[dic objectForKey: @"h"] floatValue];
		
		float fBottom = y-h/2.0f;

		for (j = 0; j < [backArray count]; j ++) {
			NSDictionary* dic = [backArray objectAtIndex: j];
			float y1 = [[dic objectForKey: @"y"] floatValue];
			float h1 = [[dic objectForKey: @"h"] floatValue];
			float fBottom1 = y1-h1/2.0f;
			
			if (fBottom > fBottom1) {
				break;
			}
		}
		
		[backArray insertObject:dic atIndex:j];
	}
	
	for (int i = 0; i < [backArray count]; i ++) {
		NSDictionary* dic = [backArray objectAtIndex: i];
		int nId = [[dic objectForKey: @"id"] intValue];
		[self updateZOfElement: nId z: i];
		
	}
}

- (int) addElement: (int) nElementId x: (float) x y: (float) y w: (float) w h: (float) h{
	NSMutableString* strSQL = [[NSMutableString alloc] init];	
	[strSQL appendFormat: @"insert into '%@'('element_id', 'x', 'y', 'z', 'w', 'h') values(", @"tbl_zoo"];
	[strSQL appendFormat: @"'%d',", nElementId];
	[strSQL appendFormat: @"%f,", x];
	[strSQL appendFormat: @"%f,", y];
	[strSQL appendFormat: @"%f,", 0];
	[strSQL appendFormat: @"%f,", w];
	[strSQL appendFormat: @"%f)", h];
//	[strSQL appendFormat: @"'%@')", @""];
	NSLog(@"%@", strSQL);
	[m_sqlManager runDynamicSQL: strSQL forTable: @"tbl_zoo"];	
	[strSQL release];	
	
	[self resortZOfElement];
	int nMaxId = [m_sqlManager lookupMax:@"id" Where:@"id!=-1" forTable:@"tbl_zoo"];
	return nMaxId;
}

- (void) updateElement: (int) nId x:(float) x y: (float) y {
	NSMutableString* strSQL = [[NSMutableString alloc] init];	
	[strSQL appendFormat: @"update '%@' set ", @"tbl_zoo"];
	[strSQL appendFormat: @"x='%f',", x];
	[strSQL appendFormat: @"y='%f'", y];
	[strSQL appendFormat: @" where id=%d", nId];
	
	[m_sqlManager runDynamicSQL: strSQL forTable: @"tbl_zoo"];	
	[strSQL release];		
	
	[self resortZOfElement];	
}

- (int) genNewElementId {
	int nMaxId = [m_sqlManager lookupMax:@"id" Where:@"id!=-1" forTable:@"tbl_zoo"];
	return nMaxId+1;	
}

- (NSArray*) loadAllMode0 {
	return [m_sqlManager lookupAllForSQL: @"select * from tbl_score where mode=0 order by score desc limit 10"];	
}

- (NSArray*) loadAllMode1 {
	return [m_sqlManager lookupAllForSQL: @"select * from tbl_score where mode=1 order by score asc limit 10"];		
}

- (NSArray*) loadAllMode2 {
	return [m_sqlManager lookupAllForSQL: @"select * from tbl_score where mode=2 order by score desc limit 10"];		
}

- (NSArray*) loadAllMode3 {
	return [m_sqlManager lookupAllForSQL: @"select * from tbl_score where mode=3 order by score desc limit 10"];		
}

- (NSArray*) loadAllMode4 {
	return [m_sqlManager lookupAllForSQL: @"select * from tbl_score where mode=4 order by score desc limit 10"];		
}

- (void) submitScore: (int) nMode 
			nCorrect: (int) nCorrect 
			   nMiss: (int) nMiss 
			  nScore: (int) nScore {
	
	NSMutableString* strSQL = [[NSMutableString alloc] init];	
	[strSQL appendFormat: @"insert into '%@'('mode', 'correct_count', 'miss_count', 'score') values(", @"tbl_score"];
	[strSQL appendFormat: @"%d,", nMode];
	[strSQL appendFormat: @"%d,", nCorrect];
	[strSQL appendFormat: @"%d,", nMiss];
	[strSQL appendFormat: @"%d)", nScore];
	
	NSLog(@"%@", strSQL);
	[m_sqlManager runDynamicSQL: strSQL forTable: @"tbl_score"];	
	[strSQL release];
}

- (void) dealloc
{
	[m_sqlManager release];
	[super dealloc];
}
@end
