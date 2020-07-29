
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
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
    printf(2, "usage: kill pid...\n");
      19:	83 ec 08             	sub    $0x8,%esp
      1c:	68 80 10 00 00       	push   $0x1080
      21:	6a 02                	push   $0x2
      23:	e8 64 04 00 00       	call   48c <printf>
      28:	83 c4 10             	add    $0x10,%esp
    exit();
      2b:	e8 c9 02 00 00       	call   2f9 <exit>
  }
  for(i=1; i<argc; i++)
      30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      37:	eb 2d                	jmp    66 <main+0x66>
    kill(atoi(argv[i]));
      39:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      43:	8b 43 04             	mov    0x4(%ebx),%eax
      46:	01 d0                	add    %edx,%eax
      48:	8b 00                	mov    (%eax),%eax
      4a:	83 ec 0c             	sub    $0xc,%esp
      4d:	50                   	push   %eax
      4e:	e8 14 02 00 00       	call   267 <atoi>
      53:	83 c4 10             	add    $0x10,%esp
      56:	83 ec 0c             	sub    $0xc,%esp
      59:	50                   	push   %eax
      5a:	e8 ca 02 00 00       	call   329 <kill>
      5f:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
      62:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      66:	8b 45 f4             	mov    -0xc(%ebp),%eax
      69:	3b 03                	cmp    (%ebx),%eax
      6b:	7c cc                	jl     39 <main+0x39>
  exit();
      6d:	e8 87 02 00 00       	call   2f9 <exit>

00000072 <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
      72:	55                   	push   %ebp
      73:	89 e5                	mov    %esp,%ebp
      75:	57                   	push   %edi
      76:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      77:	8b 4d 08             	mov    0x8(%ebp),%ecx
      7a:	8b 55 10             	mov    0x10(%ebp),%edx
      7d:	8b 45 0c             	mov    0xc(%ebp),%eax
      80:	89 cb                	mov    %ecx,%ebx
      82:	89 df                	mov    %ebx,%edi
      84:	89 d1                	mov    %edx,%ecx
      86:	fc                   	cld    
      87:	f3 aa                	rep stos %al,%es:(%edi)
      89:	89 ca                	mov    %ecx,%edx
      8b:	89 fb                	mov    %edi,%ebx
      8d:	89 5d 08             	mov    %ebx,0x8(%ebp)
      90:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      93:	90                   	nop
      94:	5b                   	pop    %ebx
      95:	5f                   	pop    %edi
      96:	5d                   	pop    %ebp
      97:	c3                   	ret    

00000098 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      98:	55                   	push   %ebp
      99:	89 e5                	mov    %esp,%ebp
      9b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      9e:	8b 45 08             	mov    0x8(%ebp),%eax
      a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      a4:	90                   	nop
      a5:	8b 55 0c             	mov    0xc(%ebp),%edx
      a8:	8d 42 01             	lea    0x1(%edx),%eax
      ab:	89 45 0c             	mov    %eax,0xc(%ebp)
      ae:	8b 45 08             	mov    0x8(%ebp),%eax
      b1:	8d 48 01             	lea    0x1(%eax),%ecx
      b4:	89 4d 08             	mov    %ecx,0x8(%ebp)
      b7:	0f b6 12             	movzbl (%edx),%edx
      ba:	88 10                	mov    %dl,(%eax)
      bc:	0f b6 00             	movzbl (%eax),%eax
      bf:	84 c0                	test   %al,%al
      c1:	75 e2                	jne    a5 <strcpy+0xd>
    ;
  return os;
      c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      c6:	c9                   	leave  
      c7:	c3                   	ret    

000000c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      c8:	55                   	push   %ebp
      c9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      cb:	eb 08                	jmp    d5 <strcmp+0xd>
    p++, q++;
      cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      d1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
      d5:	8b 45 08             	mov    0x8(%ebp),%eax
      d8:	0f b6 00             	movzbl (%eax),%eax
      db:	84 c0                	test   %al,%al
      dd:	74 10                	je     ef <strcmp+0x27>
      df:	8b 45 08             	mov    0x8(%ebp),%eax
      e2:	0f b6 10             	movzbl (%eax),%edx
      e5:	8b 45 0c             	mov    0xc(%ebp),%eax
      e8:	0f b6 00             	movzbl (%eax),%eax
      eb:	38 c2                	cmp    %al,%dl
      ed:	74 de                	je     cd <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
      ef:	8b 45 08             	mov    0x8(%ebp),%eax
      f2:	0f b6 00             	movzbl (%eax),%eax
      f5:	0f b6 d0             	movzbl %al,%edx
      f8:	8b 45 0c             	mov    0xc(%ebp),%eax
      fb:	0f b6 00             	movzbl (%eax),%eax
      fe:	0f b6 c0             	movzbl %al,%eax
     101:	29 c2                	sub    %eax,%edx
     103:	89 d0                	mov    %edx,%eax
}
     105:	5d                   	pop    %ebp
     106:	c3                   	ret    

00000107 <strlen>:

uint
strlen(char *s)
{
     107:	55                   	push   %ebp
     108:	89 e5                	mov    %esp,%ebp
     10a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     10d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     114:	eb 04                	jmp    11a <strlen+0x13>
     116:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     11a:	8b 55 fc             	mov    -0x4(%ebp),%edx
     11d:	8b 45 08             	mov    0x8(%ebp),%eax
     120:	01 d0                	add    %edx,%eax
     122:	0f b6 00             	movzbl (%eax),%eax
     125:	84 c0                	test   %al,%al
     127:	75 ed                	jne    116 <strlen+0xf>
    ;
  return n;
     129:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     12c:	c9                   	leave  
     12d:	c3                   	ret    

0000012e <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     12e:	55                   	push   %ebp
     12f:	89 e5                	mov    %esp,%ebp
     131:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     134:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     13b:	eb 0c                	jmp    149 <strnlen+0x1b>
     n++; 
     13d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     141:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     145:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     149:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     14d:	74 0a                	je     159 <strnlen+0x2b>
     14f:	8b 45 08             	mov    0x8(%ebp),%eax
     152:	0f b6 00             	movzbl (%eax),%eax
     155:	84 c0                	test   %al,%al
     157:	75 e4                	jne    13d <strnlen+0xf>
   return n; 
     159:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     15c:	c9                   	leave  
     15d:	c3                   	ret    

0000015e <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     15e:	55                   	push   %ebp
     15f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     161:	8b 45 10             	mov    0x10(%ebp),%eax
     164:	50                   	push   %eax
     165:	ff 75 0c             	pushl  0xc(%ebp)
     168:	ff 75 08             	pushl  0x8(%ebp)
     16b:	e8 02 ff ff ff       	call   72 <stosb>
     170:	83 c4 0c             	add    $0xc,%esp
  return dst;
     173:	8b 45 08             	mov    0x8(%ebp),%eax
}
     176:	c9                   	leave  
     177:	c3                   	ret    

00000178 <strchr>:

char*
strchr(const char *s, char c)
{
     178:	55                   	push   %ebp
     179:	89 e5                	mov    %esp,%ebp
     17b:	83 ec 04             	sub    $0x4,%esp
     17e:	8b 45 0c             	mov    0xc(%ebp),%eax
     181:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     184:	eb 14                	jmp    19a <strchr+0x22>
    if(*s == c)
     186:	8b 45 08             	mov    0x8(%ebp),%eax
     189:	0f b6 00             	movzbl (%eax),%eax
     18c:	38 45 fc             	cmp    %al,-0x4(%ebp)
     18f:	75 05                	jne    196 <strchr+0x1e>
      return (char*)s;
     191:	8b 45 08             	mov    0x8(%ebp),%eax
     194:	eb 13                	jmp    1a9 <strchr+0x31>
  for(; *s; s++)
     196:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     19a:	8b 45 08             	mov    0x8(%ebp),%eax
     19d:	0f b6 00             	movzbl (%eax),%eax
     1a0:	84 c0                	test   %al,%al
     1a2:	75 e2                	jne    186 <strchr+0xe>
  return 0;
     1a4:	b8 00 00 00 00       	mov    $0x0,%eax
}
     1a9:	c9                   	leave  
     1aa:	c3                   	ret    

000001ab <gets>:

char*
gets(char *buf, int max)
{
     1ab:	55                   	push   %ebp
     1ac:	89 e5                	mov    %esp,%ebp
     1ae:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1b1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     1b8:	eb 42                	jmp    1fc <gets+0x51>
    cc = read(0, &c, 1);
     1ba:	83 ec 04             	sub    $0x4,%esp
     1bd:	6a 01                	push   $0x1
     1bf:	8d 45 ef             	lea    -0x11(%ebp),%eax
     1c2:	50                   	push   %eax
     1c3:	6a 00                	push   $0x0
     1c5:	e8 47 01 00 00       	call   311 <read>
     1ca:	83 c4 10             	add    $0x10,%esp
     1cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1d4:	7e 33                	jle    209 <gets+0x5e>
      break;
    buf[i++] = c;
     1d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1d9:	8d 50 01             	lea    0x1(%eax),%edx
     1dc:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1df:	89 c2                	mov    %eax,%edx
     1e1:	8b 45 08             	mov    0x8(%ebp),%eax
     1e4:	01 c2                	add    %eax,%edx
     1e6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ea:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1ec:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1f0:	3c 0a                	cmp    $0xa,%al
     1f2:	74 16                	je     20a <gets+0x5f>
     1f4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1f8:	3c 0d                	cmp    $0xd,%al
     1fa:	74 0e                	je     20a <gets+0x5f>
  for(i=0; i+1 < max; ){
     1fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1ff:	83 c0 01             	add    $0x1,%eax
     202:	39 45 0c             	cmp    %eax,0xc(%ebp)
     205:	7f b3                	jg     1ba <gets+0xf>
     207:	eb 01                	jmp    20a <gets+0x5f>
      break;
     209:	90                   	nop
      break;
  }
  buf[i] = '\0';
     20a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     20d:	8b 45 08             	mov    0x8(%ebp),%eax
     210:	01 d0                	add    %edx,%eax
     212:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     215:	8b 45 08             	mov    0x8(%ebp),%eax
}
     218:	c9                   	leave  
     219:	c3                   	ret    

0000021a <stat>:

int
stat(char *n, struct stat *st)
{
     21a:	55                   	push   %ebp
     21b:	89 e5                	mov    %esp,%ebp
     21d:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     220:	83 ec 08             	sub    $0x8,%esp
     223:	6a 00                	push   $0x0
     225:	ff 75 08             	pushl  0x8(%ebp)
     228:	e8 0c 01 00 00       	call   339 <open>
     22d:	83 c4 10             	add    $0x10,%esp
     230:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     233:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     237:	79 07                	jns    240 <stat+0x26>
    return -1;
     239:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     23e:	eb 25                	jmp    265 <stat+0x4b>
  r = fstat(fd, st);
     240:	83 ec 08             	sub    $0x8,%esp
     243:	ff 75 0c             	pushl  0xc(%ebp)
     246:	ff 75 f4             	pushl  -0xc(%ebp)
     249:	e8 03 01 00 00       	call   351 <fstat>
     24e:	83 c4 10             	add    $0x10,%esp
     251:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     254:	83 ec 0c             	sub    $0xc,%esp
     257:	ff 75 f4             	pushl  -0xc(%ebp)
     25a:	e8 c2 00 00 00       	call   321 <close>
     25f:	83 c4 10             	add    $0x10,%esp
  return r;
     262:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     265:	c9                   	leave  
     266:	c3                   	ret    

00000267 <atoi>:

int
atoi(const char *s)
{
     267:	55                   	push   %ebp
     268:	89 e5                	mov    %esp,%ebp
     26a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     26d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     274:	eb 25                	jmp    29b <atoi+0x34>
    n = n*10 + *s++ - '0';
     276:	8b 55 fc             	mov    -0x4(%ebp),%edx
     279:	89 d0                	mov    %edx,%eax
     27b:	c1 e0 02             	shl    $0x2,%eax
     27e:	01 d0                	add    %edx,%eax
     280:	01 c0                	add    %eax,%eax
     282:	89 c1                	mov    %eax,%ecx
     284:	8b 45 08             	mov    0x8(%ebp),%eax
     287:	8d 50 01             	lea    0x1(%eax),%edx
     28a:	89 55 08             	mov    %edx,0x8(%ebp)
     28d:	0f b6 00             	movzbl (%eax),%eax
     290:	0f be c0             	movsbl %al,%eax
     293:	01 c8                	add    %ecx,%eax
     295:	83 e8 30             	sub    $0x30,%eax
     298:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     29b:	8b 45 08             	mov    0x8(%ebp),%eax
     29e:	0f b6 00             	movzbl (%eax),%eax
     2a1:	3c 2f                	cmp    $0x2f,%al
     2a3:	7e 0a                	jle    2af <atoi+0x48>
     2a5:	8b 45 08             	mov    0x8(%ebp),%eax
     2a8:	0f b6 00             	movzbl (%eax),%eax
     2ab:	3c 39                	cmp    $0x39,%al
     2ad:	7e c7                	jle    276 <atoi+0xf>
  return n;
     2af:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2b2:	c9                   	leave  
     2b3:	c3                   	ret    

000002b4 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     2b4:	55                   	push   %ebp
     2b5:	89 e5                	mov    %esp,%ebp
     2b7:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     2ba:	8b 45 08             	mov    0x8(%ebp),%eax
     2bd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     2c0:	8b 45 0c             	mov    0xc(%ebp),%eax
     2c3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     2c6:	eb 17                	jmp    2df <memmove+0x2b>
    *dst++ = *src++;
     2c8:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2cb:	8d 42 01             	lea    0x1(%edx),%eax
     2ce:	89 45 f8             	mov    %eax,-0x8(%ebp)
     2d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2d4:	8d 48 01             	lea    0x1(%eax),%ecx
     2d7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     2da:	0f b6 12             	movzbl (%edx),%edx
     2dd:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     2df:	8b 45 10             	mov    0x10(%ebp),%eax
     2e2:	8d 50 ff             	lea    -0x1(%eax),%edx
     2e5:	89 55 10             	mov    %edx,0x10(%ebp)
     2e8:	85 c0                	test   %eax,%eax
     2ea:	7f dc                	jg     2c8 <memmove+0x14>
  return vdst;
     2ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2ef:	c9                   	leave  
     2f0:	c3                   	ret    

000002f1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2f1:	b8 01 00 00 00       	mov    $0x1,%eax
     2f6:	cd 40                	int    $0x40
     2f8:	c3                   	ret    

000002f9 <exit>:
SYSCALL(exit)
     2f9:	b8 02 00 00 00       	mov    $0x2,%eax
     2fe:	cd 40                	int    $0x40
     300:	c3                   	ret    

00000301 <wait>:
SYSCALL(wait)
     301:	b8 03 00 00 00       	mov    $0x3,%eax
     306:	cd 40                	int    $0x40
     308:	c3                   	ret    

00000309 <pipe>:
SYSCALL(pipe)
     309:	b8 04 00 00 00       	mov    $0x4,%eax
     30e:	cd 40                	int    $0x40
     310:	c3                   	ret    

00000311 <read>:
SYSCALL(read)
     311:	b8 05 00 00 00       	mov    $0x5,%eax
     316:	cd 40                	int    $0x40
     318:	c3                   	ret    

00000319 <write>:
SYSCALL(write)
     319:	b8 10 00 00 00       	mov    $0x10,%eax
     31e:	cd 40                	int    $0x40
     320:	c3                   	ret    

00000321 <close>:
SYSCALL(close)
     321:	b8 15 00 00 00       	mov    $0x15,%eax
     326:	cd 40                	int    $0x40
     328:	c3                   	ret    

00000329 <kill>:
SYSCALL(kill)
     329:	b8 06 00 00 00       	mov    $0x6,%eax
     32e:	cd 40                	int    $0x40
     330:	c3                   	ret    

00000331 <exec>:
SYSCALL(exec)
     331:	b8 07 00 00 00       	mov    $0x7,%eax
     336:	cd 40                	int    $0x40
     338:	c3                   	ret    

00000339 <open>:
SYSCALL(open)
     339:	b8 0f 00 00 00       	mov    $0xf,%eax
     33e:	cd 40                	int    $0x40
     340:	c3                   	ret    

00000341 <mknod>:
SYSCALL(mknod)
     341:	b8 11 00 00 00       	mov    $0x11,%eax
     346:	cd 40                	int    $0x40
     348:	c3                   	ret    

00000349 <unlink>:
SYSCALL(unlink)
     349:	b8 12 00 00 00       	mov    $0x12,%eax
     34e:	cd 40                	int    $0x40
     350:	c3                   	ret    

00000351 <fstat>:
SYSCALL(fstat)
     351:	b8 08 00 00 00       	mov    $0x8,%eax
     356:	cd 40                	int    $0x40
     358:	c3                   	ret    

00000359 <link>:
SYSCALL(link)
     359:	b8 13 00 00 00       	mov    $0x13,%eax
     35e:	cd 40                	int    $0x40
     360:	c3                   	ret    

00000361 <mkdir>:
SYSCALL(mkdir)
     361:	b8 14 00 00 00       	mov    $0x14,%eax
     366:	cd 40                	int    $0x40
     368:	c3                   	ret    

00000369 <chdir>:
SYSCALL(chdir)
     369:	b8 09 00 00 00       	mov    $0x9,%eax
     36e:	cd 40                	int    $0x40
     370:	c3                   	ret    

00000371 <dup>:
SYSCALL(dup)
     371:	b8 0a 00 00 00       	mov    $0xa,%eax
     376:	cd 40                	int    $0x40
     378:	c3                   	ret    

00000379 <getpid>:
SYSCALL(getpid)
     379:	b8 0b 00 00 00       	mov    $0xb,%eax
     37e:	cd 40                	int    $0x40
     380:	c3                   	ret    

00000381 <sbrk>:
SYSCALL(sbrk)
     381:	b8 0c 00 00 00       	mov    $0xc,%eax
     386:	cd 40                	int    $0x40
     388:	c3                   	ret    

00000389 <sleep>:
SYSCALL(sleep)
     389:	b8 0d 00 00 00       	mov    $0xd,%eax
     38e:	cd 40                	int    $0x40
     390:	c3                   	ret    

00000391 <uptime>:
SYSCALL(uptime)
     391:	b8 0e 00 00 00       	mov    $0xe,%eax
     396:	cd 40                	int    $0x40
     398:	c3                   	ret    

00000399 <select>:
SYSCALL(select)
     399:	b8 16 00 00 00       	mov    $0x16,%eax
     39e:	cd 40                	int    $0x40
     3a0:	c3                   	ret    

000003a1 <arp>:
SYSCALL(arp)
     3a1:	b8 17 00 00 00       	mov    $0x17,%eax
     3a6:	cd 40                	int    $0x40
     3a8:	c3                   	ret    

000003a9 <arpserv>:
SYSCALL(arpserv)
     3a9:	b8 18 00 00 00       	mov    $0x18,%eax
     3ae:	cd 40                	int    $0x40
     3b0:	c3                   	ret    

000003b1 <arp_receive>:
SYSCALL(arp_receive)
     3b1:	b8 19 00 00 00       	mov    $0x19,%eax
     3b6:	cd 40                	int    $0x40
     3b8:	c3                   	ret    

000003b9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3b9:	55                   	push   %ebp
     3ba:	89 e5                	mov    %esp,%ebp
     3bc:	83 ec 18             	sub    $0x18,%esp
     3bf:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c2:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3c5:	83 ec 04             	sub    $0x4,%esp
     3c8:	6a 01                	push   $0x1
     3ca:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3cd:	50                   	push   %eax
     3ce:	ff 75 08             	pushl  0x8(%ebp)
     3d1:	e8 43 ff ff ff       	call   319 <write>
     3d6:	83 c4 10             	add    $0x10,%esp
}
     3d9:	90                   	nop
     3da:	c9                   	leave  
     3db:	c3                   	ret    

000003dc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3dc:	55                   	push   %ebp
     3dd:	89 e5                	mov    %esp,%ebp
     3df:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3e2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3e9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3ed:	74 17                	je     406 <printint+0x2a>
     3ef:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3f3:	79 11                	jns    406 <printint+0x2a>
    neg = 1;
     3f5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3fc:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ff:	f7 d8                	neg    %eax
     401:	89 45 ec             	mov    %eax,-0x14(%ebp)
     404:	eb 06                	jmp    40c <printint+0x30>
  } else {
    x = xx;
     406:	8b 45 0c             	mov    0xc(%ebp),%eax
     409:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     40c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     413:	8b 4d 10             	mov    0x10(%ebp),%ecx
     416:	8b 45 ec             	mov    -0x14(%ebp),%eax
     419:	ba 00 00 00 00       	mov    $0x0,%edx
     41e:	f7 f1                	div    %ecx
     420:	89 d1                	mov    %edx,%ecx
     422:	8b 45 f4             	mov    -0xc(%ebp),%eax
     425:	8d 50 01             	lea    0x1(%eax),%edx
     428:	89 55 f4             	mov    %edx,-0xc(%ebp)
     42b:	0f b6 91 30 17 00 00 	movzbl 0x1730(%ecx),%edx
     432:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     436:	8b 4d 10             	mov    0x10(%ebp),%ecx
     439:	8b 45 ec             	mov    -0x14(%ebp),%eax
     43c:	ba 00 00 00 00       	mov    $0x0,%edx
     441:	f7 f1                	div    %ecx
     443:	89 45 ec             	mov    %eax,-0x14(%ebp)
     446:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     44a:	75 c7                	jne    413 <printint+0x37>
  if(neg)
     44c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     450:	74 2d                	je     47f <printint+0xa3>
    buf[i++] = '-';
     452:	8b 45 f4             	mov    -0xc(%ebp),%eax
     455:	8d 50 01             	lea    0x1(%eax),%edx
     458:	89 55 f4             	mov    %edx,-0xc(%ebp)
     45b:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     460:	eb 1d                	jmp    47f <printint+0xa3>
    putc(fd, buf[i]);
     462:	8d 55 dc             	lea    -0x24(%ebp),%edx
     465:	8b 45 f4             	mov    -0xc(%ebp),%eax
     468:	01 d0                	add    %edx,%eax
     46a:	0f b6 00             	movzbl (%eax),%eax
     46d:	0f be c0             	movsbl %al,%eax
     470:	83 ec 08             	sub    $0x8,%esp
     473:	50                   	push   %eax
     474:	ff 75 08             	pushl  0x8(%ebp)
     477:	e8 3d ff ff ff       	call   3b9 <putc>
     47c:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     47f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     483:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     487:	79 d9                	jns    462 <printint+0x86>
}
     489:	90                   	nop
     48a:	c9                   	leave  
     48b:	c3                   	ret    

0000048c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     48c:	55                   	push   %ebp
     48d:	89 e5                	mov    %esp,%ebp
     48f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     492:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     499:	8d 45 0c             	lea    0xc(%ebp),%eax
     49c:	83 c0 04             	add    $0x4,%eax
     49f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4a2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4a9:	e9 59 01 00 00       	jmp    607 <printf+0x17b>
    c = fmt[i] & 0xff;
     4ae:	8b 55 0c             	mov    0xc(%ebp),%edx
     4b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4b4:	01 d0                	add    %edx,%eax
     4b6:	0f b6 00             	movzbl (%eax),%eax
     4b9:	0f be c0             	movsbl %al,%eax
     4bc:	25 ff 00 00 00       	and    $0xff,%eax
     4c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4c8:	75 2c                	jne    4f6 <printf+0x6a>
      if(c == '%'){
     4ca:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4ce:	75 0c                	jne    4dc <printf+0x50>
        state = '%';
     4d0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4d7:	e9 27 01 00 00       	jmp    603 <printf+0x177>
      } else {
        putc(fd, c);
     4dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4df:	0f be c0             	movsbl %al,%eax
     4e2:	83 ec 08             	sub    $0x8,%esp
     4e5:	50                   	push   %eax
     4e6:	ff 75 08             	pushl  0x8(%ebp)
     4e9:	e8 cb fe ff ff       	call   3b9 <putc>
     4ee:	83 c4 10             	add    $0x10,%esp
     4f1:	e9 0d 01 00 00       	jmp    603 <printf+0x177>
      }
    } else if(state == '%'){
     4f6:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4fa:	0f 85 03 01 00 00    	jne    603 <printf+0x177>
      if(c == 'd'){
     500:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     504:	75 1e                	jne    524 <printf+0x98>
        printint(fd, *ap, 10, 1);
     506:	8b 45 e8             	mov    -0x18(%ebp),%eax
     509:	8b 00                	mov    (%eax),%eax
     50b:	6a 01                	push   $0x1
     50d:	6a 0a                	push   $0xa
     50f:	50                   	push   %eax
     510:	ff 75 08             	pushl  0x8(%ebp)
     513:	e8 c4 fe ff ff       	call   3dc <printint>
     518:	83 c4 10             	add    $0x10,%esp
        ap++;
     51b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     51f:	e9 d8 00 00 00       	jmp    5fc <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     524:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     528:	74 06                	je     530 <printf+0xa4>
     52a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     52e:	75 1e                	jne    54e <printf+0xc2>
        printint(fd, *ap, 16, 0);
     530:	8b 45 e8             	mov    -0x18(%ebp),%eax
     533:	8b 00                	mov    (%eax),%eax
     535:	6a 00                	push   $0x0
     537:	6a 10                	push   $0x10
     539:	50                   	push   %eax
     53a:	ff 75 08             	pushl  0x8(%ebp)
     53d:	e8 9a fe ff ff       	call   3dc <printint>
     542:	83 c4 10             	add    $0x10,%esp
        ap++;
     545:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     549:	e9 ae 00 00 00       	jmp    5fc <printf+0x170>
      } else if(c == 's'){
     54e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     552:	75 43                	jne    597 <printf+0x10b>
        s = (char*)*ap;
     554:	8b 45 e8             	mov    -0x18(%ebp),%eax
     557:	8b 00                	mov    (%eax),%eax
     559:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     55c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     560:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     564:	75 25                	jne    58b <printf+0xff>
          s = "(null)";
     566:	c7 45 f4 94 10 00 00 	movl   $0x1094,-0xc(%ebp)
        while(*s != 0){
     56d:	eb 1c                	jmp    58b <printf+0xff>
          putc(fd, *s);
     56f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     572:	0f b6 00             	movzbl (%eax),%eax
     575:	0f be c0             	movsbl %al,%eax
     578:	83 ec 08             	sub    $0x8,%esp
     57b:	50                   	push   %eax
     57c:	ff 75 08             	pushl  0x8(%ebp)
     57f:	e8 35 fe ff ff       	call   3b9 <putc>
     584:	83 c4 10             	add    $0x10,%esp
          s++;
     587:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     58b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     58e:	0f b6 00             	movzbl (%eax),%eax
     591:	84 c0                	test   %al,%al
     593:	75 da                	jne    56f <printf+0xe3>
     595:	eb 65                	jmp    5fc <printf+0x170>
        }
      } else if(c == 'c'){
     597:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     59b:	75 1d                	jne    5ba <printf+0x12e>
        putc(fd, *ap);
     59d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a0:	8b 00                	mov    (%eax),%eax
     5a2:	0f be c0             	movsbl %al,%eax
     5a5:	83 ec 08             	sub    $0x8,%esp
     5a8:	50                   	push   %eax
     5a9:	ff 75 08             	pushl  0x8(%ebp)
     5ac:	e8 08 fe ff ff       	call   3b9 <putc>
     5b1:	83 c4 10             	add    $0x10,%esp
        ap++;
     5b4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5b8:	eb 42                	jmp    5fc <printf+0x170>
      } else if(c == '%'){
     5ba:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5be:	75 17                	jne    5d7 <printf+0x14b>
        putc(fd, c);
     5c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c3:	0f be c0             	movsbl %al,%eax
     5c6:	83 ec 08             	sub    $0x8,%esp
     5c9:	50                   	push   %eax
     5ca:	ff 75 08             	pushl  0x8(%ebp)
     5cd:	e8 e7 fd ff ff       	call   3b9 <putc>
     5d2:	83 c4 10             	add    $0x10,%esp
     5d5:	eb 25                	jmp    5fc <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5d7:	83 ec 08             	sub    $0x8,%esp
     5da:	6a 25                	push   $0x25
     5dc:	ff 75 08             	pushl  0x8(%ebp)
     5df:	e8 d5 fd ff ff       	call   3b9 <putc>
     5e4:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5ea:	0f be c0             	movsbl %al,%eax
     5ed:	83 ec 08             	sub    $0x8,%esp
     5f0:	50                   	push   %eax
     5f1:	ff 75 08             	pushl  0x8(%ebp)
     5f4:	e8 c0 fd ff ff       	call   3b9 <putc>
     5f9:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     603:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     607:	8b 55 0c             	mov    0xc(%ebp),%edx
     60a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     60d:	01 d0                	add    %edx,%eax
     60f:	0f b6 00             	movzbl (%eax),%eax
     612:	84 c0                	test   %al,%al
     614:	0f 85 94 fe ff ff    	jne    4ae <printf+0x22>
    }
  }
}
     61a:	90                   	nop
     61b:	c9                   	leave  
     61c:	c3                   	ret    

0000061d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     61d:	55                   	push   %ebp
     61e:	89 e5                	mov    %esp,%ebp
     620:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     623:	8b 45 08             	mov    0x8(%ebp),%eax
     626:	83 e8 08             	sub    $0x8,%eax
     629:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     62c:	a1 4c 17 00 00       	mov    0x174c,%eax
     631:	89 45 fc             	mov    %eax,-0x4(%ebp)
     634:	eb 24                	jmp    65a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     636:	8b 45 fc             	mov    -0x4(%ebp),%eax
     639:	8b 00                	mov    (%eax),%eax
     63b:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     63e:	72 12                	jb     652 <free+0x35>
     640:	8b 45 f8             	mov    -0x8(%ebp),%eax
     643:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     646:	77 24                	ja     66c <free+0x4f>
     648:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64b:	8b 00                	mov    (%eax),%eax
     64d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     650:	72 1a                	jb     66c <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     652:	8b 45 fc             	mov    -0x4(%ebp),%eax
     655:	8b 00                	mov    (%eax),%eax
     657:	89 45 fc             	mov    %eax,-0x4(%ebp)
     65a:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     660:	76 d4                	jbe    636 <free+0x19>
     662:	8b 45 fc             	mov    -0x4(%ebp),%eax
     665:	8b 00                	mov    (%eax),%eax
     667:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     66a:	73 ca                	jae    636 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     66c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     66f:	8b 40 04             	mov    0x4(%eax),%eax
     672:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     679:	8b 45 f8             	mov    -0x8(%ebp),%eax
     67c:	01 c2                	add    %eax,%edx
     67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     681:	8b 00                	mov    (%eax),%eax
     683:	39 c2                	cmp    %eax,%edx
     685:	75 24                	jne    6ab <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     687:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68a:	8b 50 04             	mov    0x4(%eax),%edx
     68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     690:	8b 00                	mov    (%eax),%eax
     692:	8b 40 04             	mov    0x4(%eax),%eax
     695:	01 c2                	add    %eax,%edx
     697:	8b 45 f8             	mov    -0x8(%ebp),%eax
     69a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a0:	8b 00                	mov    (%eax),%eax
     6a2:	8b 10                	mov    (%eax),%edx
     6a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a7:	89 10                	mov    %edx,(%eax)
     6a9:	eb 0a                	jmp    6b5 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ae:	8b 10                	mov    (%eax),%edx
     6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b8:	8b 40 04             	mov    0x4(%eax),%eax
     6bb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c5:	01 d0                	add    %edx,%eax
     6c7:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6ca:	75 20                	jne    6ec <free+0xcf>
    p->s.size += bp->s.size;
     6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cf:	8b 50 04             	mov    0x4(%eax),%edx
     6d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d5:	8b 40 04             	mov    0x4(%eax),%eax
     6d8:	01 c2                	add    %eax,%edx
     6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6dd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e3:	8b 10                	mov    (%eax),%edx
     6e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e8:	89 10                	mov    %edx,(%eax)
     6ea:	eb 08                	jmp    6f4 <free+0xd7>
  } else
    p->s.ptr = bp;
     6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ef:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6f2:	89 10                	mov    %edx,(%eax)
  freep = p;
     6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f7:	a3 4c 17 00 00       	mov    %eax,0x174c
}
     6fc:	90                   	nop
     6fd:	c9                   	leave  
     6fe:	c3                   	ret    

000006ff <morecore>:

static Header*
morecore(uint nu)
{
     6ff:	55                   	push   %ebp
     700:	89 e5                	mov    %esp,%ebp
     702:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     705:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     70c:	77 07                	ja     715 <morecore+0x16>
    nu = 4096;
     70e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     715:	8b 45 08             	mov    0x8(%ebp),%eax
     718:	c1 e0 03             	shl    $0x3,%eax
     71b:	83 ec 0c             	sub    $0xc,%esp
     71e:	50                   	push   %eax
     71f:	e8 5d fc ff ff       	call   381 <sbrk>
     724:	83 c4 10             	add    $0x10,%esp
     727:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     72a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     72e:	75 07                	jne    737 <morecore+0x38>
    return 0;
     730:	b8 00 00 00 00       	mov    $0x0,%eax
     735:	eb 26                	jmp    75d <morecore+0x5e>
  hp = (Header*)p;
     737:	8b 45 f4             	mov    -0xc(%ebp),%eax
     73a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     73d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     740:	8b 55 08             	mov    0x8(%ebp),%edx
     743:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     746:	8b 45 f0             	mov    -0x10(%ebp),%eax
     749:	83 c0 08             	add    $0x8,%eax
     74c:	83 ec 0c             	sub    $0xc,%esp
     74f:	50                   	push   %eax
     750:	e8 c8 fe ff ff       	call   61d <free>
     755:	83 c4 10             	add    $0x10,%esp
  return freep;
     758:	a1 4c 17 00 00       	mov    0x174c,%eax
}
     75d:	c9                   	leave  
     75e:	c3                   	ret    

0000075f <malloc>:

void*
malloc(uint nbytes)
{
     75f:	55                   	push   %ebp
     760:	89 e5                	mov    %esp,%ebp
     762:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     765:	8b 45 08             	mov    0x8(%ebp),%eax
     768:	83 c0 07             	add    $0x7,%eax
     76b:	c1 e8 03             	shr    $0x3,%eax
     76e:	83 c0 01             	add    $0x1,%eax
     771:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     774:	a1 4c 17 00 00       	mov    0x174c,%eax
     779:	89 45 f0             	mov    %eax,-0x10(%ebp)
     77c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     780:	75 23                	jne    7a5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     782:	c7 45 f0 44 17 00 00 	movl   $0x1744,-0x10(%ebp)
     789:	8b 45 f0             	mov    -0x10(%ebp),%eax
     78c:	a3 4c 17 00 00       	mov    %eax,0x174c
     791:	a1 4c 17 00 00       	mov    0x174c,%eax
     796:	a3 44 17 00 00       	mov    %eax,0x1744
    base.s.size = 0;
     79b:	c7 05 48 17 00 00 00 	movl   $0x0,0x1748
     7a2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a8:	8b 00                	mov    (%eax),%eax
     7aa:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b0:	8b 40 04             	mov    0x4(%eax),%eax
     7b3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7b6:	77 4d                	ja     805 <malloc+0xa6>
      if(p->s.size == nunits)
     7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7bb:	8b 40 04             	mov    0x4(%eax),%eax
     7be:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7c1:	75 0c                	jne    7cf <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c6:	8b 10                	mov    (%eax),%edx
     7c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7cb:	89 10                	mov    %edx,(%eax)
     7cd:	eb 26                	jmp    7f5 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d2:	8b 40 04             	mov    0x4(%eax),%eax
     7d5:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7d8:	89 c2                	mov    %eax,%edx
     7da:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7dd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e3:	8b 40 04             	mov    0x4(%eax),%eax
     7e6:	c1 e0 03             	shl    $0x3,%eax
     7e9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ef:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7f2:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7f8:	a3 4c 17 00 00       	mov    %eax,0x174c
      return (void*)(p + 1);
     7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     800:	83 c0 08             	add    $0x8,%eax
     803:	eb 3b                	jmp    840 <malloc+0xe1>
    }
    if(p == freep)
     805:	a1 4c 17 00 00       	mov    0x174c,%eax
     80a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     80d:	75 1e                	jne    82d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     80f:	83 ec 0c             	sub    $0xc,%esp
     812:	ff 75 ec             	pushl  -0x14(%ebp)
     815:	e8 e5 fe ff ff       	call   6ff <morecore>
     81a:	83 c4 10             	add    $0x10,%esp
     81d:	89 45 f4             	mov    %eax,-0xc(%ebp)
     820:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     824:	75 07                	jne    82d <malloc+0xce>
        return 0;
     826:	b8 00 00 00 00       	mov    $0x0,%eax
     82b:	eb 13                	jmp    840 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     82d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     830:	89 45 f0             	mov    %eax,-0x10(%ebp)
     833:	8b 45 f4             	mov    -0xc(%ebp),%eax
     836:	8b 00                	mov    (%eax),%eax
     838:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     83b:	e9 6d ff ff ff       	jmp    7ad <malloc+0x4e>
  }
}
     840:	c9                   	leave  
     841:	c3                   	ret    

00000842 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     842:	55                   	push   %ebp
     843:	89 e5                	mov    %esp,%ebp
     845:	53                   	push   %ebx
     846:	83 ec 14             	sub    $0x14,%esp
     849:	8b 45 10             	mov    0x10(%ebp),%eax
     84c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     84f:	8b 45 14             	mov    0x14(%ebp),%eax
     852:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     855:	8b 45 18             	mov    0x18(%ebp),%eax
     858:	ba 00 00 00 00       	mov    $0x0,%edx
     85d:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     860:	72 55                	jb     8b7 <printnum+0x75>
     862:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     865:	77 05                	ja     86c <printnum+0x2a>
     867:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     86a:	72 4b                	jb     8b7 <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     86c:	8b 45 1c             	mov    0x1c(%ebp),%eax
     86f:	8d 58 ff             	lea    -0x1(%eax),%ebx
     872:	8b 45 18             	mov    0x18(%ebp),%eax
     875:	ba 00 00 00 00       	mov    $0x0,%edx
     87a:	52                   	push   %edx
     87b:	50                   	push   %eax
     87c:	ff 75 f4             	pushl  -0xc(%ebp)
     87f:	ff 75 f0             	pushl  -0x10(%ebp)
     882:	e8 a9 05 00 00       	call   e30 <__udivdi3>
     887:	83 c4 10             	add    $0x10,%esp
     88a:	83 ec 04             	sub    $0x4,%esp
     88d:	ff 75 20             	pushl  0x20(%ebp)
     890:	53                   	push   %ebx
     891:	ff 75 18             	pushl  0x18(%ebp)
     894:	52                   	push   %edx
     895:	50                   	push   %eax
     896:	ff 75 0c             	pushl  0xc(%ebp)
     899:	ff 75 08             	pushl  0x8(%ebp)
     89c:	e8 a1 ff ff ff       	call   842 <printnum>
     8a1:	83 c4 20             	add    $0x20,%esp
     8a4:	eb 1b                	jmp    8c1 <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     8a6:	83 ec 08             	sub    $0x8,%esp
     8a9:	ff 75 0c             	pushl  0xc(%ebp)
     8ac:	ff 75 20             	pushl  0x20(%ebp)
     8af:	8b 45 08             	mov    0x8(%ebp),%eax
     8b2:	ff d0                	call   *%eax
     8b4:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     8b7:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     8bb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     8bf:	7f e5                	jg     8a6 <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     8c1:	8b 4d 18             	mov    0x18(%ebp),%ecx
     8c4:	bb 00 00 00 00       	mov    $0x0,%ebx
     8c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8cc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8cf:	53                   	push   %ebx
     8d0:	51                   	push   %ecx
     8d1:	52                   	push   %edx
     8d2:	50                   	push   %eax
     8d3:	e8 78 06 00 00       	call   f50 <__umoddi3>
     8d8:	83 c4 10             	add    $0x10,%esp
     8db:	05 60 11 00 00       	add    $0x1160,%eax
     8e0:	0f b6 00             	movzbl (%eax),%eax
     8e3:	0f be c0             	movsbl %al,%eax
     8e6:	83 ec 08             	sub    $0x8,%esp
     8e9:	ff 75 0c             	pushl  0xc(%ebp)
     8ec:	50                   	push   %eax
     8ed:	8b 45 08             	mov    0x8(%ebp),%eax
     8f0:	ff d0                	call   *%eax
     8f2:	83 c4 10             	add    $0x10,%esp
}
     8f5:	90                   	nop
     8f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8f9:	c9                   	leave  
     8fa:	c3                   	ret    

000008fb <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     8fb:	55                   	push   %ebp
     8fc:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     8fe:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     902:	7e 14                	jle    918 <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     904:	8b 45 08             	mov    0x8(%ebp),%eax
     907:	8b 00                	mov    (%eax),%eax
     909:	8d 48 08             	lea    0x8(%eax),%ecx
     90c:	8b 55 08             	mov    0x8(%ebp),%edx
     90f:	89 0a                	mov    %ecx,(%edx)
     911:	8b 50 04             	mov    0x4(%eax),%edx
     914:	8b 00                	mov    (%eax),%eax
     916:	eb 30                	jmp    948 <getuint+0x4d>
  else if (lflag)
     918:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     91c:	74 16                	je     934 <getuint+0x39>
    return va_arg(*ap, unsigned long);
     91e:	8b 45 08             	mov    0x8(%ebp),%eax
     921:	8b 00                	mov    (%eax),%eax
     923:	8d 48 04             	lea    0x4(%eax),%ecx
     926:	8b 55 08             	mov    0x8(%ebp),%edx
     929:	89 0a                	mov    %ecx,(%edx)
     92b:	8b 00                	mov    (%eax),%eax
     92d:	ba 00 00 00 00       	mov    $0x0,%edx
     932:	eb 14                	jmp    948 <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     934:	8b 45 08             	mov    0x8(%ebp),%eax
     937:	8b 00                	mov    (%eax),%eax
     939:	8d 48 04             	lea    0x4(%eax),%ecx
     93c:	8b 55 08             	mov    0x8(%ebp),%edx
     93f:	89 0a                	mov    %ecx,(%edx)
     941:	8b 00                	mov    (%eax),%eax
     943:	ba 00 00 00 00       	mov    $0x0,%edx
}
     948:	5d                   	pop    %ebp
     949:	c3                   	ret    

0000094a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     94a:	55                   	push   %ebp
     94b:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     94d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     951:	7e 14                	jle    967 <getint+0x1d>
    return va_arg(*ap, long long);
     953:	8b 45 08             	mov    0x8(%ebp),%eax
     956:	8b 00                	mov    (%eax),%eax
     958:	8d 48 08             	lea    0x8(%eax),%ecx
     95b:	8b 55 08             	mov    0x8(%ebp),%edx
     95e:	89 0a                	mov    %ecx,(%edx)
     960:	8b 50 04             	mov    0x4(%eax),%edx
     963:	8b 00                	mov    (%eax),%eax
     965:	eb 28                	jmp    98f <getint+0x45>
  else if (lflag)
     967:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     96b:	74 12                	je     97f <getint+0x35>
    return va_arg(*ap, long);
     96d:	8b 45 08             	mov    0x8(%ebp),%eax
     970:	8b 00                	mov    (%eax),%eax
     972:	8d 48 04             	lea    0x4(%eax),%ecx
     975:	8b 55 08             	mov    0x8(%ebp),%edx
     978:	89 0a                	mov    %ecx,(%edx)
     97a:	8b 00                	mov    (%eax),%eax
     97c:	99                   	cltd   
     97d:	eb 10                	jmp    98f <getint+0x45>
  else
    return va_arg(*ap, int);
     97f:	8b 45 08             	mov    0x8(%ebp),%eax
     982:	8b 00                	mov    (%eax),%eax
     984:	8d 48 04             	lea    0x4(%eax),%ecx
     987:	8b 55 08             	mov    0x8(%ebp),%edx
     98a:	89 0a                	mov    %ecx,(%edx)
     98c:	8b 00                	mov    (%eax),%eax
     98e:	99                   	cltd   
}
     98f:	5d                   	pop    %ebp
     990:	c3                   	ret    

00000991 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     991:	55                   	push   %ebp
     992:	89 e5                	mov    %esp,%ebp
     994:	56                   	push   %esi
     995:	53                   	push   %ebx
     996:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     999:	eb 17                	jmp    9b2 <vprintfmt+0x21>
      if (ch == '\0')
     99b:	85 db                	test   %ebx,%ebx
     99d:	0f 84 a0 03 00 00    	je     d43 <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     9a3:	83 ec 08             	sub    $0x8,%esp
     9a6:	ff 75 0c             	pushl  0xc(%ebp)
     9a9:	53                   	push   %ebx
     9aa:	8b 45 08             	mov    0x8(%ebp),%eax
     9ad:	ff d0                	call   *%eax
     9af:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     9b2:	8b 45 10             	mov    0x10(%ebp),%eax
     9b5:	8d 50 01             	lea    0x1(%eax),%edx
     9b8:	89 55 10             	mov    %edx,0x10(%ebp)
     9bb:	0f b6 00             	movzbl (%eax),%eax
     9be:	0f b6 d8             	movzbl %al,%ebx
     9c1:	83 fb 25             	cmp    $0x25,%ebx
     9c4:	75 d5                	jne    99b <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     9c6:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     9ca:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     9d1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     9d8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     9df:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     9e6:	8b 45 10             	mov    0x10(%ebp),%eax
     9e9:	8d 50 01             	lea    0x1(%eax),%edx
     9ec:	89 55 10             	mov    %edx,0x10(%ebp)
     9ef:	0f b6 00             	movzbl (%eax),%eax
     9f2:	0f b6 d8             	movzbl %al,%ebx
     9f5:	8d 43 dd             	lea    -0x23(%ebx),%eax
     9f8:	83 f8 55             	cmp    $0x55,%eax
     9fb:	0f 87 15 03 00 00    	ja     d16 <vprintfmt+0x385>
     a01:	8b 04 85 84 11 00 00 	mov    0x1184(,%eax,4),%eax
     a08:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     a0a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     a0e:	eb d6                	jmp    9e6 <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     a10:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     a14:	eb d0                	jmp    9e6 <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     a16:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     a1d:	8b 55 e0             	mov    -0x20(%ebp),%edx
     a20:	89 d0                	mov    %edx,%eax
     a22:	c1 e0 02             	shl    $0x2,%eax
     a25:	01 d0                	add    %edx,%eax
     a27:	01 c0                	add    %eax,%eax
     a29:	01 d8                	add    %ebx,%eax
     a2b:	83 e8 30             	sub    $0x30,%eax
     a2e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     a31:	8b 45 10             	mov    0x10(%ebp),%eax
     a34:	0f b6 00             	movzbl (%eax),%eax
     a37:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     a3a:	83 fb 2f             	cmp    $0x2f,%ebx
     a3d:	7e 39                	jle    a78 <vprintfmt+0xe7>
     a3f:	83 fb 39             	cmp    $0x39,%ebx
     a42:	7f 34                	jg     a78 <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     a44:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     a48:	eb d3                	jmp    a1d <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     a4a:	8b 45 14             	mov    0x14(%ebp),%eax
     a4d:	8d 50 04             	lea    0x4(%eax),%edx
     a50:	89 55 14             	mov    %edx,0x14(%ebp)
     a53:	8b 00                	mov    (%eax),%eax
     a55:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     a58:	eb 1f                	jmp    a79 <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     a5a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a5e:	79 86                	jns    9e6 <vprintfmt+0x55>
        width = 0;
     a60:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     a67:	e9 7a ff ff ff       	jmp    9e6 <vprintfmt+0x55>

    case '#':
      altflag = 1;
     a6c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     a73:	e9 6e ff ff ff       	jmp    9e6 <vprintfmt+0x55>
      goto process_precision;
     a78:	90                   	nop

process_precision:
      if (width < 0)
     a79:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a7d:	0f 89 63 ff ff ff    	jns    9e6 <vprintfmt+0x55>
        width = precision, precision = -1;
     a83:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a86:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a89:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     a90:	e9 51 ff ff ff       	jmp    9e6 <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     a95:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     a99:	e9 48 ff ff ff       	jmp    9e6 <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     a9e:	8b 45 14             	mov    0x14(%ebp),%eax
     aa1:	8d 50 04             	lea    0x4(%eax),%edx
     aa4:	89 55 14             	mov    %edx,0x14(%ebp)
     aa7:	8b 00                	mov    (%eax),%eax
     aa9:	83 ec 08             	sub    $0x8,%esp
     aac:	ff 75 0c             	pushl  0xc(%ebp)
     aaf:	50                   	push   %eax
     ab0:	8b 45 08             	mov    0x8(%ebp),%eax
     ab3:	ff d0                	call   *%eax
     ab5:	83 c4 10             	add    $0x10,%esp
      break;
     ab8:	e9 81 02 00 00       	jmp    d3e <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     abd:	8b 45 14             	mov    0x14(%ebp),%eax
     ac0:	8d 50 04             	lea    0x4(%eax),%edx
     ac3:	89 55 14             	mov    %edx,0x14(%ebp)
     ac6:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     ac8:	85 db                	test   %ebx,%ebx
     aca:	79 02                	jns    ace <vprintfmt+0x13d>
        err = -err;
     acc:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     ace:	83 fb 0f             	cmp    $0xf,%ebx
     ad1:	7f 0b                	jg     ade <vprintfmt+0x14d>
     ad3:	8b 34 9d 20 11 00 00 	mov    0x1120(,%ebx,4),%esi
     ada:	85 f6                	test   %esi,%esi
     adc:	75 19                	jne    af7 <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     ade:	53                   	push   %ebx
     adf:	68 71 11 00 00       	push   $0x1171
     ae4:	ff 75 0c             	pushl  0xc(%ebp)
     ae7:	ff 75 08             	pushl  0x8(%ebp)
     aea:	e8 5c 02 00 00       	call   d4b <printfmt>
     aef:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     af2:	e9 47 02 00 00       	jmp    d3e <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     af7:	56                   	push   %esi
     af8:	68 7a 11 00 00       	push   $0x117a
     afd:	ff 75 0c             	pushl  0xc(%ebp)
     b00:	ff 75 08             	pushl  0x8(%ebp)
     b03:	e8 43 02 00 00       	call   d4b <printfmt>
     b08:	83 c4 10             	add    $0x10,%esp
      break;
     b0b:	e9 2e 02 00 00       	jmp    d3e <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     b10:	8b 45 14             	mov    0x14(%ebp),%eax
     b13:	8d 50 04             	lea    0x4(%eax),%edx
     b16:	89 55 14             	mov    %edx,0x14(%ebp)
     b19:	8b 30                	mov    (%eax),%esi
     b1b:	85 f6                	test   %esi,%esi
     b1d:	75 05                	jne    b24 <vprintfmt+0x193>
        p = "(null)";
     b1f:	be 7d 11 00 00       	mov    $0x117d,%esi
      if (width > 0 && padc != '-')
     b24:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b28:	7e 6f                	jle    b99 <vprintfmt+0x208>
     b2a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     b2e:	74 69                	je     b99 <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     b30:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b33:	83 ec 08             	sub    $0x8,%esp
     b36:	50                   	push   %eax
     b37:	56                   	push   %esi
     b38:	e8 f1 f5 ff ff       	call   12e <strnlen>
     b3d:	83 c4 10             	add    $0x10,%esp
     b40:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     b43:	eb 17                	jmp    b5c <vprintfmt+0x1cb>
          putch(padc, putdat);
     b45:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     b49:	83 ec 08             	sub    $0x8,%esp
     b4c:	ff 75 0c             	pushl  0xc(%ebp)
     b4f:	50                   	push   %eax
     b50:	8b 45 08             	mov    0x8(%ebp),%eax
     b53:	ff d0                	call   *%eax
     b55:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     b58:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b5c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b60:	7f e3                	jg     b45 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b62:	eb 35                	jmp    b99 <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     b64:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     b68:	74 1c                	je     b86 <vprintfmt+0x1f5>
     b6a:	83 fb 1f             	cmp    $0x1f,%ebx
     b6d:	7e 05                	jle    b74 <vprintfmt+0x1e3>
     b6f:	83 fb 7e             	cmp    $0x7e,%ebx
     b72:	7e 12                	jle    b86 <vprintfmt+0x1f5>
          putch('?', putdat);
     b74:	83 ec 08             	sub    $0x8,%esp
     b77:	ff 75 0c             	pushl  0xc(%ebp)
     b7a:	6a 3f                	push   $0x3f
     b7c:	8b 45 08             	mov    0x8(%ebp),%eax
     b7f:	ff d0                	call   *%eax
     b81:	83 c4 10             	add    $0x10,%esp
     b84:	eb 0f                	jmp    b95 <vprintfmt+0x204>
        else
          putch(ch, putdat);
     b86:	83 ec 08             	sub    $0x8,%esp
     b89:	ff 75 0c             	pushl  0xc(%ebp)
     b8c:	53                   	push   %ebx
     b8d:	8b 45 08             	mov    0x8(%ebp),%eax
     b90:	ff d0                	call   *%eax
     b92:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b95:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b99:	89 f0                	mov    %esi,%eax
     b9b:	8d 70 01             	lea    0x1(%eax),%esi
     b9e:	0f b6 00             	movzbl (%eax),%eax
     ba1:	0f be d8             	movsbl %al,%ebx
     ba4:	85 db                	test   %ebx,%ebx
     ba6:	74 26                	je     bce <vprintfmt+0x23d>
     ba8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     bac:	78 b6                	js     b64 <vprintfmt+0x1d3>
     bae:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     bb2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     bb6:	79 ac                	jns    b64 <vprintfmt+0x1d3>
      for (; width > 0; width--)
     bb8:	eb 14                	jmp    bce <vprintfmt+0x23d>
        putch(' ', putdat);
     bba:	83 ec 08             	sub    $0x8,%esp
     bbd:	ff 75 0c             	pushl  0xc(%ebp)
     bc0:	6a 20                	push   $0x20
     bc2:	8b 45 08             	mov    0x8(%ebp),%eax
     bc5:	ff d0                	call   *%eax
     bc7:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     bca:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     bce:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bd2:	7f e6                	jg     bba <vprintfmt+0x229>
      break;
     bd4:	e9 65 01 00 00       	jmp    d3e <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     bd9:	83 ec 08             	sub    $0x8,%esp
     bdc:	ff 75 e8             	pushl  -0x18(%ebp)
     bdf:	8d 45 14             	lea    0x14(%ebp),%eax
     be2:	50                   	push   %eax
     be3:	e8 62 fd ff ff       	call   94a <getint>
     be8:	83 c4 10             	add    $0x10,%esp
     beb:	89 45 f0             	mov    %eax,-0x10(%ebp)
     bee:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     bf1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bf4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bf7:	85 d2                	test   %edx,%edx
     bf9:	79 23                	jns    c1e <vprintfmt+0x28d>
        putch('-', putdat);
     bfb:	83 ec 08             	sub    $0x8,%esp
     bfe:	ff 75 0c             	pushl  0xc(%ebp)
     c01:	6a 2d                	push   $0x2d
     c03:	8b 45 08             	mov    0x8(%ebp),%eax
     c06:	ff d0                	call   *%eax
     c08:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     c0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c0e:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c11:	f7 d8                	neg    %eax
     c13:	83 d2 00             	adc    $0x0,%edx
     c16:	f7 da                	neg    %edx
     c18:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c1b:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     c1e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c25:	e9 b6 00 00 00       	jmp    ce0 <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     c2a:	83 ec 08             	sub    $0x8,%esp
     c2d:	ff 75 e8             	pushl  -0x18(%ebp)
     c30:	8d 45 14             	lea    0x14(%ebp),%eax
     c33:	50                   	push   %eax
     c34:	e8 c2 fc ff ff       	call   8fb <getuint>
     c39:	83 c4 10             	add    $0x10,%esp
     c3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c3f:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     c42:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c49:	e9 92 00 00 00       	jmp    ce0 <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     c4e:	83 ec 08             	sub    $0x8,%esp
     c51:	ff 75 0c             	pushl  0xc(%ebp)
     c54:	6a 58                	push   $0x58
     c56:	8b 45 08             	mov    0x8(%ebp),%eax
     c59:	ff d0                	call   *%eax
     c5b:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c5e:	83 ec 08             	sub    $0x8,%esp
     c61:	ff 75 0c             	pushl  0xc(%ebp)
     c64:	6a 58                	push   $0x58
     c66:	8b 45 08             	mov    0x8(%ebp),%eax
     c69:	ff d0                	call   *%eax
     c6b:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c6e:	83 ec 08             	sub    $0x8,%esp
     c71:	ff 75 0c             	pushl  0xc(%ebp)
     c74:	6a 58                	push   $0x58
     c76:	8b 45 08             	mov    0x8(%ebp),%eax
     c79:	ff d0                	call   *%eax
     c7b:	83 c4 10             	add    $0x10,%esp
      break;
     c7e:	e9 bb 00 00 00       	jmp    d3e <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     c83:	83 ec 08             	sub    $0x8,%esp
     c86:	ff 75 0c             	pushl  0xc(%ebp)
     c89:	6a 30                	push   $0x30
     c8b:	8b 45 08             	mov    0x8(%ebp),%eax
     c8e:	ff d0                	call   *%eax
     c90:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     c93:	83 ec 08             	sub    $0x8,%esp
     c96:	ff 75 0c             	pushl  0xc(%ebp)
     c99:	6a 78                	push   $0x78
     c9b:	8b 45 08             	mov    0x8(%ebp),%eax
     c9e:	ff d0                	call   *%eax
     ca0:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     ca3:	8b 45 14             	mov    0x14(%ebp),%eax
     ca6:	8d 50 04             	lea    0x4(%eax),%edx
     ca9:	89 55 14             	mov    %edx,0x14(%ebp)
     cac:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     cae:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cb1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     cb8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     cbf:	eb 1f                	jmp    ce0 <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     cc1:	83 ec 08             	sub    $0x8,%esp
     cc4:	ff 75 e8             	pushl  -0x18(%ebp)
     cc7:	8d 45 14             	lea    0x14(%ebp),%eax
     cca:	50                   	push   %eax
     ccb:	e8 2b fc ff ff       	call   8fb <getuint>
     cd0:	83 c4 10             	add    $0x10,%esp
     cd3:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cd6:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     cd9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     ce0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     ce4:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ce7:	83 ec 04             	sub    $0x4,%esp
     cea:	52                   	push   %edx
     ceb:	ff 75 e4             	pushl  -0x1c(%ebp)
     cee:	50                   	push   %eax
     cef:	ff 75 f4             	pushl  -0xc(%ebp)
     cf2:	ff 75 f0             	pushl  -0x10(%ebp)
     cf5:	ff 75 0c             	pushl  0xc(%ebp)
     cf8:	ff 75 08             	pushl  0x8(%ebp)
     cfb:	e8 42 fb ff ff       	call   842 <printnum>
     d00:	83 c4 20             	add    $0x20,%esp
      break;
     d03:	eb 39                	jmp    d3e <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     d05:	83 ec 08             	sub    $0x8,%esp
     d08:	ff 75 0c             	pushl  0xc(%ebp)
     d0b:	53                   	push   %ebx
     d0c:	8b 45 08             	mov    0x8(%ebp),%eax
     d0f:	ff d0                	call   *%eax
     d11:	83 c4 10             	add    $0x10,%esp
      break;
     d14:	eb 28                	jmp    d3e <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     d16:	83 ec 08             	sub    $0x8,%esp
     d19:	ff 75 0c             	pushl  0xc(%ebp)
     d1c:	6a 25                	push   $0x25
     d1e:	8b 45 08             	mov    0x8(%ebp),%eax
     d21:	ff d0                	call   *%eax
     d23:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     d26:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d2a:	eb 04                	jmp    d30 <vprintfmt+0x39f>
     d2c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d30:	8b 45 10             	mov    0x10(%ebp),%eax
     d33:	83 e8 01             	sub    $0x1,%eax
     d36:	0f b6 00             	movzbl (%eax),%eax
     d39:	3c 25                	cmp    $0x25,%al
     d3b:	75 ef                	jne    d2c <vprintfmt+0x39b>
        /* do nothing */;
      break;
     d3d:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     d3e:	e9 6f fc ff ff       	jmp    9b2 <vprintfmt+0x21>
        return;
     d43:	90                   	nop
    }
  }
}
     d44:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d47:	5b                   	pop    %ebx
     d48:	5e                   	pop    %esi
     d49:	5d                   	pop    %ebp
     d4a:	c3                   	ret    

00000d4b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     d4b:	55                   	push   %ebp
     d4c:	89 e5                	mov    %esp,%ebp
     d4e:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     d51:	8d 45 14             	lea    0x14(%ebp),%eax
     d54:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     d57:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5a:	50                   	push   %eax
     d5b:	ff 75 10             	pushl  0x10(%ebp)
     d5e:	ff 75 0c             	pushl  0xc(%ebp)
     d61:	ff 75 08             	pushl  0x8(%ebp)
     d64:	e8 28 fc ff ff       	call   991 <vprintfmt>
     d69:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     d6c:	90                   	nop
     d6d:	c9                   	leave  
     d6e:	c3                   	ret    

00000d6f <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     d6f:	55                   	push   %ebp
     d70:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     d72:	8b 45 0c             	mov    0xc(%ebp),%eax
     d75:	8b 40 08             	mov    0x8(%eax),%eax
     d78:	8d 50 01             	lea    0x1(%eax),%edx
     d7b:	8b 45 0c             	mov    0xc(%ebp),%eax
     d7e:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     d81:	8b 45 0c             	mov    0xc(%ebp),%eax
     d84:	8b 10                	mov    (%eax),%edx
     d86:	8b 45 0c             	mov    0xc(%ebp),%eax
     d89:	8b 40 04             	mov    0x4(%eax),%eax
     d8c:	39 c2                	cmp    %eax,%edx
     d8e:	73 12                	jae    da2 <sprintputch+0x33>
    *b->buf++ = ch;
     d90:	8b 45 0c             	mov    0xc(%ebp),%eax
     d93:	8b 00                	mov    (%eax),%eax
     d95:	8d 48 01             	lea    0x1(%eax),%ecx
     d98:	8b 55 0c             	mov    0xc(%ebp),%edx
     d9b:	89 0a                	mov    %ecx,(%edx)
     d9d:	8b 55 08             	mov    0x8(%ebp),%edx
     da0:	88 10                	mov    %dl,(%eax)
}
     da2:	90                   	nop
     da3:	5d                   	pop    %ebp
     da4:	c3                   	ret    

00000da5 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     da5:	55                   	push   %ebp
     da6:	89 e5                	mov    %esp,%ebp
     da8:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     dab:	8b 45 08             	mov    0x8(%ebp),%eax
     dae:	89 45 ec             	mov    %eax,-0x14(%ebp)
     db1:	8b 45 0c             	mov    0xc(%ebp),%eax
     db4:	8d 50 ff             	lea    -0x1(%eax),%edx
     db7:	8b 45 08             	mov    0x8(%ebp),%eax
     dba:	01 d0                	add    %edx,%eax
     dbc:	89 45 f0             	mov    %eax,-0x10(%ebp)
     dbf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     dc6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     dca:	74 06                	je     dd2 <vsnprintf+0x2d>
     dcc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dd0:	7f 07                	jg     dd9 <vsnprintf+0x34>
    return -E_INVAL;
     dd2:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     dd7:	eb 20                	jmp    df9 <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     dd9:	ff 75 14             	pushl  0x14(%ebp)
     ddc:	ff 75 10             	pushl  0x10(%ebp)
     ddf:	8d 45 ec             	lea    -0x14(%ebp),%eax
     de2:	50                   	push   %eax
     de3:	68 6f 0d 00 00       	push   $0xd6f
     de8:	e8 a4 fb ff ff       	call   991 <vprintfmt>
     ded:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     df0:	8b 45 ec             	mov    -0x14(%ebp),%eax
     df3:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     df6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     df9:	c9                   	leave  
     dfa:	c3                   	ret    

00000dfb <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     dfb:	55                   	push   %ebp
     dfc:	89 e5                	mov    %esp,%ebp
     dfe:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     e01:	8d 45 14             	lea    0x14(%ebp),%eax
     e04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     e07:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e0a:	50                   	push   %eax
     e0b:	ff 75 10             	pushl  0x10(%ebp)
     e0e:	ff 75 0c             	pushl  0xc(%ebp)
     e11:	ff 75 08             	pushl  0x8(%ebp)
     e14:	e8 8c ff ff ff       	call   da5 <vsnprintf>
     e19:	83 c4 10             	add    $0x10,%esp
     e1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     e1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e22:	c9                   	leave  
     e23:	c3                   	ret    
     e24:	66 90                	xchg   %ax,%ax
     e26:	66 90                	xchg   %ax,%ax
     e28:	66 90                	xchg   %ax,%ax
     e2a:	66 90                	xchg   %ax,%ax
     e2c:	66 90                	xchg   %ax,%ax
     e2e:	66 90                	xchg   %ax,%ax

00000e30 <__udivdi3>:
     e30:	55                   	push   %ebp
     e31:	57                   	push   %edi
     e32:	56                   	push   %esi
     e33:	53                   	push   %ebx
     e34:	83 ec 1c             	sub    $0x1c,%esp
     e37:	8b 54 24 3c          	mov    0x3c(%esp),%edx
     e3b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
     e3f:	8b 74 24 34          	mov    0x34(%esp),%esi
     e43:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     e47:	85 d2                	test   %edx,%edx
     e49:	75 35                	jne    e80 <__udivdi3+0x50>
     e4b:	39 f3                	cmp    %esi,%ebx
     e4d:	0f 87 bd 00 00 00    	ja     f10 <__udivdi3+0xe0>
     e53:	85 db                	test   %ebx,%ebx
     e55:	89 d9                	mov    %ebx,%ecx
     e57:	75 0b                	jne    e64 <__udivdi3+0x34>
     e59:	b8 01 00 00 00       	mov    $0x1,%eax
     e5e:	31 d2                	xor    %edx,%edx
     e60:	f7 f3                	div    %ebx
     e62:	89 c1                	mov    %eax,%ecx
     e64:	31 d2                	xor    %edx,%edx
     e66:	89 f0                	mov    %esi,%eax
     e68:	f7 f1                	div    %ecx
     e6a:	89 c6                	mov    %eax,%esi
     e6c:	89 e8                	mov    %ebp,%eax
     e6e:	89 f7                	mov    %esi,%edi
     e70:	f7 f1                	div    %ecx
     e72:	89 fa                	mov    %edi,%edx
     e74:	83 c4 1c             	add    $0x1c,%esp
     e77:	5b                   	pop    %ebx
     e78:	5e                   	pop    %esi
     e79:	5f                   	pop    %edi
     e7a:	5d                   	pop    %ebp
     e7b:	c3                   	ret    
     e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e80:	39 f2                	cmp    %esi,%edx
     e82:	77 7c                	ja     f00 <__udivdi3+0xd0>
     e84:	0f bd fa             	bsr    %edx,%edi
     e87:	83 f7 1f             	xor    $0x1f,%edi
     e8a:	0f 84 98 00 00 00    	je     f28 <__udivdi3+0xf8>
     e90:	89 f9                	mov    %edi,%ecx
     e92:	b8 20 00 00 00       	mov    $0x20,%eax
     e97:	29 f8                	sub    %edi,%eax
     e99:	d3 e2                	shl    %cl,%edx
     e9b:	89 54 24 08          	mov    %edx,0x8(%esp)
     e9f:	89 c1                	mov    %eax,%ecx
     ea1:	89 da                	mov    %ebx,%edx
     ea3:	d3 ea                	shr    %cl,%edx
     ea5:	8b 4c 24 08          	mov    0x8(%esp),%ecx
     ea9:	09 d1                	or     %edx,%ecx
     eab:	89 f2                	mov    %esi,%edx
     ead:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     eb1:	89 f9                	mov    %edi,%ecx
     eb3:	d3 e3                	shl    %cl,%ebx
     eb5:	89 c1                	mov    %eax,%ecx
     eb7:	d3 ea                	shr    %cl,%edx
     eb9:	89 f9                	mov    %edi,%ecx
     ebb:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     ebf:	d3 e6                	shl    %cl,%esi
     ec1:	89 eb                	mov    %ebp,%ebx
     ec3:	89 c1                	mov    %eax,%ecx
     ec5:	d3 eb                	shr    %cl,%ebx
     ec7:	09 de                	or     %ebx,%esi
     ec9:	89 f0                	mov    %esi,%eax
     ecb:	f7 74 24 08          	divl   0x8(%esp)
     ecf:	89 d6                	mov    %edx,%esi
     ed1:	89 c3                	mov    %eax,%ebx
     ed3:	f7 64 24 0c          	mull   0xc(%esp)
     ed7:	39 d6                	cmp    %edx,%esi
     ed9:	72 0c                	jb     ee7 <__udivdi3+0xb7>
     edb:	89 f9                	mov    %edi,%ecx
     edd:	d3 e5                	shl    %cl,%ebp
     edf:	39 c5                	cmp    %eax,%ebp
     ee1:	73 5d                	jae    f40 <__udivdi3+0x110>
     ee3:	39 d6                	cmp    %edx,%esi
     ee5:	75 59                	jne    f40 <__udivdi3+0x110>
     ee7:	8d 43 ff             	lea    -0x1(%ebx),%eax
     eea:	31 ff                	xor    %edi,%edi
     eec:	89 fa                	mov    %edi,%edx
     eee:	83 c4 1c             	add    $0x1c,%esp
     ef1:	5b                   	pop    %ebx
     ef2:	5e                   	pop    %esi
     ef3:	5f                   	pop    %edi
     ef4:	5d                   	pop    %ebp
     ef5:	c3                   	ret    
     ef6:	8d 76 00             	lea    0x0(%esi),%esi
     ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     f00:	31 ff                	xor    %edi,%edi
     f02:	31 c0                	xor    %eax,%eax
     f04:	89 fa                	mov    %edi,%edx
     f06:	83 c4 1c             	add    $0x1c,%esp
     f09:	5b                   	pop    %ebx
     f0a:	5e                   	pop    %esi
     f0b:	5f                   	pop    %edi
     f0c:	5d                   	pop    %ebp
     f0d:	c3                   	ret    
     f0e:	66 90                	xchg   %ax,%ax
     f10:	31 ff                	xor    %edi,%edi
     f12:	89 e8                	mov    %ebp,%eax
     f14:	89 f2                	mov    %esi,%edx
     f16:	f7 f3                	div    %ebx
     f18:	89 fa                	mov    %edi,%edx
     f1a:	83 c4 1c             	add    $0x1c,%esp
     f1d:	5b                   	pop    %ebx
     f1e:	5e                   	pop    %esi
     f1f:	5f                   	pop    %edi
     f20:	5d                   	pop    %ebp
     f21:	c3                   	ret    
     f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f28:	39 f2                	cmp    %esi,%edx
     f2a:	72 06                	jb     f32 <__udivdi3+0x102>
     f2c:	31 c0                	xor    %eax,%eax
     f2e:	39 eb                	cmp    %ebp,%ebx
     f30:	77 d2                	ja     f04 <__udivdi3+0xd4>
     f32:	b8 01 00 00 00       	mov    $0x1,%eax
     f37:	eb cb                	jmp    f04 <__udivdi3+0xd4>
     f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f40:	89 d8                	mov    %ebx,%eax
     f42:	31 ff                	xor    %edi,%edi
     f44:	eb be                	jmp    f04 <__udivdi3+0xd4>
     f46:	66 90                	xchg   %ax,%ax
     f48:	66 90                	xchg   %ax,%ax
     f4a:	66 90                	xchg   %ax,%ax
     f4c:	66 90                	xchg   %ax,%ax
     f4e:	66 90                	xchg   %ax,%ax

00000f50 <__umoddi3>:
     f50:	55                   	push   %ebp
     f51:	57                   	push   %edi
     f52:	56                   	push   %esi
     f53:	53                   	push   %ebx
     f54:	83 ec 1c             	sub    $0x1c,%esp
     f57:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
     f5b:	8b 74 24 30          	mov    0x30(%esp),%esi
     f5f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
     f63:	8b 7c 24 38          	mov    0x38(%esp),%edi
     f67:	85 ed                	test   %ebp,%ebp
     f69:	89 f0                	mov    %esi,%eax
     f6b:	89 da                	mov    %ebx,%edx
     f6d:	75 19                	jne    f88 <__umoddi3+0x38>
     f6f:	39 df                	cmp    %ebx,%edi
     f71:	0f 86 b1 00 00 00    	jbe    1028 <__umoddi3+0xd8>
     f77:	f7 f7                	div    %edi
     f79:	89 d0                	mov    %edx,%eax
     f7b:	31 d2                	xor    %edx,%edx
     f7d:	83 c4 1c             	add    $0x1c,%esp
     f80:	5b                   	pop    %ebx
     f81:	5e                   	pop    %esi
     f82:	5f                   	pop    %edi
     f83:	5d                   	pop    %ebp
     f84:	c3                   	ret    
     f85:	8d 76 00             	lea    0x0(%esi),%esi
     f88:	39 dd                	cmp    %ebx,%ebp
     f8a:	77 f1                	ja     f7d <__umoddi3+0x2d>
     f8c:	0f bd cd             	bsr    %ebp,%ecx
     f8f:	83 f1 1f             	xor    $0x1f,%ecx
     f92:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     f96:	0f 84 b4 00 00 00    	je     1050 <__umoddi3+0x100>
     f9c:	b8 20 00 00 00       	mov    $0x20,%eax
     fa1:	89 c2                	mov    %eax,%edx
     fa3:	8b 44 24 04          	mov    0x4(%esp),%eax
     fa7:	29 c2                	sub    %eax,%edx
     fa9:	89 c1                	mov    %eax,%ecx
     fab:	89 f8                	mov    %edi,%eax
     fad:	d3 e5                	shl    %cl,%ebp
     faf:	89 d1                	mov    %edx,%ecx
     fb1:	89 54 24 0c          	mov    %edx,0xc(%esp)
     fb5:	d3 e8                	shr    %cl,%eax
     fb7:	09 c5                	or     %eax,%ebp
     fb9:	8b 44 24 04          	mov    0x4(%esp),%eax
     fbd:	89 c1                	mov    %eax,%ecx
     fbf:	d3 e7                	shl    %cl,%edi
     fc1:	89 d1                	mov    %edx,%ecx
     fc3:	89 7c 24 08          	mov    %edi,0x8(%esp)
     fc7:	89 df                	mov    %ebx,%edi
     fc9:	d3 ef                	shr    %cl,%edi
     fcb:	89 c1                	mov    %eax,%ecx
     fcd:	89 f0                	mov    %esi,%eax
     fcf:	d3 e3                	shl    %cl,%ebx
     fd1:	89 d1                	mov    %edx,%ecx
     fd3:	89 fa                	mov    %edi,%edx
     fd5:	d3 e8                	shr    %cl,%eax
     fd7:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
     fdc:	09 d8                	or     %ebx,%eax
     fde:	f7 f5                	div    %ebp
     fe0:	d3 e6                	shl    %cl,%esi
     fe2:	89 d1                	mov    %edx,%ecx
     fe4:	f7 64 24 08          	mull   0x8(%esp)
     fe8:	39 d1                	cmp    %edx,%ecx
     fea:	89 c3                	mov    %eax,%ebx
     fec:	89 d7                	mov    %edx,%edi
     fee:	72 06                	jb     ff6 <__umoddi3+0xa6>
     ff0:	75 0e                	jne    1000 <__umoddi3+0xb0>
     ff2:	39 c6                	cmp    %eax,%esi
     ff4:	73 0a                	jae    1000 <__umoddi3+0xb0>
     ff6:	2b 44 24 08          	sub    0x8(%esp),%eax
     ffa:	19 ea                	sbb    %ebp,%edx
     ffc:	89 d7                	mov    %edx,%edi
     ffe:	89 c3                	mov    %eax,%ebx
    1000:	89 ca                	mov    %ecx,%edx
    1002:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
    1007:	29 de                	sub    %ebx,%esi
    1009:	19 fa                	sbb    %edi,%edx
    100b:	8b 5c 24 04          	mov    0x4(%esp),%ebx
    100f:	89 d0                	mov    %edx,%eax
    1011:	d3 e0                	shl    %cl,%eax
    1013:	89 d9                	mov    %ebx,%ecx
    1015:	d3 ee                	shr    %cl,%esi
    1017:	d3 ea                	shr    %cl,%edx
    1019:	09 f0                	or     %esi,%eax
    101b:	83 c4 1c             	add    $0x1c,%esp
    101e:	5b                   	pop    %ebx
    101f:	5e                   	pop    %esi
    1020:	5f                   	pop    %edi
    1021:	5d                   	pop    %ebp
    1022:	c3                   	ret    
    1023:	90                   	nop
    1024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1028:	85 ff                	test   %edi,%edi
    102a:	89 f9                	mov    %edi,%ecx
    102c:	75 0b                	jne    1039 <__umoddi3+0xe9>
    102e:	b8 01 00 00 00       	mov    $0x1,%eax
    1033:	31 d2                	xor    %edx,%edx
    1035:	f7 f7                	div    %edi
    1037:	89 c1                	mov    %eax,%ecx
    1039:	89 d8                	mov    %ebx,%eax
    103b:	31 d2                	xor    %edx,%edx
    103d:	f7 f1                	div    %ecx
    103f:	89 f0                	mov    %esi,%eax
    1041:	f7 f1                	div    %ecx
    1043:	e9 31 ff ff ff       	jmp    f79 <__umoddi3+0x29>
    1048:	90                   	nop
    1049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1050:	39 dd                	cmp    %ebx,%ebp
    1052:	72 08                	jb     105c <__umoddi3+0x10c>
    1054:	39 f7                	cmp    %esi,%edi
    1056:	0f 87 21 ff ff ff    	ja     f7d <__umoddi3+0x2d>
    105c:	89 da                	mov    %ebx,%edx
    105e:	89 f0                	mov    %esi,%eax
    1060:	29 f8                	sub    %edi,%eax
    1062:	19 ea                	sbb    %ebp,%edx
    1064:	e9 14 ff ff ff       	jmp    f7d <__umoddi3+0x2d>
