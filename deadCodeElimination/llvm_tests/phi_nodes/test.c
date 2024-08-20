#include <stdio.h>

int global = 0;

int main ( int argc, const char **argv) {
	int a, b, c;

	scanf (
		"%d %d",
		&a, &b
	);


	if ( a > b ) {
		c = a + b;
		a = a * b;
		b = a * b;
	} else {
		c = a - b;
		a = a * b;
		b = a * b;
	}

	a = a * b;
	b = a * b;
	a = 5;
	b = 5;

	global = 1;
	
	return c;
}

