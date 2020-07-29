
_rm:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
       f:	83 ec 10             	sub    $0x10,%esp
      12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
      14:	83 3b 01             	cmpl   $0x1,(%ebx)
      17:	7f 17                	jg     30 <main+0x30>
    printf(2, "Usage: rm files...\n");
      19:	83 ec 08             	sub    $0x8,%esp
      1c:	68 a0 10 00 00       	push   $0x10a0
      21:	6a 02                	push   $0x2
      23:	e8 82 04 00 00       	call   4aa <printf>
      28:	83 c4 10             	add    $0x10,%esp
    exit();
      2b:	e8 e7 02 00 00       	call   317 <exit>
  }

  for(i = 1; i < argc; i++){
      30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      37:	eb 4b                	jmp    84 <main+0x84>
    if(unlink(argv[i]) < 0){
      39:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      43:	8b 43 04             	mov    0x4(%ebx),%eax
      46:	01 d0                	add    %edx,%eax
      48:	8b 00                	mov    (%eax),%eax
      4a:	83 ec 0c             	sub    $0xc,%esp
      4d:	50                   	push   %eax
      4e:	e8 14 03 00 00       	call   367 <unlink>
      53:	83 c4 10             	add    $0x10,%esp
      56:	85 c0                	test   %eax,%eax
      58:	79 26                	jns    80 <main+0x80>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      64:	8b 43 04             	mov    0x4(%ebx),%eax
      67:	01 d0                	add    %edx,%eax
      69:	8b 00                	mov    (%eax),%eax
      6b:	83 ec 04             	sub    $0x4,%esp
      6e:	50                   	push   %eax
      6f:	68 b4 10 00 00       	push   $0x10b4
      74:	6a 02                	push   $0x2
      76:	e8 2f 04 00 00       	call   4aa <printf>
      7b:	83 c4 10             	add    $0x10,%esp
      break;
      7e:	eb 0b                	jmp    8b <main+0x8b>
  for(i = 1; i < argc; i++){
      80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      84:	8b 45 f4             	mov    -0xc(%ebp),%eax
      87:	3b 03                	cmp    (%ebx),%eax
      89:	7c ae                	jl     39 <main+0x39>
    }
  }

  exit();
      8b:	e8 87 02 00 00       	call   317 <exit>

00000090 <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
      90:	55                   	push   %ebp
      91:	89 e5                	mov    %esp,%ebp
      93:	57                   	push   %edi
      94:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      95:	8b 4d 08             	mov    0x8(%ebp),%ecx
      98:	8b 55 10             	mov    0x10(%ebp),%edx
      9b:	8b 45 0c             	mov    0xc(%ebp),%eax
      9e:	89 cb                	mov    %ecx,%ebx
      a0:	89 df                	mov    %ebx,%edi
      a2:	89 d1                	mov    %edx,%ecx
      a4:	fc                   	cld    
      a5:	f3 aa                	rep stos %al,%es:(%edi)
      a7:	89 ca                	mov    %ecx,%edx
      a9:	89 fb                	mov    %edi,%ebx
      ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
      ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      b1:	90                   	nop
      b2:	5b                   	pop    %ebx
      b3:	5f                   	pop    %edi
      b4:	5d                   	pop    %ebp
      b5:	c3                   	ret    

000000b6 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      b6:	55                   	push   %ebp
      b7:	89 e5                	mov    %esp,%ebp
      b9:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      bc:	8b 45 08             	mov    0x8(%ebp),%eax
      bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      c2:	90                   	nop
      c3:	8b 55 0c             	mov    0xc(%ebp),%edx
      c6:	8d 42 01             	lea    0x1(%edx),%eax
      c9:	89 45 0c             	mov    %eax,0xc(%ebp)
      cc:	8b 45 08             	mov    0x8(%ebp),%eax
      cf:	8d 48 01             	lea    0x1(%eax),%ecx
      d2:	89 4d 08             	mov    %ecx,0x8(%ebp)
      d5:	0f b6 12             	movzbl (%edx),%edx
      d8:	88 10                	mov    %dl,(%eax)
      da:	0f b6 00             	movzbl (%eax),%eax
      dd:	84 c0                	test   %al,%al
      df:	75 e2                	jne    c3 <strcpy+0xd>
    ;
  return os;
      e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      e4:	c9                   	leave  
      e5:	c3                   	ret    

000000e6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      e6:	55                   	push   %ebp
      e7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      e9:	eb 08                	jmp    f3 <strcmp+0xd>
    p++, q++;
      eb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      ef:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
      f3:	8b 45 08             	mov    0x8(%ebp),%eax
      f6:	0f b6 00             	movzbl (%eax),%eax
      f9:	84 c0                	test   %al,%al
      fb:	74 10                	je     10d <strcmp+0x27>
      fd:	8b 45 08             	mov    0x8(%ebp),%eax
     100:	0f b6 10             	movzbl (%eax),%edx
     103:	8b 45 0c             	mov    0xc(%ebp),%eax
     106:	0f b6 00             	movzbl (%eax),%eax
     109:	38 c2                	cmp    %al,%dl
     10b:	74 de                	je     eb <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     10d:	8b 45 08             	mov    0x8(%ebp),%eax
     110:	0f b6 00             	movzbl (%eax),%eax
     113:	0f b6 d0             	movzbl %al,%edx
     116:	8b 45 0c             	mov    0xc(%ebp),%eax
     119:	0f b6 00             	movzbl (%eax),%eax
     11c:	0f b6 c0             	movzbl %al,%eax
     11f:	29 c2                	sub    %eax,%edx
     121:	89 d0                	mov    %edx,%eax
}
     123:	5d                   	pop    %ebp
     124:	c3                   	ret    

00000125 <strlen>:

uint
strlen(char *s)
{
     125:	55                   	push   %ebp
     126:	89 e5                	mov    %esp,%ebp
     128:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     12b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     132:	eb 04                	jmp    138 <strlen+0x13>
     134:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     138:	8b 55 fc             	mov    -0x4(%ebp),%edx
     13b:	8b 45 08             	mov    0x8(%ebp),%eax
     13e:	01 d0                	add    %edx,%eax
     140:	0f b6 00             	movzbl (%eax),%eax
     143:	84 c0                	test   %al,%al
     145:	75 ed                	jne    134 <strlen+0xf>
    ;
  return n;
     147:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     14a:	c9                   	leave  
     14b:	c3                   	ret    

0000014c <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     14c:	55                   	push   %ebp
     14d:	89 e5                	mov    %esp,%ebp
     14f:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     152:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     159:	eb 0c                	jmp    167 <strnlen+0x1b>
     n++; 
     15b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     15f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     163:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     167:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     16b:	74 0a                	je     177 <strnlen+0x2b>
     16d:	8b 45 08             	mov    0x8(%ebp),%eax
     170:	0f b6 00             	movzbl (%eax),%eax
     173:	84 c0                	test   %al,%al
     175:	75 e4                	jne    15b <strnlen+0xf>
   return n; 
     177:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     17a:	c9                   	leave  
     17b:	c3                   	ret    

0000017c <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     17c:	55                   	push   %ebp
     17d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     17f:	8b 45 10             	mov    0x10(%ebp),%eax
     182:	50                   	push   %eax
     183:	ff 75 0c             	pushl  0xc(%ebp)
     186:	ff 75 08             	pushl  0x8(%ebp)
     189:	e8 02 ff ff ff       	call   90 <stosb>
     18e:	83 c4 0c             	add    $0xc,%esp
  return dst;
     191:	8b 45 08             	mov    0x8(%ebp),%eax
}
     194:	c9                   	leave  
     195:	c3                   	ret    

00000196 <strchr>:

char*
strchr(const char *s, char c)
{
     196:	55                   	push   %ebp
     197:	89 e5                	mov    %esp,%ebp
     199:	83 ec 04             	sub    $0x4,%esp
     19c:	8b 45 0c             	mov    0xc(%ebp),%eax
     19f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     1a2:	eb 14                	jmp    1b8 <strchr+0x22>
    if(*s == c)
     1a4:	8b 45 08             	mov    0x8(%ebp),%eax
     1a7:	0f b6 00             	movzbl (%eax),%eax
     1aa:	38 45 fc             	cmp    %al,-0x4(%ebp)
     1ad:	75 05                	jne    1b4 <strchr+0x1e>
      return (char*)s;
     1af:	8b 45 08             	mov    0x8(%ebp),%eax
     1b2:	eb 13                	jmp    1c7 <strchr+0x31>
  for(; *s; s++)
     1b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1b8:	8b 45 08             	mov    0x8(%ebp),%eax
     1bb:	0f b6 00             	movzbl (%eax),%eax
     1be:	84 c0                	test   %al,%al
     1c0:	75 e2                	jne    1a4 <strchr+0xe>
  return 0;
     1c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
     1c7:	c9                   	leave  
     1c8:	c3                   	ret    

000001c9 <gets>:

char*
gets(char *buf, int max)
{
     1c9:	55                   	push   %ebp
     1ca:	89 e5                	mov    %esp,%ebp
     1cc:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     1d6:	eb 42                	jmp    21a <gets+0x51>
    cc = read(0, &c, 1);
     1d8:	83 ec 04             	sub    $0x4,%esp
     1db:	6a 01                	push   $0x1
     1dd:	8d 45 ef             	lea    -0x11(%ebp),%eax
     1e0:	50                   	push   %eax
     1e1:	6a 00                	push   $0x0
     1e3:	e8 47 01 00 00       	call   32f <read>
     1e8:	83 c4 10             	add    $0x10,%esp
     1eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1ee:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1f2:	7e 33                	jle    227 <gets+0x5e>
      break;
    buf[i++] = c;
     1f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1f7:	8d 50 01             	lea    0x1(%eax),%edx
     1fa:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1fd:	89 c2                	mov    %eax,%edx
     1ff:	8b 45 08             	mov    0x8(%ebp),%eax
     202:	01 c2                	add    %eax,%edx
     204:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     208:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     20a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     20e:	3c 0a                	cmp    $0xa,%al
     210:	74 16                	je     228 <gets+0x5f>
     212:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     216:	3c 0d                	cmp    $0xd,%al
     218:	74 0e                	je     228 <gets+0x5f>
  for(i=0; i+1 < max; ){
     21a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     21d:	83 c0 01             	add    $0x1,%eax
     220:	39 45 0c             	cmp    %eax,0xc(%ebp)
     223:	7f b3                	jg     1d8 <gets+0xf>
     225:	eb 01                	jmp    228 <gets+0x5f>
      break;
     227:	90                   	nop
      break;
  }
  buf[i] = '\0';
     228:	8b 55 f4             	mov    -0xc(%ebp),%edx
     22b:	8b 45 08             	mov    0x8(%ebp),%eax
     22e:	01 d0                	add    %edx,%eax
     230:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     233:	8b 45 08             	mov    0x8(%ebp),%eax
}
     236:	c9                   	leave  
     237:	c3                   	ret    

00000238 <stat>:

int
stat(char *n, struct stat *st)
{
     238:	55                   	push   %ebp
     239:	89 e5                	mov    %esp,%ebp
     23b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     23e:	83 ec 08             	sub    $0x8,%esp
     241:	6a 00                	push   $0x0
     243:	ff 75 08             	pushl  0x8(%ebp)
     246:	e8 0c 01 00 00       	call   357 <open>
     24b:	83 c4 10             	add    $0x10,%esp
     24e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     251:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     255:	79 07                	jns    25e <stat+0x26>
    return -1;
     257:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     25c:	eb 25                	jmp    283 <stat+0x4b>
  r = fstat(fd, st);
     25e:	83 ec 08             	sub    $0x8,%esp
     261:	ff 75 0c             	pushl  0xc(%ebp)
     264:	ff 75 f4             	pushl  -0xc(%ebp)
     267:	e8 03 01 00 00       	call   36f <fstat>
     26c:	83 c4 10             	add    $0x10,%esp
     26f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     272:	83 ec 0c             	sub    $0xc,%esp
     275:	ff 75 f4             	pushl  -0xc(%ebp)
     278:	e8 c2 00 00 00       	call   33f <close>
     27d:	83 c4 10             	add    $0x10,%esp
  return r;
     280:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     283:	c9                   	leave  
     284:	c3                   	ret    

00000285 <atoi>:

int
atoi(const char *s)
{
     285:	55                   	push   %ebp
     286:	89 e5                	mov    %esp,%ebp
     288:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     28b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     292:	eb 25                	jmp    2b9 <atoi+0x34>
    n = n*10 + *s++ - '0';
     294:	8b 55 fc             	mov    -0x4(%ebp),%edx
     297:	89 d0                	mov    %edx,%eax
     299:	c1 e0 02             	shl    $0x2,%eax
     29c:	01 d0                	add    %edx,%eax
     29e:	01 c0                	add    %eax,%eax
     2a0:	89 c1                	mov    %eax,%ecx
     2a2:	8b 45 08             	mov    0x8(%ebp),%eax
     2a5:	8d 50 01             	lea    0x1(%eax),%edx
     2a8:	89 55 08             	mov    %edx,0x8(%ebp)
     2ab:	0f b6 00             	movzbl (%eax),%eax
     2ae:	0f be c0             	movsbl %al,%eax
     2b1:	01 c8                	add    %ecx,%eax
     2b3:	83 e8 30             	sub    $0x30,%eax
     2b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2b9:	8b 45 08             	mov    0x8(%ebp),%eax
     2bc:	0f b6 00             	movzbl (%eax),%eax
     2bf:	3c 2f                	cmp    $0x2f,%al
     2c1:	7e 0a                	jle    2cd <atoi+0x48>
     2c3:	8b 45 08             	mov    0x8(%ebp),%eax
     2c6:	0f b6 00             	movzbl (%eax),%eax
     2c9:	3c 39                	cmp    $0x39,%al
     2cb:	7e c7                	jle    294 <atoi+0xf>
  return n;
     2cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2d0:	c9                   	leave  
     2d1:	c3                   	ret    

000002d2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     2d2:	55                   	push   %ebp
     2d3:	89 e5                	mov    %esp,%ebp
     2d5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     2d8:	8b 45 08             	mov    0x8(%ebp),%eax
     2db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     2de:	8b 45 0c             	mov    0xc(%ebp),%eax
     2e1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     2e4:	eb 17                	jmp    2fd <memmove+0x2b>
    *dst++ = *src++;
     2e6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2e9:	8d 42 01             	lea    0x1(%edx),%eax
     2ec:	89 45 f8             	mov    %eax,-0x8(%ebp)
     2ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2f2:	8d 48 01             	lea    0x1(%eax),%ecx
     2f5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     2f8:	0f b6 12             	movzbl (%edx),%edx
     2fb:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     2fd:	8b 45 10             	mov    0x10(%ebp),%eax
     300:	8d 50 ff             	lea    -0x1(%eax),%edx
     303:	89 55 10             	mov    %edx,0x10(%ebp)
     306:	85 c0                	test   %eax,%eax
     308:	7f dc                	jg     2e6 <memmove+0x14>
  return vdst;
     30a:	8b 45 08             	mov    0x8(%ebp),%eax
}
     30d:	c9                   	leave  
     30e:	c3                   	ret    

0000030f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     30f:	b8 01 00 00 00       	mov    $0x1,%eax
     314:	cd 40                	int    $0x40
     316:	c3                   	ret    

00000317 <exit>:
SYSCALL(exit)
     317:	b8 02 00 00 00       	mov    $0x2,%eax
     31c:	cd 40                	int    $0x40
     31e:	c3                   	ret    

0000031f <wait>:
SYSCALL(wait)
     31f:	b8 03 00 00 00       	mov    $0x3,%eax
     324:	cd 40                	int    $0x40
     326:	c3                   	ret    

00000327 <pipe>:
SYSCALL(pipe)
     327:	b8 04 00 00 00       	mov    $0x4,%eax
     32c:	cd 40                	int    $0x40
     32e:	c3                   	ret    

0000032f <read>:
SYSCALL(read)
     32f:	b8 05 00 00 00       	mov    $0x5,%eax
     334:	cd 40                	int    $0x40
     336:	c3                   	ret    

00000337 <write>:
SYSCALL(write)
     337:	b8 10 00 00 00       	mov    $0x10,%eax
     33c:	cd 40                	int    $0x40
     33e:	c3                   	ret    

0000033f <close>:
SYSCALL(close)
     33f:	b8 15 00 00 00       	mov    $0x15,%eax
     344:	cd 40                	int    $0x40
     346:	c3                   	ret    

00000347 <kill>:
SYSCALL(kill)
     347:	b8 06 00 00 00       	mov    $0x6,%eax
     34c:	cd 40                	int    $0x40
     34e:	c3                   	ret    

0000034f <exec>:
SYSCALL(exec)
     34f:	b8 07 00 00 00       	mov    $0x7,%eax
     354:	cd 40                	int    $0x40
     356:	c3                   	ret    

00000357 <open>:
SYSCALL(open)
     357:	b8 0f 00 00 00       	mov    $0xf,%eax
     35c:	cd 40                	int    $0x40
     35e:	c3                   	ret    

0000035f <mknod>:
SYSCALL(mknod)
     35f:	b8 11 00 00 00       	mov    $0x11,%eax
     364:	cd 40                	int    $0x40
     366:	c3                   	ret    

00000367 <unlink>:
SYSCALL(unlink)
     367:	b8 12 00 00 00       	mov    $0x12,%eax
     36c:	cd 40                	int    $0x40
     36e:	c3                   	ret    

0000036f <fstat>:
SYSCALL(fstat)
     36f:	b8 08 00 00 00       	mov    $0x8,%eax
     374:	cd 40                	int    $0x40
     376:	c3                   	ret    

00000377 <link>:
SYSCALL(link)
     377:	b8 13 00 00 00       	mov    $0x13,%eax
     37c:	cd 40                	int    $0x40
     37e:	c3                   	ret    

0000037f <mkdir>:
SYSCALL(mkdir)
     37f:	b8 14 00 00 00       	mov    $0x14,%eax
     384:	cd 40                	int    $0x40
     386:	c3                   	ret    

00000387 <chdir>:
SYSCALL(chdir)
     387:	b8 09 00 00 00       	mov    $0x9,%eax
     38c:	cd 40                	int    $0x40
     38e:	c3                   	ret    

0000038f <dup>:
SYSCALL(dup)
     38f:	b8 0a 00 00 00       	mov    $0xa,%eax
     394:	cd 40                	int    $0x40
     396:	c3                   	ret    

00000397 <getpid>:
SYSCALL(getpid)
     397:	b8 0b 00 00 00       	mov    $0xb,%eax
     39c:	cd 40                	int    $0x40
     39e:	c3                   	ret    

0000039f <sbrk>:
SYSCALL(sbrk)
     39f:	b8 0c 00 00 00       	mov    $0xc,%eax
     3a4:	cd 40                	int    $0x40
     3a6:	c3                   	ret    

000003a7 <sleep>:
SYSCALL(sleep)
     3a7:	b8 0d 00 00 00       	mov    $0xd,%eax
     3ac:	cd 40                	int    $0x40
     3ae:	c3                   	ret    

000003af <uptime>:
SYSCALL(uptime)
     3af:	b8 0e 00 00 00       	mov    $0xe,%eax
     3b4:	cd 40                	int    $0x40
     3b6:	c3                   	ret    

000003b7 <select>:
SYSCALL(select)
     3b7:	b8 16 00 00 00       	mov    $0x16,%eax
     3bc:	cd 40                	int    $0x40
     3be:	c3                   	ret    

000003bf <arp>:
SYSCALL(arp)
     3bf:	b8 17 00 00 00       	mov    $0x17,%eax
     3c4:	cd 40                	int    $0x40
     3c6:	c3                   	ret    

000003c7 <arpserv>:
SYSCALL(arpserv)
     3c7:	b8 18 00 00 00       	mov    $0x18,%eax
     3cc:	cd 40                	int    $0x40
     3ce:	c3                   	ret    

000003cf <arp_receive>:
SYSCALL(arp_receive)
     3cf:	b8 19 00 00 00       	mov    $0x19,%eax
     3d4:	cd 40                	int    $0x40
     3d6:	c3                   	ret    

000003d7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3d7:	55                   	push   %ebp
     3d8:	89 e5                	mov    %esp,%ebp
     3da:	83 ec 18             	sub    $0x18,%esp
     3dd:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3e3:	83 ec 04             	sub    $0x4,%esp
     3e6:	6a 01                	push   $0x1
     3e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3eb:	50                   	push   %eax
     3ec:	ff 75 08             	pushl  0x8(%ebp)
     3ef:	e8 43 ff ff ff       	call   337 <write>
     3f4:	83 c4 10             	add    $0x10,%esp
}
     3f7:	90                   	nop
     3f8:	c9                   	leave  
     3f9:	c3                   	ret    

000003fa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3fa:	55                   	push   %ebp
     3fb:	89 e5                	mov    %esp,%ebp
     3fd:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     400:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     407:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     40b:	74 17                	je     424 <printint+0x2a>
     40d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     411:	79 11                	jns    424 <printint+0x2a>
    neg = 1;
     413:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     41a:	8b 45 0c             	mov    0xc(%ebp),%eax
     41d:	f7 d8                	neg    %eax
     41f:	89 45 ec             	mov    %eax,-0x14(%ebp)
     422:	eb 06                	jmp    42a <printint+0x30>
  } else {
    x = xx;
     424:	8b 45 0c             	mov    0xc(%ebp),%eax
     427:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     42a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     431:	8b 4d 10             	mov    0x10(%ebp),%ecx
     434:	8b 45 ec             	mov    -0x14(%ebp),%eax
     437:	ba 00 00 00 00       	mov    $0x0,%edx
     43c:	f7 f1                	div    %ecx
     43e:	89 d1                	mov    %edx,%ecx
     440:	8b 45 f4             	mov    -0xc(%ebp),%eax
     443:	8d 50 01             	lea    0x1(%eax),%edx
     446:	89 55 f4             	mov    %edx,-0xc(%ebp)
     449:	0f b6 91 70 17 00 00 	movzbl 0x1770(%ecx),%edx
     450:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     454:	8b 4d 10             	mov    0x10(%ebp),%ecx
     457:	8b 45 ec             	mov    -0x14(%ebp),%eax
     45a:	ba 00 00 00 00       	mov    $0x0,%edx
     45f:	f7 f1                	div    %ecx
     461:	89 45 ec             	mov    %eax,-0x14(%ebp)
     464:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     468:	75 c7                	jne    431 <printint+0x37>
  if(neg)
     46a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     46e:	74 2d                	je     49d <printint+0xa3>
    buf[i++] = '-';
     470:	8b 45 f4             	mov    -0xc(%ebp),%eax
     473:	8d 50 01             	lea    0x1(%eax),%edx
     476:	89 55 f4             	mov    %edx,-0xc(%ebp)
     479:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     47e:	eb 1d                	jmp    49d <printint+0xa3>
    putc(fd, buf[i]);
     480:	8d 55 dc             	lea    -0x24(%ebp),%edx
     483:	8b 45 f4             	mov    -0xc(%ebp),%eax
     486:	01 d0                	add    %edx,%eax
     488:	0f b6 00             	movzbl (%eax),%eax
     48b:	0f be c0             	movsbl %al,%eax
     48e:	83 ec 08             	sub    $0x8,%esp
     491:	50                   	push   %eax
     492:	ff 75 08             	pushl  0x8(%ebp)
     495:	e8 3d ff ff ff       	call   3d7 <putc>
     49a:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     49d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     4a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4a5:	79 d9                	jns    480 <printint+0x86>
}
     4a7:	90                   	nop
     4a8:	c9                   	leave  
     4a9:	c3                   	ret    

000004aa <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     4aa:	55                   	push   %ebp
     4ab:	89 e5                	mov    %esp,%ebp
     4ad:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     4b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     4b7:	8d 45 0c             	lea    0xc(%ebp),%eax
     4ba:	83 c0 04             	add    $0x4,%eax
     4bd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4c7:	e9 59 01 00 00       	jmp    625 <printf+0x17b>
    c = fmt[i] & 0xff;
     4cc:	8b 55 0c             	mov    0xc(%ebp),%edx
     4cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4d2:	01 d0                	add    %edx,%eax
     4d4:	0f b6 00             	movzbl (%eax),%eax
     4d7:	0f be c0             	movsbl %al,%eax
     4da:	25 ff 00 00 00       	and    $0xff,%eax
     4df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4e2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4e6:	75 2c                	jne    514 <printf+0x6a>
      if(c == '%'){
     4e8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4ec:	75 0c                	jne    4fa <printf+0x50>
        state = '%';
     4ee:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4f5:	e9 27 01 00 00       	jmp    621 <printf+0x177>
      } else {
        putc(fd, c);
     4fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4fd:	0f be c0             	movsbl %al,%eax
     500:	83 ec 08             	sub    $0x8,%esp
     503:	50                   	push   %eax
     504:	ff 75 08             	pushl  0x8(%ebp)
     507:	e8 cb fe ff ff       	call   3d7 <putc>
     50c:	83 c4 10             	add    $0x10,%esp
     50f:	e9 0d 01 00 00       	jmp    621 <printf+0x177>
      }
    } else if(state == '%'){
     514:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     518:	0f 85 03 01 00 00    	jne    621 <printf+0x177>
      if(c == 'd'){
     51e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     522:	75 1e                	jne    542 <printf+0x98>
        printint(fd, *ap, 10, 1);
     524:	8b 45 e8             	mov    -0x18(%ebp),%eax
     527:	8b 00                	mov    (%eax),%eax
     529:	6a 01                	push   $0x1
     52b:	6a 0a                	push   $0xa
     52d:	50                   	push   %eax
     52e:	ff 75 08             	pushl  0x8(%ebp)
     531:	e8 c4 fe ff ff       	call   3fa <printint>
     536:	83 c4 10             	add    $0x10,%esp
        ap++;
     539:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     53d:	e9 d8 00 00 00       	jmp    61a <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     542:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     546:	74 06                	je     54e <printf+0xa4>
     548:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     54c:	75 1e                	jne    56c <printf+0xc2>
        printint(fd, *ap, 16, 0);
     54e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     551:	8b 00                	mov    (%eax),%eax
     553:	6a 00                	push   $0x0
     555:	6a 10                	push   $0x10
     557:	50                   	push   %eax
     558:	ff 75 08             	pushl  0x8(%ebp)
     55b:	e8 9a fe ff ff       	call   3fa <printint>
     560:	83 c4 10             	add    $0x10,%esp
        ap++;
     563:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     567:	e9 ae 00 00 00       	jmp    61a <printf+0x170>
      } else if(c == 's'){
     56c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     570:	75 43                	jne    5b5 <printf+0x10b>
        s = (char*)*ap;
     572:	8b 45 e8             	mov    -0x18(%ebp),%eax
     575:	8b 00                	mov    (%eax),%eax
     577:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     57a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     57e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     582:	75 25                	jne    5a9 <printf+0xff>
          s = "(null)";
     584:	c7 45 f4 cd 10 00 00 	movl   $0x10cd,-0xc(%ebp)
        while(*s != 0){
     58b:	eb 1c                	jmp    5a9 <printf+0xff>
          putc(fd, *s);
     58d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     590:	0f b6 00             	movzbl (%eax),%eax
     593:	0f be c0             	movsbl %al,%eax
     596:	83 ec 08             	sub    $0x8,%esp
     599:	50                   	push   %eax
     59a:	ff 75 08             	pushl  0x8(%ebp)
     59d:	e8 35 fe ff ff       	call   3d7 <putc>
     5a2:	83 c4 10             	add    $0x10,%esp
          s++;
     5a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     5a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ac:	0f b6 00             	movzbl (%eax),%eax
     5af:	84 c0                	test   %al,%al
     5b1:	75 da                	jne    58d <printf+0xe3>
     5b3:	eb 65                	jmp    61a <printf+0x170>
        }
      } else if(c == 'c'){
     5b5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     5b9:	75 1d                	jne    5d8 <printf+0x12e>
        putc(fd, *ap);
     5bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5be:	8b 00                	mov    (%eax),%eax
     5c0:	0f be c0             	movsbl %al,%eax
     5c3:	83 ec 08             	sub    $0x8,%esp
     5c6:	50                   	push   %eax
     5c7:	ff 75 08             	pushl  0x8(%ebp)
     5ca:	e8 08 fe ff ff       	call   3d7 <putc>
     5cf:	83 c4 10             	add    $0x10,%esp
        ap++;
     5d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5d6:	eb 42                	jmp    61a <printf+0x170>
      } else if(c == '%'){
     5d8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5dc:	75 17                	jne    5f5 <printf+0x14b>
        putc(fd, c);
     5de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5e1:	0f be c0             	movsbl %al,%eax
     5e4:	83 ec 08             	sub    $0x8,%esp
     5e7:	50                   	push   %eax
     5e8:	ff 75 08             	pushl  0x8(%ebp)
     5eb:	e8 e7 fd ff ff       	call   3d7 <putc>
     5f0:	83 c4 10             	add    $0x10,%esp
     5f3:	eb 25                	jmp    61a <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5f5:	83 ec 08             	sub    $0x8,%esp
     5f8:	6a 25                	push   $0x25
     5fa:	ff 75 08             	pushl  0x8(%ebp)
     5fd:	e8 d5 fd ff ff       	call   3d7 <putc>
     602:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     605:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     608:	0f be c0             	movsbl %al,%eax
     60b:	83 ec 08             	sub    $0x8,%esp
     60e:	50                   	push   %eax
     60f:	ff 75 08             	pushl  0x8(%ebp)
     612:	e8 c0 fd ff ff       	call   3d7 <putc>
     617:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     61a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     621:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     625:	8b 55 0c             	mov    0xc(%ebp),%edx
     628:	8b 45 f0             	mov    -0x10(%ebp),%eax
     62b:	01 d0                	add    %edx,%eax
     62d:	0f b6 00             	movzbl (%eax),%eax
     630:	84 c0                	test   %al,%al
     632:	0f 85 94 fe ff ff    	jne    4cc <printf+0x22>
    }
  }
}
     638:	90                   	nop
     639:	c9                   	leave  
     63a:	c3                   	ret    

0000063b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     63b:	55                   	push   %ebp
     63c:	89 e5                	mov    %esp,%ebp
     63e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     641:	8b 45 08             	mov    0x8(%ebp),%eax
     644:	83 e8 08             	sub    $0x8,%eax
     647:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     64a:	a1 8c 17 00 00       	mov    0x178c,%eax
     64f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     652:	eb 24                	jmp    678 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     654:	8b 45 fc             	mov    -0x4(%ebp),%eax
     657:	8b 00                	mov    (%eax),%eax
     659:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     65c:	72 12                	jb     670 <free+0x35>
     65e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     661:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     664:	77 24                	ja     68a <free+0x4f>
     666:	8b 45 fc             	mov    -0x4(%ebp),%eax
     669:	8b 00                	mov    (%eax),%eax
     66b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     66e:	72 1a                	jb     68a <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     670:	8b 45 fc             	mov    -0x4(%ebp),%eax
     673:	8b 00                	mov    (%eax),%eax
     675:	89 45 fc             	mov    %eax,-0x4(%ebp)
     678:	8b 45 f8             	mov    -0x8(%ebp),%eax
     67b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     67e:	76 d4                	jbe    654 <free+0x19>
     680:	8b 45 fc             	mov    -0x4(%ebp),%eax
     683:	8b 00                	mov    (%eax),%eax
     685:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     688:	73 ca                	jae    654 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     68a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68d:	8b 40 04             	mov    0x4(%eax),%eax
     690:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     697:	8b 45 f8             	mov    -0x8(%ebp),%eax
     69a:	01 c2                	add    %eax,%edx
     69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69f:	8b 00                	mov    (%eax),%eax
     6a1:	39 c2                	cmp    %eax,%edx
     6a3:	75 24                	jne    6c9 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     6a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a8:	8b 50 04             	mov    0x4(%eax),%edx
     6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ae:	8b 00                	mov    (%eax),%eax
     6b0:	8b 40 04             	mov    0x4(%eax),%eax
     6b3:	01 c2                	add    %eax,%edx
     6b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b8:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6be:	8b 00                	mov    (%eax),%eax
     6c0:	8b 10                	mov    (%eax),%edx
     6c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c5:	89 10                	mov    %edx,(%eax)
     6c7:	eb 0a                	jmp    6d3 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cc:	8b 10                	mov    (%eax),%edx
     6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d1:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d6:	8b 40 04             	mov    0x4(%eax),%eax
     6d9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e3:	01 d0                	add    %edx,%eax
     6e5:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6e8:	75 20                	jne    70a <free+0xcf>
    p->s.size += bp->s.size;
     6ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ed:	8b 50 04             	mov    0x4(%eax),%edx
     6f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f3:	8b 40 04             	mov    0x4(%eax),%eax
     6f6:	01 c2                	add    %eax,%edx
     6f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6fb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
     701:	8b 10                	mov    (%eax),%edx
     703:	8b 45 fc             	mov    -0x4(%ebp),%eax
     706:	89 10                	mov    %edx,(%eax)
     708:	eb 08                	jmp    712 <free+0xd7>
  } else
    p->s.ptr = bp;
     70a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     70d:	8b 55 f8             	mov    -0x8(%ebp),%edx
     710:	89 10                	mov    %edx,(%eax)
  freep = p;
     712:	8b 45 fc             	mov    -0x4(%ebp),%eax
     715:	a3 8c 17 00 00       	mov    %eax,0x178c
}
     71a:	90                   	nop
     71b:	c9                   	leave  
     71c:	c3                   	ret    

0000071d <morecore>:

static Header*
morecore(uint nu)
{
     71d:	55                   	push   %ebp
     71e:	89 e5                	mov    %esp,%ebp
     720:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     723:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     72a:	77 07                	ja     733 <morecore+0x16>
    nu = 4096;
     72c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     733:	8b 45 08             	mov    0x8(%ebp),%eax
     736:	c1 e0 03             	shl    $0x3,%eax
     739:	83 ec 0c             	sub    $0xc,%esp
     73c:	50                   	push   %eax
     73d:	e8 5d fc ff ff       	call   39f <sbrk>
     742:	83 c4 10             	add    $0x10,%esp
     745:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     748:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     74c:	75 07                	jne    755 <morecore+0x38>
    return 0;
     74e:	b8 00 00 00 00       	mov    $0x0,%eax
     753:	eb 26                	jmp    77b <morecore+0x5e>
  hp = (Header*)p;
     755:	8b 45 f4             	mov    -0xc(%ebp),%eax
     758:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     75b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     75e:	8b 55 08             	mov    0x8(%ebp),%edx
     761:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     764:	8b 45 f0             	mov    -0x10(%ebp),%eax
     767:	83 c0 08             	add    $0x8,%eax
     76a:	83 ec 0c             	sub    $0xc,%esp
     76d:	50                   	push   %eax
     76e:	e8 c8 fe ff ff       	call   63b <free>
     773:	83 c4 10             	add    $0x10,%esp
  return freep;
     776:	a1 8c 17 00 00       	mov    0x178c,%eax
}
     77b:	c9                   	leave  
     77c:	c3                   	ret    

0000077d <malloc>:

void*
malloc(uint nbytes)
{
     77d:	55                   	push   %ebp
     77e:	89 e5                	mov    %esp,%ebp
     780:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     783:	8b 45 08             	mov    0x8(%ebp),%eax
     786:	83 c0 07             	add    $0x7,%eax
     789:	c1 e8 03             	shr    $0x3,%eax
     78c:	83 c0 01             	add    $0x1,%eax
     78f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     792:	a1 8c 17 00 00       	mov    0x178c,%eax
     797:	89 45 f0             	mov    %eax,-0x10(%ebp)
     79a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     79e:	75 23                	jne    7c3 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7a0:	c7 45 f0 84 17 00 00 	movl   $0x1784,-0x10(%ebp)
     7a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7aa:	a3 8c 17 00 00       	mov    %eax,0x178c
     7af:	a1 8c 17 00 00       	mov    0x178c,%eax
     7b4:	a3 84 17 00 00       	mov    %eax,0x1784
    base.s.size = 0;
     7b9:	c7 05 88 17 00 00 00 	movl   $0x0,0x1788
     7c0:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c6:	8b 00                	mov    (%eax),%eax
     7c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ce:	8b 40 04             	mov    0x4(%eax),%eax
     7d1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7d4:	77 4d                	ja     823 <malloc+0xa6>
      if(p->s.size == nunits)
     7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d9:	8b 40 04             	mov    0x4(%eax),%eax
     7dc:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7df:	75 0c                	jne    7ed <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e4:	8b 10                	mov    (%eax),%edx
     7e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e9:	89 10                	mov    %edx,(%eax)
     7eb:	eb 26                	jmp    813 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f0:	8b 40 04             	mov    0x4(%eax),%eax
     7f3:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7f6:	89 c2                	mov    %eax,%edx
     7f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7fb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     801:	8b 40 04             	mov    0x4(%eax),%eax
     804:	c1 e0 03             	shl    $0x3,%eax
     807:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     80a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80d:	8b 55 ec             	mov    -0x14(%ebp),%edx
     810:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     813:	8b 45 f0             	mov    -0x10(%ebp),%eax
     816:	a3 8c 17 00 00       	mov    %eax,0x178c
      return (void*)(p + 1);
     81b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81e:	83 c0 08             	add    $0x8,%eax
     821:	eb 3b                	jmp    85e <malloc+0xe1>
    }
    if(p == freep)
     823:	a1 8c 17 00 00       	mov    0x178c,%eax
     828:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     82b:	75 1e                	jne    84b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     82d:	83 ec 0c             	sub    $0xc,%esp
     830:	ff 75 ec             	pushl  -0x14(%ebp)
     833:	e8 e5 fe ff ff       	call   71d <morecore>
     838:	83 c4 10             	add    $0x10,%esp
     83b:	89 45 f4             	mov    %eax,-0xc(%ebp)
     83e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     842:	75 07                	jne    84b <malloc+0xce>
        return 0;
     844:	b8 00 00 00 00       	mov    $0x0,%eax
     849:	eb 13                	jmp    85e <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     84b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     851:	8b 45 f4             	mov    -0xc(%ebp),%eax
     854:	8b 00                	mov    (%eax),%eax
     856:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     859:	e9 6d ff ff ff       	jmp    7cb <malloc+0x4e>
  }
}
     85e:	c9                   	leave  
     85f:	c3                   	ret    

00000860 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	53                   	push   %ebx
     864:	83 ec 14             	sub    $0x14,%esp
     867:	8b 45 10             	mov    0x10(%ebp),%eax
     86a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     86d:	8b 45 14             	mov    0x14(%ebp),%eax
     870:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     873:	8b 45 18             	mov    0x18(%ebp),%eax
     876:	ba 00 00 00 00       	mov    $0x0,%edx
     87b:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     87e:	72 55                	jb     8d5 <printnum+0x75>
     880:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     883:	77 05                	ja     88a <printnum+0x2a>
     885:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     888:	72 4b                	jb     8d5 <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     88a:	8b 45 1c             	mov    0x1c(%ebp),%eax
     88d:	8d 58 ff             	lea    -0x1(%eax),%ebx
     890:	8b 45 18             	mov    0x18(%ebp),%eax
     893:	ba 00 00 00 00       	mov    $0x0,%edx
     898:	52                   	push   %edx
     899:	50                   	push   %eax
     89a:	ff 75 f4             	pushl  -0xc(%ebp)
     89d:	ff 75 f0             	pushl  -0x10(%ebp)
     8a0:	e8 ab 05 00 00       	call   e50 <__udivdi3>
     8a5:	83 c4 10             	add    $0x10,%esp
     8a8:	83 ec 04             	sub    $0x4,%esp
     8ab:	ff 75 20             	pushl  0x20(%ebp)
     8ae:	53                   	push   %ebx
     8af:	ff 75 18             	pushl  0x18(%ebp)
     8b2:	52                   	push   %edx
     8b3:	50                   	push   %eax
     8b4:	ff 75 0c             	pushl  0xc(%ebp)
     8b7:	ff 75 08             	pushl  0x8(%ebp)
     8ba:	e8 a1 ff ff ff       	call   860 <printnum>
     8bf:	83 c4 20             	add    $0x20,%esp
     8c2:	eb 1b                	jmp    8df <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     8c4:	83 ec 08             	sub    $0x8,%esp
     8c7:	ff 75 0c             	pushl  0xc(%ebp)
     8ca:	ff 75 20             	pushl  0x20(%ebp)
     8cd:	8b 45 08             	mov    0x8(%ebp),%eax
     8d0:	ff d0                	call   *%eax
     8d2:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     8d5:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     8d9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     8dd:	7f e5                	jg     8c4 <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     8df:	8b 4d 18             	mov    0x18(%ebp),%ecx
     8e2:	bb 00 00 00 00       	mov    $0x0,%ebx
     8e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8ed:	53                   	push   %ebx
     8ee:	51                   	push   %ecx
     8ef:	52                   	push   %edx
     8f0:	50                   	push   %eax
     8f1:	e8 7a 06 00 00       	call   f70 <__umoddi3>
     8f6:	83 c4 10             	add    $0x10,%esp
     8f9:	05 a0 11 00 00       	add    $0x11a0,%eax
     8fe:	0f b6 00             	movzbl (%eax),%eax
     901:	0f be c0             	movsbl %al,%eax
     904:	83 ec 08             	sub    $0x8,%esp
     907:	ff 75 0c             	pushl  0xc(%ebp)
     90a:	50                   	push   %eax
     90b:	8b 45 08             	mov    0x8(%ebp),%eax
     90e:	ff d0                	call   *%eax
     910:	83 c4 10             	add    $0x10,%esp
}
     913:	90                   	nop
     914:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     917:	c9                   	leave  
     918:	c3                   	ret    

00000919 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     919:	55                   	push   %ebp
     91a:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     91c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     920:	7e 14                	jle    936 <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     922:	8b 45 08             	mov    0x8(%ebp),%eax
     925:	8b 00                	mov    (%eax),%eax
     927:	8d 48 08             	lea    0x8(%eax),%ecx
     92a:	8b 55 08             	mov    0x8(%ebp),%edx
     92d:	89 0a                	mov    %ecx,(%edx)
     92f:	8b 50 04             	mov    0x4(%eax),%edx
     932:	8b 00                	mov    (%eax),%eax
     934:	eb 30                	jmp    966 <getuint+0x4d>
  else if (lflag)
     936:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     93a:	74 16                	je     952 <getuint+0x39>
    return va_arg(*ap, unsigned long);
     93c:	8b 45 08             	mov    0x8(%ebp),%eax
     93f:	8b 00                	mov    (%eax),%eax
     941:	8d 48 04             	lea    0x4(%eax),%ecx
     944:	8b 55 08             	mov    0x8(%ebp),%edx
     947:	89 0a                	mov    %ecx,(%edx)
     949:	8b 00                	mov    (%eax),%eax
     94b:	ba 00 00 00 00       	mov    $0x0,%edx
     950:	eb 14                	jmp    966 <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     952:	8b 45 08             	mov    0x8(%ebp),%eax
     955:	8b 00                	mov    (%eax),%eax
     957:	8d 48 04             	lea    0x4(%eax),%ecx
     95a:	8b 55 08             	mov    0x8(%ebp),%edx
     95d:	89 0a                	mov    %ecx,(%edx)
     95f:	8b 00                	mov    (%eax),%eax
     961:	ba 00 00 00 00       	mov    $0x0,%edx
}
     966:	5d                   	pop    %ebp
     967:	c3                   	ret    

00000968 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     968:	55                   	push   %ebp
     969:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     96b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     96f:	7e 14                	jle    985 <getint+0x1d>
    return va_arg(*ap, long long);
     971:	8b 45 08             	mov    0x8(%ebp),%eax
     974:	8b 00                	mov    (%eax),%eax
     976:	8d 48 08             	lea    0x8(%eax),%ecx
     979:	8b 55 08             	mov    0x8(%ebp),%edx
     97c:	89 0a                	mov    %ecx,(%edx)
     97e:	8b 50 04             	mov    0x4(%eax),%edx
     981:	8b 00                	mov    (%eax),%eax
     983:	eb 28                	jmp    9ad <getint+0x45>
  else if (lflag)
     985:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     989:	74 12                	je     99d <getint+0x35>
    return va_arg(*ap, long);
     98b:	8b 45 08             	mov    0x8(%ebp),%eax
     98e:	8b 00                	mov    (%eax),%eax
     990:	8d 48 04             	lea    0x4(%eax),%ecx
     993:	8b 55 08             	mov    0x8(%ebp),%edx
     996:	89 0a                	mov    %ecx,(%edx)
     998:	8b 00                	mov    (%eax),%eax
     99a:	99                   	cltd   
     99b:	eb 10                	jmp    9ad <getint+0x45>
  else
    return va_arg(*ap, int);
     99d:	8b 45 08             	mov    0x8(%ebp),%eax
     9a0:	8b 00                	mov    (%eax),%eax
     9a2:	8d 48 04             	lea    0x4(%eax),%ecx
     9a5:	8b 55 08             	mov    0x8(%ebp),%edx
     9a8:	89 0a                	mov    %ecx,(%edx)
     9aa:	8b 00                	mov    (%eax),%eax
     9ac:	99                   	cltd   
}
     9ad:	5d                   	pop    %ebp
     9ae:	c3                   	ret    

000009af <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     9af:	55                   	push   %ebp
     9b0:	89 e5                	mov    %esp,%ebp
     9b2:	56                   	push   %esi
     9b3:	53                   	push   %ebx
     9b4:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     9b7:	eb 17                	jmp    9d0 <vprintfmt+0x21>
      if (ch == '\0')
     9b9:	85 db                	test   %ebx,%ebx
     9bb:	0f 84 a0 03 00 00    	je     d61 <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     9c1:	83 ec 08             	sub    $0x8,%esp
     9c4:	ff 75 0c             	pushl  0xc(%ebp)
     9c7:	53                   	push   %ebx
     9c8:	8b 45 08             	mov    0x8(%ebp),%eax
     9cb:	ff d0                	call   *%eax
     9cd:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     9d0:	8b 45 10             	mov    0x10(%ebp),%eax
     9d3:	8d 50 01             	lea    0x1(%eax),%edx
     9d6:	89 55 10             	mov    %edx,0x10(%ebp)
     9d9:	0f b6 00             	movzbl (%eax),%eax
     9dc:	0f b6 d8             	movzbl %al,%ebx
     9df:	83 fb 25             	cmp    $0x25,%ebx
     9e2:	75 d5                	jne    9b9 <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     9e4:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     9e8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     9ef:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     9f6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     9fd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     a04:	8b 45 10             	mov    0x10(%ebp),%eax
     a07:	8d 50 01             	lea    0x1(%eax),%edx
     a0a:	89 55 10             	mov    %edx,0x10(%ebp)
     a0d:	0f b6 00             	movzbl (%eax),%eax
     a10:	0f b6 d8             	movzbl %al,%ebx
     a13:	8d 43 dd             	lea    -0x23(%ebx),%eax
     a16:	83 f8 55             	cmp    $0x55,%eax
     a19:	0f 87 15 03 00 00    	ja     d34 <vprintfmt+0x385>
     a1f:	8b 04 85 c4 11 00 00 	mov    0x11c4(,%eax,4),%eax
     a26:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     a28:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     a2c:	eb d6                	jmp    a04 <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     a2e:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     a32:	eb d0                	jmp    a04 <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     a34:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     a3b:	8b 55 e0             	mov    -0x20(%ebp),%edx
     a3e:	89 d0                	mov    %edx,%eax
     a40:	c1 e0 02             	shl    $0x2,%eax
     a43:	01 d0                	add    %edx,%eax
     a45:	01 c0                	add    %eax,%eax
     a47:	01 d8                	add    %ebx,%eax
     a49:	83 e8 30             	sub    $0x30,%eax
     a4c:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     a4f:	8b 45 10             	mov    0x10(%ebp),%eax
     a52:	0f b6 00             	movzbl (%eax),%eax
     a55:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     a58:	83 fb 2f             	cmp    $0x2f,%ebx
     a5b:	7e 39                	jle    a96 <vprintfmt+0xe7>
     a5d:	83 fb 39             	cmp    $0x39,%ebx
     a60:	7f 34                	jg     a96 <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     a62:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     a66:	eb d3                	jmp    a3b <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     a68:	8b 45 14             	mov    0x14(%ebp),%eax
     a6b:	8d 50 04             	lea    0x4(%eax),%edx
     a6e:	89 55 14             	mov    %edx,0x14(%ebp)
     a71:	8b 00                	mov    (%eax),%eax
     a73:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     a76:	eb 1f                	jmp    a97 <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     a78:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a7c:	79 86                	jns    a04 <vprintfmt+0x55>
        width = 0;
     a7e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     a85:	e9 7a ff ff ff       	jmp    a04 <vprintfmt+0x55>

    case '#':
      altflag = 1;
     a8a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     a91:	e9 6e ff ff ff       	jmp    a04 <vprintfmt+0x55>
      goto process_precision;
     a96:	90                   	nop

process_precision:
      if (width < 0)
     a97:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a9b:	0f 89 63 ff ff ff    	jns    a04 <vprintfmt+0x55>
        width = precision, precision = -1;
     aa1:	8b 45 e0             	mov    -0x20(%ebp),%eax
     aa4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     aa7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     aae:	e9 51 ff ff ff       	jmp    a04 <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     ab3:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     ab7:	e9 48 ff ff ff       	jmp    a04 <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     abc:	8b 45 14             	mov    0x14(%ebp),%eax
     abf:	8d 50 04             	lea    0x4(%eax),%edx
     ac2:	89 55 14             	mov    %edx,0x14(%ebp)
     ac5:	8b 00                	mov    (%eax),%eax
     ac7:	83 ec 08             	sub    $0x8,%esp
     aca:	ff 75 0c             	pushl  0xc(%ebp)
     acd:	50                   	push   %eax
     ace:	8b 45 08             	mov    0x8(%ebp),%eax
     ad1:	ff d0                	call   *%eax
     ad3:	83 c4 10             	add    $0x10,%esp
      break;
     ad6:	e9 81 02 00 00       	jmp    d5c <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     adb:	8b 45 14             	mov    0x14(%ebp),%eax
     ade:	8d 50 04             	lea    0x4(%eax),%edx
     ae1:	89 55 14             	mov    %edx,0x14(%ebp)
     ae4:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     ae6:	85 db                	test   %ebx,%ebx
     ae8:	79 02                	jns    aec <vprintfmt+0x13d>
        err = -err;
     aea:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     aec:	83 fb 0f             	cmp    $0xf,%ebx
     aef:	7f 0b                	jg     afc <vprintfmt+0x14d>
     af1:	8b 34 9d 60 11 00 00 	mov    0x1160(,%ebx,4),%esi
     af8:	85 f6                	test   %esi,%esi
     afa:	75 19                	jne    b15 <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     afc:	53                   	push   %ebx
     afd:	68 b1 11 00 00       	push   $0x11b1
     b02:	ff 75 0c             	pushl  0xc(%ebp)
     b05:	ff 75 08             	pushl  0x8(%ebp)
     b08:	e8 5c 02 00 00       	call   d69 <printfmt>
     b0d:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     b10:	e9 47 02 00 00       	jmp    d5c <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     b15:	56                   	push   %esi
     b16:	68 ba 11 00 00       	push   $0x11ba
     b1b:	ff 75 0c             	pushl  0xc(%ebp)
     b1e:	ff 75 08             	pushl  0x8(%ebp)
     b21:	e8 43 02 00 00       	call   d69 <printfmt>
     b26:	83 c4 10             	add    $0x10,%esp
      break;
     b29:	e9 2e 02 00 00       	jmp    d5c <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     b2e:	8b 45 14             	mov    0x14(%ebp),%eax
     b31:	8d 50 04             	lea    0x4(%eax),%edx
     b34:	89 55 14             	mov    %edx,0x14(%ebp)
     b37:	8b 30                	mov    (%eax),%esi
     b39:	85 f6                	test   %esi,%esi
     b3b:	75 05                	jne    b42 <vprintfmt+0x193>
        p = "(null)";
     b3d:	be bd 11 00 00       	mov    $0x11bd,%esi
      if (width > 0 && padc != '-')
     b42:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b46:	7e 6f                	jle    bb7 <vprintfmt+0x208>
     b48:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     b4c:	74 69                	je     bb7 <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     b4e:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b51:	83 ec 08             	sub    $0x8,%esp
     b54:	50                   	push   %eax
     b55:	56                   	push   %esi
     b56:	e8 f1 f5 ff ff       	call   14c <strnlen>
     b5b:	83 c4 10             	add    $0x10,%esp
     b5e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     b61:	eb 17                	jmp    b7a <vprintfmt+0x1cb>
          putch(padc, putdat);
     b63:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     b67:	83 ec 08             	sub    $0x8,%esp
     b6a:	ff 75 0c             	pushl  0xc(%ebp)
     b6d:	50                   	push   %eax
     b6e:	8b 45 08             	mov    0x8(%ebp),%eax
     b71:	ff d0                	call   *%eax
     b73:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     b76:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b7a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b7e:	7f e3                	jg     b63 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b80:	eb 35                	jmp    bb7 <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     b82:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     b86:	74 1c                	je     ba4 <vprintfmt+0x1f5>
     b88:	83 fb 1f             	cmp    $0x1f,%ebx
     b8b:	7e 05                	jle    b92 <vprintfmt+0x1e3>
     b8d:	83 fb 7e             	cmp    $0x7e,%ebx
     b90:	7e 12                	jle    ba4 <vprintfmt+0x1f5>
          putch('?', putdat);
     b92:	83 ec 08             	sub    $0x8,%esp
     b95:	ff 75 0c             	pushl  0xc(%ebp)
     b98:	6a 3f                	push   $0x3f
     b9a:	8b 45 08             	mov    0x8(%ebp),%eax
     b9d:	ff d0                	call   *%eax
     b9f:	83 c4 10             	add    $0x10,%esp
     ba2:	eb 0f                	jmp    bb3 <vprintfmt+0x204>
        else
          putch(ch, putdat);
     ba4:	83 ec 08             	sub    $0x8,%esp
     ba7:	ff 75 0c             	pushl  0xc(%ebp)
     baa:	53                   	push   %ebx
     bab:	8b 45 08             	mov    0x8(%ebp),%eax
     bae:	ff d0                	call   *%eax
     bb0:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     bb3:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     bb7:	89 f0                	mov    %esi,%eax
     bb9:	8d 70 01             	lea    0x1(%eax),%esi
     bbc:	0f b6 00             	movzbl (%eax),%eax
     bbf:	0f be d8             	movsbl %al,%ebx
     bc2:	85 db                	test   %ebx,%ebx
     bc4:	74 26                	je     bec <vprintfmt+0x23d>
     bc6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     bca:	78 b6                	js     b82 <vprintfmt+0x1d3>
     bcc:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     bd0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     bd4:	79 ac                	jns    b82 <vprintfmt+0x1d3>
      for (; width > 0; width--)
     bd6:	eb 14                	jmp    bec <vprintfmt+0x23d>
        putch(' ', putdat);
     bd8:	83 ec 08             	sub    $0x8,%esp
     bdb:	ff 75 0c             	pushl  0xc(%ebp)
     bde:	6a 20                	push   $0x20
     be0:	8b 45 08             	mov    0x8(%ebp),%eax
     be3:	ff d0                	call   *%eax
     be5:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     be8:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     bec:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bf0:	7f e6                	jg     bd8 <vprintfmt+0x229>
      break;
     bf2:	e9 65 01 00 00       	jmp    d5c <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     bf7:	83 ec 08             	sub    $0x8,%esp
     bfa:	ff 75 e8             	pushl  -0x18(%ebp)
     bfd:	8d 45 14             	lea    0x14(%ebp),%eax
     c00:	50                   	push   %eax
     c01:	e8 62 fd ff ff       	call   968 <getint>
     c06:	83 c4 10             	add    $0x10,%esp
     c09:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c0c:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     c0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c12:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c15:	85 d2                	test   %edx,%edx
     c17:	79 23                	jns    c3c <vprintfmt+0x28d>
        putch('-', putdat);
     c19:	83 ec 08             	sub    $0x8,%esp
     c1c:	ff 75 0c             	pushl  0xc(%ebp)
     c1f:	6a 2d                	push   $0x2d
     c21:	8b 45 08             	mov    0x8(%ebp),%eax
     c24:	ff d0                	call   *%eax
     c26:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     c29:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c2c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c2f:	f7 d8                	neg    %eax
     c31:	83 d2 00             	adc    $0x0,%edx
     c34:	f7 da                	neg    %edx
     c36:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c39:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     c3c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c43:	e9 b6 00 00 00       	jmp    cfe <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     c48:	83 ec 08             	sub    $0x8,%esp
     c4b:	ff 75 e8             	pushl  -0x18(%ebp)
     c4e:	8d 45 14             	lea    0x14(%ebp),%eax
     c51:	50                   	push   %eax
     c52:	e8 c2 fc ff ff       	call   919 <getuint>
     c57:	83 c4 10             	add    $0x10,%esp
     c5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c5d:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     c60:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c67:	e9 92 00 00 00       	jmp    cfe <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     c6c:	83 ec 08             	sub    $0x8,%esp
     c6f:	ff 75 0c             	pushl  0xc(%ebp)
     c72:	6a 58                	push   $0x58
     c74:	8b 45 08             	mov    0x8(%ebp),%eax
     c77:	ff d0                	call   *%eax
     c79:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c7c:	83 ec 08             	sub    $0x8,%esp
     c7f:	ff 75 0c             	pushl  0xc(%ebp)
     c82:	6a 58                	push   $0x58
     c84:	8b 45 08             	mov    0x8(%ebp),%eax
     c87:	ff d0                	call   *%eax
     c89:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c8c:	83 ec 08             	sub    $0x8,%esp
     c8f:	ff 75 0c             	pushl  0xc(%ebp)
     c92:	6a 58                	push   $0x58
     c94:	8b 45 08             	mov    0x8(%ebp),%eax
     c97:	ff d0                	call   *%eax
     c99:	83 c4 10             	add    $0x10,%esp
      break;
     c9c:	e9 bb 00 00 00       	jmp    d5c <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     ca1:	83 ec 08             	sub    $0x8,%esp
     ca4:	ff 75 0c             	pushl  0xc(%ebp)
     ca7:	6a 30                	push   $0x30
     ca9:	8b 45 08             	mov    0x8(%ebp),%eax
     cac:	ff d0                	call   *%eax
     cae:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     cb1:	83 ec 08             	sub    $0x8,%esp
     cb4:	ff 75 0c             	pushl  0xc(%ebp)
     cb7:	6a 78                	push   $0x78
     cb9:	8b 45 08             	mov    0x8(%ebp),%eax
     cbc:	ff d0                	call   *%eax
     cbe:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     cc1:	8b 45 14             	mov    0x14(%ebp),%eax
     cc4:	8d 50 04             	lea    0x4(%eax),%edx
     cc7:	89 55 14             	mov    %edx,0x14(%ebp)
     cca:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     ccc:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ccf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     cd6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     cdd:	eb 1f                	jmp    cfe <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     cdf:	83 ec 08             	sub    $0x8,%esp
     ce2:	ff 75 e8             	pushl  -0x18(%ebp)
     ce5:	8d 45 14             	lea    0x14(%ebp),%eax
     ce8:	50                   	push   %eax
     ce9:	e8 2b fc ff ff       	call   919 <getuint>
     cee:	83 c4 10             	add    $0x10,%esp
     cf1:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cf4:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     cf7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     cfe:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     d02:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d05:	83 ec 04             	sub    $0x4,%esp
     d08:	52                   	push   %edx
     d09:	ff 75 e4             	pushl  -0x1c(%ebp)
     d0c:	50                   	push   %eax
     d0d:	ff 75 f4             	pushl  -0xc(%ebp)
     d10:	ff 75 f0             	pushl  -0x10(%ebp)
     d13:	ff 75 0c             	pushl  0xc(%ebp)
     d16:	ff 75 08             	pushl  0x8(%ebp)
     d19:	e8 42 fb ff ff       	call   860 <printnum>
     d1e:	83 c4 20             	add    $0x20,%esp
      break;
     d21:	eb 39                	jmp    d5c <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     d23:	83 ec 08             	sub    $0x8,%esp
     d26:	ff 75 0c             	pushl  0xc(%ebp)
     d29:	53                   	push   %ebx
     d2a:	8b 45 08             	mov    0x8(%ebp),%eax
     d2d:	ff d0                	call   *%eax
     d2f:	83 c4 10             	add    $0x10,%esp
      break;
     d32:	eb 28                	jmp    d5c <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     d34:	83 ec 08             	sub    $0x8,%esp
     d37:	ff 75 0c             	pushl  0xc(%ebp)
     d3a:	6a 25                	push   $0x25
     d3c:	8b 45 08             	mov    0x8(%ebp),%eax
     d3f:	ff d0                	call   *%eax
     d41:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     d44:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d48:	eb 04                	jmp    d4e <vprintfmt+0x39f>
     d4a:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d4e:	8b 45 10             	mov    0x10(%ebp),%eax
     d51:	83 e8 01             	sub    $0x1,%eax
     d54:	0f b6 00             	movzbl (%eax),%eax
     d57:	3c 25                	cmp    $0x25,%al
     d59:	75 ef                	jne    d4a <vprintfmt+0x39b>
        /* do nothing */;
      break;
     d5b:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     d5c:	e9 6f fc ff ff       	jmp    9d0 <vprintfmt+0x21>
        return;
     d61:	90                   	nop
    }
  }
}
     d62:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d65:	5b                   	pop    %ebx
     d66:	5e                   	pop    %esi
     d67:	5d                   	pop    %ebp
     d68:	c3                   	ret    

00000d69 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     d69:	55                   	push   %ebp
     d6a:	89 e5                	mov    %esp,%ebp
     d6c:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     d6f:	8d 45 14             	lea    0x14(%ebp),%eax
     d72:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     d75:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d78:	50                   	push   %eax
     d79:	ff 75 10             	pushl  0x10(%ebp)
     d7c:	ff 75 0c             	pushl  0xc(%ebp)
     d7f:	ff 75 08             	pushl  0x8(%ebp)
     d82:	e8 28 fc ff ff       	call   9af <vprintfmt>
     d87:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     d8a:	90                   	nop
     d8b:	c9                   	leave  
     d8c:	c3                   	ret    

00000d8d <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     d8d:	55                   	push   %ebp
     d8e:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     d90:	8b 45 0c             	mov    0xc(%ebp),%eax
     d93:	8b 40 08             	mov    0x8(%eax),%eax
     d96:	8d 50 01             	lea    0x1(%eax),%edx
     d99:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9c:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     d9f:	8b 45 0c             	mov    0xc(%ebp),%eax
     da2:	8b 10                	mov    (%eax),%edx
     da4:	8b 45 0c             	mov    0xc(%ebp),%eax
     da7:	8b 40 04             	mov    0x4(%eax),%eax
     daa:	39 c2                	cmp    %eax,%edx
     dac:	73 12                	jae    dc0 <sprintputch+0x33>
    *b->buf++ = ch;
     dae:	8b 45 0c             	mov    0xc(%ebp),%eax
     db1:	8b 00                	mov    (%eax),%eax
     db3:	8d 48 01             	lea    0x1(%eax),%ecx
     db6:	8b 55 0c             	mov    0xc(%ebp),%edx
     db9:	89 0a                	mov    %ecx,(%edx)
     dbb:	8b 55 08             	mov    0x8(%ebp),%edx
     dbe:	88 10                	mov    %dl,(%eax)
}
     dc0:	90                   	nop
     dc1:	5d                   	pop    %ebp
     dc2:	c3                   	ret    

00000dc3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     dc3:	55                   	push   %ebp
     dc4:	89 e5                	mov    %esp,%ebp
     dc6:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     dc9:	8b 45 08             	mov    0x8(%ebp),%eax
     dcc:	89 45 ec             	mov    %eax,-0x14(%ebp)
     dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd2:	8d 50 ff             	lea    -0x1(%eax),%edx
     dd5:	8b 45 08             	mov    0x8(%ebp),%eax
     dd8:	01 d0                	add    %edx,%eax
     dda:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ddd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     de4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     de8:	74 06                	je     df0 <vsnprintf+0x2d>
     dea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dee:	7f 07                	jg     df7 <vsnprintf+0x34>
    return -E_INVAL;
     df0:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     df5:	eb 20                	jmp    e17 <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     df7:	ff 75 14             	pushl  0x14(%ebp)
     dfa:	ff 75 10             	pushl  0x10(%ebp)
     dfd:	8d 45 ec             	lea    -0x14(%ebp),%eax
     e00:	50                   	push   %eax
     e01:	68 8d 0d 00 00       	push   $0xd8d
     e06:	e8 a4 fb ff ff       	call   9af <vprintfmt>
     e0b:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     e0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e11:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     e14:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e17:	c9                   	leave  
     e18:	c3                   	ret    

00000e19 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     e19:	55                   	push   %ebp
     e1a:	89 e5                	mov    %esp,%ebp
     e1c:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     e1f:	8d 45 14             	lea    0x14(%ebp),%eax
     e22:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     e25:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e28:	50                   	push   %eax
     e29:	ff 75 10             	pushl  0x10(%ebp)
     e2c:	ff 75 0c             	pushl  0xc(%ebp)
     e2f:	ff 75 08             	pushl  0x8(%ebp)
     e32:	e8 8c ff ff ff       	call   dc3 <vsnprintf>
     e37:	83 c4 10             	add    $0x10,%esp
     e3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     e3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e40:	c9                   	leave  
     e41:	c3                   	ret    
     e42:	66 90                	xchg   %ax,%ax
     e44:	66 90                	xchg   %ax,%ax
     e46:	66 90                	xchg   %ax,%ax
     e48:	66 90                	xchg   %ax,%ax
     e4a:	66 90                	xchg   %ax,%ax
     e4c:	66 90                	xchg   %ax,%ax
     e4e:	66 90                	xchg   %ax,%ax

00000e50 <__udivdi3>:
     e50:	55                   	push   %ebp
     e51:	57                   	push   %edi
     e52:	56                   	push   %esi
     e53:	53                   	push   %ebx
     e54:	83 ec 1c             	sub    $0x1c,%esp
     e57:	8b 54 24 3c          	mov    0x3c(%esp),%edx
     e5b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
     e5f:	8b 74 24 34          	mov    0x34(%esp),%esi
     e63:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     e67:	85 d2                	test   %edx,%edx
     e69:	75 35                	jne    ea0 <__udivdi3+0x50>
     e6b:	39 f3                	cmp    %esi,%ebx
     e6d:	0f 87 bd 00 00 00    	ja     f30 <__udivdi3+0xe0>
     e73:	85 db                	test   %ebx,%ebx
     e75:	89 d9                	mov    %ebx,%ecx
     e77:	75 0b                	jne    e84 <__udivdi3+0x34>
     e79:	b8 01 00 00 00       	mov    $0x1,%eax
     e7e:	31 d2                	xor    %edx,%edx
     e80:	f7 f3                	div    %ebx
     e82:	89 c1                	mov    %eax,%ecx
     e84:	31 d2                	xor    %edx,%edx
     e86:	89 f0                	mov    %esi,%eax
     e88:	f7 f1                	div    %ecx
     e8a:	89 c6                	mov    %eax,%esi
     e8c:	89 e8                	mov    %ebp,%eax
     e8e:	89 f7                	mov    %esi,%edi
     e90:	f7 f1                	div    %ecx
     e92:	89 fa                	mov    %edi,%edx
     e94:	83 c4 1c             	add    $0x1c,%esp
     e97:	5b                   	pop    %ebx
     e98:	5e                   	pop    %esi
     e99:	5f                   	pop    %edi
     e9a:	5d                   	pop    %ebp
     e9b:	c3                   	ret    
     e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ea0:	39 f2                	cmp    %esi,%edx
     ea2:	77 7c                	ja     f20 <__udivdi3+0xd0>
     ea4:	0f bd fa             	bsr    %edx,%edi
     ea7:	83 f7 1f             	xor    $0x1f,%edi
     eaa:	0f 84 98 00 00 00    	je     f48 <__udivdi3+0xf8>
     eb0:	89 f9                	mov    %edi,%ecx
     eb2:	b8 20 00 00 00       	mov    $0x20,%eax
     eb7:	29 f8                	sub    %edi,%eax
     eb9:	d3 e2                	shl    %cl,%edx
     ebb:	89 54 24 08          	mov    %edx,0x8(%esp)
     ebf:	89 c1                	mov    %eax,%ecx
     ec1:	89 da                	mov    %ebx,%edx
     ec3:	d3 ea                	shr    %cl,%edx
     ec5:	8b 4c 24 08          	mov    0x8(%esp),%ecx
     ec9:	09 d1                	or     %edx,%ecx
     ecb:	89 f2                	mov    %esi,%edx
     ecd:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     ed1:	89 f9                	mov    %edi,%ecx
     ed3:	d3 e3                	shl    %cl,%ebx
     ed5:	89 c1                	mov    %eax,%ecx
     ed7:	d3 ea                	shr    %cl,%edx
     ed9:	89 f9                	mov    %edi,%ecx
     edb:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     edf:	d3 e6                	shl    %cl,%esi
     ee1:	89 eb                	mov    %ebp,%ebx
     ee3:	89 c1                	mov    %eax,%ecx
     ee5:	d3 eb                	shr    %cl,%ebx
     ee7:	09 de                	or     %ebx,%esi
     ee9:	89 f0                	mov    %esi,%eax
     eeb:	f7 74 24 08          	divl   0x8(%esp)
     eef:	89 d6                	mov    %edx,%esi
     ef1:	89 c3                	mov    %eax,%ebx
     ef3:	f7 64 24 0c          	mull   0xc(%esp)
     ef7:	39 d6                	cmp    %edx,%esi
     ef9:	72 0c                	jb     f07 <__udivdi3+0xb7>
     efb:	89 f9                	mov    %edi,%ecx
     efd:	d3 e5                	shl    %cl,%ebp
     eff:	39 c5                	cmp    %eax,%ebp
     f01:	73 5d                	jae    f60 <__udivdi3+0x110>
     f03:	39 d6                	cmp    %edx,%esi
     f05:	75 59                	jne    f60 <__udivdi3+0x110>
     f07:	8d 43 ff             	lea    -0x1(%ebx),%eax
     f0a:	31 ff                	xor    %edi,%edi
     f0c:	89 fa                	mov    %edi,%edx
     f0e:	83 c4 1c             	add    $0x1c,%esp
     f11:	5b                   	pop    %ebx
     f12:	5e                   	pop    %esi
     f13:	5f                   	pop    %edi
     f14:	5d                   	pop    %ebp
     f15:	c3                   	ret    
     f16:	8d 76 00             	lea    0x0(%esi),%esi
     f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     f20:	31 ff                	xor    %edi,%edi
     f22:	31 c0                	xor    %eax,%eax
     f24:	89 fa                	mov    %edi,%edx
     f26:	83 c4 1c             	add    $0x1c,%esp
     f29:	5b                   	pop    %ebx
     f2a:	5e                   	pop    %esi
     f2b:	5f                   	pop    %edi
     f2c:	5d                   	pop    %ebp
     f2d:	c3                   	ret    
     f2e:	66 90                	xchg   %ax,%ax
     f30:	31 ff                	xor    %edi,%edi
     f32:	89 e8                	mov    %ebp,%eax
     f34:	89 f2                	mov    %esi,%edx
     f36:	f7 f3                	div    %ebx
     f38:	89 fa                	mov    %edi,%edx
     f3a:	83 c4 1c             	add    $0x1c,%esp
     f3d:	5b                   	pop    %ebx
     f3e:	5e                   	pop    %esi
     f3f:	5f                   	pop    %edi
     f40:	5d                   	pop    %ebp
     f41:	c3                   	ret    
     f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f48:	39 f2                	cmp    %esi,%edx
     f4a:	72 06                	jb     f52 <__udivdi3+0x102>
     f4c:	31 c0                	xor    %eax,%eax
     f4e:	39 eb                	cmp    %ebp,%ebx
     f50:	77 d2                	ja     f24 <__udivdi3+0xd4>
     f52:	b8 01 00 00 00       	mov    $0x1,%eax
     f57:	eb cb                	jmp    f24 <__udivdi3+0xd4>
     f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f60:	89 d8                	mov    %ebx,%eax
     f62:	31 ff                	xor    %edi,%edi
     f64:	eb be                	jmp    f24 <__udivdi3+0xd4>
     f66:	66 90                	xchg   %ax,%ax
     f68:	66 90                	xchg   %ax,%ax
     f6a:	66 90                	xchg   %ax,%ax
     f6c:	66 90                	xchg   %ax,%ax
     f6e:	66 90                	xchg   %ax,%ax

00000f70 <__umoddi3>:
     f70:	55                   	push   %ebp
     f71:	57                   	push   %edi
     f72:	56                   	push   %esi
     f73:	53                   	push   %ebx
     f74:	83 ec 1c             	sub    $0x1c,%esp
     f77:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
     f7b:	8b 74 24 30          	mov    0x30(%esp),%esi
     f7f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
     f83:	8b 7c 24 38          	mov    0x38(%esp),%edi
     f87:	85 ed                	test   %ebp,%ebp
     f89:	89 f0                	mov    %esi,%eax
     f8b:	89 da                	mov    %ebx,%edx
     f8d:	75 19                	jne    fa8 <__umoddi3+0x38>
     f8f:	39 df                	cmp    %ebx,%edi
     f91:	0f 86 b1 00 00 00    	jbe    1048 <__umoddi3+0xd8>
     f97:	f7 f7                	div    %edi
     f99:	89 d0                	mov    %edx,%eax
     f9b:	31 d2                	xor    %edx,%edx
     f9d:	83 c4 1c             	add    $0x1c,%esp
     fa0:	5b                   	pop    %ebx
     fa1:	5e                   	pop    %esi
     fa2:	5f                   	pop    %edi
     fa3:	5d                   	pop    %ebp
     fa4:	c3                   	ret    
     fa5:	8d 76 00             	lea    0x0(%esi),%esi
     fa8:	39 dd                	cmp    %ebx,%ebp
     faa:	77 f1                	ja     f9d <__umoddi3+0x2d>
     fac:	0f bd cd             	bsr    %ebp,%ecx
     faf:	83 f1 1f             	xor    $0x1f,%ecx
     fb2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     fb6:	0f 84 b4 00 00 00    	je     1070 <__umoddi3+0x100>
     fbc:	b8 20 00 00 00       	mov    $0x20,%eax
     fc1:	89 c2                	mov    %eax,%edx
     fc3:	8b 44 24 04          	mov    0x4(%esp),%eax
     fc7:	29 c2                	sub    %eax,%edx
     fc9:	89 c1                	mov    %eax,%ecx
     fcb:	89 f8                	mov    %edi,%eax
     fcd:	d3 e5                	shl    %cl,%ebp
     fcf:	89 d1                	mov    %edx,%ecx
     fd1:	89 54 24 0c          	mov    %edx,0xc(%esp)
     fd5:	d3 e8                	shr    %cl,%eax
     fd7:	09 c5                	or     %eax,%ebp
     fd9:	8b 44 24 04          	mov    0x4(%esp),%eax
     fdd:	89 c1                	mov    %eax,%ecx
     fdf:	d3 e7                	shl    %cl,%edi
     fe1:	89 d1                	mov    %edx,%ecx
     fe3:	89 7c 24 08          	mov    %edi,0x8(%esp)
     fe7:	89 df                	mov    %ebx,%edi
     fe9:	d3 ef                	shr    %cl,%edi
     feb:	89 c1                	mov    %eax,%ecx
     fed:	89 f0                	mov    %esi,%eax
     fef:	d3 e3                	shl    %cl,%ebx
     ff1:	89 d1                	mov    %edx,%ecx
     ff3:	89 fa                	mov    %edi,%edx
     ff5:	d3 e8                	shr    %cl,%eax
     ff7:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
     ffc:	09 d8                	or     %ebx,%eax
     ffe:	f7 f5                	div    %ebp
    1000:	d3 e6                	shl    %cl,%esi
    1002:	89 d1                	mov    %edx,%ecx
    1004:	f7 64 24 08          	mull   0x8(%esp)
    1008:	39 d1                	cmp    %edx,%ecx
    100a:	89 c3                	mov    %eax,%ebx
    100c:	89 d7                	mov    %edx,%edi
    100e:	72 06                	jb     1016 <__umoddi3+0xa6>
    1010:	75 0e                	jne    1020 <__umoddi3+0xb0>
    1012:	39 c6                	cmp    %eax,%esi
    1014:	73 0a                	jae    1020 <__umoddi3+0xb0>
    1016:	2b 44 24 08          	sub    0x8(%esp),%eax
    101a:	19 ea                	sbb    %ebp,%edx
    101c:	89 d7                	mov    %edx,%edi
    101e:	89 c3                	mov    %eax,%ebx
    1020:	89 ca                	mov    %ecx,%edx
    1022:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
    1027:	29 de                	sub    %ebx,%esi
    1029:	19 fa                	sbb    %edi,%edx
    102b:	8b 5c 24 04          	mov    0x4(%esp),%ebx
    102f:	89 d0                	mov    %edx,%eax
    1031:	d3 e0                	shl    %cl,%eax
    1033:	89 d9                	mov    %ebx,%ecx
    1035:	d3 ee                	shr    %cl,%esi
    1037:	d3 ea                	shr    %cl,%edx
    1039:	09 f0                	or     %esi,%eax
    103b:	83 c4 1c             	add    $0x1c,%esp
    103e:	5b                   	pop    %ebx
    103f:	5e                   	pop    %esi
    1040:	5f                   	pop    %edi
    1041:	5d                   	pop    %ebp
    1042:	c3                   	ret    
    1043:	90                   	nop
    1044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1048:	85 ff                	test   %edi,%edi
    104a:	89 f9                	mov    %edi,%ecx
    104c:	75 0b                	jne    1059 <__umoddi3+0xe9>
    104e:	b8 01 00 00 00       	mov    $0x1,%eax
    1053:	31 d2                	xor    %edx,%edx
    1055:	f7 f7                	div    %edi
    1057:	89 c1                	mov    %eax,%ecx
    1059:	89 d8                	mov    %ebx,%eax
    105b:	31 d2                	xor    %edx,%edx
    105d:	f7 f1                	div    %ecx
    105f:	89 f0                	mov    %esi,%eax
    1061:	f7 f1                	div    %ecx
    1063:	e9 31 ff ff ff       	jmp    f99 <__umoddi3+0x29>
    1068:	90                   	nop
    1069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1070:	39 dd                	cmp    %ebx,%ebp
    1072:	72 08                	jb     107c <__umoddi3+0x10c>
    1074:	39 f7                	cmp    %esi,%edi
    1076:	0f 87 21 ff ff ff    	ja     f9d <__umoddi3+0x2d>
    107c:	89 da                	mov    %ebx,%edx
    107e:	89 f0                	mov    %esi,%eax
    1080:	29 f8                	sub    %edi,%eax
    1082:	19 ea                	sbb    %ebp,%edx
    1084:	e9 14 ff ff ff       	jmp    f9d <__umoddi3+0x2d>
