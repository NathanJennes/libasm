#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>

int ft_strcmp(const char* s1, const char* s2);
char* ft_strcpy(char* restrict dst, const char* restrict src);
char* ft_strdup(const char* s);
size_t ft_strlen(const char* s);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void *buf, size_t count);

void test_ft_strcmp(void)
{
	printf("%4d | %4d\n", ft_strcmp("Hello", "Hello"), strcmp("Hello", "Hello"));
	printf("%4d | %4d\n", ft_strcmp("Hello", "Hello!"), strcmp("Hello", "Hello!"));
	printf("%4d | %4d\n", ft_strcmp("Hello!", "Hello"), strcmp("Hello!", "Hello"));
	printf("%4d | %4d\n", ft_strcmp("Hello!", ""), strcmp("Hello!", ""));
	printf("%4d | %4d\n", ft_strcmp("", "Hello!"), strcmp("", "Hello!"));
	printf("%4d | %4d\n", ft_strcmp("", "\xff"), strcmp("", "\xff"));
	printf("%4d | %4d\n", ft_strcmp("\xff", ""), strcmp("\xff", ""));
	printf("%4d | %4d\n", ft_strcmp("\xaa", "\xff"), strcmp("\xaa", "\xff"));
	printf("%4d | %4d\n", ft_strcmp("\xff", "\xaa"), strcmp("\xff", "\xaa"));
}

void test_ft_strcpy(void)
{
	char dst[100];
	char dst2[100];
	memset(dst, 'X', 100);
	memset(dst2, 'X', 100);
	dst[99] = 0;
	dst2[99] = 0;

	ft_strcpy(dst, "Hello");
	strcpy(dst2, "Hello");
	printf("[%s] | [%s]\n", dst, dst2);

	ft_strcpy(dst, "");
	strcpy(dst2, "");
	printf("[%s] | [%s]\n", dst, dst2);

	ft_strcpy(dst, "Hello!");
	strcpy(dst2, "Hello!");
	printf("[%s] | [%s]\n", dst, dst2);
}

void test_ft_strdup(void)
{
	const char* str = "Hello";
	char* s = ft_strdup(str);
	printf("[%s], %p - %p\n", s, s, str);
	free(s);

	str = "";
	s = ft_strdup(str);
	printf("[%s], %p - %p\n", s, s, str);
	free(s);

	str = "Hello!";
	s = ft_strdup(str);
	printf("[%s], %p - %p\n", s, s, str);
	free(s);
}

void test_ft_strlen(void)
{
	printf("%zu | %zu\n", ft_strlen("Hello"), strlen("Hello"));
	printf("%zu | %zu\n", ft_strlen(""), strlen(""));
	printf("%zu | %zu\n", ft_strlen("Hello!"), strlen("Hello!"));
}

void test_ft_write(void)
{
	int p[2];
	pipe(p);
	char buf[100];
	memset(buf, 0, 100);
	char buf2[100];
	memset(buf2, 0, 100);

	ssize_t ft_written_bytes = ft_write(p[1], "HEYYYYY", 5);
	ssize_t ft_read_bytes = read(p[0], buf, 10);

	ssize_t written_bytes = write(p[1], "HEYYYYY", 5);
	ssize_t read_bytes = read(p[0], buf2, 10);

	printf("%d %d [%s] | %d %d [%s]\n", (int)ft_written_bytes, (int)ft_read_bytes, buf, (int)written_bytes, (int)read_bytes, buf2);

	close(p[1]);
	close (p[0]);
}

void test_ft_read(void)
{
	int p[2];
	pipe(p);
	char buf[100];

	memset(buf, 0, 100);
	write(p[1], "HEYYYYY", 5);
	printf("%d\n", (int)ft_read(p[0], buf, 5));
	printf("%s\n", buf);

	memset(buf, 0, 100);
	write(p[1], "HEYYYYY", 5);
	printf("%d\n", (int)read(p[0], buf, 5));
	printf("%s\n", buf);
}

int main()
{
	printf("ft_strcmp | strcmp\n");
	test_ft_strcmp();
	printf("\n");

	printf("ft_strcpy | strcpy\n");
	test_ft_strcpy();
	printf("\n");

	printf("ft_strdup\n");
	test_ft_strdup();
	printf("\n");

	printf("ft_strlen | strlen\n");
	test_ft_strlen();
	printf("\n");

	printf("ft_write | write\n");
	test_ft_write();
	printf("\n");

	printf("ft_read | read\n");
	test_ft_read();

	return 0;
}