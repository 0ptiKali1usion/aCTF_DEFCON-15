#include<stdio.h>
FILE*a;char b,c,e,f,g,h,*k=" \t\n",f;main(int argc,char *argv[]){a=fopen(argv[
1],"r");for(;;){c=getchar();if(c==EOF&&e==EOF)exit(0);else if(c==EOF)c=32;if(b
!='\\'&&b!='\''&&c=='"')f=1-f;if(!f&&(!(c-32)||!(c-9)||!(c-10))&&(e=getc(a))!=
EOF){printf("%c%c%c%c%c",k[e%3],k[(e-e%3)/3%3],k[((e-e%3)/3-((e-e%3)/3%3))/3%3
],k[(((e-e%3)/3-((e-e%3)/3%3))/3-(((e-e%3)/3-((e-e%3)/3%3))/3%3))/3%3],k[((((e
-e%3)/3-((e-e%3)/3%3))/3-(((e-e%3)/3-((e-e%3)/3%3))/3%3))/3-((((e-e%3)/3-((e-e
%3)/3%3))/3-(((e-e%3)/3-((e-e%3)/3%3))/3%3))/3%3))/3]);}else putchar(c);b=c;}}
