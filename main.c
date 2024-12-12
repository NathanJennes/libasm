#include <stdio.h>
#include <string.h>
#include <unistd.h>

int ft_strcmp(const char* s1, const char* s2);
char* ft_strcpy(char* restrict dst, const char* restrict src);
char* ft_strdup(const char* s);
size_t ft_strlen(const char* s);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void *buf, size_t count);


int main()
{
	//printf("%4d | %4d\n", ft_strcmp("Hello", "Hello"), strcmp("Hello", "Hello"));
	//printf("%4d | %4d\n", ft_strcmp("Hello", "Hello!"), strcmp("Hello", "Hello!"));
	//printf("%4d | %4d\n", ft_strcmp("Hello!", "Hello"), strcmp("Hello!", "Hello"));
	//printf("%4d | %4d\n", ft_strcmp("Hello!", ""), strcmp("Hello!", ""));
	//printf("%4d | %4d\n", ft_strcmp("", "Hello!"), strcmp("", "Hello!"));
	//printf("%4d | %4d\n", ft_strcmp("", "\xff"), strcmp("", "\xff"));
	//printf("%4d | %4d\n", ft_strcmp("\xff", ""), strcmp("\xff", ""));
	//printf("%4d | %4d\n", ft_strcmp("\xaa", "\xff"), strcmp("\xaa", "\xff"));
	//printf("%4d | %4d\n", ft_strcmp("\xff", "\xaa"), strcmp("\xff", "\xaa"));
//
	//printf("\n");
	//int p[2]; pipe(p);
	//printf("%d | %d\n", (int)ft_write(p[1], "NULLLLL", 5), (int)write(p[1], "NULLLL", 5));

	int p[2]; pipe(p);
	ft_write(-1, NULL, 1);
	perror("err");

	return 0;
}