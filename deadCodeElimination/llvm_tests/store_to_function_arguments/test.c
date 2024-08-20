#include <stdio.h>

int global = 0;

int test ( int *a, int b) {
	float c, d;

	scanf (
		"%d %d %f %f",
		a, &b, &c, &d
	);

	if ( *a > b ) {
		*a + b;
		c * d;
	} else {
		*a / b;
		c - d;
	}

	*a = 5;
	b = 5;
	c = 5;
	d = 5;

	global = 1;
	
	return 1;
}

