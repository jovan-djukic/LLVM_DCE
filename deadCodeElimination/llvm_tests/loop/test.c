#include <stdio.h>

int global = 0;

int main ( int argc, const char **argv) {
	int a [ 10 ] = { 0 };

	for ( int i = 0; i < 10; i++ ) {
		scanf ( "%d", &a [ i ] );
	}

	int s = 0;
	for ( int i = 0; i < 10; i++ ) {
		s += a [ i ];	
	}


	global = 1;
	
	return 1;
}

