#ifndef LEVELS_H_INCLUDED
#define LEVELS_H_INCLUDED

#include "defs.h"

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// COMPRESSION LEVELS
//
// LEVEL_0 IS RESERVED TO THE ALGORITHM
#define LEVEL_1 "   1: -m 13:100:0:0/0 "
#define LEVEL_2 "   2: -m 13:100:1:0/0 "
#define LEVEL_3 "   3: -m 14:200:0:0/0 "
#define LEVEL_4 "   4: -m 14:200:1:0/0 "
#define LEVEL_5 "   5: -m 18:500:1:0/0   -c 30 "
#define LEVEL_6 "   6: -m 18:500:1:0/0   -c 40 "
#define LEVEL_7 "   7: -m 18:500:1:0/0   -c 50 "
#define LEVEL_8 "   8: -m 20:500:1:1/100 -c 10 -g 0.85 "
#define LEVEL_9 "   9: -m 20:500:1:2/100 -c 20 -g 0.85 "
#define LEVEL_10 " 10: -m 20:500:1:2/100 -c 30 -g 0.85 "
#define LEVEL_11 " 11: -m 20:500:1:2/100 -c 35 -g 0.85 "
#define LEVEL_12 " 12: -m 20:500:1:2/100 -c 40 -g 0.85 "
#define LEVEL_13 " 13: -m 20:500:1:2/100 -c 45 -g 0.85 "
#define LEVEL_14 " 14: -m 20:500:1:2/100 -c 50 -g 0.85 "
#define LEVEL_15 " 15: -m 20:500:1:3/100 -c 60 -g 0.85 "
#define LEVEL_16 " 16: -m 20:500:1:3/100 -c 60 -g 0.85 "
#define LEVEL_17 " 17: -m 20:500:1:3/100 -c 70 -g 0.85 "
#define LEVEL_18 " 18: -m 20:500:1:1/100 -m 13:100:0:0/0 -c 30 -g 0.85 "
#define LEVEL_19 " 19: -m 20:500:1:1/100 -m 13:100:0:0/0 -c 35 -g 0.85 "
#define LEVEL_20 " 20: -m 20:500:1:1/100 -m 13:100:0:0/0 -c 40 -g 0.85 "
#define LEVEL_21 " 21: -m 20:500:1:1/100 -m 14:100:0:0/0 -c 45 -g 0.85 "
#define LEVEL_22 " 22: -m 20:500:1:1/100 -m 14:100:1:0/0 -c 45 -g 0.85 "
#define LEVEL_23 " 23: -m 20:500:1:3/100 -m 14:100:1:0/0 -c 45 -g 0.85 "
#define LEVEL_24 " 24: -m 20:1000:1:3/100 -m 13:100:0:0/0 -m 8:1:0:0/0 -c 40 -g 0.85 "
#define LEVEL_25 " 25: -m 20:1000:1:3/100 -m 14:200:1:0/0 -m 10:10:0:0/0 -m 4:1:0:0/0 -c 40 -g 0.85 "
#define LEVEL_26 " 26: -m 20:1000:1:1/100 -m 14:200:1:0/0 -m 12:20:0:0/0 -m 4:1:0:0/0 -c 50 -g 0.85 "
#define LEVEL_27 " 27: -m 20:1000:1:2/100 -m 14:200:1:0/0 -m 12:20:0:0/0 -m 4:1:0:0/0 -c 60 -g 0.85 "
#define LEVEL_28 " 28: -m 20:1000:1:3/100 -m 14:200:1:0/0 -m 12:20:0:0/0 -m 4:1:0:0/0 -c 50 -g 0.85 "
#define LEVEL_29 " 29: -m 20:1000:1:3/100 -m 14:200:1:0/0 -m 12:20:0:0/0 -m 4:1:0:0/0 -c 60 -g 0.85 "
#define LEVEL_30 " 30: -m 20:1000:1:3/100 -m 14:200:1:0/0 -m 12:20:0:0/0 -m 8:1:0:0/0 -m 4:1:0:0/0 -c 50 -g 0.85 "
#define LEVEL_31 " 31: -m 20:500:1:3/20 -m 14:50:1:0/0 -m 12:1:0:0/0 -m 8:1:0:0/0 -m 4:1:0:0/0 -c 60 -g 0.8 "
#define LEVEL_32 " 32: -m 25:500:1:3/100 -m 14:50:1:0/0 -m 12:1:0:0/0 -m 8:1:0:0/0 -m 4:1:0:0/0 -c 50 "

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

char    *GetLevels  (uint8_t);
void    PrintLevels (void);

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#endif

