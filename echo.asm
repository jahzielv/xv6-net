
_echo:     file format elf32-i386


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

  for(i = 1; i < argc; i++)
      14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      1b:	eb 3c                	jmp    59 <main+0x59>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
      1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
      20:	83 c0 01             	add    $0x1,%eax
      23:	39 03                	cmp    %eax,(%ebx)
      25:	7e 07                	jle    2e <main+0x2e>
      27:	ba 60 10 00 00       	mov    $0x1060,%edx
      2c:	eb 05                	jmp    33 <main+0x33>
      2e:	ba 62 10 00 00       	mov    $0x1062,%edx
      33:	8b 45 f4             	mov    -0xc(%ebp),%eax
      36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
      3d:	8b 43 04             	mov    0x4(%ebx),%eax
      40:	01 c8                	add    %ecx,%eax
      42:	8b 00                	mov    (%eax),%eax
      44:	52                   	push   %edx
      45:	50                   	push   %eax
      46:	68 64 10 00 00       	push   $0x1064
      4b:	6a 01                	push   $0x1
      4d:	e8 2d 04 00 00       	call   47f <printf>
      52:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++)
      55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      59:	8b 45 f4             	mov    -0xc(%ebp),%eax
      5c:	3b 03                	cmp    (%ebx),%eax
      5e:	7c bd                	jl     1d <main+0x1d>
  exit();
      60:	e8 87 02 00 00       	call   2ec <exit>

00000065 <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
      65:	55                   	push   %ebp
      66:	89 e5                	mov    %esp,%ebp
      68:	57                   	push   %edi
      69:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
      6d:	8b 55 10             	mov    0x10(%ebp),%edx
      70:	8b 45 0c             	mov    0xc(%ebp),%eax
      73:	89 cb                	mov    %ecx,%ebx
      75:	89 df                	mov    %ebx,%edi
      77:	89 d1                	mov    %edx,%ecx
      79:	fc                   	cld    
      7a:	f3 aa                	rep stos %al,%es:(%edi)
      7c:	89 ca                	mov    %ecx,%edx
      7e:	89 fb                	mov    %edi,%ebx
      80:	89 5d 08             	mov    %ebx,0x8(%ebp)
      83:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      86:	90                   	nop
      87:	5b                   	pop    %ebx
      88:	5f                   	pop    %edi
      89:	5d                   	pop    %ebp
      8a:	c3                   	ret    

0000008b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      8b:	55                   	push   %ebp
      8c:	89 e5                	mov    %esp,%ebp
      8e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      91:	8b 45 08             	mov    0x8(%ebp),%eax
      94:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      97:	90                   	nop
      98:	8b 55 0c             	mov    0xc(%ebp),%edx
      9b:	8d 42 01             	lea    0x1(%edx),%eax
      9e:	89 45 0c             	mov    %eax,0xc(%ebp)
      a1:	8b 45 08             	mov    0x8(%ebp),%eax
      a4:	8d 48 01             	lea    0x1(%eax),%ecx
      a7:	89 4d 08             	mov    %ecx,0x8(%ebp)
      aa:	0f b6 12             	movzbl (%edx),%edx
      ad:	88 10                	mov    %dl,(%eax)
      af:	0f b6 00             	movzbl (%eax),%eax
      b2:	84 c0                	test   %al,%al
      b4:	75 e2                	jne    98 <strcpy+0xd>
    ;
  return os;
      b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      b9:	c9                   	leave  
      ba:	c3                   	ret    

000000bb <strcmp>:

int
strcmp(const char *p, const char *q)
{
      bb:	55                   	push   %ebp
      bc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      be:	eb 08                	jmp    c8 <strcmp+0xd>
    p++, q++;
      c0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      c4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
      c8:	8b 45 08             	mov    0x8(%ebp),%eax
      cb:	0f b6 00             	movzbl (%eax),%eax
      ce:	84 c0                	test   %al,%al
      d0:	74 10                	je     e2 <strcmp+0x27>
      d2:	8b 45 08             	mov    0x8(%ebp),%eax
      d5:	0f b6 10             	movzbl (%eax),%edx
      d8:	8b 45 0c             	mov    0xc(%ebp),%eax
      db:	0f b6 00             	movzbl (%eax),%eax
      de:	38 c2                	cmp    %al,%dl
      e0:	74 de                	je     c0 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
      e2:	8b 45 08             	mov    0x8(%ebp),%eax
      e5:	0f b6 00             	movzbl (%eax),%eax
      e8:	0f b6 d0             	movzbl %al,%edx
      eb:	8b 45 0c             	mov    0xc(%ebp),%eax
      ee:	0f b6 00             	movzbl (%eax),%eax
      f1:	0f b6 c0             	movzbl %al,%eax
      f4:	29 c2                	sub    %eax,%edx
      f6:	89 d0                	mov    %edx,%eax
}
      f8:	5d                   	pop    %ebp
      f9:	c3                   	ret    

000000fa <strlen>:

uint
strlen(char *s)
{
      fa:	55                   	push   %ebp
      fb:	89 e5                	mov    %esp,%ebp
      fd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     100:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     107:	eb 04                	jmp    10d <strlen+0x13>
     109:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     10d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     110:	8b 45 08             	mov    0x8(%ebp),%eax
     113:	01 d0                	add    %edx,%eax
     115:	0f b6 00             	movzbl (%eax),%eax
     118:	84 c0                	test   %al,%al
     11a:	75 ed                	jne    109 <strlen+0xf>
    ;
  return n;
     11c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     11f:	c9                   	leave  
     120:	c3                   	ret    

00000121 <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     121:	55                   	push   %ebp
     122:	89 e5                	mov    %esp,%ebp
     124:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     127:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     12e:	eb 0c                	jmp    13c <strnlen+0x1b>
     n++; 
     130:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     134:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     138:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     13c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     140:	74 0a                	je     14c <strnlen+0x2b>
     142:	8b 45 08             	mov    0x8(%ebp),%eax
     145:	0f b6 00             	movzbl (%eax),%eax
     148:	84 c0                	test   %al,%al
     14a:	75 e4                	jne    130 <strnlen+0xf>
   return n; 
     14c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     14f:	c9                   	leave  
     150:	c3                   	ret    

00000151 <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     151:	55                   	push   %ebp
     152:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     154:	8b 45 10             	mov    0x10(%ebp),%eax
     157:	50                   	push   %eax
     158:	ff 75 0c             	pushl  0xc(%ebp)
     15b:	ff 75 08             	pushl  0x8(%ebp)
     15e:	e8 02 ff ff ff       	call   65 <stosb>
     163:	83 c4 0c             	add    $0xc,%esp
  return dst;
     166:	8b 45 08             	mov    0x8(%ebp),%eax
}
     169:	c9                   	leave  
     16a:	c3                   	ret    

0000016b <strchr>:

char*
strchr(const char *s, char c)
{
     16b:	55                   	push   %ebp
     16c:	89 e5                	mov    %esp,%ebp
     16e:	83 ec 04             	sub    $0x4,%esp
     171:	8b 45 0c             	mov    0xc(%ebp),%eax
     174:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     177:	eb 14                	jmp    18d <strchr+0x22>
    if(*s == c)
     179:	8b 45 08             	mov    0x8(%ebp),%eax
     17c:	0f b6 00             	movzbl (%eax),%eax
     17f:	38 45 fc             	cmp    %al,-0x4(%ebp)
     182:	75 05                	jne    189 <strchr+0x1e>
      return (char*)s;
     184:	8b 45 08             	mov    0x8(%ebp),%eax
     187:	eb 13                	jmp    19c <strchr+0x31>
  for(; *s; s++)
     189:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     18d:	8b 45 08             	mov    0x8(%ebp),%eax
     190:	0f b6 00             	movzbl (%eax),%eax
     193:	84 c0                	test   %al,%al
     195:	75 e2                	jne    179 <strchr+0xe>
  return 0;
     197:	b8 00 00 00 00       	mov    $0x0,%eax
}
     19c:	c9                   	leave  
     19d:	c3                   	ret    

0000019e <gets>:

char*
gets(char *buf, int max)
{
     19e:	55                   	push   %ebp
     19f:	89 e5                	mov    %esp,%ebp
     1a1:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     1ab:	eb 42                	jmp    1ef <gets+0x51>
    cc = read(0, &c, 1);
     1ad:	83 ec 04             	sub    $0x4,%esp
     1b0:	6a 01                	push   $0x1
     1b2:	8d 45 ef             	lea    -0x11(%ebp),%eax
     1b5:	50                   	push   %eax
     1b6:	6a 00                	push   $0x0
     1b8:	e8 47 01 00 00       	call   304 <read>
     1bd:	83 c4 10             	add    $0x10,%esp
     1c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1c7:	7e 33                	jle    1fc <gets+0x5e>
      break;
    buf[i++] = c;
     1c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1cc:	8d 50 01             	lea    0x1(%eax),%edx
     1cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1d2:	89 c2                	mov    %eax,%edx
     1d4:	8b 45 08             	mov    0x8(%ebp),%eax
     1d7:	01 c2                	add    %eax,%edx
     1d9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1dd:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1df:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1e3:	3c 0a                	cmp    $0xa,%al
     1e5:	74 16                	je     1fd <gets+0x5f>
     1e7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1eb:	3c 0d                	cmp    $0xd,%al
     1ed:	74 0e                	je     1fd <gets+0x5f>
  for(i=0; i+1 < max; ){
     1ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1f2:	83 c0 01             	add    $0x1,%eax
     1f5:	39 45 0c             	cmp    %eax,0xc(%ebp)
     1f8:	7f b3                	jg     1ad <gets+0xf>
     1fa:	eb 01                	jmp    1fd <gets+0x5f>
      break;
     1fc:	90                   	nop
      break;
  }
  buf[i] = '\0';
     1fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
     200:	8b 45 08             	mov    0x8(%ebp),%eax
     203:	01 d0                	add    %edx,%eax
     205:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     208:	8b 45 08             	mov    0x8(%ebp),%eax
}
     20b:	c9                   	leave  
     20c:	c3                   	ret    

0000020d <stat>:

int
stat(char *n, struct stat *st)
{
     20d:	55                   	push   %ebp
     20e:	89 e5                	mov    %esp,%ebp
     210:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     213:	83 ec 08             	sub    $0x8,%esp
     216:	6a 00                	push   $0x0
     218:	ff 75 08             	pushl  0x8(%ebp)
     21b:	e8 0c 01 00 00       	call   32c <open>
     220:	83 c4 10             	add    $0x10,%esp
     223:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     226:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     22a:	79 07                	jns    233 <stat+0x26>
    return -1;
     22c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     231:	eb 25                	jmp    258 <stat+0x4b>
  r = fstat(fd, st);
     233:	83 ec 08             	sub    $0x8,%esp
     236:	ff 75 0c             	pushl  0xc(%ebp)
     239:	ff 75 f4             	pushl  -0xc(%ebp)
     23c:	e8 03 01 00 00       	call   344 <fstat>
     241:	83 c4 10             	add    $0x10,%esp
     244:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     247:	83 ec 0c             	sub    $0xc,%esp
     24a:	ff 75 f4             	pushl  -0xc(%ebp)
     24d:	e8 c2 00 00 00       	call   314 <close>
     252:	83 c4 10             	add    $0x10,%esp
  return r;
     255:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     258:	c9                   	leave  
     259:	c3                   	ret    

0000025a <atoi>:

int
atoi(const char *s)
{
     25a:	55                   	push   %ebp
     25b:	89 e5                	mov    %esp,%ebp
     25d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     260:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     267:	eb 25                	jmp    28e <atoi+0x34>
    n = n*10 + *s++ - '0';
     269:	8b 55 fc             	mov    -0x4(%ebp),%edx
     26c:	89 d0                	mov    %edx,%eax
     26e:	c1 e0 02             	shl    $0x2,%eax
     271:	01 d0                	add    %edx,%eax
     273:	01 c0                	add    %eax,%eax
     275:	89 c1                	mov    %eax,%ecx
     277:	8b 45 08             	mov    0x8(%ebp),%eax
     27a:	8d 50 01             	lea    0x1(%eax),%edx
     27d:	89 55 08             	mov    %edx,0x8(%ebp)
     280:	0f b6 00             	movzbl (%eax),%eax
     283:	0f be c0             	movsbl %al,%eax
     286:	01 c8                	add    %ecx,%eax
     288:	83 e8 30             	sub    $0x30,%eax
     28b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     28e:	8b 45 08             	mov    0x8(%ebp),%eax
     291:	0f b6 00             	movzbl (%eax),%eax
     294:	3c 2f                	cmp    $0x2f,%al
     296:	7e 0a                	jle    2a2 <atoi+0x48>
     298:	8b 45 08             	mov    0x8(%ebp),%eax
     29b:	0f b6 00             	movzbl (%eax),%eax
     29e:	3c 39                	cmp    $0x39,%al
     2a0:	7e c7                	jle    269 <atoi+0xf>
  return n;
     2a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2a5:	c9                   	leave  
     2a6:	c3                   	ret    

000002a7 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     2a7:	55                   	push   %ebp
     2a8:	89 e5                	mov    %esp,%ebp
     2aa:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     2ad:	8b 45 08             	mov    0x8(%ebp),%eax
     2b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     2b3:	8b 45 0c             	mov    0xc(%ebp),%eax
     2b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     2b9:	eb 17                	jmp    2d2 <memmove+0x2b>
    *dst++ = *src++;
     2bb:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2be:	8d 42 01             	lea    0x1(%edx),%eax
     2c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
     2c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2c7:	8d 48 01             	lea    0x1(%eax),%ecx
     2ca:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     2cd:	0f b6 12             	movzbl (%edx),%edx
     2d0:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     2d2:	8b 45 10             	mov    0x10(%ebp),%eax
     2d5:	8d 50 ff             	lea    -0x1(%eax),%edx
     2d8:	89 55 10             	mov    %edx,0x10(%ebp)
     2db:	85 c0                	test   %eax,%eax
     2dd:	7f dc                	jg     2bb <memmove+0x14>
  return vdst;
     2df:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2e2:	c9                   	leave  
     2e3:	c3                   	ret    

000002e4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2e4:	b8 01 00 00 00       	mov    $0x1,%eax
     2e9:	cd 40                	int    $0x40
     2eb:	c3                   	ret    

000002ec <exit>:
SYSCALL(exit)
     2ec:	b8 02 00 00 00       	mov    $0x2,%eax
     2f1:	cd 40                	int    $0x40
     2f3:	c3                   	ret    

000002f4 <wait>:
SYSCALL(wait)
     2f4:	b8 03 00 00 00       	mov    $0x3,%eax
     2f9:	cd 40                	int    $0x40
     2fb:	c3                   	ret    

000002fc <pipe>:
SYSCALL(pipe)
     2fc:	b8 04 00 00 00       	mov    $0x4,%eax
     301:	cd 40                	int    $0x40
     303:	c3                   	ret    

00000304 <read>:
SYSCALL(read)
     304:	b8 05 00 00 00       	mov    $0x5,%eax
     309:	cd 40                	int    $0x40
     30b:	c3                   	ret    

0000030c <write>:
SYSCALL(write)
     30c:	b8 10 00 00 00       	mov    $0x10,%eax
     311:	cd 40                	int    $0x40
     313:	c3                   	ret    

00000314 <close>:
SYSCALL(close)
     314:	b8 15 00 00 00       	mov    $0x15,%eax
     319:	cd 40                	int    $0x40
     31b:	c3                   	ret    

0000031c <kill>:
SYSCALL(kill)
     31c:	b8 06 00 00 00       	mov    $0x6,%eax
     321:	cd 40                	int    $0x40
     323:	c3                   	ret    

00000324 <exec>:
SYSCALL(exec)
     324:	b8 07 00 00 00       	mov    $0x7,%eax
     329:	cd 40                	int    $0x40
     32b:	c3                   	ret    

0000032c <open>:
SYSCALL(open)
     32c:	b8 0f 00 00 00       	mov    $0xf,%eax
     331:	cd 40                	int    $0x40
     333:	c3                   	ret    

00000334 <mknod>:
SYSCALL(mknod)
     334:	b8 11 00 00 00       	mov    $0x11,%eax
     339:	cd 40                	int    $0x40
     33b:	c3                   	ret    

0000033c <unlink>:
SYSCALL(unlink)
     33c:	b8 12 00 00 00       	mov    $0x12,%eax
     341:	cd 40                	int    $0x40
     343:	c3                   	ret    

00000344 <fstat>:
SYSCALL(fstat)
     344:	b8 08 00 00 00       	mov    $0x8,%eax
     349:	cd 40                	int    $0x40
     34b:	c3                   	ret    

0000034c <link>:
SYSCALL(link)
     34c:	b8 13 00 00 00       	mov    $0x13,%eax
     351:	cd 40                	int    $0x40
     353:	c3                   	ret    

00000354 <mkdir>:
SYSCALL(mkdir)
     354:	b8 14 00 00 00       	mov    $0x14,%eax
     359:	cd 40                	int    $0x40
     35b:	c3                   	ret    

0000035c <chdir>:
SYSCALL(chdir)
     35c:	b8 09 00 00 00       	mov    $0x9,%eax
     361:	cd 40                	int    $0x40
     363:	c3                   	ret    

00000364 <dup>:
SYSCALL(dup)
     364:	b8 0a 00 00 00       	mov    $0xa,%eax
     369:	cd 40                	int    $0x40
     36b:	c3                   	ret    

0000036c <getpid>:
SYSCALL(getpid)
     36c:	b8 0b 00 00 00       	mov    $0xb,%eax
     371:	cd 40                	int    $0x40
     373:	c3                   	ret    

00000374 <sbrk>:
SYSCALL(sbrk)
     374:	b8 0c 00 00 00       	mov    $0xc,%eax
     379:	cd 40                	int    $0x40
     37b:	c3                   	ret    

0000037c <sleep>:
SYSCALL(sleep)
     37c:	b8 0d 00 00 00       	mov    $0xd,%eax
     381:	cd 40                	int    $0x40
     383:	c3                   	ret    

00000384 <uptime>:
SYSCALL(uptime)
     384:	b8 0e 00 00 00       	mov    $0xe,%eax
     389:	cd 40                	int    $0x40
     38b:	c3                   	ret    

0000038c <select>:
SYSCALL(select)
     38c:	b8 16 00 00 00       	mov    $0x16,%eax
     391:	cd 40                	int    $0x40
     393:	c3                   	ret    

00000394 <arp>:
SYSCALL(arp)
     394:	b8 17 00 00 00       	mov    $0x17,%eax
     399:	cd 40                	int    $0x40
     39b:	c3                   	ret    

0000039c <arpserv>:
SYSCALL(arpserv)
     39c:	b8 18 00 00 00       	mov    $0x18,%eax
     3a1:	cd 40                	int    $0x40
     3a3:	c3                   	ret    

000003a4 <arp_receive>:
SYSCALL(arp_receive)
     3a4:	b8 19 00 00 00       	mov    $0x19,%eax
     3a9:	cd 40                	int    $0x40
     3ab:	c3                   	ret    

000003ac <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3ac:	55                   	push   %ebp
     3ad:	89 e5                	mov    %esp,%ebp
     3af:	83 ec 18             	sub    $0x18,%esp
     3b2:	8b 45 0c             	mov    0xc(%ebp),%eax
     3b5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3b8:	83 ec 04             	sub    $0x4,%esp
     3bb:	6a 01                	push   $0x1
     3bd:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3c0:	50                   	push   %eax
     3c1:	ff 75 08             	pushl  0x8(%ebp)
     3c4:	e8 43 ff ff ff       	call   30c <write>
     3c9:	83 c4 10             	add    $0x10,%esp
}
     3cc:	90                   	nop
     3cd:	c9                   	leave  
     3ce:	c3                   	ret    

000003cf <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3cf:	55                   	push   %ebp
     3d0:	89 e5                	mov    %esp,%ebp
     3d2:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3d5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3dc:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3e0:	74 17                	je     3f9 <printint+0x2a>
     3e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3e6:	79 11                	jns    3f9 <printint+0x2a>
    neg = 1;
     3e8:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3ef:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f2:	f7 d8                	neg    %eax
     3f4:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3f7:	eb 06                	jmp    3ff <printint+0x30>
  } else {
    x = xx;
     3f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     406:	8b 4d 10             	mov    0x10(%ebp),%ecx
     409:	8b 45 ec             	mov    -0x14(%ebp),%eax
     40c:	ba 00 00 00 00       	mov    $0x0,%edx
     411:	f7 f1                	div    %ecx
     413:	89 d1                	mov    %edx,%ecx
     415:	8b 45 f4             	mov    -0xc(%ebp),%eax
     418:	8d 50 01             	lea    0x1(%eax),%edx
     41b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     41e:	0f b6 91 10 17 00 00 	movzbl 0x1710(%ecx),%edx
     425:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     429:	8b 4d 10             	mov    0x10(%ebp),%ecx
     42c:	8b 45 ec             	mov    -0x14(%ebp),%eax
     42f:	ba 00 00 00 00       	mov    $0x0,%edx
     434:	f7 f1                	div    %ecx
     436:	89 45 ec             	mov    %eax,-0x14(%ebp)
     439:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     43d:	75 c7                	jne    406 <printint+0x37>
  if(neg)
     43f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     443:	74 2d                	je     472 <printint+0xa3>
    buf[i++] = '-';
     445:	8b 45 f4             	mov    -0xc(%ebp),%eax
     448:	8d 50 01             	lea    0x1(%eax),%edx
     44b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     44e:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     453:	eb 1d                	jmp    472 <printint+0xa3>
    putc(fd, buf[i]);
     455:	8d 55 dc             	lea    -0x24(%ebp),%edx
     458:	8b 45 f4             	mov    -0xc(%ebp),%eax
     45b:	01 d0                	add    %edx,%eax
     45d:	0f b6 00             	movzbl (%eax),%eax
     460:	0f be c0             	movsbl %al,%eax
     463:	83 ec 08             	sub    $0x8,%esp
     466:	50                   	push   %eax
     467:	ff 75 08             	pushl  0x8(%ebp)
     46a:	e8 3d ff ff ff       	call   3ac <putc>
     46f:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     472:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     476:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     47a:	79 d9                	jns    455 <printint+0x86>
}
     47c:	90                   	nop
     47d:	c9                   	leave  
     47e:	c3                   	ret    

0000047f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     47f:	55                   	push   %ebp
     480:	89 e5                	mov    %esp,%ebp
     482:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     485:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     48c:	8d 45 0c             	lea    0xc(%ebp),%eax
     48f:	83 c0 04             	add    $0x4,%eax
     492:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     495:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     49c:	e9 59 01 00 00       	jmp    5fa <printf+0x17b>
    c = fmt[i] & 0xff;
     4a1:	8b 55 0c             	mov    0xc(%ebp),%edx
     4a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4a7:	01 d0                	add    %edx,%eax
     4a9:	0f b6 00             	movzbl (%eax),%eax
     4ac:	0f be c0             	movsbl %al,%eax
     4af:	25 ff 00 00 00       	and    $0xff,%eax
     4b4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4b7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4bb:	75 2c                	jne    4e9 <printf+0x6a>
      if(c == '%'){
     4bd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4c1:	75 0c                	jne    4cf <printf+0x50>
        state = '%';
     4c3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4ca:	e9 27 01 00 00       	jmp    5f6 <printf+0x177>
      } else {
        putc(fd, c);
     4cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4d2:	0f be c0             	movsbl %al,%eax
     4d5:	83 ec 08             	sub    $0x8,%esp
     4d8:	50                   	push   %eax
     4d9:	ff 75 08             	pushl  0x8(%ebp)
     4dc:	e8 cb fe ff ff       	call   3ac <putc>
     4e1:	83 c4 10             	add    $0x10,%esp
     4e4:	e9 0d 01 00 00       	jmp    5f6 <printf+0x177>
      }
    } else if(state == '%'){
     4e9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4ed:	0f 85 03 01 00 00    	jne    5f6 <printf+0x177>
      if(c == 'd'){
     4f3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4f7:	75 1e                	jne    517 <printf+0x98>
        printint(fd, *ap, 10, 1);
     4f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4fc:	8b 00                	mov    (%eax),%eax
     4fe:	6a 01                	push   $0x1
     500:	6a 0a                	push   $0xa
     502:	50                   	push   %eax
     503:	ff 75 08             	pushl  0x8(%ebp)
     506:	e8 c4 fe ff ff       	call   3cf <printint>
     50b:	83 c4 10             	add    $0x10,%esp
        ap++;
     50e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     512:	e9 d8 00 00 00       	jmp    5ef <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     517:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     51b:	74 06                	je     523 <printf+0xa4>
     51d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     521:	75 1e                	jne    541 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     523:	8b 45 e8             	mov    -0x18(%ebp),%eax
     526:	8b 00                	mov    (%eax),%eax
     528:	6a 00                	push   $0x0
     52a:	6a 10                	push   $0x10
     52c:	50                   	push   %eax
     52d:	ff 75 08             	pushl  0x8(%ebp)
     530:	e8 9a fe ff ff       	call   3cf <printint>
     535:	83 c4 10             	add    $0x10,%esp
        ap++;
     538:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     53c:	e9 ae 00 00 00       	jmp    5ef <printf+0x170>
      } else if(c == 's'){
     541:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     545:	75 43                	jne    58a <printf+0x10b>
        s = (char*)*ap;
     547:	8b 45 e8             	mov    -0x18(%ebp),%eax
     54a:	8b 00                	mov    (%eax),%eax
     54c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     54f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     553:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     557:	75 25                	jne    57e <printf+0xff>
          s = "(null)";
     559:	c7 45 f4 69 10 00 00 	movl   $0x1069,-0xc(%ebp)
        while(*s != 0){
     560:	eb 1c                	jmp    57e <printf+0xff>
          putc(fd, *s);
     562:	8b 45 f4             	mov    -0xc(%ebp),%eax
     565:	0f b6 00             	movzbl (%eax),%eax
     568:	0f be c0             	movsbl %al,%eax
     56b:	83 ec 08             	sub    $0x8,%esp
     56e:	50                   	push   %eax
     56f:	ff 75 08             	pushl  0x8(%ebp)
     572:	e8 35 fe ff ff       	call   3ac <putc>
     577:	83 c4 10             	add    $0x10,%esp
          s++;
     57a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     57e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     581:	0f b6 00             	movzbl (%eax),%eax
     584:	84 c0                	test   %al,%al
     586:	75 da                	jne    562 <printf+0xe3>
     588:	eb 65                	jmp    5ef <printf+0x170>
        }
      } else if(c == 'c'){
     58a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     58e:	75 1d                	jne    5ad <printf+0x12e>
        putc(fd, *ap);
     590:	8b 45 e8             	mov    -0x18(%ebp),%eax
     593:	8b 00                	mov    (%eax),%eax
     595:	0f be c0             	movsbl %al,%eax
     598:	83 ec 08             	sub    $0x8,%esp
     59b:	50                   	push   %eax
     59c:	ff 75 08             	pushl  0x8(%ebp)
     59f:	e8 08 fe ff ff       	call   3ac <putc>
     5a4:	83 c4 10             	add    $0x10,%esp
        ap++;
     5a7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5ab:	eb 42                	jmp    5ef <printf+0x170>
      } else if(c == '%'){
     5ad:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5b1:	75 17                	jne    5ca <printf+0x14b>
        putc(fd, c);
     5b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5b6:	0f be c0             	movsbl %al,%eax
     5b9:	83 ec 08             	sub    $0x8,%esp
     5bc:	50                   	push   %eax
     5bd:	ff 75 08             	pushl  0x8(%ebp)
     5c0:	e8 e7 fd ff ff       	call   3ac <putc>
     5c5:	83 c4 10             	add    $0x10,%esp
     5c8:	eb 25                	jmp    5ef <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5ca:	83 ec 08             	sub    $0x8,%esp
     5cd:	6a 25                	push   $0x25
     5cf:	ff 75 08             	pushl  0x8(%ebp)
     5d2:	e8 d5 fd ff ff       	call   3ac <putc>
     5d7:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5dd:	0f be c0             	movsbl %al,%eax
     5e0:	83 ec 08             	sub    $0x8,%esp
     5e3:	50                   	push   %eax
     5e4:	ff 75 08             	pushl  0x8(%ebp)
     5e7:	e8 c0 fd ff ff       	call   3ac <putc>
     5ec:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     5f6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5fa:	8b 55 0c             	mov    0xc(%ebp),%edx
     5fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     600:	01 d0                	add    %edx,%eax
     602:	0f b6 00             	movzbl (%eax),%eax
     605:	84 c0                	test   %al,%al
     607:	0f 85 94 fe ff ff    	jne    4a1 <printf+0x22>
    }
  }
}
     60d:	90                   	nop
     60e:	c9                   	leave  
     60f:	c3                   	ret    

00000610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     616:	8b 45 08             	mov    0x8(%ebp),%eax
     619:	83 e8 08             	sub    $0x8,%eax
     61c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     61f:	a1 2c 17 00 00       	mov    0x172c,%eax
     624:	89 45 fc             	mov    %eax,-0x4(%ebp)
     627:	eb 24                	jmp    64d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     629:	8b 45 fc             	mov    -0x4(%ebp),%eax
     62c:	8b 00                	mov    (%eax),%eax
     62e:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     631:	72 12                	jb     645 <free+0x35>
     633:	8b 45 f8             	mov    -0x8(%ebp),%eax
     636:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     639:	77 24                	ja     65f <free+0x4f>
     63b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     63e:	8b 00                	mov    (%eax),%eax
     640:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     643:	72 1a                	jb     65f <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     645:	8b 45 fc             	mov    -0x4(%ebp),%eax
     648:	8b 00                	mov    (%eax),%eax
     64a:	89 45 fc             	mov    %eax,-0x4(%ebp)
     64d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     650:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     653:	76 d4                	jbe    629 <free+0x19>
     655:	8b 45 fc             	mov    -0x4(%ebp),%eax
     658:	8b 00                	mov    (%eax),%eax
     65a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     65d:	73 ca                	jae    629 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     65f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     662:	8b 40 04             	mov    0x4(%eax),%eax
     665:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     66c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     66f:	01 c2                	add    %eax,%edx
     671:	8b 45 fc             	mov    -0x4(%ebp),%eax
     674:	8b 00                	mov    (%eax),%eax
     676:	39 c2                	cmp    %eax,%edx
     678:	75 24                	jne    69e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     67a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     67d:	8b 50 04             	mov    0x4(%eax),%edx
     680:	8b 45 fc             	mov    -0x4(%ebp),%eax
     683:	8b 00                	mov    (%eax),%eax
     685:	8b 40 04             	mov    0x4(%eax),%eax
     688:	01 c2                	add    %eax,%edx
     68a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     690:	8b 45 fc             	mov    -0x4(%ebp),%eax
     693:	8b 00                	mov    (%eax),%eax
     695:	8b 10                	mov    (%eax),%edx
     697:	8b 45 f8             	mov    -0x8(%ebp),%eax
     69a:	89 10                	mov    %edx,(%eax)
     69c:	eb 0a                	jmp    6a8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     69e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a1:	8b 10                	mov    (%eax),%edx
     6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ab:	8b 40 04             	mov    0x4(%eax),%eax
     6ae:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b8:	01 d0                	add    %edx,%eax
     6ba:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6bd:	75 20                	jne    6df <free+0xcf>
    p->s.size += bp->s.size;
     6bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c2:	8b 50 04             	mov    0x4(%eax),%edx
     6c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c8:	8b 40 04             	mov    0x4(%eax),%eax
     6cb:	01 c2                	add    %eax,%edx
     6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d6:	8b 10                	mov    (%eax),%edx
     6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6db:	89 10                	mov    %edx,(%eax)
     6dd:	eb 08                	jmp    6e7 <free+0xd7>
  } else
    p->s.ptr = bp;
     6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e2:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6e5:	89 10                	mov    %edx,(%eax)
  freep = p;
     6e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ea:	a3 2c 17 00 00       	mov    %eax,0x172c
}
     6ef:	90                   	nop
     6f0:	c9                   	leave  
     6f1:	c3                   	ret    

000006f2 <morecore>:

static Header*
morecore(uint nu)
{
     6f2:	55                   	push   %ebp
     6f3:	89 e5                	mov    %esp,%ebp
     6f5:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6f8:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6ff:	77 07                	ja     708 <morecore+0x16>
    nu = 4096;
     701:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     708:	8b 45 08             	mov    0x8(%ebp),%eax
     70b:	c1 e0 03             	shl    $0x3,%eax
     70e:	83 ec 0c             	sub    $0xc,%esp
     711:	50                   	push   %eax
     712:	e8 5d fc ff ff       	call   374 <sbrk>
     717:	83 c4 10             	add    $0x10,%esp
     71a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     71d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     721:	75 07                	jne    72a <morecore+0x38>
    return 0;
     723:	b8 00 00 00 00       	mov    $0x0,%eax
     728:	eb 26                	jmp    750 <morecore+0x5e>
  hp = (Header*)p;
     72a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     730:	8b 45 f0             	mov    -0x10(%ebp),%eax
     733:	8b 55 08             	mov    0x8(%ebp),%edx
     736:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     739:	8b 45 f0             	mov    -0x10(%ebp),%eax
     73c:	83 c0 08             	add    $0x8,%eax
     73f:	83 ec 0c             	sub    $0xc,%esp
     742:	50                   	push   %eax
     743:	e8 c8 fe ff ff       	call   610 <free>
     748:	83 c4 10             	add    $0x10,%esp
  return freep;
     74b:	a1 2c 17 00 00       	mov    0x172c,%eax
}
     750:	c9                   	leave  
     751:	c3                   	ret    

00000752 <malloc>:

void*
malloc(uint nbytes)
{
     752:	55                   	push   %ebp
     753:	89 e5                	mov    %esp,%ebp
     755:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     758:	8b 45 08             	mov    0x8(%ebp),%eax
     75b:	83 c0 07             	add    $0x7,%eax
     75e:	c1 e8 03             	shr    $0x3,%eax
     761:	83 c0 01             	add    $0x1,%eax
     764:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     767:	a1 2c 17 00 00       	mov    0x172c,%eax
     76c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     76f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     773:	75 23                	jne    798 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     775:	c7 45 f0 24 17 00 00 	movl   $0x1724,-0x10(%ebp)
     77c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     77f:	a3 2c 17 00 00       	mov    %eax,0x172c
     784:	a1 2c 17 00 00       	mov    0x172c,%eax
     789:	a3 24 17 00 00       	mov    %eax,0x1724
    base.s.size = 0;
     78e:	c7 05 28 17 00 00 00 	movl   $0x0,0x1728
     795:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     798:	8b 45 f0             	mov    -0x10(%ebp),%eax
     79b:	8b 00                	mov    (%eax),%eax
     79d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a3:	8b 40 04             	mov    0x4(%eax),%eax
     7a6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7a9:	77 4d                	ja     7f8 <malloc+0xa6>
      if(p->s.size == nunits)
     7ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ae:	8b 40 04             	mov    0x4(%eax),%eax
     7b1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7b4:	75 0c                	jne    7c2 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b9:	8b 10                	mov    (%eax),%edx
     7bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7be:	89 10                	mov    %edx,(%eax)
     7c0:	eb 26                	jmp    7e8 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c5:	8b 40 04             	mov    0x4(%eax),%eax
     7c8:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7cb:	89 c2                	mov    %eax,%edx
     7cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d6:	8b 40 04             	mov    0x4(%eax),%eax
     7d9:	c1 e0 03             	shl    $0x3,%eax
     7dc:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7df:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e2:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7e5:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7eb:	a3 2c 17 00 00       	mov    %eax,0x172c
      return (void*)(p + 1);
     7f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f3:	83 c0 08             	add    $0x8,%eax
     7f6:	eb 3b                	jmp    833 <malloc+0xe1>
    }
    if(p == freep)
     7f8:	a1 2c 17 00 00       	mov    0x172c,%eax
     7fd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     800:	75 1e                	jne    820 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     802:	83 ec 0c             	sub    $0xc,%esp
     805:	ff 75 ec             	pushl  -0x14(%ebp)
     808:	e8 e5 fe ff ff       	call   6f2 <morecore>
     80d:	83 c4 10             	add    $0x10,%esp
     810:	89 45 f4             	mov    %eax,-0xc(%ebp)
     813:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     817:	75 07                	jne    820 <malloc+0xce>
        return 0;
     819:	b8 00 00 00 00       	mov    $0x0,%eax
     81e:	eb 13                	jmp    833 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     820:	8b 45 f4             	mov    -0xc(%ebp),%eax
     823:	89 45 f0             	mov    %eax,-0x10(%ebp)
     826:	8b 45 f4             	mov    -0xc(%ebp),%eax
     829:	8b 00                	mov    (%eax),%eax
     82b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     82e:	e9 6d ff ff ff       	jmp    7a0 <malloc+0x4e>
  }
}
     833:	c9                   	leave  
     834:	c3                   	ret    

00000835 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     835:	55                   	push   %ebp
     836:	89 e5                	mov    %esp,%ebp
     838:	53                   	push   %ebx
     839:	83 ec 14             	sub    $0x14,%esp
     83c:	8b 45 10             	mov    0x10(%ebp),%eax
     83f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     842:	8b 45 14             	mov    0x14(%ebp),%eax
     845:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     848:	8b 45 18             	mov    0x18(%ebp),%eax
     84b:	ba 00 00 00 00       	mov    $0x0,%edx
     850:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     853:	72 55                	jb     8aa <printnum+0x75>
     855:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     858:	77 05                	ja     85f <printnum+0x2a>
     85a:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     85d:	72 4b                	jb     8aa <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     85f:	8b 45 1c             	mov    0x1c(%ebp),%eax
     862:	8d 58 ff             	lea    -0x1(%eax),%ebx
     865:	8b 45 18             	mov    0x18(%ebp),%eax
     868:	ba 00 00 00 00       	mov    $0x0,%edx
     86d:	52                   	push   %edx
     86e:	50                   	push   %eax
     86f:	ff 75 f4             	pushl  -0xc(%ebp)
     872:	ff 75 f0             	pushl  -0x10(%ebp)
     875:	e8 a6 05 00 00       	call   e20 <__udivdi3>
     87a:	83 c4 10             	add    $0x10,%esp
     87d:	83 ec 04             	sub    $0x4,%esp
     880:	ff 75 20             	pushl  0x20(%ebp)
     883:	53                   	push   %ebx
     884:	ff 75 18             	pushl  0x18(%ebp)
     887:	52                   	push   %edx
     888:	50                   	push   %eax
     889:	ff 75 0c             	pushl  0xc(%ebp)
     88c:	ff 75 08             	pushl  0x8(%ebp)
     88f:	e8 a1 ff ff ff       	call   835 <printnum>
     894:	83 c4 20             	add    $0x20,%esp
     897:	eb 1b                	jmp    8b4 <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     899:	83 ec 08             	sub    $0x8,%esp
     89c:	ff 75 0c             	pushl  0xc(%ebp)
     89f:	ff 75 20             	pushl  0x20(%ebp)
     8a2:	8b 45 08             	mov    0x8(%ebp),%eax
     8a5:	ff d0                	call   *%eax
     8a7:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     8aa:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     8ae:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     8b2:	7f e5                	jg     899 <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     8b4:	8b 4d 18             	mov    0x18(%ebp),%ecx
     8b7:	bb 00 00 00 00       	mov    $0x0,%ebx
     8bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8c2:	53                   	push   %ebx
     8c3:	51                   	push   %ecx
     8c4:	52                   	push   %edx
     8c5:	50                   	push   %eax
     8c6:	e8 75 06 00 00       	call   f40 <__umoddi3>
     8cb:	83 c4 10             	add    $0x10,%esp
     8ce:	05 40 11 00 00       	add    $0x1140,%eax
     8d3:	0f b6 00             	movzbl (%eax),%eax
     8d6:	0f be c0             	movsbl %al,%eax
     8d9:	83 ec 08             	sub    $0x8,%esp
     8dc:	ff 75 0c             	pushl  0xc(%ebp)
     8df:	50                   	push   %eax
     8e0:	8b 45 08             	mov    0x8(%ebp),%eax
     8e3:	ff d0                	call   *%eax
     8e5:	83 c4 10             	add    $0x10,%esp
}
     8e8:	90                   	nop
     8e9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8ec:	c9                   	leave  
     8ed:	c3                   	ret    

000008ee <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     8ee:	55                   	push   %ebp
     8ef:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     8f1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     8f5:	7e 14                	jle    90b <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     8f7:	8b 45 08             	mov    0x8(%ebp),%eax
     8fa:	8b 00                	mov    (%eax),%eax
     8fc:	8d 48 08             	lea    0x8(%eax),%ecx
     8ff:	8b 55 08             	mov    0x8(%ebp),%edx
     902:	89 0a                	mov    %ecx,(%edx)
     904:	8b 50 04             	mov    0x4(%eax),%edx
     907:	8b 00                	mov    (%eax),%eax
     909:	eb 30                	jmp    93b <getuint+0x4d>
  else if (lflag)
     90b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     90f:	74 16                	je     927 <getuint+0x39>
    return va_arg(*ap, unsigned long);
     911:	8b 45 08             	mov    0x8(%ebp),%eax
     914:	8b 00                	mov    (%eax),%eax
     916:	8d 48 04             	lea    0x4(%eax),%ecx
     919:	8b 55 08             	mov    0x8(%ebp),%edx
     91c:	89 0a                	mov    %ecx,(%edx)
     91e:	8b 00                	mov    (%eax),%eax
     920:	ba 00 00 00 00       	mov    $0x0,%edx
     925:	eb 14                	jmp    93b <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     927:	8b 45 08             	mov    0x8(%ebp),%eax
     92a:	8b 00                	mov    (%eax),%eax
     92c:	8d 48 04             	lea    0x4(%eax),%ecx
     92f:	8b 55 08             	mov    0x8(%ebp),%edx
     932:	89 0a                	mov    %ecx,(%edx)
     934:	8b 00                	mov    (%eax),%eax
     936:	ba 00 00 00 00       	mov    $0x0,%edx
}
     93b:	5d                   	pop    %ebp
     93c:	c3                   	ret    

0000093d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     93d:	55                   	push   %ebp
     93e:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     940:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     944:	7e 14                	jle    95a <getint+0x1d>
    return va_arg(*ap, long long);
     946:	8b 45 08             	mov    0x8(%ebp),%eax
     949:	8b 00                	mov    (%eax),%eax
     94b:	8d 48 08             	lea    0x8(%eax),%ecx
     94e:	8b 55 08             	mov    0x8(%ebp),%edx
     951:	89 0a                	mov    %ecx,(%edx)
     953:	8b 50 04             	mov    0x4(%eax),%edx
     956:	8b 00                	mov    (%eax),%eax
     958:	eb 28                	jmp    982 <getint+0x45>
  else if (lflag)
     95a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     95e:	74 12                	je     972 <getint+0x35>
    return va_arg(*ap, long);
     960:	8b 45 08             	mov    0x8(%ebp),%eax
     963:	8b 00                	mov    (%eax),%eax
     965:	8d 48 04             	lea    0x4(%eax),%ecx
     968:	8b 55 08             	mov    0x8(%ebp),%edx
     96b:	89 0a                	mov    %ecx,(%edx)
     96d:	8b 00                	mov    (%eax),%eax
     96f:	99                   	cltd   
     970:	eb 10                	jmp    982 <getint+0x45>
  else
    return va_arg(*ap, int);
     972:	8b 45 08             	mov    0x8(%ebp),%eax
     975:	8b 00                	mov    (%eax),%eax
     977:	8d 48 04             	lea    0x4(%eax),%ecx
     97a:	8b 55 08             	mov    0x8(%ebp),%edx
     97d:	89 0a                	mov    %ecx,(%edx)
     97f:	8b 00                	mov    (%eax),%eax
     981:	99                   	cltd   
}
     982:	5d                   	pop    %ebp
     983:	c3                   	ret    

00000984 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     984:	55                   	push   %ebp
     985:	89 e5                	mov    %esp,%ebp
     987:	56                   	push   %esi
     988:	53                   	push   %ebx
     989:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     98c:	eb 17                	jmp    9a5 <vprintfmt+0x21>
      if (ch == '\0')
     98e:	85 db                	test   %ebx,%ebx
     990:	0f 84 a0 03 00 00    	je     d36 <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     996:	83 ec 08             	sub    $0x8,%esp
     999:	ff 75 0c             	pushl  0xc(%ebp)
     99c:	53                   	push   %ebx
     99d:	8b 45 08             	mov    0x8(%ebp),%eax
     9a0:	ff d0                	call   *%eax
     9a2:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     9a5:	8b 45 10             	mov    0x10(%ebp),%eax
     9a8:	8d 50 01             	lea    0x1(%eax),%edx
     9ab:	89 55 10             	mov    %edx,0x10(%ebp)
     9ae:	0f b6 00             	movzbl (%eax),%eax
     9b1:	0f b6 d8             	movzbl %al,%ebx
     9b4:	83 fb 25             	cmp    $0x25,%ebx
     9b7:	75 d5                	jne    98e <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     9b9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     9bd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     9c4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     9cb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     9d2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     9d9:	8b 45 10             	mov    0x10(%ebp),%eax
     9dc:	8d 50 01             	lea    0x1(%eax),%edx
     9df:	89 55 10             	mov    %edx,0x10(%ebp)
     9e2:	0f b6 00             	movzbl (%eax),%eax
     9e5:	0f b6 d8             	movzbl %al,%ebx
     9e8:	8d 43 dd             	lea    -0x23(%ebx),%eax
     9eb:	83 f8 55             	cmp    $0x55,%eax
     9ee:	0f 87 15 03 00 00    	ja     d09 <vprintfmt+0x385>
     9f4:	8b 04 85 64 11 00 00 	mov    0x1164(,%eax,4),%eax
     9fb:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     9fd:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     a01:	eb d6                	jmp    9d9 <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     a03:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     a07:	eb d0                	jmp    9d9 <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     a09:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     a10:	8b 55 e0             	mov    -0x20(%ebp),%edx
     a13:	89 d0                	mov    %edx,%eax
     a15:	c1 e0 02             	shl    $0x2,%eax
     a18:	01 d0                	add    %edx,%eax
     a1a:	01 c0                	add    %eax,%eax
     a1c:	01 d8                	add    %ebx,%eax
     a1e:	83 e8 30             	sub    $0x30,%eax
     a21:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     a24:	8b 45 10             	mov    0x10(%ebp),%eax
     a27:	0f b6 00             	movzbl (%eax),%eax
     a2a:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     a2d:	83 fb 2f             	cmp    $0x2f,%ebx
     a30:	7e 39                	jle    a6b <vprintfmt+0xe7>
     a32:	83 fb 39             	cmp    $0x39,%ebx
     a35:	7f 34                	jg     a6b <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     a37:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     a3b:	eb d3                	jmp    a10 <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     a3d:	8b 45 14             	mov    0x14(%ebp),%eax
     a40:	8d 50 04             	lea    0x4(%eax),%edx
     a43:	89 55 14             	mov    %edx,0x14(%ebp)
     a46:	8b 00                	mov    (%eax),%eax
     a48:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     a4b:	eb 1f                	jmp    a6c <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     a4d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a51:	79 86                	jns    9d9 <vprintfmt+0x55>
        width = 0;
     a53:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     a5a:	e9 7a ff ff ff       	jmp    9d9 <vprintfmt+0x55>

    case '#':
      altflag = 1;
     a5f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     a66:	e9 6e ff ff ff       	jmp    9d9 <vprintfmt+0x55>
      goto process_precision;
     a6b:	90                   	nop

process_precision:
      if (width < 0)
     a6c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a70:	0f 89 63 ff ff ff    	jns    9d9 <vprintfmt+0x55>
        width = precision, precision = -1;
     a76:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a79:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a7c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     a83:	e9 51 ff ff ff       	jmp    9d9 <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     a88:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     a8c:	e9 48 ff ff ff       	jmp    9d9 <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     a91:	8b 45 14             	mov    0x14(%ebp),%eax
     a94:	8d 50 04             	lea    0x4(%eax),%edx
     a97:	89 55 14             	mov    %edx,0x14(%ebp)
     a9a:	8b 00                	mov    (%eax),%eax
     a9c:	83 ec 08             	sub    $0x8,%esp
     a9f:	ff 75 0c             	pushl  0xc(%ebp)
     aa2:	50                   	push   %eax
     aa3:	8b 45 08             	mov    0x8(%ebp),%eax
     aa6:	ff d0                	call   *%eax
     aa8:	83 c4 10             	add    $0x10,%esp
      break;
     aab:	e9 81 02 00 00       	jmp    d31 <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     ab0:	8b 45 14             	mov    0x14(%ebp),%eax
     ab3:	8d 50 04             	lea    0x4(%eax),%edx
     ab6:	89 55 14             	mov    %edx,0x14(%ebp)
     ab9:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     abb:	85 db                	test   %ebx,%ebx
     abd:	79 02                	jns    ac1 <vprintfmt+0x13d>
        err = -err;
     abf:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     ac1:	83 fb 0f             	cmp    $0xf,%ebx
     ac4:	7f 0b                	jg     ad1 <vprintfmt+0x14d>
     ac6:	8b 34 9d 00 11 00 00 	mov    0x1100(,%ebx,4),%esi
     acd:	85 f6                	test   %esi,%esi
     acf:	75 19                	jne    aea <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     ad1:	53                   	push   %ebx
     ad2:	68 51 11 00 00       	push   $0x1151
     ad7:	ff 75 0c             	pushl  0xc(%ebp)
     ada:	ff 75 08             	pushl  0x8(%ebp)
     add:	e8 5c 02 00 00       	call   d3e <printfmt>
     ae2:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     ae5:	e9 47 02 00 00       	jmp    d31 <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     aea:	56                   	push   %esi
     aeb:	68 5a 11 00 00       	push   $0x115a
     af0:	ff 75 0c             	pushl  0xc(%ebp)
     af3:	ff 75 08             	pushl  0x8(%ebp)
     af6:	e8 43 02 00 00       	call   d3e <printfmt>
     afb:	83 c4 10             	add    $0x10,%esp
      break;
     afe:	e9 2e 02 00 00       	jmp    d31 <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     b03:	8b 45 14             	mov    0x14(%ebp),%eax
     b06:	8d 50 04             	lea    0x4(%eax),%edx
     b09:	89 55 14             	mov    %edx,0x14(%ebp)
     b0c:	8b 30                	mov    (%eax),%esi
     b0e:	85 f6                	test   %esi,%esi
     b10:	75 05                	jne    b17 <vprintfmt+0x193>
        p = "(null)";
     b12:	be 5d 11 00 00       	mov    $0x115d,%esi
      if (width > 0 && padc != '-')
     b17:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b1b:	7e 6f                	jle    b8c <vprintfmt+0x208>
     b1d:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     b21:	74 69                	je     b8c <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     b23:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b26:	83 ec 08             	sub    $0x8,%esp
     b29:	50                   	push   %eax
     b2a:	56                   	push   %esi
     b2b:	e8 f1 f5 ff ff       	call   121 <strnlen>
     b30:	83 c4 10             	add    $0x10,%esp
     b33:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     b36:	eb 17                	jmp    b4f <vprintfmt+0x1cb>
          putch(padc, putdat);
     b38:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     b3c:	83 ec 08             	sub    $0x8,%esp
     b3f:	ff 75 0c             	pushl  0xc(%ebp)
     b42:	50                   	push   %eax
     b43:	8b 45 08             	mov    0x8(%ebp),%eax
     b46:	ff d0                	call   *%eax
     b48:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     b4b:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b4f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b53:	7f e3                	jg     b38 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b55:	eb 35                	jmp    b8c <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     b57:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     b5b:	74 1c                	je     b79 <vprintfmt+0x1f5>
     b5d:	83 fb 1f             	cmp    $0x1f,%ebx
     b60:	7e 05                	jle    b67 <vprintfmt+0x1e3>
     b62:	83 fb 7e             	cmp    $0x7e,%ebx
     b65:	7e 12                	jle    b79 <vprintfmt+0x1f5>
          putch('?', putdat);
     b67:	83 ec 08             	sub    $0x8,%esp
     b6a:	ff 75 0c             	pushl  0xc(%ebp)
     b6d:	6a 3f                	push   $0x3f
     b6f:	8b 45 08             	mov    0x8(%ebp),%eax
     b72:	ff d0                	call   *%eax
     b74:	83 c4 10             	add    $0x10,%esp
     b77:	eb 0f                	jmp    b88 <vprintfmt+0x204>
        else
          putch(ch, putdat);
     b79:	83 ec 08             	sub    $0x8,%esp
     b7c:	ff 75 0c             	pushl  0xc(%ebp)
     b7f:	53                   	push   %ebx
     b80:	8b 45 08             	mov    0x8(%ebp),%eax
     b83:	ff d0                	call   *%eax
     b85:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b88:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b8c:	89 f0                	mov    %esi,%eax
     b8e:	8d 70 01             	lea    0x1(%eax),%esi
     b91:	0f b6 00             	movzbl (%eax),%eax
     b94:	0f be d8             	movsbl %al,%ebx
     b97:	85 db                	test   %ebx,%ebx
     b99:	74 26                	je     bc1 <vprintfmt+0x23d>
     b9b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     b9f:	78 b6                	js     b57 <vprintfmt+0x1d3>
     ba1:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     ba5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     ba9:	79 ac                	jns    b57 <vprintfmt+0x1d3>
      for (; width > 0; width--)
     bab:	eb 14                	jmp    bc1 <vprintfmt+0x23d>
        putch(' ', putdat);
     bad:	83 ec 08             	sub    $0x8,%esp
     bb0:	ff 75 0c             	pushl  0xc(%ebp)
     bb3:	6a 20                	push   $0x20
     bb5:	8b 45 08             	mov    0x8(%ebp),%eax
     bb8:	ff d0                	call   *%eax
     bba:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     bbd:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     bc1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bc5:	7f e6                	jg     bad <vprintfmt+0x229>
      break;
     bc7:	e9 65 01 00 00       	jmp    d31 <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     bcc:	83 ec 08             	sub    $0x8,%esp
     bcf:	ff 75 e8             	pushl  -0x18(%ebp)
     bd2:	8d 45 14             	lea    0x14(%ebp),%eax
     bd5:	50                   	push   %eax
     bd6:	e8 62 fd ff ff       	call   93d <getint>
     bdb:	83 c4 10             	add    $0x10,%esp
     bde:	89 45 f0             	mov    %eax,-0x10(%ebp)
     be1:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     be4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     be7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bea:	85 d2                	test   %edx,%edx
     bec:	79 23                	jns    c11 <vprintfmt+0x28d>
        putch('-', putdat);
     bee:	83 ec 08             	sub    $0x8,%esp
     bf1:	ff 75 0c             	pushl  0xc(%ebp)
     bf4:	6a 2d                	push   $0x2d
     bf6:	8b 45 08             	mov    0x8(%ebp),%eax
     bf9:	ff d0                	call   *%eax
     bfb:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     bfe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c01:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c04:	f7 d8                	neg    %eax
     c06:	83 d2 00             	adc    $0x0,%edx
     c09:	f7 da                	neg    %edx
     c0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c0e:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     c11:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c18:	e9 b6 00 00 00       	jmp    cd3 <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     c1d:	83 ec 08             	sub    $0x8,%esp
     c20:	ff 75 e8             	pushl  -0x18(%ebp)
     c23:	8d 45 14             	lea    0x14(%ebp),%eax
     c26:	50                   	push   %eax
     c27:	e8 c2 fc ff ff       	call   8ee <getuint>
     c2c:	83 c4 10             	add    $0x10,%esp
     c2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c32:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     c35:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c3c:	e9 92 00 00 00       	jmp    cd3 <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     c41:	83 ec 08             	sub    $0x8,%esp
     c44:	ff 75 0c             	pushl  0xc(%ebp)
     c47:	6a 58                	push   $0x58
     c49:	8b 45 08             	mov    0x8(%ebp),%eax
     c4c:	ff d0                	call   *%eax
     c4e:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c51:	83 ec 08             	sub    $0x8,%esp
     c54:	ff 75 0c             	pushl  0xc(%ebp)
     c57:	6a 58                	push   $0x58
     c59:	8b 45 08             	mov    0x8(%ebp),%eax
     c5c:	ff d0                	call   *%eax
     c5e:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c61:	83 ec 08             	sub    $0x8,%esp
     c64:	ff 75 0c             	pushl  0xc(%ebp)
     c67:	6a 58                	push   $0x58
     c69:	8b 45 08             	mov    0x8(%ebp),%eax
     c6c:	ff d0                	call   *%eax
     c6e:	83 c4 10             	add    $0x10,%esp
      break;
     c71:	e9 bb 00 00 00       	jmp    d31 <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     c76:	83 ec 08             	sub    $0x8,%esp
     c79:	ff 75 0c             	pushl  0xc(%ebp)
     c7c:	6a 30                	push   $0x30
     c7e:	8b 45 08             	mov    0x8(%ebp),%eax
     c81:	ff d0                	call   *%eax
     c83:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     c86:	83 ec 08             	sub    $0x8,%esp
     c89:	ff 75 0c             	pushl  0xc(%ebp)
     c8c:	6a 78                	push   $0x78
     c8e:	8b 45 08             	mov    0x8(%ebp),%eax
     c91:	ff d0                	call   *%eax
     c93:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     c96:	8b 45 14             	mov    0x14(%ebp),%eax
     c99:	8d 50 04             	lea    0x4(%eax),%edx
     c9c:	89 55 14             	mov    %edx,0x14(%ebp)
     c9f:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     ca1:	89 45 f0             	mov    %eax,-0x10(%ebp)
     ca4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     cab:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     cb2:	eb 1f                	jmp    cd3 <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     cb4:	83 ec 08             	sub    $0x8,%esp
     cb7:	ff 75 e8             	pushl  -0x18(%ebp)
     cba:	8d 45 14             	lea    0x14(%ebp),%eax
     cbd:	50                   	push   %eax
     cbe:	e8 2b fc ff ff       	call   8ee <getuint>
     cc3:	83 c4 10             	add    $0x10,%esp
     cc6:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cc9:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     ccc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     cd3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     cd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cda:	83 ec 04             	sub    $0x4,%esp
     cdd:	52                   	push   %edx
     cde:	ff 75 e4             	pushl  -0x1c(%ebp)
     ce1:	50                   	push   %eax
     ce2:	ff 75 f4             	pushl  -0xc(%ebp)
     ce5:	ff 75 f0             	pushl  -0x10(%ebp)
     ce8:	ff 75 0c             	pushl  0xc(%ebp)
     ceb:	ff 75 08             	pushl  0x8(%ebp)
     cee:	e8 42 fb ff ff       	call   835 <printnum>
     cf3:	83 c4 20             	add    $0x20,%esp
      break;
     cf6:	eb 39                	jmp    d31 <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     cf8:	83 ec 08             	sub    $0x8,%esp
     cfb:	ff 75 0c             	pushl  0xc(%ebp)
     cfe:	53                   	push   %ebx
     cff:	8b 45 08             	mov    0x8(%ebp),%eax
     d02:	ff d0                	call   *%eax
     d04:	83 c4 10             	add    $0x10,%esp
      break;
     d07:	eb 28                	jmp    d31 <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     d09:	83 ec 08             	sub    $0x8,%esp
     d0c:	ff 75 0c             	pushl  0xc(%ebp)
     d0f:	6a 25                	push   $0x25
     d11:	8b 45 08             	mov    0x8(%ebp),%eax
     d14:	ff d0                	call   *%eax
     d16:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     d19:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d1d:	eb 04                	jmp    d23 <vprintfmt+0x39f>
     d1f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d23:	8b 45 10             	mov    0x10(%ebp),%eax
     d26:	83 e8 01             	sub    $0x1,%eax
     d29:	0f b6 00             	movzbl (%eax),%eax
     d2c:	3c 25                	cmp    $0x25,%al
     d2e:	75 ef                	jne    d1f <vprintfmt+0x39b>
        /* do nothing */;
      break;
     d30:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     d31:	e9 6f fc ff ff       	jmp    9a5 <vprintfmt+0x21>
        return;
     d36:	90                   	nop
    }
  }
}
     d37:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d3a:	5b                   	pop    %ebx
     d3b:	5e                   	pop    %esi
     d3c:	5d                   	pop    %ebp
     d3d:	c3                   	ret    

00000d3e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     d3e:	55                   	push   %ebp
     d3f:	89 e5                	mov    %esp,%ebp
     d41:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     d44:	8d 45 14             	lea    0x14(%ebp),%eax
     d47:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     d4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d4d:	50                   	push   %eax
     d4e:	ff 75 10             	pushl  0x10(%ebp)
     d51:	ff 75 0c             	pushl  0xc(%ebp)
     d54:	ff 75 08             	pushl  0x8(%ebp)
     d57:	e8 28 fc ff ff       	call   984 <vprintfmt>
     d5c:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     d5f:	90                   	nop
     d60:	c9                   	leave  
     d61:	c3                   	ret    

00000d62 <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     d62:	55                   	push   %ebp
     d63:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     d65:	8b 45 0c             	mov    0xc(%ebp),%eax
     d68:	8b 40 08             	mov    0x8(%eax),%eax
     d6b:	8d 50 01             	lea    0x1(%eax),%edx
     d6e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d71:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     d74:	8b 45 0c             	mov    0xc(%ebp),%eax
     d77:	8b 10                	mov    (%eax),%edx
     d79:	8b 45 0c             	mov    0xc(%ebp),%eax
     d7c:	8b 40 04             	mov    0x4(%eax),%eax
     d7f:	39 c2                	cmp    %eax,%edx
     d81:	73 12                	jae    d95 <sprintputch+0x33>
    *b->buf++ = ch;
     d83:	8b 45 0c             	mov    0xc(%ebp),%eax
     d86:	8b 00                	mov    (%eax),%eax
     d88:	8d 48 01             	lea    0x1(%eax),%ecx
     d8b:	8b 55 0c             	mov    0xc(%ebp),%edx
     d8e:	89 0a                	mov    %ecx,(%edx)
     d90:	8b 55 08             	mov    0x8(%ebp),%edx
     d93:	88 10                	mov    %dl,(%eax)
}
     d95:	90                   	nop
     d96:	5d                   	pop    %ebp
     d97:	c3                   	ret    

00000d98 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     d98:	55                   	push   %ebp
     d99:	89 e5                	mov    %esp,%ebp
     d9b:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     d9e:	8b 45 08             	mov    0x8(%ebp),%eax
     da1:	89 45 ec             	mov    %eax,-0x14(%ebp)
     da4:	8b 45 0c             	mov    0xc(%ebp),%eax
     da7:	8d 50 ff             	lea    -0x1(%eax),%edx
     daa:	8b 45 08             	mov    0x8(%ebp),%eax
     dad:	01 d0                	add    %edx,%eax
     daf:	89 45 f0             	mov    %eax,-0x10(%ebp)
     db2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     db9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     dbd:	74 06                	je     dc5 <vsnprintf+0x2d>
     dbf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dc3:	7f 07                	jg     dcc <vsnprintf+0x34>
    return -E_INVAL;
     dc5:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     dca:	eb 20                	jmp    dec <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     dcc:	ff 75 14             	pushl  0x14(%ebp)
     dcf:	ff 75 10             	pushl  0x10(%ebp)
     dd2:	8d 45 ec             	lea    -0x14(%ebp),%eax
     dd5:	50                   	push   %eax
     dd6:	68 62 0d 00 00       	push   $0xd62
     ddb:	e8 a4 fb ff ff       	call   984 <vprintfmt>
     de0:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     de3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     de6:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     de9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     dec:	c9                   	leave  
     ded:	c3                   	ret    

00000dee <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     dee:	55                   	push   %ebp
     def:	89 e5                	mov    %esp,%ebp
     df1:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     df4:	8d 45 14             	lea    0x14(%ebp),%eax
     df7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     dfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
     dfd:	50                   	push   %eax
     dfe:	ff 75 10             	pushl  0x10(%ebp)
     e01:	ff 75 0c             	pushl  0xc(%ebp)
     e04:	ff 75 08             	pushl  0x8(%ebp)
     e07:	e8 8c ff ff ff       	call   d98 <vsnprintf>
     e0c:	83 c4 10             	add    $0x10,%esp
     e0f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     e12:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e15:	c9                   	leave  
     e16:	c3                   	ret    
     e17:	66 90                	xchg   %ax,%ax
     e19:	66 90                	xchg   %ax,%ax
     e1b:	66 90                	xchg   %ax,%ax
     e1d:	66 90                	xchg   %ax,%ax
     e1f:	90                   	nop

00000e20 <__udivdi3>:
     e20:	55                   	push   %ebp
     e21:	57                   	push   %edi
     e22:	56                   	push   %esi
     e23:	53                   	push   %ebx
     e24:	83 ec 1c             	sub    $0x1c,%esp
     e27:	8b 54 24 3c          	mov    0x3c(%esp),%edx
     e2b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
     e2f:	8b 74 24 34          	mov    0x34(%esp),%esi
     e33:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     e37:	85 d2                	test   %edx,%edx
     e39:	75 35                	jne    e70 <__udivdi3+0x50>
     e3b:	39 f3                	cmp    %esi,%ebx
     e3d:	0f 87 bd 00 00 00    	ja     f00 <__udivdi3+0xe0>
     e43:	85 db                	test   %ebx,%ebx
     e45:	89 d9                	mov    %ebx,%ecx
     e47:	75 0b                	jne    e54 <__udivdi3+0x34>
     e49:	b8 01 00 00 00       	mov    $0x1,%eax
     e4e:	31 d2                	xor    %edx,%edx
     e50:	f7 f3                	div    %ebx
     e52:	89 c1                	mov    %eax,%ecx
     e54:	31 d2                	xor    %edx,%edx
     e56:	89 f0                	mov    %esi,%eax
     e58:	f7 f1                	div    %ecx
     e5a:	89 c6                	mov    %eax,%esi
     e5c:	89 e8                	mov    %ebp,%eax
     e5e:	89 f7                	mov    %esi,%edi
     e60:	f7 f1                	div    %ecx
     e62:	89 fa                	mov    %edi,%edx
     e64:	83 c4 1c             	add    $0x1c,%esp
     e67:	5b                   	pop    %ebx
     e68:	5e                   	pop    %esi
     e69:	5f                   	pop    %edi
     e6a:	5d                   	pop    %ebp
     e6b:	c3                   	ret    
     e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e70:	39 f2                	cmp    %esi,%edx
     e72:	77 7c                	ja     ef0 <__udivdi3+0xd0>
     e74:	0f bd fa             	bsr    %edx,%edi
     e77:	83 f7 1f             	xor    $0x1f,%edi
     e7a:	0f 84 98 00 00 00    	je     f18 <__udivdi3+0xf8>
     e80:	89 f9                	mov    %edi,%ecx
     e82:	b8 20 00 00 00       	mov    $0x20,%eax
     e87:	29 f8                	sub    %edi,%eax
     e89:	d3 e2                	shl    %cl,%edx
     e8b:	89 54 24 08          	mov    %edx,0x8(%esp)
     e8f:	89 c1                	mov    %eax,%ecx
     e91:	89 da                	mov    %ebx,%edx
     e93:	d3 ea                	shr    %cl,%edx
     e95:	8b 4c 24 08          	mov    0x8(%esp),%ecx
     e99:	09 d1                	or     %edx,%ecx
     e9b:	89 f2                	mov    %esi,%edx
     e9d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     ea1:	89 f9                	mov    %edi,%ecx
     ea3:	d3 e3                	shl    %cl,%ebx
     ea5:	89 c1                	mov    %eax,%ecx
     ea7:	d3 ea                	shr    %cl,%edx
     ea9:	89 f9                	mov    %edi,%ecx
     eab:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     eaf:	d3 e6                	shl    %cl,%esi
     eb1:	89 eb                	mov    %ebp,%ebx
     eb3:	89 c1                	mov    %eax,%ecx
     eb5:	d3 eb                	shr    %cl,%ebx
     eb7:	09 de                	or     %ebx,%esi
     eb9:	89 f0                	mov    %esi,%eax
     ebb:	f7 74 24 08          	divl   0x8(%esp)
     ebf:	89 d6                	mov    %edx,%esi
     ec1:	89 c3                	mov    %eax,%ebx
     ec3:	f7 64 24 0c          	mull   0xc(%esp)
     ec7:	39 d6                	cmp    %edx,%esi
     ec9:	72 0c                	jb     ed7 <__udivdi3+0xb7>
     ecb:	89 f9                	mov    %edi,%ecx
     ecd:	d3 e5                	shl    %cl,%ebp
     ecf:	39 c5                	cmp    %eax,%ebp
     ed1:	73 5d                	jae    f30 <__udivdi3+0x110>
     ed3:	39 d6                	cmp    %edx,%esi
     ed5:	75 59                	jne    f30 <__udivdi3+0x110>
     ed7:	8d 43 ff             	lea    -0x1(%ebx),%eax
     eda:	31 ff                	xor    %edi,%edi
     edc:	89 fa                	mov    %edi,%edx
     ede:	83 c4 1c             	add    $0x1c,%esp
     ee1:	5b                   	pop    %ebx
     ee2:	5e                   	pop    %esi
     ee3:	5f                   	pop    %edi
     ee4:	5d                   	pop    %ebp
     ee5:	c3                   	ret    
     ee6:	8d 76 00             	lea    0x0(%esi),%esi
     ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     ef0:	31 ff                	xor    %edi,%edi
     ef2:	31 c0                	xor    %eax,%eax
     ef4:	89 fa                	mov    %edi,%edx
     ef6:	83 c4 1c             	add    $0x1c,%esp
     ef9:	5b                   	pop    %ebx
     efa:	5e                   	pop    %esi
     efb:	5f                   	pop    %edi
     efc:	5d                   	pop    %ebp
     efd:	c3                   	ret    
     efe:	66 90                	xchg   %ax,%ax
     f00:	31 ff                	xor    %edi,%edi
     f02:	89 e8                	mov    %ebp,%eax
     f04:	89 f2                	mov    %esi,%edx
     f06:	f7 f3                	div    %ebx
     f08:	89 fa                	mov    %edi,%edx
     f0a:	83 c4 1c             	add    $0x1c,%esp
     f0d:	5b                   	pop    %ebx
     f0e:	5e                   	pop    %esi
     f0f:	5f                   	pop    %edi
     f10:	5d                   	pop    %ebp
     f11:	c3                   	ret    
     f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f18:	39 f2                	cmp    %esi,%edx
     f1a:	72 06                	jb     f22 <__udivdi3+0x102>
     f1c:	31 c0                	xor    %eax,%eax
     f1e:	39 eb                	cmp    %ebp,%ebx
     f20:	77 d2                	ja     ef4 <__udivdi3+0xd4>
     f22:	b8 01 00 00 00       	mov    $0x1,%eax
     f27:	eb cb                	jmp    ef4 <__udivdi3+0xd4>
     f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f30:	89 d8                	mov    %ebx,%eax
     f32:	31 ff                	xor    %edi,%edi
     f34:	eb be                	jmp    ef4 <__udivdi3+0xd4>
     f36:	66 90                	xchg   %ax,%ax
     f38:	66 90                	xchg   %ax,%ax
     f3a:	66 90                	xchg   %ax,%ax
     f3c:	66 90                	xchg   %ax,%ax
     f3e:	66 90                	xchg   %ax,%ax

00000f40 <__umoddi3>:
     f40:	55                   	push   %ebp
     f41:	57                   	push   %edi
     f42:	56                   	push   %esi
     f43:	53                   	push   %ebx
     f44:	83 ec 1c             	sub    $0x1c,%esp
     f47:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
     f4b:	8b 74 24 30          	mov    0x30(%esp),%esi
     f4f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
     f53:	8b 7c 24 38          	mov    0x38(%esp),%edi
     f57:	85 ed                	test   %ebp,%ebp
     f59:	89 f0                	mov    %esi,%eax
     f5b:	89 da                	mov    %ebx,%edx
     f5d:	75 19                	jne    f78 <__umoddi3+0x38>
     f5f:	39 df                	cmp    %ebx,%edi
     f61:	0f 86 b1 00 00 00    	jbe    1018 <__umoddi3+0xd8>
     f67:	f7 f7                	div    %edi
     f69:	89 d0                	mov    %edx,%eax
     f6b:	31 d2                	xor    %edx,%edx
     f6d:	83 c4 1c             	add    $0x1c,%esp
     f70:	5b                   	pop    %ebx
     f71:	5e                   	pop    %esi
     f72:	5f                   	pop    %edi
     f73:	5d                   	pop    %ebp
     f74:	c3                   	ret    
     f75:	8d 76 00             	lea    0x0(%esi),%esi
     f78:	39 dd                	cmp    %ebx,%ebp
     f7a:	77 f1                	ja     f6d <__umoddi3+0x2d>
     f7c:	0f bd cd             	bsr    %ebp,%ecx
     f7f:	83 f1 1f             	xor    $0x1f,%ecx
     f82:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     f86:	0f 84 b4 00 00 00    	je     1040 <__umoddi3+0x100>
     f8c:	b8 20 00 00 00       	mov    $0x20,%eax
     f91:	89 c2                	mov    %eax,%edx
     f93:	8b 44 24 04          	mov    0x4(%esp),%eax
     f97:	29 c2                	sub    %eax,%edx
     f99:	89 c1                	mov    %eax,%ecx
     f9b:	89 f8                	mov    %edi,%eax
     f9d:	d3 e5                	shl    %cl,%ebp
     f9f:	89 d1                	mov    %edx,%ecx
     fa1:	89 54 24 0c          	mov    %edx,0xc(%esp)
     fa5:	d3 e8                	shr    %cl,%eax
     fa7:	09 c5                	or     %eax,%ebp
     fa9:	8b 44 24 04          	mov    0x4(%esp),%eax
     fad:	89 c1                	mov    %eax,%ecx
     faf:	d3 e7                	shl    %cl,%edi
     fb1:	89 d1                	mov    %edx,%ecx
     fb3:	89 7c 24 08          	mov    %edi,0x8(%esp)
     fb7:	89 df                	mov    %ebx,%edi
     fb9:	d3 ef                	shr    %cl,%edi
     fbb:	89 c1                	mov    %eax,%ecx
     fbd:	89 f0                	mov    %esi,%eax
     fbf:	d3 e3                	shl    %cl,%ebx
     fc1:	89 d1                	mov    %edx,%ecx
     fc3:	89 fa                	mov    %edi,%edx
     fc5:	d3 e8                	shr    %cl,%eax
     fc7:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
     fcc:	09 d8                	or     %ebx,%eax
     fce:	f7 f5                	div    %ebp
     fd0:	d3 e6                	shl    %cl,%esi
     fd2:	89 d1                	mov    %edx,%ecx
     fd4:	f7 64 24 08          	mull   0x8(%esp)
     fd8:	39 d1                	cmp    %edx,%ecx
     fda:	89 c3                	mov    %eax,%ebx
     fdc:	89 d7                	mov    %edx,%edi
     fde:	72 06                	jb     fe6 <__umoddi3+0xa6>
     fe0:	75 0e                	jne    ff0 <__umoddi3+0xb0>
     fe2:	39 c6                	cmp    %eax,%esi
     fe4:	73 0a                	jae    ff0 <__umoddi3+0xb0>
     fe6:	2b 44 24 08          	sub    0x8(%esp),%eax
     fea:	19 ea                	sbb    %ebp,%edx
     fec:	89 d7                	mov    %edx,%edi
     fee:	89 c3                	mov    %eax,%ebx
     ff0:	89 ca                	mov    %ecx,%edx
     ff2:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
     ff7:	29 de                	sub    %ebx,%esi
     ff9:	19 fa                	sbb    %edi,%edx
     ffb:	8b 5c 24 04          	mov    0x4(%esp),%ebx
     fff:	89 d0                	mov    %edx,%eax
    1001:	d3 e0                	shl    %cl,%eax
    1003:	89 d9                	mov    %ebx,%ecx
    1005:	d3 ee                	shr    %cl,%esi
    1007:	d3 ea                	shr    %cl,%edx
    1009:	09 f0                	or     %esi,%eax
    100b:	83 c4 1c             	add    $0x1c,%esp
    100e:	5b                   	pop    %ebx
    100f:	5e                   	pop    %esi
    1010:	5f                   	pop    %edi
    1011:	5d                   	pop    %ebp
    1012:	c3                   	ret    
    1013:	90                   	nop
    1014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1018:	85 ff                	test   %edi,%edi
    101a:	89 f9                	mov    %edi,%ecx
    101c:	75 0b                	jne    1029 <__umoddi3+0xe9>
    101e:	b8 01 00 00 00       	mov    $0x1,%eax
    1023:	31 d2                	xor    %edx,%edx
    1025:	f7 f7                	div    %edi
    1027:	89 c1                	mov    %eax,%ecx
    1029:	89 d8                	mov    %ebx,%eax
    102b:	31 d2                	xor    %edx,%edx
    102d:	f7 f1                	div    %ecx
    102f:	89 f0                	mov    %esi,%eax
    1031:	f7 f1                	div    %ecx
    1033:	e9 31 ff ff ff       	jmp    f69 <__umoddi3+0x29>
    1038:	90                   	nop
    1039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1040:	39 dd                	cmp    %ebx,%ebp
    1042:	72 08                	jb     104c <__umoddi3+0x10c>
    1044:	39 f7                	cmp    %esi,%edi
    1046:	0f 87 21 ff ff ff    	ja     f6d <__umoddi3+0x2d>
    104c:	89 da                	mov    %ebx,%edx
    104e:	89 f0                	mov    %esi,%eax
    1050:	29 f8                	sub    %edi,%eax
    1052:	19 ea                	sbb    %ebp,%edx
    1054:	e9 14 ff ff ff       	jmp    f6d <__umoddi3+0x2d>
