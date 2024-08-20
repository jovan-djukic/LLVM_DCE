#include <stdio.h>

int global = 0;

int main ( int argc, const char **argv) {
	int a, b;
	float c, d;

	scanf (
		"%d %d %f",
		&a, &b, &c
	);

	if ( a > b ) {
		d = a + b;
		c = c * d;
	} else {
		d = a / b;
		c = c - d;
	}

	a = 5;
	b = 5;
	c = 5;
	d = 5;

	global = 1;
	
	return 1;
}

