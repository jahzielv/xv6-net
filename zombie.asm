
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
      11:	e8 95 02 00 00       	call   2ab <fork>
      16:	85 c0                	test   %eax,%eax
      18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
      1a:	83 ec 0c             	sub    $0xc,%esp
      1d:	6a 05                	push   $0x5
      1f:	e8 1f 03 00 00       	call   343 <sleep>
      24:	83 c4 10             	add    $0x10,%esp
  exit();
      27:	e8 87 02 00 00       	call   2b3 <exit>

0000002c <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
      2c:	55                   	push   %ebp
      2d:	89 e5                	mov    %esp,%ebp
      2f:	57                   	push   %edi
      30:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      31:	8b 4d 08             	mov    0x8(%ebp),%ecx
      34:	8b 55 10             	mov    0x10(%ebp),%edx
      37:	8b 45 0c             	mov    0xc(%ebp),%eax
      3a:	89 cb                	mov    %ecx,%ebx
      3c:	89 df                	mov    %ebx,%edi
      3e:	89 d1                	mov    %edx,%ecx
      40:	fc                   	cld    
      41:	f3 aa                	rep stos %al,%es:(%edi)
      43:	89 ca                	mov    %ecx,%edx
      45:	89 fb                	mov    %edi,%ebx
      47:	89 5d 08             	mov    %ebx,0x8(%ebp)
      4a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      4d:	90                   	nop
      4e:	5b                   	pop    %ebx
      4f:	5f                   	pop    %edi
      50:	5d                   	pop    %ebp
      51:	c3                   	ret    

00000052 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      52:	55                   	push   %ebp
      53:	89 e5                	mov    %esp,%ebp
      55:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      58:	8b 45 08             	mov    0x8(%ebp),%eax
      5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      5e:	90                   	nop
      5f:	8b 55 0c             	mov    0xc(%ebp),%edx
      62:	8d 42 01             	lea    0x1(%edx),%eax
      65:	89 45 0c             	mov    %eax,0xc(%ebp)
      68:	8b 45 08             	mov    0x8(%ebp),%eax
      6b:	8d 48 01             	lea    0x1(%eax),%ecx
      6e:	89 4d 08             	mov    %ecx,0x8(%ebp)
      71:	0f b6 12             	movzbl (%edx),%edx
      74:	88 10                	mov    %dl,(%eax)
      76:	0f b6 00             	movzbl (%eax),%eax
      79:	84 c0                	test   %al,%al
      7b:	75 e2                	jne    5f <strcpy+0xd>
    ;
  return os;
      7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      80:	c9                   	leave  
      81:	c3                   	ret    

00000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      82:	55                   	push   %ebp
      83:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      85:	eb 08                	jmp    8f <strcmp+0xd>
    p++, q++;
      87:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      8b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
      8f:	8b 45 08             	mov    0x8(%ebp),%eax
      92:	0f b6 00             	movzbl (%eax),%eax
      95:	84 c0                	test   %al,%al
      97:	74 10                	je     a9 <strcmp+0x27>
      99:	8b 45 08             	mov    0x8(%ebp),%eax
      9c:	0f b6 10             	movzbl (%eax),%edx
      9f:	8b 45 0c             	mov    0xc(%ebp),%eax
      a2:	0f b6 00             	movzbl (%eax),%eax
      a5:	38 c2                	cmp    %al,%dl
      a7:	74 de                	je     87 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
      a9:	8b 45 08             	mov    0x8(%ebp),%eax
      ac:	0f b6 00             	movzbl (%eax),%eax
      af:	0f b6 d0             	movzbl %al,%edx
      b2:	8b 45 0c             	mov    0xc(%ebp),%eax
      b5:	0f b6 00             	movzbl (%eax),%eax
      b8:	0f b6 c0             	movzbl %al,%eax
      bb:	29 c2                	sub    %eax,%edx
      bd:	89 d0                	mov    %edx,%eax
}
      bf:	5d                   	pop    %ebp
      c0:	c3                   	ret    

000000c1 <strlen>:

uint
strlen(char *s)
{
      c1:	55                   	push   %ebp
      c2:	89 e5                	mov    %esp,%ebp
      c4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
      c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
      ce:	eb 04                	jmp    d4 <strlen+0x13>
      d0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
      d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
      d7:	8b 45 08             	mov    0x8(%ebp),%eax
      da:	01 d0                	add    %edx,%eax
      dc:	0f b6 00             	movzbl (%eax),%eax
      df:	84 c0                	test   %al,%al
      e1:	75 ed                	jne    d0 <strlen+0xf>
    ;
  return n;
      e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      e6:	c9                   	leave  
      e7:	c3                   	ret    

000000e8 <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
      e8:	55                   	push   %ebp
      e9:	89 e5                	mov    %esp,%ebp
      eb:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
      ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
      f5:	eb 0c                	jmp    103 <strnlen+0x1b>
     n++; 
      f7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
      fb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      ff:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     103:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     107:	74 0a                	je     113 <strnlen+0x2b>
     109:	8b 45 08             	mov    0x8(%ebp),%eax
     10c:	0f b6 00             	movzbl (%eax),%eax
     10f:	84 c0                	test   %al,%al
     111:	75 e4                	jne    f7 <strnlen+0xf>
   return n; 
     113:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     116:	c9                   	leave  
     117:	c3                   	ret    

00000118 <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     118:	55                   	push   %ebp
     119:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     11b:	8b 45 10             	mov    0x10(%ebp),%eax
     11e:	50                   	push   %eax
     11f:	ff 75 0c             	pushl  0xc(%ebp)
     122:	ff 75 08             	pushl  0x8(%ebp)
     125:	e8 02 ff ff ff       	call   2c <stosb>
     12a:	83 c4 0c             	add    $0xc,%esp
  return dst;
     12d:	8b 45 08             	mov    0x8(%ebp),%eax
}
     130:	c9                   	leave  
     131:	c3                   	ret    

00000132 <strchr>:

char*
strchr(const char *s, char c)
{
     132:	55                   	push   %ebp
     133:	89 e5                	mov    %esp,%ebp
     135:	83 ec 04             	sub    $0x4,%esp
     138:	8b 45 0c             	mov    0xc(%ebp),%eax
     13b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     13e:	eb 14                	jmp    154 <strchr+0x22>
    if(*s == c)
     140:	8b 45 08             	mov    0x8(%ebp),%eax
     143:	0f b6 00             	movzbl (%eax),%eax
     146:	38 45 fc             	cmp    %al,-0x4(%ebp)
     149:	75 05                	jne    150 <strchr+0x1e>
      return (char*)s;
     14b:	8b 45 08             	mov    0x8(%ebp),%eax
     14e:	eb 13                	jmp    163 <strchr+0x31>
  for(; *s; s++)
     150:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     154:	8b 45 08             	mov    0x8(%ebp),%eax
     157:	0f b6 00             	movzbl (%eax),%eax
     15a:	84 c0                	test   %al,%al
     15c:	75 e2                	jne    140 <strchr+0xe>
  return 0;
     15e:	b8 00 00 00 00       	mov    $0x0,%eax
}
     163:	c9                   	leave  
     164:	c3                   	ret    

00000165 <gets>:

char*
gets(char *buf, int max)
{
     165:	55                   	push   %ebp
     166:	89 e5                	mov    %esp,%ebp
     168:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     16b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     172:	eb 42                	jmp    1b6 <gets+0x51>
    cc = read(0, &c, 1);
     174:	83 ec 04             	sub    $0x4,%esp
     177:	6a 01                	push   $0x1
     179:	8d 45 ef             	lea    -0x11(%ebp),%eax
     17c:	50                   	push   %eax
     17d:	6a 00                	push   $0x0
     17f:	e8 47 01 00 00       	call   2cb <read>
     184:	83 c4 10             	add    $0x10,%esp
     187:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     18a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     18e:	7e 33                	jle    1c3 <gets+0x5e>
      break;
    buf[i++] = c;
     190:	8b 45 f4             	mov    -0xc(%ebp),%eax
     193:	8d 50 01             	lea    0x1(%eax),%edx
     196:	89 55 f4             	mov    %edx,-0xc(%ebp)
     199:	89 c2                	mov    %eax,%edx
     19b:	8b 45 08             	mov    0x8(%ebp),%eax
     19e:	01 c2                	add    %eax,%edx
     1a0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1a4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1a6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1aa:	3c 0a                	cmp    $0xa,%al
     1ac:	74 16                	je     1c4 <gets+0x5f>
     1ae:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1b2:	3c 0d                	cmp    $0xd,%al
     1b4:	74 0e                	je     1c4 <gets+0x5f>
  for(i=0; i+1 < max; ){
     1b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1b9:	83 c0 01             	add    $0x1,%eax
     1bc:	39 45 0c             	cmp    %eax,0xc(%ebp)
     1bf:	7f b3                	jg     174 <gets+0xf>
     1c1:	eb 01                	jmp    1c4 <gets+0x5f>
      break;
     1c3:	90                   	nop
      break;
  }
  buf[i] = '\0';
     1c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1c7:	8b 45 08             	mov    0x8(%ebp),%eax
     1ca:	01 d0                	add    %edx,%eax
     1cc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1cf:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1d2:	c9                   	leave  
     1d3:	c3                   	ret    

000001d4 <stat>:

int
stat(char *n, struct stat *st)
{
     1d4:	55                   	push   %ebp
     1d5:	89 e5                	mov    %esp,%ebp
     1d7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     1da:	83 ec 08             	sub    $0x8,%esp
     1dd:	6a 00                	push   $0x0
     1df:	ff 75 08             	pushl  0x8(%ebp)
     1e2:	e8 0c 01 00 00       	call   2f3 <open>
     1e7:	83 c4 10             	add    $0x10,%esp
     1ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     1ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     1f1:	79 07                	jns    1fa <stat+0x26>
    return -1;
     1f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     1f8:	eb 25                	jmp    21f <stat+0x4b>
  r = fstat(fd, st);
     1fa:	83 ec 08             	sub    $0x8,%esp
     1fd:	ff 75 0c             	pushl  0xc(%ebp)
     200:	ff 75 f4             	pushl  -0xc(%ebp)
     203:	e8 03 01 00 00       	call   30b <fstat>
     208:	83 c4 10             	add    $0x10,%esp
     20b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     20e:	83 ec 0c             	sub    $0xc,%esp
     211:	ff 75 f4             	pushl  -0xc(%ebp)
     214:	e8 c2 00 00 00       	call   2db <close>
     219:	83 c4 10             	add    $0x10,%esp
  return r;
     21c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     21f:	c9                   	leave  
     220:	c3                   	ret    

00000221 <atoi>:

int
atoi(const char *s)
{
     221:	55                   	push   %ebp
     222:	89 e5                	mov    %esp,%ebp
     224:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     227:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     22e:	eb 25                	jmp    255 <atoi+0x34>
    n = n*10 + *s++ - '0';
     230:	8b 55 fc             	mov    -0x4(%ebp),%edx
     233:	89 d0                	mov    %edx,%eax
     235:	c1 e0 02             	shl    $0x2,%eax
     238:	01 d0                	add    %edx,%eax
     23a:	01 c0                	add    %eax,%eax
     23c:	89 c1                	mov    %eax,%ecx
     23e:	8b 45 08             	mov    0x8(%ebp),%eax
     241:	8d 50 01             	lea    0x1(%eax),%edx
     244:	89 55 08             	mov    %edx,0x8(%ebp)
     247:	0f b6 00             	movzbl (%eax),%eax
     24a:	0f be c0             	movsbl %al,%eax
     24d:	01 c8                	add    %ecx,%eax
     24f:	83 e8 30             	sub    $0x30,%eax
     252:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     255:	8b 45 08             	mov    0x8(%ebp),%eax
     258:	0f b6 00             	movzbl (%eax),%eax
     25b:	3c 2f                	cmp    $0x2f,%al
     25d:	7e 0a                	jle    269 <atoi+0x48>
     25f:	8b 45 08             	mov    0x8(%ebp),%eax
     262:	0f b6 00             	movzbl (%eax),%eax
     265:	3c 39                	cmp    $0x39,%al
     267:	7e c7                	jle    230 <atoi+0xf>
  return n;
     269:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     26c:	c9                   	leave  
     26d:	c3                   	ret    

0000026e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     26e:	55                   	push   %ebp
     26f:	89 e5                	mov    %esp,%ebp
     271:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     274:	8b 45 08             	mov    0x8(%ebp),%eax
     277:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     27a:	8b 45 0c             	mov    0xc(%ebp),%eax
     27d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     280:	eb 17                	jmp    299 <memmove+0x2b>
    *dst++ = *src++;
     282:	8b 55 f8             	mov    -0x8(%ebp),%edx
     285:	8d 42 01             	lea    0x1(%edx),%eax
     288:	89 45 f8             	mov    %eax,-0x8(%ebp)
     28b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     28e:	8d 48 01             	lea    0x1(%eax),%ecx
     291:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     294:	0f b6 12             	movzbl (%edx),%edx
     297:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     299:	8b 45 10             	mov    0x10(%ebp),%eax
     29c:	8d 50 ff             	lea    -0x1(%eax),%edx
     29f:	89 55 10             	mov    %edx,0x10(%ebp)
     2a2:	85 c0                	test   %eax,%eax
     2a4:	7f dc                	jg     282 <memmove+0x14>
  return vdst;
     2a6:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2a9:	c9                   	leave  
     2aa:	c3                   	ret    

000002ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2ab:	b8 01 00 00 00       	mov    $0x1,%eax
     2b0:	cd 40                	int    $0x40
     2b2:	c3                   	ret    

000002b3 <exit>:
SYSCALL(exit)
     2b3:	b8 02 00 00 00       	mov    $0x2,%eax
     2b8:	cd 40                	int    $0x40
     2ba:	c3                   	ret    

000002bb <wait>:
SYSCALL(wait)
     2bb:	b8 03 00 00 00       	mov    $0x3,%eax
     2c0:	cd 40                	int    $0x40
     2c2:	c3                   	ret    

000002c3 <pipe>:
SYSCALL(pipe)
     2c3:	b8 04 00 00 00       	mov    $0x4,%eax
     2c8:	cd 40                	int    $0x40
     2ca:	c3                   	ret    

000002cb <read>:
SYSCALL(read)
     2cb:	b8 05 00 00 00       	mov    $0x5,%eax
     2d0:	cd 40                	int    $0x40
     2d2:	c3                   	ret    

000002d3 <write>:
SYSCALL(write)
     2d3:	b8 10 00 00 00       	mov    $0x10,%eax
     2d8:	cd 40                	int    $0x40
     2da:	c3                   	ret    

000002db <close>:
SYSCALL(close)
     2db:	b8 15 00 00 00       	mov    $0x15,%eax
     2e0:	cd 40                	int    $0x40
     2e2:	c3                   	ret    

000002e3 <kill>:
SYSCALL(kill)
     2e3:	b8 06 00 00 00       	mov    $0x6,%eax
     2e8:	cd 40                	int    $0x40
     2ea:	c3                   	ret    

000002eb <exec>:
SYSCALL(exec)
     2eb:	b8 07 00 00 00       	mov    $0x7,%eax
     2f0:	cd 40                	int    $0x40
     2f2:	c3                   	ret    

000002f3 <open>:
SYSCALL(open)
     2f3:	b8 0f 00 00 00       	mov    $0xf,%eax
     2f8:	cd 40                	int    $0x40
     2fa:	c3                   	ret    

000002fb <mknod>:
SYSCALL(mknod)
     2fb:	b8 11 00 00 00       	mov    $0x11,%eax
     300:	cd 40                	int    $0x40
     302:	c3                   	ret    

00000303 <unlink>:
SYSCALL(unlink)
     303:	b8 12 00 00 00       	mov    $0x12,%eax
     308:	cd 40                	int    $0x40
     30a:	c3                   	ret    

0000030b <fstat>:
SYSCALL(fstat)
     30b:	b8 08 00 00 00       	mov    $0x8,%eax
     310:	cd 40                	int    $0x40
     312:	c3                   	ret    

00000313 <link>:
SYSCALL(link)
     313:	b8 13 00 00 00       	mov    $0x13,%eax
     318:	cd 40                	int    $0x40
     31a:	c3                   	ret    

0000031b <mkdir>:
SYSCALL(mkdir)
     31b:	b8 14 00 00 00       	mov    $0x14,%eax
     320:	cd 40                	int    $0x40
     322:	c3                   	ret    

00000323 <chdir>:
SYSCALL(chdir)
     323:	b8 09 00 00 00       	mov    $0x9,%eax
     328:	cd 40                	int    $0x40
     32a:	c3                   	ret    

0000032b <dup>:
SYSCALL(dup)
     32b:	b8 0a 00 00 00       	mov    $0xa,%eax
     330:	cd 40                	int    $0x40
     332:	c3                   	ret    

00000333 <getpid>:
SYSCALL(getpid)
     333:	b8 0b 00 00 00       	mov    $0xb,%eax
     338:	cd 40                	int    $0x40
     33a:	c3                   	ret    

0000033b <sbrk>:
SYSCALL(sbrk)
     33b:	b8 0c 00 00 00       	mov    $0xc,%eax
     340:	cd 40                	int    $0x40
     342:	c3                   	ret    

00000343 <sleep>:
SYSCALL(sleep)
     343:	b8 0d 00 00 00       	mov    $0xd,%eax
     348:	cd 40                	int    $0x40
     34a:	c3                   	ret    

0000034b <uptime>:
SYSCALL(uptime)
     34b:	b8 0e 00 00 00       	mov    $0xe,%eax
     350:	cd 40                	int    $0x40
     352:	c3                   	ret    

00000353 <select>:
SYSCALL(select)
     353:	b8 16 00 00 00       	mov    $0x16,%eax
     358:	cd 40                	int    $0x40
     35a:	c3                   	ret    

0000035b <arp>:
SYSCALL(arp)
     35b:	b8 17 00 00 00       	mov    $0x17,%eax
     360:	cd 40                	int    $0x40
     362:	c3                   	ret    

00000363 <arpserv>:
SYSCALL(arpserv)
     363:	b8 18 00 00 00       	mov    $0x18,%eax
     368:	cd 40                	int    $0x40
     36a:	c3                   	ret    

0000036b <arp_receive>:
SYSCALL(arp_receive)
     36b:	b8 19 00 00 00       	mov    $0x19,%eax
     370:	cd 40                	int    $0x40
     372:	c3                   	ret    

00000373 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     373:	55                   	push   %ebp
     374:	89 e5                	mov    %esp,%ebp
     376:	83 ec 18             	sub    $0x18,%esp
     379:	8b 45 0c             	mov    0xc(%ebp),%eax
     37c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     37f:	83 ec 04             	sub    $0x4,%esp
     382:	6a 01                	push   $0x1
     384:	8d 45 f4             	lea    -0xc(%ebp),%eax
     387:	50                   	push   %eax
     388:	ff 75 08             	pushl  0x8(%ebp)
     38b:	e8 43 ff ff ff       	call   2d3 <write>
     390:	83 c4 10             	add    $0x10,%esp
}
     393:	90                   	nop
     394:	c9                   	leave  
     395:	c3                   	ret    

00000396 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     396:	55                   	push   %ebp
     397:	89 e5                	mov    %esp,%ebp
     399:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     39c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3a3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3a7:	74 17                	je     3c0 <printint+0x2a>
     3a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3ad:	79 11                	jns    3c0 <printint+0x2a>
    neg = 1;
     3af:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3b6:	8b 45 0c             	mov    0xc(%ebp),%eax
     3b9:	f7 d8                	neg    %eax
     3bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3be:	eb 06                	jmp    3c6 <printint+0x30>
  } else {
    x = xx;
     3c0:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3cd:	8b 4d 10             	mov    0x10(%ebp),%ecx
     3d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3d3:	ba 00 00 00 00       	mov    $0x0,%edx
     3d8:	f7 f1                	div    %ecx
     3da:	89 d1                	mov    %edx,%ecx
     3dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     3df:	8d 50 01             	lea    0x1(%eax),%edx
     3e2:	89 55 f4             	mov    %edx,-0xc(%ebp)
     3e5:	0f b6 91 cc 16 00 00 	movzbl 0x16cc(%ecx),%edx
     3ec:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     3f0:	8b 4d 10             	mov    0x10(%ebp),%ecx
     3f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     3f6:	ba 00 00 00 00       	mov    $0x0,%edx
     3fb:	f7 f1                	div    %ecx
     3fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
     400:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     404:	75 c7                	jne    3cd <printint+0x37>
  if(neg)
     406:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     40a:	74 2d                	je     439 <printint+0xa3>
    buf[i++] = '-';
     40c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     40f:	8d 50 01             	lea    0x1(%eax),%edx
     412:	89 55 f4             	mov    %edx,-0xc(%ebp)
     415:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     41a:	eb 1d                	jmp    439 <printint+0xa3>
    putc(fd, buf[i]);
     41c:	8d 55 dc             	lea    -0x24(%ebp),%edx
     41f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     422:	01 d0                	add    %edx,%eax
     424:	0f b6 00             	movzbl (%eax),%eax
     427:	0f be c0             	movsbl %al,%eax
     42a:	83 ec 08             	sub    $0x8,%esp
     42d:	50                   	push   %eax
     42e:	ff 75 08             	pushl  0x8(%ebp)
     431:	e8 3d ff ff ff       	call   373 <putc>
     436:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     439:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     43d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     441:	79 d9                	jns    41c <printint+0x86>
}
     443:	90                   	nop
     444:	c9                   	leave  
     445:	c3                   	ret    

00000446 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     446:	55                   	push   %ebp
     447:	89 e5                	mov    %esp,%ebp
     449:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     44c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     453:	8d 45 0c             	lea    0xc(%ebp),%eax
     456:	83 c0 04             	add    $0x4,%eax
     459:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     45c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     463:	e9 59 01 00 00       	jmp    5c1 <printf+0x17b>
    c = fmt[i] & 0xff;
     468:	8b 55 0c             	mov    0xc(%ebp),%edx
     46b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     46e:	01 d0                	add    %edx,%eax
     470:	0f b6 00             	movzbl (%eax),%eax
     473:	0f be c0             	movsbl %al,%eax
     476:	25 ff 00 00 00       	and    $0xff,%eax
     47b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     47e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     482:	75 2c                	jne    4b0 <printf+0x6a>
      if(c == '%'){
     484:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     488:	75 0c                	jne    496 <printf+0x50>
        state = '%';
     48a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     491:	e9 27 01 00 00       	jmp    5bd <printf+0x177>
      } else {
        putc(fd, c);
     496:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     499:	0f be c0             	movsbl %al,%eax
     49c:	83 ec 08             	sub    $0x8,%esp
     49f:	50                   	push   %eax
     4a0:	ff 75 08             	pushl  0x8(%ebp)
     4a3:	e8 cb fe ff ff       	call   373 <putc>
     4a8:	83 c4 10             	add    $0x10,%esp
     4ab:	e9 0d 01 00 00       	jmp    5bd <printf+0x177>
      }
    } else if(state == '%'){
     4b0:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4b4:	0f 85 03 01 00 00    	jne    5bd <printf+0x177>
      if(c == 'd'){
     4ba:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4be:	75 1e                	jne    4de <printf+0x98>
        printint(fd, *ap, 10, 1);
     4c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4c3:	8b 00                	mov    (%eax),%eax
     4c5:	6a 01                	push   $0x1
     4c7:	6a 0a                	push   $0xa
     4c9:	50                   	push   %eax
     4ca:	ff 75 08             	pushl  0x8(%ebp)
     4cd:	e8 c4 fe ff ff       	call   396 <printint>
     4d2:	83 c4 10             	add    $0x10,%esp
        ap++;
     4d5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     4d9:	e9 d8 00 00 00       	jmp    5b6 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     4de:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     4e2:	74 06                	je     4ea <printf+0xa4>
     4e4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     4e8:	75 1e                	jne    508 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     4ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4ed:	8b 00                	mov    (%eax),%eax
     4ef:	6a 00                	push   $0x0
     4f1:	6a 10                	push   $0x10
     4f3:	50                   	push   %eax
     4f4:	ff 75 08             	pushl  0x8(%ebp)
     4f7:	e8 9a fe ff ff       	call   396 <printint>
     4fc:	83 c4 10             	add    $0x10,%esp
        ap++;
     4ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     503:	e9 ae 00 00 00       	jmp    5b6 <printf+0x170>
      } else if(c == 's'){
     508:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     50c:	75 43                	jne    551 <printf+0x10b>
        s = (char*)*ap;
     50e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     511:	8b 00                	mov    (%eax),%eax
     513:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     516:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     51a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     51e:	75 25                	jne    545 <printf+0xff>
          s = "(null)";
     520:	c7 45 f4 20 10 00 00 	movl   $0x1020,-0xc(%ebp)
        while(*s != 0){
     527:	eb 1c                	jmp    545 <printf+0xff>
          putc(fd, *s);
     529:	8b 45 f4             	mov    -0xc(%ebp),%eax
     52c:	0f b6 00             	movzbl (%eax),%eax
     52f:	0f be c0             	movsbl %al,%eax
     532:	83 ec 08             	sub    $0x8,%esp
     535:	50                   	push   %eax
     536:	ff 75 08             	pushl  0x8(%ebp)
     539:	e8 35 fe ff ff       	call   373 <putc>
     53e:	83 c4 10             	add    $0x10,%esp
          s++;
     541:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     545:	8b 45 f4             	mov    -0xc(%ebp),%eax
     548:	0f b6 00             	movzbl (%eax),%eax
     54b:	84 c0                	test   %al,%al
     54d:	75 da                	jne    529 <printf+0xe3>
     54f:	eb 65                	jmp    5b6 <printf+0x170>
        }
      } else if(c == 'c'){
     551:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     555:	75 1d                	jne    574 <printf+0x12e>
        putc(fd, *ap);
     557:	8b 45 e8             	mov    -0x18(%ebp),%eax
     55a:	8b 00                	mov    (%eax),%eax
     55c:	0f be c0             	movsbl %al,%eax
     55f:	83 ec 08             	sub    $0x8,%esp
     562:	50                   	push   %eax
     563:	ff 75 08             	pushl  0x8(%ebp)
     566:	e8 08 fe ff ff       	call   373 <putc>
     56b:	83 c4 10             	add    $0x10,%esp
        ap++;
     56e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     572:	eb 42                	jmp    5b6 <printf+0x170>
      } else if(c == '%'){
     574:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     578:	75 17                	jne    591 <printf+0x14b>
        putc(fd, c);
     57a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     57d:	0f be c0             	movsbl %al,%eax
     580:	83 ec 08             	sub    $0x8,%esp
     583:	50                   	push   %eax
     584:	ff 75 08             	pushl  0x8(%ebp)
     587:	e8 e7 fd ff ff       	call   373 <putc>
     58c:	83 c4 10             	add    $0x10,%esp
     58f:	eb 25                	jmp    5b6 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     591:	83 ec 08             	sub    $0x8,%esp
     594:	6a 25                	push   $0x25
     596:	ff 75 08             	pushl  0x8(%ebp)
     599:	e8 d5 fd ff ff       	call   373 <putc>
     59e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5a4:	0f be c0             	movsbl %al,%eax
     5a7:	83 ec 08             	sub    $0x8,%esp
     5aa:	50                   	push   %eax
     5ab:	ff 75 08             	pushl  0x8(%ebp)
     5ae:	e8 c0 fd ff ff       	call   373 <putc>
     5b3:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     5bd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5c1:	8b 55 0c             	mov    0xc(%ebp),%edx
     5c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5c7:	01 d0                	add    %edx,%eax
     5c9:	0f b6 00             	movzbl (%eax),%eax
     5cc:	84 c0                	test   %al,%al
     5ce:	0f 85 94 fe ff ff    	jne    468 <printf+0x22>
    }
  }
}
     5d4:	90                   	nop
     5d5:	c9                   	leave  
     5d6:	c3                   	ret    

000005d7 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     5d7:	55                   	push   %ebp
     5d8:	89 e5                	mov    %esp,%ebp
     5da:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     5dd:	8b 45 08             	mov    0x8(%ebp),%eax
     5e0:	83 e8 08             	sub    $0x8,%eax
     5e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     5e6:	a1 e8 16 00 00       	mov    0x16e8,%eax
     5eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
     5ee:	eb 24                	jmp    614 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     5f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
     5f3:	8b 00                	mov    (%eax),%eax
     5f5:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     5f8:	72 12                	jb     60c <free+0x35>
     5fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
     5fd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     600:	77 24                	ja     626 <free+0x4f>
     602:	8b 45 fc             	mov    -0x4(%ebp),%eax
     605:	8b 00                	mov    (%eax),%eax
     607:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     60a:	72 1a                	jb     626 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     60c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     60f:	8b 00                	mov    (%eax),%eax
     611:	89 45 fc             	mov    %eax,-0x4(%ebp)
     614:	8b 45 f8             	mov    -0x8(%ebp),%eax
     617:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     61a:	76 d4                	jbe    5f0 <free+0x19>
     61c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     61f:	8b 00                	mov    (%eax),%eax
     621:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     624:	73 ca                	jae    5f0 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     626:	8b 45 f8             	mov    -0x8(%ebp),%eax
     629:	8b 40 04             	mov    0x4(%eax),%eax
     62c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     633:	8b 45 f8             	mov    -0x8(%ebp),%eax
     636:	01 c2                	add    %eax,%edx
     638:	8b 45 fc             	mov    -0x4(%ebp),%eax
     63b:	8b 00                	mov    (%eax),%eax
     63d:	39 c2                	cmp    %eax,%edx
     63f:	75 24                	jne    665 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     641:	8b 45 f8             	mov    -0x8(%ebp),%eax
     644:	8b 50 04             	mov    0x4(%eax),%edx
     647:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64a:	8b 00                	mov    (%eax),%eax
     64c:	8b 40 04             	mov    0x4(%eax),%eax
     64f:	01 c2                	add    %eax,%edx
     651:	8b 45 f8             	mov    -0x8(%ebp),%eax
     654:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     657:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65a:	8b 00                	mov    (%eax),%eax
     65c:	8b 10                	mov    (%eax),%edx
     65e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     661:	89 10                	mov    %edx,(%eax)
     663:	eb 0a                	jmp    66f <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     665:	8b 45 fc             	mov    -0x4(%ebp),%eax
     668:	8b 10                	mov    (%eax),%edx
     66a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     66d:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     672:	8b 40 04             	mov    0x4(%eax),%eax
     675:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     67c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     67f:	01 d0                	add    %edx,%eax
     681:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     684:	75 20                	jne    6a6 <free+0xcf>
    p->s.size += bp->s.size;
     686:	8b 45 fc             	mov    -0x4(%ebp),%eax
     689:	8b 50 04             	mov    0x4(%eax),%edx
     68c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68f:	8b 40 04             	mov    0x4(%eax),%eax
     692:	01 c2                	add    %eax,%edx
     694:	8b 45 fc             	mov    -0x4(%ebp),%eax
     697:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     69a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     69d:	8b 10                	mov    (%eax),%edx
     69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a2:	89 10                	mov    %edx,(%eax)
     6a4:	eb 08                	jmp    6ae <free+0xd7>
  } else
    p->s.ptr = bp;
     6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a9:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6ac:	89 10                	mov    %edx,(%eax)
  freep = p;
     6ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b1:	a3 e8 16 00 00       	mov    %eax,0x16e8
}
     6b6:	90                   	nop
     6b7:	c9                   	leave  
     6b8:	c3                   	ret    

000006b9 <morecore>:

static Header*
morecore(uint nu)
{
     6b9:	55                   	push   %ebp
     6ba:	89 e5                	mov    %esp,%ebp
     6bc:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6bf:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6c6:	77 07                	ja     6cf <morecore+0x16>
    nu = 4096;
     6c8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6cf:	8b 45 08             	mov    0x8(%ebp),%eax
     6d2:	c1 e0 03             	shl    $0x3,%eax
     6d5:	83 ec 0c             	sub    $0xc,%esp
     6d8:	50                   	push   %eax
     6d9:	e8 5d fc ff ff       	call   33b <sbrk>
     6de:	83 c4 10             	add    $0x10,%esp
     6e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     6e4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     6e8:	75 07                	jne    6f1 <morecore+0x38>
    return 0;
     6ea:	b8 00 00 00 00       	mov    $0x0,%eax
     6ef:	eb 26                	jmp    717 <morecore+0x5e>
  hp = (Header*)p;
     6f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     6f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6fa:	8b 55 08             	mov    0x8(%ebp),%edx
     6fd:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     700:	8b 45 f0             	mov    -0x10(%ebp),%eax
     703:	83 c0 08             	add    $0x8,%eax
     706:	83 ec 0c             	sub    $0xc,%esp
     709:	50                   	push   %eax
     70a:	e8 c8 fe ff ff       	call   5d7 <free>
     70f:	83 c4 10             	add    $0x10,%esp
  return freep;
     712:	a1 e8 16 00 00       	mov    0x16e8,%eax
}
     717:	c9                   	leave  
     718:	c3                   	ret    

00000719 <malloc>:

void*
malloc(uint nbytes)
{
     719:	55                   	push   %ebp
     71a:	89 e5                	mov    %esp,%ebp
     71c:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     71f:	8b 45 08             	mov    0x8(%ebp),%eax
     722:	83 c0 07             	add    $0x7,%eax
     725:	c1 e8 03             	shr    $0x3,%eax
     728:	83 c0 01             	add    $0x1,%eax
     72b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     72e:	a1 e8 16 00 00       	mov    0x16e8,%eax
     733:	89 45 f0             	mov    %eax,-0x10(%ebp)
     736:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     73a:	75 23                	jne    75f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     73c:	c7 45 f0 e0 16 00 00 	movl   $0x16e0,-0x10(%ebp)
     743:	8b 45 f0             	mov    -0x10(%ebp),%eax
     746:	a3 e8 16 00 00       	mov    %eax,0x16e8
     74b:	a1 e8 16 00 00       	mov    0x16e8,%eax
     750:	a3 e0 16 00 00       	mov    %eax,0x16e0
    base.s.size = 0;
     755:	c7 05 e4 16 00 00 00 	movl   $0x0,0x16e4
     75c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     75f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     762:	8b 00                	mov    (%eax),%eax
     764:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     767:	8b 45 f4             	mov    -0xc(%ebp),%eax
     76a:	8b 40 04             	mov    0x4(%eax),%eax
     76d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     770:	77 4d                	ja     7bf <malloc+0xa6>
      if(p->s.size == nunits)
     772:	8b 45 f4             	mov    -0xc(%ebp),%eax
     775:	8b 40 04             	mov    0x4(%eax),%eax
     778:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     77b:	75 0c                	jne    789 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     780:	8b 10                	mov    (%eax),%edx
     782:	8b 45 f0             	mov    -0x10(%ebp),%eax
     785:	89 10                	mov    %edx,(%eax)
     787:	eb 26                	jmp    7af <malloc+0x96>
      else {
        p->s.size -= nunits;
     789:	8b 45 f4             	mov    -0xc(%ebp),%eax
     78c:	8b 40 04             	mov    0x4(%eax),%eax
     78f:	2b 45 ec             	sub    -0x14(%ebp),%eax
     792:	89 c2                	mov    %eax,%edx
     794:	8b 45 f4             	mov    -0xc(%ebp),%eax
     797:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     79d:	8b 40 04             	mov    0x4(%eax),%eax
     7a0:	c1 e0 03             	shl    $0x3,%eax
     7a3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a9:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7ac:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7af:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b2:	a3 e8 16 00 00       	mov    %eax,0x16e8
      return (void*)(p + 1);
     7b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ba:	83 c0 08             	add    $0x8,%eax
     7bd:	eb 3b                	jmp    7fa <malloc+0xe1>
    }
    if(p == freep)
     7bf:	a1 e8 16 00 00       	mov    0x16e8,%eax
     7c4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7c7:	75 1e                	jne    7e7 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7c9:	83 ec 0c             	sub    $0xc,%esp
     7cc:	ff 75 ec             	pushl  -0x14(%ebp)
     7cf:	e8 e5 fe ff ff       	call   6b9 <morecore>
     7d4:	83 c4 10             	add    $0x10,%esp
     7d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     7da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     7de:	75 07                	jne    7e7 <malloc+0xce>
        return 0;
     7e0:	b8 00 00 00 00       	mov    $0x0,%eax
     7e5:	eb 13                	jmp    7fa <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f0:	8b 00                	mov    (%eax),%eax
     7f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7f5:	e9 6d ff ff ff       	jmp    767 <malloc+0x4e>
  }
}
     7fa:	c9                   	leave  
     7fb:	c3                   	ret    

000007fc <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     7fc:	55                   	push   %ebp
     7fd:	89 e5                	mov    %esp,%ebp
     7ff:	53                   	push   %ebx
     800:	83 ec 14             	sub    $0x14,%esp
     803:	8b 45 10             	mov    0x10(%ebp),%eax
     806:	89 45 f0             	mov    %eax,-0x10(%ebp)
     809:	8b 45 14             	mov    0x14(%ebp),%eax
     80c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     80f:	8b 45 18             	mov    0x18(%ebp),%eax
     812:	ba 00 00 00 00       	mov    $0x0,%edx
     817:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     81a:	72 55                	jb     871 <printnum+0x75>
     81c:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     81f:	77 05                	ja     826 <printnum+0x2a>
     821:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     824:	72 4b                	jb     871 <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     826:	8b 45 1c             	mov    0x1c(%ebp),%eax
     829:	8d 58 ff             	lea    -0x1(%eax),%ebx
     82c:	8b 45 18             	mov    0x18(%ebp),%eax
     82f:	ba 00 00 00 00       	mov    $0x0,%edx
     834:	52                   	push   %edx
     835:	50                   	push   %eax
     836:	ff 75 f4             	pushl  -0xc(%ebp)
     839:	ff 75 f0             	pushl  -0x10(%ebp)
     83c:	e8 9f 05 00 00       	call   de0 <__udivdi3>
     841:	83 c4 10             	add    $0x10,%esp
     844:	83 ec 04             	sub    $0x4,%esp
     847:	ff 75 20             	pushl  0x20(%ebp)
     84a:	53                   	push   %ebx
     84b:	ff 75 18             	pushl  0x18(%ebp)
     84e:	52                   	push   %edx
     84f:	50                   	push   %eax
     850:	ff 75 0c             	pushl  0xc(%ebp)
     853:	ff 75 08             	pushl  0x8(%ebp)
     856:	e8 a1 ff ff ff       	call   7fc <printnum>
     85b:	83 c4 20             	add    $0x20,%esp
     85e:	eb 1b                	jmp    87b <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     860:	83 ec 08             	sub    $0x8,%esp
     863:	ff 75 0c             	pushl  0xc(%ebp)
     866:	ff 75 20             	pushl  0x20(%ebp)
     869:	8b 45 08             	mov    0x8(%ebp),%eax
     86c:	ff d0                	call   *%eax
     86e:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     871:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     875:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     879:	7f e5                	jg     860 <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     87b:	8b 4d 18             	mov    0x18(%ebp),%ecx
     87e:	bb 00 00 00 00       	mov    $0x0,%ebx
     883:	8b 45 f0             	mov    -0x10(%ebp),%eax
     886:	8b 55 f4             	mov    -0xc(%ebp),%edx
     889:	53                   	push   %ebx
     88a:	51                   	push   %ecx
     88b:	52                   	push   %edx
     88c:	50                   	push   %eax
     88d:	e8 6e 06 00 00       	call   f00 <__umoddi3>
     892:	83 c4 10             	add    $0x10,%esp
     895:	05 00 11 00 00       	add    $0x1100,%eax
     89a:	0f b6 00             	movzbl (%eax),%eax
     89d:	0f be c0             	movsbl %al,%eax
     8a0:	83 ec 08             	sub    $0x8,%esp
     8a3:	ff 75 0c             	pushl  0xc(%ebp)
     8a6:	50                   	push   %eax
     8a7:	8b 45 08             	mov    0x8(%ebp),%eax
     8aa:	ff d0                	call   *%eax
     8ac:	83 c4 10             	add    $0x10,%esp
}
     8af:	90                   	nop
     8b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8b3:	c9                   	leave  
     8b4:	c3                   	ret    

000008b5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     8b5:	55                   	push   %ebp
     8b6:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     8b8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     8bc:	7e 14                	jle    8d2 <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     8be:	8b 45 08             	mov    0x8(%ebp),%eax
     8c1:	8b 00                	mov    (%eax),%eax
     8c3:	8d 48 08             	lea    0x8(%eax),%ecx
     8c6:	8b 55 08             	mov    0x8(%ebp),%edx
     8c9:	89 0a                	mov    %ecx,(%edx)
     8cb:	8b 50 04             	mov    0x4(%eax),%edx
     8ce:	8b 00                	mov    (%eax),%eax
     8d0:	eb 30                	jmp    902 <getuint+0x4d>
  else if (lflag)
     8d2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     8d6:	74 16                	je     8ee <getuint+0x39>
    return va_arg(*ap, unsigned long);
     8d8:	8b 45 08             	mov    0x8(%ebp),%eax
     8db:	8b 00                	mov    (%eax),%eax
     8dd:	8d 48 04             	lea    0x4(%eax),%ecx
     8e0:	8b 55 08             	mov    0x8(%ebp),%edx
     8e3:	89 0a                	mov    %ecx,(%edx)
     8e5:	8b 00                	mov    (%eax),%eax
     8e7:	ba 00 00 00 00       	mov    $0x0,%edx
     8ec:	eb 14                	jmp    902 <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     8ee:	8b 45 08             	mov    0x8(%ebp),%eax
     8f1:	8b 00                	mov    (%eax),%eax
     8f3:	8d 48 04             	lea    0x4(%eax),%ecx
     8f6:	8b 55 08             	mov    0x8(%ebp),%edx
     8f9:	89 0a                	mov    %ecx,(%edx)
     8fb:	8b 00                	mov    (%eax),%eax
     8fd:	ba 00 00 00 00       	mov    $0x0,%edx
}
     902:	5d                   	pop    %ebp
     903:	c3                   	ret    

00000904 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     904:	55                   	push   %ebp
     905:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     907:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     90b:	7e 14                	jle    921 <getint+0x1d>
    return va_arg(*ap, long long);
     90d:	8b 45 08             	mov    0x8(%ebp),%eax
     910:	8b 00                	mov    (%eax),%eax
     912:	8d 48 08             	lea    0x8(%eax),%ecx
     915:	8b 55 08             	mov    0x8(%ebp),%edx
     918:	89 0a                	mov    %ecx,(%edx)
     91a:	8b 50 04             	mov    0x4(%eax),%edx
     91d:	8b 00                	mov    (%eax),%eax
     91f:	eb 28                	jmp    949 <getint+0x45>
  else if (lflag)
     921:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     925:	74 12                	je     939 <getint+0x35>
    return va_arg(*ap, long);
     927:	8b 45 08             	mov    0x8(%ebp),%eax
     92a:	8b 00                	mov    (%eax),%eax
     92c:	8d 48 04             	lea    0x4(%eax),%ecx
     92f:	8b 55 08             	mov    0x8(%ebp),%edx
     932:	89 0a                	mov    %ecx,(%edx)
     934:	8b 00                	mov    (%eax),%eax
     936:	99                   	cltd   
     937:	eb 10                	jmp    949 <getint+0x45>
  else
    return va_arg(*ap, int);
     939:	8b 45 08             	mov    0x8(%ebp),%eax
     93c:	8b 00                	mov    (%eax),%eax
     93e:	8d 48 04             	lea    0x4(%eax),%ecx
     941:	8b 55 08             	mov    0x8(%ebp),%edx
     944:	89 0a                	mov    %ecx,(%edx)
     946:	8b 00                	mov    (%eax),%eax
     948:	99                   	cltd   
}
     949:	5d                   	pop    %ebp
     94a:	c3                   	ret    

0000094b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     94b:	55                   	push   %ebp
     94c:	89 e5                	mov    %esp,%ebp
     94e:	56                   	push   %esi
     94f:	53                   	push   %ebx
     950:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     953:	eb 17                	jmp    96c <vprintfmt+0x21>
      if (ch == '\0')
     955:	85 db                	test   %ebx,%ebx
     957:	0f 84 a0 03 00 00    	je     cfd <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     95d:	83 ec 08             	sub    $0x8,%esp
     960:	ff 75 0c             	pushl  0xc(%ebp)
     963:	53                   	push   %ebx
     964:	8b 45 08             	mov    0x8(%ebp),%eax
     967:	ff d0                	call   *%eax
     969:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     96c:	8b 45 10             	mov    0x10(%ebp),%eax
     96f:	8d 50 01             	lea    0x1(%eax),%edx
     972:	89 55 10             	mov    %edx,0x10(%ebp)
     975:	0f b6 00             	movzbl (%eax),%eax
     978:	0f b6 d8             	movzbl %al,%ebx
     97b:	83 fb 25             	cmp    $0x25,%ebx
     97e:	75 d5                	jne    955 <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     980:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     984:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     98b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     992:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     999:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     9a0:	8b 45 10             	mov    0x10(%ebp),%eax
     9a3:	8d 50 01             	lea    0x1(%eax),%edx
     9a6:	89 55 10             	mov    %edx,0x10(%ebp)
     9a9:	0f b6 00             	movzbl (%eax),%eax
     9ac:	0f b6 d8             	movzbl %al,%ebx
     9af:	8d 43 dd             	lea    -0x23(%ebx),%eax
     9b2:	83 f8 55             	cmp    $0x55,%eax
     9b5:	0f 87 15 03 00 00    	ja     cd0 <vprintfmt+0x385>
     9bb:	8b 04 85 24 11 00 00 	mov    0x1124(,%eax,4),%eax
     9c2:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     9c4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     9c8:	eb d6                	jmp    9a0 <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     9ca:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     9ce:	eb d0                	jmp    9a0 <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     9d0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     9d7:	8b 55 e0             	mov    -0x20(%ebp),%edx
     9da:	89 d0                	mov    %edx,%eax
     9dc:	c1 e0 02             	shl    $0x2,%eax
     9df:	01 d0                	add    %edx,%eax
     9e1:	01 c0                	add    %eax,%eax
     9e3:	01 d8                	add    %ebx,%eax
     9e5:	83 e8 30             	sub    $0x30,%eax
     9e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     9eb:	8b 45 10             	mov    0x10(%ebp),%eax
     9ee:	0f b6 00             	movzbl (%eax),%eax
     9f1:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     9f4:	83 fb 2f             	cmp    $0x2f,%ebx
     9f7:	7e 39                	jle    a32 <vprintfmt+0xe7>
     9f9:	83 fb 39             	cmp    $0x39,%ebx
     9fc:	7f 34                	jg     a32 <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     9fe:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     a02:	eb d3                	jmp    9d7 <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     a04:	8b 45 14             	mov    0x14(%ebp),%eax
     a07:	8d 50 04             	lea    0x4(%eax),%edx
     a0a:	89 55 14             	mov    %edx,0x14(%ebp)
     a0d:	8b 00                	mov    (%eax),%eax
     a0f:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     a12:	eb 1f                	jmp    a33 <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     a14:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a18:	79 86                	jns    9a0 <vprintfmt+0x55>
        width = 0;
     a1a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     a21:	e9 7a ff ff ff       	jmp    9a0 <vprintfmt+0x55>

    case '#':
      altflag = 1;
     a26:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     a2d:	e9 6e ff ff ff       	jmp    9a0 <vprintfmt+0x55>
      goto process_precision;
     a32:	90                   	nop

process_precision:
      if (width < 0)
     a33:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a37:	0f 89 63 ff ff ff    	jns    9a0 <vprintfmt+0x55>
        width = precision, precision = -1;
     a3d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a40:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a43:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     a4a:	e9 51 ff ff ff       	jmp    9a0 <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     a4f:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     a53:	e9 48 ff ff ff       	jmp    9a0 <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     a58:	8b 45 14             	mov    0x14(%ebp),%eax
     a5b:	8d 50 04             	lea    0x4(%eax),%edx
     a5e:	89 55 14             	mov    %edx,0x14(%ebp)
     a61:	8b 00                	mov    (%eax),%eax
     a63:	83 ec 08             	sub    $0x8,%esp
     a66:	ff 75 0c             	pushl  0xc(%ebp)
     a69:	50                   	push   %eax
     a6a:	8b 45 08             	mov    0x8(%ebp),%eax
     a6d:	ff d0                	call   *%eax
     a6f:	83 c4 10             	add    $0x10,%esp
      break;
     a72:	e9 81 02 00 00       	jmp    cf8 <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     a77:	8b 45 14             	mov    0x14(%ebp),%eax
     a7a:	8d 50 04             	lea    0x4(%eax),%edx
     a7d:	89 55 14             	mov    %edx,0x14(%ebp)
     a80:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     a82:	85 db                	test   %ebx,%ebx
     a84:	79 02                	jns    a88 <vprintfmt+0x13d>
        err = -err;
     a86:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     a88:	83 fb 0f             	cmp    $0xf,%ebx
     a8b:	7f 0b                	jg     a98 <vprintfmt+0x14d>
     a8d:	8b 34 9d c0 10 00 00 	mov    0x10c0(,%ebx,4),%esi
     a94:	85 f6                	test   %esi,%esi
     a96:	75 19                	jne    ab1 <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     a98:	53                   	push   %ebx
     a99:	68 11 11 00 00       	push   $0x1111
     a9e:	ff 75 0c             	pushl  0xc(%ebp)
     aa1:	ff 75 08             	pushl  0x8(%ebp)
     aa4:	e8 5c 02 00 00       	call   d05 <printfmt>
     aa9:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     aac:	e9 47 02 00 00       	jmp    cf8 <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     ab1:	56                   	push   %esi
     ab2:	68 1a 11 00 00       	push   $0x111a
     ab7:	ff 75 0c             	pushl  0xc(%ebp)
     aba:	ff 75 08             	pushl  0x8(%ebp)
     abd:	e8 43 02 00 00       	call   d05 <printfmt>
     ac2:	83 c4 10             	add    $0x10,%esp
      break;
     ac5:	e9 2e 02 00 00       	jmp    cf8 <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     aca:	8b 45 14             	mov    0x14(%ebp),%eax
     acd:	8d 50 04             	lea    0x4(%eax),%edx
     ad0:	89 55 14             	mov    %edx,0x14(%ebp)
     ad3:	8b 30                	mov    (%eax),%esi
     ad5:	85 f6                	test   %esi,%esi
     ad7:	75 05                	jne    ade <vprintfmt+0x193>
        p = "(null)";
     ad9:	be 1d 11 00 00       	mov    $0x111d,%esi
      if (width > 0 && padc != '-')
     ade:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     ae2:	7e 6f                	jle    b53 <vprintfmt+0x208>
     ae4:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     ae8:	74 69                	je     b53 <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     aea:	8b 45 e0             	mov    -0x20(%ebp),%eax
     aed:	83 ec 08             	sub    $0x8,%esp
     af0:	50                   	push   %eax
     af1:	56                   	push   %esi
     af2:	e8 f1 f5 ff ff       	call   e8 <strnlen>
     af7:	83 c4 10             	add    $0x10,%esp
     afa:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     afd:	eb 17                	jmp    b16 <vprintfmt+0x1cb>
          putch(padc, putdat);
     aff:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     b03:	83 ec 08             	sub    $0x8,%esp
     b06:	ff 75 0c             	pushl  0xc(%ebp)
     b09:	50                   	push   %eax
     b0a:	8b 45 08             	mov    0x8(%ebp),%eax
     b0d:	ff d0                	call   *%eax
     b0f:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     b12:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b16:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b1a:	7f e3                	jg     aff <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b1c:	eb 35                	jmp    b53 <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     b1e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     b22:	74 1c                	je     b40 <vprintfmt+0x1f5>
     b24:	83 fb 1f             	cmp    $0x1f,%ebx
     b27:	7e 05                	jle    b2e <vprintfmt+0x1e3>
     b29:	83 fb 7e             	cmp    $0x7e,%ebx
     b2c:	7e 12                	jle    b40 <vprintfmt+0x1f5>
          putch('?', putdat);
     b2e:	83 ec 08             	sub    $0x8,%esp
     b31:	ff 75 0c             	pushl  0xc(%ebp)
     b34:	6a 3f                	push   $0x3f
     b36:	8b 45 08             	mov    0x8(%ebp),%eax
     b39:	ff d0                	call   *%eax
     b3b:	83 c4 10             	add    $0x10,%esp
     b3e:	eb 0f                	jmp    b4f <vprintfmt+0x204>
        else
          putch(ch, putdat);
     b40:	83 ec 08             	sub    $0x8,%esp
     b43:	ff 75 0c             	pushl  0xc(%ebp)
     b46:	53                   	push   %ebx
     b47:	8b 45 08             	mov    0x8(%ebp),%eax
     b4a:	ff d0                	call   *%eax
     b4c:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b4f:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b53:	89 f0                	mov    %esi,%eax
     b55:	8d 70 01             	lea    0x1(%eax),%esi
     b58:	0f b6 00             	movzbl (%eax),%eax
     b5b:	0f be d8             	movsbl %al,%ebx
     b5e:	85 db                	test   %ebx,%ebx
     b60:	74 26                	je     b88 <vprintfmt+0x23d>
     b62:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     b66:	78 b6                	js     b1e <vprintfmt+0x1d3>
     b68:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     b6c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     b70:	79 ac                	jns    b1e <vprintfmt+0x1d3>
      for (; width > 0; width--)
     b72:	eb 14                	jmp    b88 <vprintfmt+0x23d>
        putch(' ', putdat);
     b74:	83 ec 08             	sub    $0x8,%esp
     b77:	ff 75 0c             	pushl  0xc(%ebp)
     b7a:	6a 20                	push   $0x20
     b7c:	8b 45 08             	mov    0x8(%ebp),%eax
     b7f:	ff d0                	call   *%eax
     b81:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     b84:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b88:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b8c:	7f e6                	jg     b74 <vprintfmt+0x229>
      break;
     b8e:	e9 65 01 00 00       	jmp    cf8 <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     b93:	83 ec 08             	sub    $0x8,%esp
     b96:	ff 75 e8             	pushl  -0x18(%ebp)
     b99:	8d 45 14             	lea    0x14(%ebp),%eax
     b9c:	50                   	push   %eax
     b9d:	e8 62 fd ff ff       	call   904 <getint>
     ba2:	83 c4 10             	add    $0x10,%esp
     ba5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ba8:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     bab:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bae:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bb1:	85 d2                	test   %edx,%edx
     bb3:	79 23                	jns    bd8 <vprintfmt+0x28d>
        putch('-', putdat);
     bb5:	83 ec 08             	sub    $0x8,%esp
     bb8:	ff 75 0c             	pushl  0xc(%ebp)
     bbb:	6a 2d                	push   $0x2d
     bbd:	8b 45 08             	mov    0x8(%ebp),%eax
     bc0:	ff d0                	call   *%eax
     bc2:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     bc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bc8:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bcb:	f7 d8                	neg    %eax
     bcd:	83 d2 00             	adc    $0x0,%edx
     bd0:	f7 da                	neg    %edx
     bd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
     bd5:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     bd8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     bdf:	e9 b6 00 00 00       	jmp    c9a <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     be4:	83 ec 08             	sub    $0x8,%esp
     be7:	ff 75 e8             	pushl  -0x18(%ebp)
     bea:	8d 45 14             	lea    0x14(%ebp),%eax
     bed:	50                   	push   %eax
     bee:	e8 c2 fc ff ff       	call   8b5 <getuint>
     bf3:	83 c4 10             	add    $0x10,%esp
     bf6:	89 45 f0             	mov    %eax,-0x10(%ebp)
     bf9:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     bfc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c03:	e9 92 00 00 00       	jmp    c9a <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     c08:	83 ec 08             	sub    $0x8,%esp
     c0b:	ff 75 0c             	pushl  0xc(%ebp)
     c0e:	6a 58                	push   $0x58
     c10:	8b 45 08             	mov    0x8(%ebp),%eax
     c13:	ff d0                	call   *%eax
     c15:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c18:	83 ec 08             	sub    $0x8,%esp
     c1b:	ff 75 0c             	pushl  0xc(%ebp)
     c1e:	6a 58                	push   $0x58
     c20:	8b 45 08             	mov    0x8(%ebp),%eax
     c23:	ff d0                	call   *%eax
     c25:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c28:	83 ec 08             	sub    $0x8,%esp
     c2b:	ff 75 0c             	pushl  0xc(%ebp)
     c2e:	6a 58                	push   $0x58
     c30:	8b 45 08             	mov    0x8(%ebp),%eax
     c33:	ff d0                	call   *%eax
     c35:	83 c4 10             	add    $0x10,%esp
      break;
     c38:	e9 bb 00 00 00       	jmp    cf8 <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     c3d:	83 ec 08             	sub    $0x8,%esp
     c40:	ff 75 0c             	pushl  0xc(%ebp)
     c43:	6a 30                	push   $0x30
     c45:	8b 45 08             	mov    0x8(%ebp),%eax
     c48:	ff d0                	call   *%eax
     c4a:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     c4d:	83 ec 08             	sub    $0x8,%esp
     c50:	ff 75 0c             	pushl  0xc(%ebp)
     c53:	6a 78                	push   $0x78
     c55:	8b 45 08             	mov    0x8(%ebp),%eax
     c58:	ff d0                	call   *%eax
     c5a:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     c5d:	8b 45 14             	mov    0x14(%ebp),%eax
     c60:	8d 50 04             	lea    0x4(%eax),%edx
     c63:	89 55 14             	mov    %edx,0x14(%ebp)
     c66:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     c68:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c6b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     c72:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     c79:	eb 1f                	jmp    c9a <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     c7b:	83 ec 08             	sub    $0x8,%esp
     c7e:	ff 75 e8             	pushl  -0x18(%ebp)
     c81:	8d 45 14             	lea    0x14(%ebp),%eax
     c84:	50                   	push   %eax
     c85:	e8 2b fc ff ff       	call   8b5 <getuint>
     c8a:	83 c4 10             	add    $0x10,%esp
     c8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c90:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     c93:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     c9a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     c9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ca1:	83 ec 04             	sub    $0x4,%esp
     ca4:	52                   	push   %edx
     ca5:	ff 75 e4             	pushl  -0x1c(%ebp)
     ca8:	50                   	push   %eax
     ca9:	ff 75 f4             	pushl  -0xc(%ebp)
     cac:	ff 75 f0             	pushl  -0x10(%ebp)
     caf:	ff 75 0c             	pushl  0xc(%ebp)
     cb2:	ff 75 08             	pushl  0x8(%ebp)
     cb5:	e8 42 fb ff ff       	call   7fc <printnum>
     cba:	83 c4 20             	add    $0x20,%esp
      break;
     cbd:	eb 39                	jmp    cf8 <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     cbf:	83 ec 08             	sub    $0x8,%esp
     cc2:	ff 75 0c             	pushl  0xc(%ebp)
     cc5:	53                   	push   %ebx
     cc6:	8b 45 08             	mov    0x8(%ebp),%eax
     cc9:	ff d0                	call   *%eax
     ccb:	83 c4 10             	add    $0x10,%esp
      break;
     cce:	eb 28                	jmp    cf8 <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     cd0:	83 ec 08             	sub    $0x8,%esp
     cd3:	ff 75 0c             	pushl  0xc(%ebp)
     cd6:	6a 25                	push   $0x25
     cd8:	8b 45 08             	mov    0x8(%ebp),%eax
     cdb:	ff d0                	call   *%eax
     cdd:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     ce0:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     ce4:	eb 04                	jmp    cea <vprintfmt+0x39f>
     ce6:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     cea:	8b 45 10             	mov    0x10(%ebp),%eax
     ced:	83 e8 01             	sub    $0x1,%eax
     cf0:	0f b6 00             	movzbl (%eax),%eax
     cf3:	3c 25                	cmp    $0x25,%al
     cf5:	75 ef                	jne    ce6 <vprintfmt+0x39b>
        /* do nothing */;
      break;
     cf7:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     cf8:	e9 6f fc ff ff       	jmp    96c <vprintfmt+0x21>
        return;
     cfd:	90                   	nop
    }
  }
}
     cfe:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d01:	5b                   	pop    %ebx
     d02:	5e                   	pop    %esi
     d03:	5d                   	pop    %ebp
     d04:	c3                   	ret    

00000d05 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     d05:	55                   	push   %ebp
     d06:	89 e5                	mov    %esp,%ebp
     d08:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     d0b:	8d 45 14             	lea    0x14(%ebp),%eax
     d0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     d11:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d14:	50                   	push   %eax
     d15:	ff 75 10             	pushl  0x10(%ebp)
     d18:	ff 75 0c             	pushl  0xc(%ebp)
     d1b:	ff 75 08             	pushl  0x8(%ebp)
     d1e:	e8 28 fc ff ff       	call   94b <vprintfmt>
     d23:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     d26:	90                   	nop
     d27:	c9                   	leave  
     d28:	c3                   	ret    

00000d29 <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     d29:	55                   	push   %ebp
     d2a:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     d2c:	8b 45 0c             	mov    0xc(%ebp),%eax
     d2f:	8b 40 08             	mov    0x8(%eax),%eax
     d32:	8d 50 01             	lea    0x1(%eax),%edx
     d35:	8b 45 0c             	mov    0xc(%ebp),%eax
     d38:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
     d3e:	8b 10                	mov    (%eax),%edx
     d40:	8b 45 0c             	mov    0xc(%ebp),%eax
     d43:	8b 40 04             	mov    0x4(%eax),%eax
     d46:	39 c2                	cmp    %eax,%edx
     d48:	73 12                	jae    d5c <sprintputch+0x33>
    *b->buf++ = ch;
     d4a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d4d:	8b 00                	mov    (%eax),%eax
     d4f:	8d 48 01             	lea    0x1(%eax),%ecx
     d52:	8b 55 0c             	mov    0xc(%ebp),%edx
     d55:	89 0a                	mov    %ecx,(%edx)
     d57:	8b 55 08             	mov    0x8(%ebp),%edx
     d5a:	88 10                	mov    %dl,(%eax)
}
     d5c:	90                   	nop
     d5d:	5d                   	pop    %ebp
     d5e:	c3                   	ret    

00000d5f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     d5f:	55                   	push   %ebp
     d60:	89 e5                	mov    %esp,%ebp
     d62:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     d65:	8b 45 08             	mov    0x8(%ebp),%eax
     d68:	89 45 ec             	mov    %eax,-0x14(%ebp)
     d6b:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6e:	8d 50 ff             	lea    -0x1(%eax),%edx
     d71:	8b 45 08             	mov    0x8(%ebp),%eax
     d74:	01 d0                	add    %edx,%eax
     d76:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d79:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     d80:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     d84:	74 06                	je     d8c <vsnprintf+0x2d>
     d86:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     d8a:	7f 07                	jg     d93 <vsnprintf+0x34>
    return -E_INVAL;
     d8c:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     d91:	eb 20                	jmp    db3 <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     d93:	ff 75 14             	pushl  0x14(%ebp)
     d96:	ff 75 10             	pushl  0x10(%ebp)
     d99:	8d 45 ec             	lea    -0x14(%ebp),%eax
     d9c:	50                   	push   %eax
     d9d:	68 29 0d 00 00       	push   $0xd29
     da2:	e8 a4 fb ff ff       	call   94b <vprintfmt>
     da7:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     daa:	8b 45 ec             	mov    -0x14(%ebp),%eax
     dad:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     db0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     db3:	c9                   	leave  
     db4:	c3                   	ret    

00000db5 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     db5:	55                   	push   %ebp
     db6:	89 e5                	mov    %esp,%ebp
     db8:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     dbb:	8d 45 14             	lea    0x14(%ebp),%eax
     dbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     dc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dc4:	50                   	push   %eax
     dc5:	ff 75 10             	pushl  0x10(%ebp)
     dc8:	ff 75 0c             	pushl  0xc(%ebp)
     dcb:	ff 75 08             	pushl  0x8(%ebp)
     dce:	e8 8c ff ff ff       	call   d5f <vsnprintf>
     dd3:	83 c4 10             	add    $0x10,%esp
     dd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     dd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ddc:	c9                   	leave  
     ddd:	c3                   	ret    
     dde:	66 90                	xchg   %ax,%ax

00000de0 <__udivdi3>:
     de0:	55                   	push   %ebp
     de1:	57                   	push   %edi
     de2:	56                   	push   %esi
     de3:	53                   	push   %ebx
     de4:	83 ec 1c             	sub    $0x1c,%esp
     de7:	8b 54 24 3c          	mov    0x3c(%esp),%edx
     deb:	8b 6c 24 30          	mov    0x30(%esp),%ebp
     def:	8b 74 24 34          	mov    0x34(%esp),%esi
     df3:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     df7:	85 d2                	test   %edx,%edx
     df9:	75 35                	jne    e30 <__udivdi3+0x50>
     dfb:	39 f3                	cmp    %esi,%ebx
     dfd:	0f 87 bd 00 00 00    	ja     ec0 <__udivdi3+0xe0>
     e03:	85 db                	test   %ebx,%ebx
     e05:	89 d9                	mov    %ebx,%ecx
     e07:	75 0b                	jne    e14 <__udivdi3+0x34>
     e09:	b8 01 00 00 00       	mov    $0x1,%eax
     e0e:	31 d2                	xor    %edx,%edx
     e10:	f7 f3                	div    %ebx
     e12:	89 c1                	mov    %eax,%ecx
     e14:	31 d2                	xor    %edx,%edx
     e16:	89 f0                	mov    %esi,%eax
     e18:	f7 f1                	div    %ecx
     e1a:	89 c6                	mov    %eax,%esi
     e1c:	89 e8                	mov    %ebp,%eax
     e1e:	89 f7                	mov    %esi,%edi
     e20:	f7 f1                	div    %ecx
     e22:	89 fa                	mov    %edi,%edx
     e24:	83 c4 1c             	add    $0x1c,%esp
     e27:	5b                   	pop    %ebx
     e28:	5e                   	pop    %esi
     e29:	5f                   	pop    %edi
     e2a:	5d                   	pop    %ebp
     e2b:	c3                   	ret    
     e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e30:	39 f2                	cmp    %esi,%edx
     e32:	77 7c                	ja     eb0 <__udivdi3+0xd0>
     e34:	0f bd fa             	bsr    %edx,%edi
     e37:	83 f7 1f             	xor    $0x1f,%edi
     e3a:	0f 84 98 00 00 00    	je     ed8 <__udivdi3+0xf8>
     e40:	89 f9                	mov    %edi,%ecx
     e42:	b8 20 00 00 00       	mov    $0x20,%eax
     e47:	29 f8                	sub    %edi,%eax
     e49:	d3 e2                	shl    %cl,%edx
     e4b:	89 54 24 08          	mov    %edx,0x8(%esp)
     e4f:	89 c1                	mov    %eax,%ecx
     e51:	89 da                	mov    %ebx,%edx
     e53:	d3 ea                	shr    %cl,%edx
     e55:	8b 4c 24 08          	mov    0x8(%esp),%ecx
     e59:	09 d1                	or     %edx,%ecx
     e5b:	89 f2                	mov    %esi,%edx
     e5d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     e61:	89 f9                	mov    %edi,%ecx
     e63:	d3 e3                	shl    %cl,%ebx
     e65:	89 c1                	mov    %eax,%ecx
     e67:	d3 ea                	shr    %cl,%edx
     e69:	89 f9                	mov    %edi,%ecx
     e6b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     e6f:	d3 e6                	shl    %cl,%esi
     e71:	89 eb                	mov    %ebp,%ebx
     e73:	89 c1                	mov    %eax,%ecx
     e75:	d3 eb                	shr    %cl,%ebx
     e77:	09 de                	or     %ebx,%esi
     e79:	89 f0                	mov    %esi,%eax
     e7b:	f7 74 24 08          	divl   0x8(%esp)
     e7f:	89 d6                	mov    %edx,%esi
     e81:	89 c3                	mov    %eax,%ebx
     e83:	f7 64 24 0c          	mull   0xc(%esp)
     e87:	39 d6                	cmp    %edx,%esi
     e89:	72 0c                	jb     e97 <__udivdi3+0xb7>
     e8b:	89 f9                	mov    %edi,%ecx
     e8d:	d3 e5                	shl    %cl,%ebp
     e8f:	39 c5                	cmp    %eax,%ebp
     e91:	73 5d                	jae    ef0 <__udivdi3+0x110>
     e93:	39 d6                	cmp    %edx,%esi
     e95:	75 59                	jne    ef0 <__udivdi3+0x110>
     e97:	8d 43 ff             	lea    -0x1(%ebx),%eax
     e9a:	31 ff                	xor    %edi,%edi
     e9c:	89 fa                	mov    %edi,%edx
     e9e:	83 c4 1c             	add    $0x1c,%esp
     ea1:	5b                   	pop    %ebx
     ea2:	5e                   	pop    %esi
     ea3:	5f                   	pop    %edi
     ea4:	5d                   	pop    %ebp
     ea5:	c3                   	ret    
     ea6:	8d 76 00             	lea    0x0(%esi),%esi
     ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     eb0:	31 ff                	xor    %edi,%edi
     eb2:	31 c0                	xor    %eax,%eax
     eb4:	89 fa                	mov    %edi,%edx
     eb6:	83 c4 1c             	add    $0x1c,%esp
     eb9:	5b                   	pop    %ebx
     eba:	5e                   	pop    %esi
     ebb:	5f                   	pop    %edi
     ebc:	5d                   	pop    %ebp
     ebd:	c3                   	ret    
     ebe:	66 90                	xchg   %ax,%ax
     ec0:	31 ff                	xor    %edi,%edi
     ec2:	89 e8                	mov    %ebp,%eax
     ec4:	89 f2                	mov    %esi,%edx
     ec6:	f7 f3                	div    %ebx
     ec8:	89 fa                	mov    %edi,%edx
     eca:	83 c4 1c             	add    $0x1c,%esp
     ecd:	5b                   	pop    %ebx
     ece:	5e                   	pop    %esi
     ecf:	5f                   	pop    %edi
     ed0:	5d                   	pop    %ebp
     ed1:	c3                   	ret    
     ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ed8:	39 f2                	cmp    %esi,%edx
     eda:	72 06                	jb     ee2 <__udivdi3+0x102>
     edc:	31 c0                	xor    %eax,%eax
     ede:	39 eb                	cmp    %ebp,%ebx
     ee0:	77 d2                	ja     eb4 <__udivdi3+0xd4>
     ee2:	b8 01 00 00 00       	mov    $0x1,%eax
     ee7:	eb cb                	jmp    eb4 <__udivdi3+0xd4>
     ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ef0:	89 d8                	mov    %ebx,%eax
     ef2:	31 ff                	xor    %edi,%edi
     ef4:	eb be                	jmp    eb4 <__udivdi3+0xd4>
     ef6:	66 90                	xchg   %ax,%ax
     ef8:	66 90                	xchg   %ax,%ax
     efa:	66 90                	xchg   %ax,%ax
     efc:	66 90                	xchg   %ax,%ax
     efe:	66 90                	xchg   %ax,%ax

00000f00 <__umoddi3>:
     f00:	55                   	push   %ebp
     f01:	57                   	push   %edi
     f02:	56                   	push   %esi
     f03:	53                   	push   %ebx
     f04:	83 ec 1c             	sub    $0x1c,%esp
     f07:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
     f0b:	8b 74 24 30          	mov    0x30(%esp),%esi
     f0f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
     f13:	8b 7c 24 38          	mov    0x38(%esp),%edi
     f17:	85 ed                	test   %ebp,%ebp
     f19:	89 f0                	mov    %esi,%eax
     f1b:	89 da                	mov    %ebx,%edx
     f1d:	75 19                	jne    f38 <__umoddi3+0x38>
     f1f:	39 df                	cmp    %ebx,%edi
     f21:	0f 86 b1 00 00 00    	jbe    fd8 <__umoddi3+0xd8>
     f27:	f7 f7                	div    %edi
     f29:	89 d0                	mov    %edx,%eax
     f2b:	31 d2                	xor    %edx,%edx
     f2d:	83 c4 1c             	add    $0x1c,%esp
     f30:	5b                   	pop    %ebx
     f31:	5e                   	pop    %esi
     f32:	5f                   	pop    %edi
     f33:	5d                   	pop    %ebp
     f34:	c3                   	ret    
     f35:	8d 76 00             	lea    0x0(%esi),%esi
     f38:	39 dd                	cmp    %ebx,%ebp
     f3a:	77 f1                	ja     f2d <__umoddi3+0x2d>
     f3c:	0f bd cd             	bsr    %ebp,%ecx
     f3f:	83 f1 1f             	xor    $0x1f,%ecx
     f42:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     f46:	0f 84 b4 00 00 00    	je     1000 <__umoddi3+0x100>
     f4c:	b8 20 00 00 00       	mov    $0x20,%eax
     f51:	89 c2                	mov    %eax,%edx
     f53:	8b 44 24 04          	mov    0x4(%esp),%eax
     f57:	29 c2                	sub    %eax,%edx
     f59:	89 c1                	mov    %eax,%ecx
     f5b:	89 f8                	mov    %edi,%eax
     f5d:	d3 e5                	shl    %cl,%ebp
     f5f:	89 d1                	mov    %edx,%ecx
     f61:	89 54 24 0c          	mov    %edx,0xc(%esp)
     f65:	d3 e8                	shr    %cl,%eax
     f67:	09 c5                	or     %eax,%ebp
     f69:	8b 44 24 04          	mov    0x4(%esp),%eax
     f6d:	89 c1                	mov    %eax,%ecx
     f6f:	d3 e7                	shl    %cl,%edi
     f71:	89 d1                	mov    %edx,%ecx
     f73:	89 7c 24 08          	mov    %edi,0x8(%esp)
     f77:	89 df                	mov    %ebx,%edi
     f79:	d3 ef                	shr    %cl,%edi
     f7b:	89 c1                	mov    %eax,%ecx
     f7d:	89 f0                	mov    %esi,%eax
     f7f:	d3 e3                	shl    %cl,%ebx
     f81:	89 d1                	mov    %edx,%ecx
     f83:	89 fa                	mov    %edi,%edx
     f85:	d3 e8                	shr    %cl,%eax
     f87:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
     f8c:	09 d8                	or     %ebx,%eax
     f8e:	f7 f5                	div    %ebp
     f90:	d3 e6                	shl    %cl,%esi
     f92:	89 d1                	mov    %edx,%ecx
     f94:	f7 64 24 08          	mull   0x8(%esp)
     f98:	39 d1                	cmp    %edx,%ecx
     f9a:	89 c3                	mov    %eax,%ebx
     f9c:	89 d7                	mov    %edx,%edi
     f9e:	72 06                	jb     fa6 <__umoddi3+0xa6>
     fa0:	75 0e                	jne    fb0 <__umoddi3+0xb0>
     fa2:	39 c6                	cmp    %eax,%esi
     fa4:	73 0a                	jae    fb0 <__umoddi3+0xb0>
     fa6:	2b 44 24 08          	sub    0x8(%esp),%eax
     faa:	19 ea                	sbb    %ebp,%edx
     fac:	89 d7                	mov    %edx,%edi
     fae:	89 c3                	mov    %eax,%ebx
     fb0:	89 ca                	mov    %ecx,%edx
     fb2:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
     fb7:	29 de                	sub    %ebx,%esi
     fb9:	19 fa                	sbb    %edi,%edx
     fbb:	8b 5c 24 04          	mov    0x4(%esp),%ebx
     fbf:	89 d0                	mov    %edx,%eax
     fc1:	d3 e0                	shl    %cl,%eax
     fc3:	89 d9                	mov    %ebx,%ecx
     fc5:	d3 ee                	shr    %cl,%esi
     fc7:	d3 ea                	shr    %cl,%edx
     fc9:	09 f0                	or     %esi,%eax
     fcb:	83 c4 1c             	add    $0x1c,%esp
     fce:	5b                   	pop    %ebx
     fcf:	5e                   	pop    %esi
     fd0:	5f                   	pop    %edi
     fd1:	5d                   	pop    %ebp
     fd2:	c3                   	ret    
     fd3:	90                   	nop
     fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     fd8:	85 ff                	test   %edi,%edi
     fda:	89 f9                	mov    %edi,%ecx
     fdc:	75 0b                	jne    fe9 <__umoddi3+0xe9>
     fde:	b8 01 00 00 00       	mov    $0x1,%eax
     fe3:	31 d2                	xor    %edx,%edx
     fe5:	f7 f7                	div    %edi
     fe7:	89 c1                	mov    %eax,%ecx
     fe9:	89 d8                	mov    %ebx,%eax
     feb:	31 d2                	xor    %edx,%edx
     fed:	f7 f1                	div    %ecx
     fef:	89 f0                	mov    %esi,%eax
     ff1:	f7 f1                	div    %ecx
     ff3:	e9 31 ff ff ff       	jmp    f29 <__umoddi3+0x29>
     ff8:	90                   	nop
     ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1000:	39 dd                	cmp    %ebx,%ebp
    1002:	72 08                	jb     100c <__umoddi3+0x10c>
    1004:	39 f7                	cmp    %esi,%edi
    1006:	0f 87 21 ff ff ff    	ja     f2d <__umoddi3+0x2d>
    100c:	89 da                	mov    %ebx,%edx
    100e:	89 f0                	mov    %esi,%eax
    1010:	29 f8                	sub    %edi,%eax
    1012:	19 ea                	sbb    %ebp,%edx
    1014:	e9 14 ff ff ff       	jmp    f2d <__umoddi3+0x2d>
