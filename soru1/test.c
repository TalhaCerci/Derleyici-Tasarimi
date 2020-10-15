#include<stdlib.h>
void main()
{
	int x[100];
	float a[100][100];
	float b[100];
	float c[100];	
	int i, j, k; 
	i = 0; 
	while (i < 100) 
	{ 
		j = 0; 
		while (j < 100) 
		{ 
			if (!(c[i][j] == 0.0)) 
			c[i][j] = 0.0;
			k = 0; 
			while (k < 100) 
			{ 
				c[i][j] = c[i][j] + a[i][k] * b[k][j]; 
				k = k + 1;
			}
			j = j + 1;
		}
		i = i + 1;
	}
}
