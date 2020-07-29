
_ln:     file format elf32-i386


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
       f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
      11:	83 3b 03             	cmpl   $0x3,(%ebx)
      14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
      16:	83 ec 08             	sub    $0x8,%esp
      19:	68 80 10 00 00       	push   $0x1080
      1e:	6a 02                	push   $0x2
      20:	e8 69 04 00 00       	call   48e <printf>
      25:	83 c4 10             	add    $0x10,%esp
    exit();
      28:	e8 ce 02 00 00       	call   2fb <exit>
  }
  if(link(argv[1], argv[2]) < 0)
      2d:	8b 43 04             	mov    0x4(%ebx),%eax
      30:	83 c0 08             	add    $0x8,%eax
      33:	8b 10                	mov    (%eax),%edx
      35:	8b 43 04             	mov    0x4(%ebx),%eax
      38:	83 c0 04             	add    $0x4,%eax
      3b:	8b 00                	mov    (%eax),%eax
      3d:	83 ec 08             	sub    $0x8,%esp
      40:	52                   	push   %edx
      41:	50                   	push   %eax
      42:	e8 14 03 00 00       	call   35b <link>
      47:	83 c4 10             	add    $0x10,%esp
      4a:	85 c0                	test   %eax,%eax
      4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
      4e:	8b 43 04             	mov    0x4(%ebx),%eax
      51:	83 c0 08             	add    $0x8,%eax
      54:	8b 10                	mov    (%eax),%edx
      56:	8b 43 04             	mov    0x4(%ebx),%eax
      59:	83 c0 04             	add    $0x4,%eax
      5c:	8b 00                	mov    (%eax),%eax
      5e:	52                   	push   %edx
      5f:	50                   	push   %eax
      60:	68 93 10 00 00       	push   $0x1093
      65:	6a 02                	push   $0x2
      67:	e8 22 04 00 00       	call   48e <printf>
      6c:	83 c4 10             	add    $0x10,%esp
  exit();
      6f:	e8 87 02 00 00       	call   2fb <exit>

00000074 <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
      74:	55                   	push   %ebp
      75:	89 e5                	mov    %esp,%ebp
      77:	57                   	push   %edi
      78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      79:	8b 4d 08             	mov    0x8(%ebp),%ecx
      7c:	8b 55 10             	mov    0x10(%ebp),%edx
      7f:	8b 45 0c             	mov    0xc(%ebp),%eax
      82:	89 cb                	mov    %ecx,%ebx
      84:	89 df                	mov    %ebx,%edi
      86:	89 d1                	mov    %edx,%ecx
      88:	fc                   	cld    
      89:	f3 aa                	rep stos %al,%es:(%edi)
      8b:	89 ca                	mov    %ecx,%edx
      8d:	89 fb                	mov    %edi,%ebx
      8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
      92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      95:	90                   	nop
      96:	5b                   	pop    %ebx
      97:	5f                   	pop    %edi
      98:	5d                   	pop    %ebp
      99:	c3                   	ret    

0000009a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      9a:	55                   	push   %ebp
      9b:	89 e5                	mov    %esp,%ebp
      9d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      a0:	8b 45 08             	mov    0x8(%ebp),%eax
      a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      a6:	90                   	nop
      a7:	8b 55 0c             	mov    0xc(%ebp),%edx
      aa:	8d 42 01             	lea    0x1(%edx),%eax
      ad:	89 45 0c             	mov    %eax,0xc(%ebp)
      b0:	8b 45 08             	mov    0x8(%ebp),%eax
      b3:	8d 48 01             	lea    0x1(%eax),%ecx
      b6:	89 4d 08             	mov    %ecx,0x8(%ebp)
      b9:	0f b6 12             	movzbl (%edx),%edx
      bc:	88 10                	mov    %dl,(%eax)
      be:	0f b6 00             	movzbl (%eax),%eax
      c1:	84 c0                	test   %al,%al
      c3:	75 e2                	jne    a7 <strcpy+0xd>
    ;
  return os;
      c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      c8:	c9                   	leave  
      c9:	c3                   	ret    

000000ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
      ca:	55                   	push   %ebp
      cb:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      cd:	eb 08                	jmp    d7 <strcmp+0xd>
    p++, q++;
      cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      d3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
      d7:	8b 45 08             	mov    0x8(%ebp),%eax
      da:	0f b6 00             	movzbl (%eax),%eax
      dd:	84 c0                	test   %al,%al
      df:	74 10                	je     f1 <strcmp+0x27>
      e1:	8b 45 08             	mov    0x8(%ebp),%eax
      e4:	0f b6 10             	movzbl (%eax),%edx
      e7:	8b 45 0c             	mov    0xc(%ebp),%eax
      ea:	0f b6 00             	movzbl (%eax),%eax
      ed:	38 c2                	cmp    %al,%dl
      ef:	74 de                	je     cf <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
      f1:	8b 45 08             	mov    0x8(%ebp),%eax
      f4:	0f b6 00             	movzbl (%eax),%eax
      f7:	0f b6 d0             	movzbl %al,%edx
      fa:	8b 45 0c             	mov    0xc(%ebp),%eax
      fd:	0f b6 00             	movzbl (%eax),%eax
     100:	0f b6 c0             	movzbl %al,%eax
     103:	29 c2                	sub    %eax,%edx
     105:	89 d0                	mov    %edx,%eax
}
     107:	5d                   	pop    %ebp
     108:	c3                   	ret    

00000109 <strlen>:

uint
strlen(char *s)
{
     109:	55                   	push   %ebp
     10a:	89 e5                	mov    %esp,%ebp
     10c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     10f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     116:	eb 04                	jmp    11c <strlen+0x13>
     118:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     11c:	8b 55 fc             	mov    -0x4(%ebp),%edx
     11f:	8b 45 08             	mov    0x8(%ebp),%eax
     122:	01 d0                	add    %edx,%eax
     124:	0f b6 00             	movzbl (%eax),%eax
     127:	84 c0                	test   %al,%al
     129:	75 ed                	jne    118 <strlen+0xf>
    ;
  return n;
     12b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     12e:	c9                   	leave  
     12f:	c3                   	ret    

00000130 <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     136:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     13d:	eb 0c                	jmp    14b <strnlen+0x1b>
     n++; 
     13f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     143:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     147:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     14b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     14f:	74 0a                	je     15b <strnlen+0x2b>
     151:	8b 45 08             	mov    0x8(%ebp),%eax
     154:	0f b6 00             	movzbl (%eax),%eax
     157:	84 c0                	test   %al,%al
     159:	75 e4                	jne    13f <strnlen+0xf>
   return n; 
     15b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     15e:	c9                   	leave  
     15f:	c3                   	ret    

00000160 <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     163:	8b 45 10             	mov    0x10(%ebp),%eax
     166:	50                   	push   %eax
     167:	ff 75 0c             	pushl  0xc(%ebp)
     16a:	ff 75 08             	pushl  0x8(%ebp)
     16d:	e8 02 ff ff ff       	call   74 <stosb>
     172:	83 c4 0c             	add    $0xc,%esp
  return dst;
     175:	8b 45 08             	mov    0x8(%ebp),%eax
}
     178:	c9                   	leave  
     179:	c3                   	ret    

0000017a <strchr>:

char*
strchr(const char *s, char c)
{
     17a:	55                   	push   %ebp
     17b:	89 e5                	mov    %esp,%ebp
     17d:	83 ec 04             	sub    $0x4,%esp
     180:	8b 45 0c             	mov    0xc(%ebp),%eax
     183:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     186:	eb 14                	jmp    19c <strchr+0x22>
    if(*s == c)
     188:	8b 45 08             	mov    0x8(%ebp),%eax
     18b:	0f b6 00             	movzbl (%eax),%eax
     18e:	38 45 fc             	cmp    %al,-0x4(%ebp)
     191:	75 05                	jne    198 <strchr+0x1e>
      return (char*)s;
     193:	8b 45 08             	mov    0x8(%ebp),%eax
     196:	eb 13                	jmp    1ab <strchr+0x31>
  for(; *s; s++)
     198:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     19c:	8b 45 08             	mov    0x8(%ebp),%eax
     19f:	0f b6 00             	movzbl (%eax),%eax
     1a2:	84 c0                	test   %al,%al
     1a4:	75 e2                	jne    188 <strchr+0xe>
  return 0;
     1a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
     1ab:	c9                   	leave  
     1ac:	c3                   	ret    

000001ad <gets>:

char*
gets(char *buf, int max)
{
     1ad:	55                   	push   %ebp
     1ae:	89 e5                	mov    %esp,%ebp
     1b0:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     1ba:	eb 42                	jmp    1fe <gets+0x51>
    cc = read(0, &c, 1);
     1bc:	83 ec 04             	sub    $0x4,%esp
     1bf:	6a 01                	push   $0x1
     1c1:	8d 45 ef             	lea    -0x11(%ebp),%eax
     1c4:	50                   	push   %eax
     1c5:	6a 00                	push   $0x0
     1c7:	e8 47 01 00 00       	call   313 <read>
     1cc:	83 c4 10             	add    $0x10,%esp
     1cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1d6:	7e 33                	jle    20b <gets+0x5e>
      break;
    buf[i++] = c;
     1d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1db:	8d 50 01             	lea    0x1(%eax),%edx
     1de:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1e1:	89 c2                	mov    %eax,%edx
     1e3:	8b 45 08             	mov    0x8(%ebp),%eax
     1e6:	01 c2                	add    %eax,%edx
     1e8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1ec:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1ee:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1f2:	3c 0a                	cmp    $0xa,%al
     1f4:	74 16                	je     20c <gets+0x5f>
     1f6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1fa:	3c 0d                	cmp    $0xd,%al
     1fc:	74 0e                	je     20c <gets+0x5f>
  for(i=0; i+1 < max; ){
     1fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     201:	83 c0 01             	add    $0x1,%eax
     204:	39 45 0c             	cmp    %eax,0xc(%ebp)
     207:	7f b3                	jg     1bc <gets+0xf>
     209:	eb 01                	jmp    20c <gets+0x5f>
      break;
     20b:	90                   	nop
      break;
  }
  buf[i] = '\0';
     20c:	8b 55 f4             	mov    -0xc(%ebp),%edx
     20f:	8b 45 08             	mov    0x8(%ebp),%eax
     212:	01 d0                	add    %edx,%eax
     214:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     217:	8b 45 08             	mov    0x8(%ebp),%eax
}
     21a:	c9                   	leave  
     21b:	c3                   	ret    

0000021c <stat>:

int
stat(char *n, struct stat *st)
{
     21c:	55                   	push   %ebp
     21d:	89 e5                	mov    %esp,%ebp
     21f:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     222:	83 ec 08             	sub    $0x8,%esp
     225:	6a 00                	push   $0x0
     227:	ff 75 08             	pushl  0x8(%ebp)
     22a:	e8 0c 01 00 00       	call   33b <open>
     22f:	83 c4 10             	add    $0x10,%esp
     232:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     235:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     239:	79 07                	jns    242 <stat+0x26>
    return -1;
     23b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     240:	eb 25                	jmp    267 <stat+0x4b>
  r = fstat(fd, st);
     242:	83 ec 08             	sub    $0x8,%esp
     245:	ff 75 0c             	pushl  0xc(%ebp)
     248:	ff 75 f4             	pushl  -0xc(%ebp)
     24b:	e8 03 01 00 00       	call   353 <fstat>
     250:	83 c4 10             	add    $0x10,%esp
     253:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     256:	83 ec 0c             	sub    $0xc,%esp
     259:	ff 75 f4             	pushl  -0xc(%ebp)
     25c:	e8 c2 00 00 00       	call   323 <close>
     261:	83 c4 10             	add    $0x10,%esp
  return r;
     264:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     267:	c9                   	leave  
     268:	c3                   	ret    

00000269 <atoi>:

int
atoi(const char *s)
{
     269:	55                   	push   %ebp
     26a:	89 e5                	mov    %esp,%ebp
     26c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     26f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     276:	eb 25                	jmp    29d <atoi+0x34>
    n = n*10 + *s++ - '0';
     278:	8b 55 fc             	mov    -0x4(%ebp),%edx
     27b:	89 d0                	mov    %edx,%eax
     27d:	c1 e0 02             	shl    $0x2,%eax
     280:	01 d0                	add    %edx,%eax
     282:	01 c0                	add    %eax,%eax
     284:	89 c1                	mov    %eax,%ecx
     286:	8b 45 08             	mov    0x8(%ebp),%eax
     289:	8d 50 01             	lea    0x1(%eax),%edx
     28c:	89 55 08             	mov    %edx,0x8(%ebp)
     28f:	0f b6 00             	movzbl (%eax),%eax
     292:	0f be c0             	movsbl %al,%eax
     295:	01 c8                	add    %ecx,%eax
     297:	83 e8 30             	sub    $0x30,%eax
     29a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     29d:	8b 45 08             	mov    0x8(%ebp),%eax
     2a0:	0f b6 00             	movzbl (%eax),%eax
     2a3:	3c 2f                	cmp    $0x2f,%al
     2a5:	7e 0a                	jle    2b1 <atoi+0x48>
     2a7:	8b 45 08             	mov    0x8(%ebp),%eax
     2aa:	0f b6 00             	movzbl (%eax),%eax
     2ad:	3c 39                	cmp    $0x39,%al
     2af:	7e c7                	jle    278 <atoi+0xf>
  return n;
     2b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2b4:	c9                   	leave  
     2b5:	c3                   	ret    

000002b6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     2b6:	55                   	push   %ebp
     2b7:	89 e5                	mov    %esp,%ebp
     2b9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     2bc:	8b 45 08             	mov    0x8(%ebp),%eax
     2bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     2c2:	8b 45 0c             	mov    0xc(%ebp),%eax
     2c5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     2c8:	eb 17                	jmp    2e1 <memmove+0x2b>
    *dst++ = *src++;
     2ca:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2cd:	8d 42 01             	lea    0x1(%edx),%eax
     2d0:	89 45 f8             	mov    %eax,-0x8(%ebp)
     2d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2d6:	8d 48 01             	lea    0x1(%eax),%ecx
     2d9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     2dc:	0f b6 12             	movzbl (%edx),%edx
     2df:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     2e1:	8b 45 10             	mov    0x10(%ebp),%eax
     2e4:	8d 50 ff             	lea    -0x1(%eax),%edx
     2e7:	89 55 10             	mov    %edx,0x10(%ebp)
     2ea:	85 c0                	test   %eax,%eax
     2ec:	7f dc                	jg     2ca <memmove+0x14>
  return vdst;
     2ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2f1:	c9                   	leave  
     2f2:	c3                   	ret    

000002f3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2f3:	b8 01 00 00 00       	mov    $0x1,%eax
     2f8:	cd 40                	int    $0x40
     2fa:	c3                   	ret    

000002fb <exit>:
SYSCALL(exit)
     2fb:	b8 02 00 00 00       	mov    $0x2,%eax
     300:	cd 40                	int    $0x40
     302:	c3                   	ret    

00000303 <wait>:
SYSCALL(wait)
     303:	b8 03 00 00 00       	mov    $0x3,%eax
     308:	cd 40                	int    $0x40
     30a:	c3                   	ret    

0000030b <pipe>:
SYSCALL(pipe)
     30b:	b8 04 00 00 00       	mov    $0x4,%eax
     310:	cd 40                	int    $0x40
     312:	c3                   	ret    

00000313 <read>:
SYSCALL(read)
     313:	b8 05 00 00 00       	mov    $0x5,%eax
     318:	cd 40                	int    $0x40
     31a:	c3                   	ret    

0000031b <write>:
SYSCALL(write)
     31b:	b8 10 00 00 00       	mov    $0x10,%eax
     320:	cd 40                	int    $0x40
     322:	c3                   	ret    

00000323 <close>:
SYSCALL(close)
     323:	b8 15 00 00 00       	mov    $0x15,%eax
     328:	cd 40                	int    $0x40
     32a:	c3                   	ret    

0000032b <kill>:
SYSCALL(kill)
     32b:	b8 06 00 00 00       	mov    $0x6,%eax
     330:	cd 40                	int    $0x40
     332:	c3                   	ret    

00000333 <exec>:
SYSCALL(exec)
     333:	b8 07 00 00 00       	mov    $0x7,%eax
     338:	cd 40                	int    $0x40
     33a:	c3                   	ret    

0000033b <open>:
SYSCALL(open)
     33b:	b8 0f 00 00 00       	mov    $0xf,%eax
     340:	cd 40                	int    $0x40
     342:	c3                   	ret    

00000343 <mknod>:
SYSCALL(mknod)
     343:	b8 11 00 00 00       	mov    $0x11,%eax
     348:	cd 40                	int    $0x40
     34a:	c3                   	ret    

0000034b <unlink>:
SYSCALL(unlink)
     34b:	b8 12 00 00 00       	mov    $0x12,%eax
     350:	cd 40                	int    $0x40
     352:	c3                   	ret    

00000353 <fstat>:
SYSCALL(fstat)
     353:	b8 08 00 00 00       	mov    $0x8,%eax
     358:	cd 40                	int    $0x40
     35a:	c3                   	ret    

0000035b <link>:
SYSCALL(link)
     35b:	b8 13 00 00 00       	mov    $0x13,%eax
     360:	cd 40                	int    $0x40
     362:	c3                   	ret    

00000363 <mkdir>:
SYSCALL(mkdir)
     363:	b8 14 00 00 00       	mov    $0x14,%eax
     368:	cd 40                	int    $0x40
     36a:	c3                   	ret    

0000036b <chdir>:
SYSCALL(chdir)
     36b:	b8 09 00 00 00       	mov    $0x9,%eax
     370:	cd 40                	int    $0x40
     372:	c3                   	ret    

00000373 <dup>:
SYSCALL(dup)
     373:	b8 0a 00 00 00       	mov    $0xa,%eax
     378:	cd 40                	int    $0x40
     37a:	c3                   	ret    

0000037b <getpid>:
SYSCALL(getpid)
     37b:	b8 0b 00 00 00       	mov    $0xb,%eax
     380:	cd 40                	int    $0x40
     382:	c3                   	ret    

00000383 <sbrk>:
SYSCALL(sbrk)
     383:	b8 0c 00 00 00       	mov    $0xc,%eax
     388:	cd 40                	int    $0x40
     38a:	c3                   	ret    

0000038b <sleep>:
SYSCALL(sleep)
     38b:	b8 0d 00 00 00       	mov    $0xd,%eax
     390:	cd 40                	int    $0x40
     392:	c3                   	ret    

00000393 <uptime>:
SYSCALL(uptime)
     393:	b8 0e 00 00 00       	mov    $0xe,%eax
     398:	cd 40                	int    $0x40
     39a:	c3                   	ret    

0000039b <select>:
SYSCALL(select)
     39b:	b8 16 00 00 00       	mov    $0x16,%eax
     3a0:	cd 40                	int    $0x40
     3a2:	c3                   	ret    

000003a3 <arp>:
SYSCALL(arp)
     3a3:	b8 17 00 00 00       	mov    $0x17,%eax
     3a8:	cd 40                	int    $0x40
     3aa:	c3                   	ret    

000003ab <arpserv>:
SYSCALL(arpserv)
     3ab:	b8 18 00 00 00       	mov    $0x18,%eax
     3b0:	cd 40                	int    $0x40
     3b2:	c3                   	ret    

000003b3 <arp_receive>:
SYSCALL(arp_receive)
     3b3:	b8 19 00 00 00       	mov    $0x19,%eax
     3b8:	cd 40                	int    $0x40
     3ba:	c3                   	ret    

000003bb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3bb:	55                   	push   %ebp
     3bc:	89 e5                	mov    %esp,%ebp
     3be:	83 ec 18             	sub    $0x18,%esp
     3c1:	8b 45 0c             	mov    0xc(%ebp),%eax
     3c4:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3c7:	83 ec 04             	sub    $0x4,%esp
     3ca:	6a 01                	push   $0x1
     3cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3cf:	50                   	push   %eax
     3d0:	ff 75 08             	pushl  0x8(%ebp)
     3d3:	e8 43 ff ff ff       	call   31b <write>
     3d8:	83 c4 10             	add    $0x10,%esp
}
     3db:	90                   	nop
     3dc:	c9                   	leave  
     3dd:	c3                   	ret    

000003de <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3de:	55                   	push   %ebp
     3df:	89 e5                	mov    %esp,%ebp
     3e1:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3eb:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3ef:	74 17                	je     408 <printint+0x2a>
     3f1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3f5:	79 11                	jns    408 <printint+0x2a>
    neg = 1;
     3f7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3fe:	8b 45 0c             	mov    0xc(%ebp),%eax
     401:	f7 d8                	neg    %eax
     403:	89 45 ec             	mov    %eax,-0x14(%ebp)
     406:	eb 06                	jmp    40e <printint+0x30>
  } else {
    x = xx;
     408:	8b 45 0c             	mov    0xc(%ebp),%eax
     40b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     40e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     415:	8b 4d 10             	mov    0x10(%ebp),%ecx
     418:	8b 45 ec             	mov    -0x14(%ebp),%eax
     41b:	ba 00 00 00 00       	mov    $0x0,%edx
     420:	f7 f1                	div    %ecx
     422:	89 d1                	mov    %edx,%ecx
     424:	8b 45 f4             	mov    -0xc(%ebp),%eax
     427:	8d 50 01             	lea    0x1(%eax),%edx
     42a:	89 55 f4             	mov    %edx,-0xc(%ebp)
     42d:	0f b6 91 50 17 00 00 	movzbl 0x1750(%ecx),%edx
     434:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     438:	8b 4d 10             	mov    0x10(%ebp),%ecx
     43b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     43e:	ba 00 00 00 00       	mov    $0x0,%edx
     443:	f7 f1                	div    %ecx
     445:	89 45 ec             	mov    %eax,-0x14(%ebp)
     448:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     44c:	75 c7                	jne    415 <printint+0x37>
  if(neg)
     44e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     452:	74 2d                	je     481 <printint+0xa3>
    buf[i++] = '-';
     454:	8b 45 f4             	mov    -0xc(%ebp),%eax
     457:	8d 50 01             	lea    0x1(%eax),%edx
     45a:	89 55 f4             	mov    %edx,-0xc(%ebp)
     45d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     462:	eb 1d                	jmp    481 <printint+0xa3>
    putc(fd, buf[i]);
     464:	8d 55 dc             	lea    -0x24(%ebp),%edx
     467:	8b 45 f4             	mov    -0xc(%ebp),%eax
     46a:	01 d0                	add    %edx,%eax
     46c:	0f b6 00             	movzbl (%eax),%eax
     46f:	0f be c0             	movsbl %al,%eax
     472:	83 ec 08             	sub    $0x8,%esp
     475:	50                   	push   %eax
     476:	ff 75 08             	pushl  0x8(%ebp)
     479:	e8 3d ff ff ff       	call   3bb <putc>
     47e:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     481:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     485:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     489:	79 d9                	jns    464 <printint+0x86>
}
     48b:	90                   	nop
     48c:	c9                   	leave  
     48d:	c3                   	ret    

0000048e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     48e:	55                   	push   %ebp
     48f:	89 e5                	mov    %esp,%ebp
     491:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     494:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     49b:	8d 45 0c             	lea    0xc(%ebp),%eax
     49e:	83 c0 04             	add    $0x4,%eax
     4a1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4ab:	e9 59 01 00 00       	jmp    609 <printf+0x17b>
    c = fmt[i] & 0xff;
     4b0:	8b 55 0c             	mov    0xc(%ebp),%edx
     4b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4b6:	01 d0                	add    %edx,%eax
     4b8:	0f b6 00             	movzbl (%eax),%eax
     4bb:	0f be c0             	movsbl %al,%eax
     4be:	25 ff 00 00 00       	and    $0xff,%eax
     4c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4c6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4ca:	75 2c                	jne    4f8 <printf+0x6a>
      if(c == '%'){
     4cc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4d0:	75 0c                	jne    4de <printf+0x50>
        state = '%';
     4d2:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4d9:	e9 27 01 00 00       	jmp    605 <printf+0x177>
      } else {
        putc(fd, c);
     4de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4e1:	0f be c0             	movsbl %al,%eax
     4e4:	83 ec 08             	sub    $0x8,%esp
     4e7:	50                   	push   %eax
     4e8:	ff 75 08             	pushl  0x8(%ebp)
     4eb:	e8 cb fe ff ff       	call   3bb <putc>
     4f0:	83 c4 10             	add    $0x10,%esp
     4f3:	e9 0d 01 00 00       	jmp    605 <printf+0x177>
      }
    } else if(state == '%'){
     4f8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4fc:	0f 85 03 01 00 00    	jne    605 <printf+0x177>
      if(c == 'd'){
     502:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     506:	75 1e                	jne    526 <printf+0x98>
        printint(fd, *ap, 10, 1);
     508:	8b 45 e8             	mov    -0x18(%ebp),%eax
     50b:	8b 00                	mov    (%eax),%eax
     50d:	6a 01                	push   $0x1
     50f:	6a 0a                	push   $0xa
     511:	50                   	push   %eax
     512:	ff 75 08             	pushl  0x8(%ebp)
     515:	e8 c4 fe ff ff       	call   3de <printint>
     51a:	83 c4 10             	add    $0x10,%esp
        ap++;
     51d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     521:	e9 d8 00 00 00       	jmp    5fe <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     526:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     52a:	74 06                	je     532 <printf+0xa4>
     52c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     530:	75 1e                	jne    550 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     532:	8b 45 e8             	mov    -0x18(%ebp),%eax
     535:	8b 00                	mov    (%eax),%eax
     537:	6a 00                	push   $0x0
     539:	6a 10                	push   $0x10
     53b:	50                   	push   %eax
     53c:	ff 75 08             	pushl  0x8(%ebp)
     53f:	e8 9a fe ff ff       	call   3de <printint>
     544:	83 c4 10             	add    $0x10,%esp
        ap++;
     547:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     54b:	e9 ae 00 00 00       	jmp    5fe <printf+0x170>
      } else if(c == 's'){
     550:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     554:	75 43                	jne    599 <printf+0x10b>
        s = (char*)*ap;
     556:	8b 45 e8             	mov    -0x18(%ebp),%eax
     559:	8b 00                	mov    (%eax),%eax
     55b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     55e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     562:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     566:	75 25                	jne    58d <printf+0xff>
          s = "(null)";
     568:	c7 45 f4 a7 10 00 00 	movl   $0x10a7,-0xc(%ebp)
        while(*s != 0){
     56f:	eb 1c                	jmp    58d <printf+0xff>
          putc(fd, *s);
     571:	8b 45 f4             	mov    -0xc(%ebp),%eax
     574:	0f b6 00             	movzbl (%eax),%eax
     577:	0f be c0             	movsbl %al,%eax
     57a:	83 ec 08             	sub    $0x8,%esp
     57d:	50                   	push   %eax
     57e:	ff 75 08             	pushl  0x8(%ebp)
     581:	e8 35 fe ff ff       	call   3bb <putc>
     586:	83 c4 10             	add    $0x10,%esp
          s++;
     589:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     58d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     590:	0f b6 00             	movzbl (%eax),%eax
     593:	84 c0                	test   %al,%al
     595:	75 da                	jne    571 <printf+0xe3>
     597:	eb 65                	jmp    5fe <printf+0x170>
        }
      } else if(c == 'c'){
     599:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     59d:	75 1d                	jne    5bc <printf+0x12e>
        putc(fd, *ap);
     59f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a2:	8b 00                	mov    (%eax),%eax
     5a4:	0f be c0             	movsbl %al,%eax
     5a7:	83 ec 08             	sub    $0x8,%esp
     5aa:	50                   	push   %eax
     5ab:	ff 75 08             	pushl  0x8(%ebp)
     5ae:	e8 08 fe ff ff       	call   3bb <putc>
     5b3:	83 c4 10             	add    $0x10,%esp
        ap++;
     5b6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5ba:	eb 42                	jmp    5fe <printf+0x170>
      } else if(c == '%'){
     5bc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5c0:	75 17                	jne    5d9 <printf+0x14b>
        putc(fd, c);
     5c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5c5:	0f be c0             	movsbl %al,%eax
     5c8:	83 ec 08             	sub    $0x8,%esp
     5cb:	50                   	push   %eax
     5cc:	ff 75 08             	pushl  0x8(%ebp)
     5cf:	e8 e7 fd ff ff       	call   3bb <putc>
     5d4:	83 c4 10             	add    $0x10,%esp
     5d7:	eb 25                	jmp    5fe <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5d9:	83 ec 08             	sub    $0x8,%esp
     5dc:	6a 25                	push   $0x25
     5de:	ff 75 08             	pushl  0x8(%ebp)
     5e1:	e8 d5 fd ff ff       	call   3bb <putc>
     5e6:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5ec:	0f be c0             	movsbl %al,%eax
     5ef:	83 ec 08             	sub    $0x8,%esp
     5f2:	50                   	push   %eax
     5f3:	ff 75 08             	pushl  0x8(%ebp)
     5f6:	e8 c0 fd ff ff       	call   3bb <putc>
     5fb:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     605:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     609:	8b 55 0c             	mov    0xc(%ebp),%edx
     60c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     60f:	01 d0                	add    %edx,%eax
     611:	0f b6 00             	movzbl (%eax),%eax
     614:	84 c0                	test   %al,%al
     616:	0f 85 94 fe ff ff    	jne    4b0 <printf+0x22>
    }
  }
}
     61c:	90                   	nop
     61d:	c9                   	leave  
     61e:	c3                   	ret    

0000061f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     61f:	55                   	push   %ebp
     620:	89 e5                	mov    %esp,%ebp
     622:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     625:	8b 45 08             	mov    0x8(%ebp),%eax
     628:	83 e8 08             	sub    $0x8,%eax
     62b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     62e:	a1 6c 17 00 00       	mov    0x176c,%eax
     633:	89 45 fc             	mov    %eax,-0x4(%ebp)
     636:	eb 24                	jmp    65c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     638:	8b 45 fc             	mov    -0x4(%ebp),%eax
     63b:	8b 00                	mov    (%eax),%eax
     63d:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     640:	72 12                	jb     654 <free+0x35>
     642:	8b 45 f8             	mov    -0x8(%ebp),%eax
     645:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     648:	77 24                	ja     66e <free+0x4f>
     64a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64d:	8b 00                	mov    (%eax),%eax
     64f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     652:	72 1a                	jb     66e <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     654:	8b 45 fc             	mov    -0x4(%ebp),%eax
     657:	8b 00                	mov    (%eax),%eax
     659:	89 45 fc             	mov    %eax,-0x4(%ebp)
     65c:	8b 45 f8             	mov    -0x8(%ebp),%eax
     65f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     662:	76 d4                	jbe    638 <free+0x19>
     664:	8b 45 fc             	mov    -0x4(%ebp),%eax
     667:	8b 00                	mov    (%eax),%eax
     669:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     66c:	73 ca                	jae    638 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     671:	8b 40 04             	mov    0x4(%eax),%eax
     674:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     67e:	01 c2                	add    %eax,%edx
     680:	8b 45 fc             	mov    -0x4(%ebp),%eax
     683:	8b 00                	mov    (%eax),%eax
     685:	39 c2                	cmp    %eax,%edx
     687:	75 24                	jne    6ad <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     689:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68c:	8b 50 04             	mov    0x4(%eax),%edx
     68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     692:	8b 00                	mov    (%eax),%eax
     694:	8b 40 04             	mov    0x4(%eax),%eax
     697:	01 c2                	add    %eax,%edx
     699:	8b 45 f8             	mov    -0x8(%ebp),%eax
     69c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a2:	8b 00                	mov    (%eax),%eax
     6a4:	8b 10                	mov    (%eax),%edx
     6a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a9:	89 10                	mov    %edx,(%eax)
     6ab:	eb 0a                	jmp    6b7 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b0:	8b 10                	mov    (%eax),%edx
     6b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b5:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ba:	8b 40 04             	mov    0x4(%eax),%eax
     6bd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c7:	01 d0                	add    %edx,%eax
     6c9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6cc:	75 20                	jne    6ee <free+0xcf>
    p->s.size += bp->s.size;
     6ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d1:	8b 50 04             	mov    0x4(%eax),%edx
     6d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d7:	8b 40 04             	mov    0x4(%eax),%eax
     6da:	01 c2                	add    %eax,%edx
     6dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e5:	8b 10                	mov    (%eax),%edx
     6e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ea:	89 10                	mov    %edx,(%eax)
     6ec:	eb 08                	jmp    6f6 <free+0xd7>
  } else
    p->s.ptr = bp;
     6ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f1:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6f4:	89 10                	mov    %edx,(%eax)
  freep = p;
     6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f9:	a3 6c 17 00 00       	mov    %eax,0x176c
}
     6fe:	90                   	nop
     6ff:	c9                   	leave  
     700:	c3                   	ret    

00000701 <morecore>:

static Header*
morecore(uint nu)
{
     701:	55                   	push   %ebp
     702:	89 e5                	mov    %esp,%ebp
     704:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     707:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     70e:	77 07                	ja     717 <morecore+0x16>
    nu = 4096;
     710:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     717:	8b 45 08             	mov    0x8(%ebp),%eax
     71a:	c1 e0 03             	shl    $0x3,%eax
     71d:	83 ec 0c             	sub    $0xc,%esp
     720:	50                   	push   %eax
     721:	e8 5d fc ff ff       	call   383 <sbrk>
     726:	83 c4 10             	add    $0x10,%esp
     729:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     72c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     730:	75 07                	jne    739 <morecore+0x38>
    return 0;
     732:	b8 00 00 00 00       	mov    $0x0,%eax
     737:	eb 26                	jmp    75f <morecore+0x5e>
  hp = (Header*)p;
     739:	8b 45 f4             	mov    -0xc(%ebp),%eax
     73c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     73f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     742:	8b 55 08             	mov    0x8(%ebp),%edx
     745:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     748:	8b 45 f0             	mov    -0x10(%ebp),%eax
     74b:	83 c0 08             	add    $0x8,%eax
     74e:	83 ec 0c             	sub    $0xc,%esp
     751:	50                   	push   %eax
     752:	e8 c8 fe ff ff       	call   61f <free>
     757:	83 c4 10             	add    $0x10,%esp
  return freep;
     75a:	a1 6c 17 00 00       	mov    0x176c,%eax
}
     75f:	c9                   	leave  
     760:	c3                   	ret    

00000761 <malloc>:

void*
malloc(uint nbytes)
{
     761:	55                   	push   %ebp
     762:	89 e5                	mov    %esp,%ebp
     764:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     767:	8b 45 08             	mov    0x8(%ebp),%eax
     76a:	83 c0 07             	add    $0x7,%eax
     76d:	c1 e8 03             	shr    $0x3,%eax
     770:	83 c0 01             	add    $0x1,%eax
     773:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     776:	a1 6c 17 00 00       	mov    0x176c,%eax
     77b:	89 45 f0             	mov    %eax,-0x10(%ebp)
     77e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     782:	75 23                	jne    7a7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     784:	c7 45 f0 64 17 00 00 	movl   $0x1764,-0x10(%ebp)
     78b:	8b 45 f0             	mov    -0x10(%ebp),%eax
     78e:	a3 6c 17 00 00       	mov    %eax,0x176c
     793:	a1 6c 17 00 00       	mov    0x176c,%eax
     798:	a3 64 17 00 00       	mov    %eax,0x1764
    base.s.size = 0;
     79d:	c7 05 68 17 00 00 00 	movl   $0x0,0x1768
     7a4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7aa:	8b 00                	mov    (%eax),%eax
     7ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7af:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b2:	8b 40 04             	mov    0x4(%eax),%eax
     7b5:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7b8:	77 4d                	ja     807 <malloc+0xa6>
      if(p->s.size == nunits)
     7ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7bd:	8b 40 04             	mov    0x4(%eax),%eax
     7c0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7c3:	75 0c                	jne    7d1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c8:	8b 10                	mov    (%eax),%edx
     7ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7cd:	89 10                	mov    %edx,(%eax)
     7cf:	eb 26                	jmp    7f7 <malloc+0x96>
      else {
        p->s.size -= nunits;
     7d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d4:	8b 40 04             	mov    0x4(%eax),%eax
     7d7:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7da:	89 c2                	mov    %eax,%edx
     7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7df:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e5:	8b 40 04             	mov    0x4(%eax),%eax
     7e8:	c1 e0 03             	shl    $0x3,%eax
     7eb:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f1:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7f4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7fa:	a3 6c 17 00 00       	mov    %eax,0x176c
      return (void*)(p + 1);
     7ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
     802:	83 c0 08             	add    $0x8,%eax
     805:	eb 3b                	jmp    842 <malloc+0xe1>
    }
    if(p == freep)
     807:	a1 6c 17 00 00       	mov    0x176c,%eax
     80c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     80f:	75 1e                	jne    82f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     811:	83 ec 0c             	sub    $0xc,%esp
     814:	ff 75 ec             	pushl  -0x14(%ebp)
     817:	e8 e5 fe ff ff       	call   701 <morecore>
     81c:	83 c4 10             	add    $0x10,%esp
     81f:	89 45 f4             	mov    %eax,-0xc(%ebp)
     822:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     826:	75 07                	jne    82f <malloc+0xce>
        return 0;
     828:	b8 00 00 00 00       	mov    $0x0,%eax
     82d:	eb 13                	jmp    842 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     82f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     832:	89 45 f0             	mov    %eax,-0x10(%ebp)
     835:	8b 45 f4             	mov    -0xc(%ebp),%eax
     838:	8b 00                	mov    (%eax),%eax
     83a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     83d:	e9 6d ff ff ff       	jmp    7af <malloc+0x4e>
  }
}
     842:	c9                   	leave  
     843:	c3                   	ret    

00000844 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     844:	55                   	push   %ebp
     845:	89 e5                	mov    %esp,%ebp
     847:	53                   	push   %ebx
     848:	83 ec 14             	sub    $0x14,%esp
     84b:	8b 45 10             	mov    0x10(%ebp),%eax
     84e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     851:	8b 45 14             	mov    0x14(%ebp),%eax
     854:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     857:	8b 45 18             	mov    0x18(%ebp),%eax
     85a:	ba 00 00 00 00       	mov    $0x0,%edx
     85f:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     862:	72 55                	jb     8b9 <printnum+0x75>
     864:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     867:	77 05                	ja     86e <printnum+0x2a>
     869:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     86c:	72 4b                	jb     8b9 <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     86e:	8b 45 1c             	mov    0x1c(%ebp),%eax
     871:	8d 58 ff             	lea    -0x1(%eax),%ebx
     874:	8b 45 18             	mov    0x18(%ebp),%eax
     877:	ba 00 00 00 00       	mov    $0x0,%edx
     87c:	52                   	push   %edx
     87d:	50                   	push   %eax
     87e:	ff 75 f4             	pushl  -0xc(%ebp)
     881:	ff 75 f0             	pushl  -0x10(%ebp)
     884:	e8 a7 05 00 00       	call   e30 <__udivdi3>
     889:	83 c4 10             	add    $0x10,%esp
     88c:	83 ec 04             	sub    $0x4,%esp
     88f:	ff 75 20             	pushl  0x20(%ebp)
     892:	53                   	push   %ebx
     893:	ff 75 18             	pushl  0x18(%ebp)
     896:	52                   	push   %edx
     897:	50                   	push   %eax
     898:	ff 75 0c             	pushl  0xc(%ebp)
     89b:	ff 75 08             	pushl  0x8(%ebp)
     89e:	e8 a1 ff ff ff       	call   844 <printnum>
     8a3:	83 c4 20             	add    $0x20,%esp
     8a6:	eb 1b                	jmp    8c3 <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     8a8:	83 ec 08             	sub    $0x8,%esp
     8ab:	ff 75 0c             	pushl  0xc(%ebp)
     8ae:	ff 75 20             	pushl  0x20(%ebp)
     8b1:	8b 45 08             	mov    0x8(%ebp),%eax
     8b4:	ff d0                	call   *%eax
     8b6:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     8b9:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     8bd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     8c1:	7f e5                	jg     8a8 <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     8c3:	8b 4d 18             	mov    0x18(%ebp),%ecx
     8c6:	bb 00 00 00 00       	mov    $0x0,%ebx
     8cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8d1:	53                   	push   %ebx
     8d2:	51                   	push   %ecx
     8d3:	52                   	push   %edx
     8d4:	50                   	push   %eax
     8d5:	e8 76 06 00 00       	call   f50 <__umoddi3>
     8da:	83 c4 10             	add    $0x10,%esp
     8dd:	05 80 11 00 00       	add    $0x1180,%eax
     8e2:	0f b6 00             	movzbl (%eax),%eax
     8e5:	0f be c0             	movsbl %al,%eax
     8e8:	83 ec 08             	sub    $0x8,%esp
     8eb:	ff 75 0c             	pushl  0xc(%ebp)
     8ee:	50                   	push   %eax
     8ef:	8b 45 08             	mov    0x8(%ebp),%eax
     8f2:	ff d0                	call   *%eax
     8f4:	83 c4 10             	add    $0x10,%esp
}
     8f7:	90                   	nop
     8f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8fb:	c9                   	leave  
     8fc:	c3                   	ret    

000008fd <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     8fd:	55                   	push   %ebp
     8fe:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     900:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     904:	7e 14                	jle    91a <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     906:	8b 45 08             	mov    0x8(%ebp),%eax
     909:	8b 00                	mov    (%eax),%eax
     90b:	8d 48 08             	lea    0x8(%eax),%ecx
     90e:	8b 55 08             	mov    0x8(%ebp),%edx
     911:	89 0a                	mov    %ecx,(%edx)
     913:	8b 50 04             	mov    0x4(%eax),%edx
     916:	8b 00                	mov    (%eax),%eax
     918:	eb 30                	jmp    94a <getuint+0x4d>
  else if (lflag)
     91a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     91e:	74 16                	je     936 <getuint+0x39>
    return va_arg(*ap, unsigned long);
     920:	8b 45 08             	mov    0x8(%ebp),%eax
     923:	8b 00                	mov    (%eax),%eax
     925:	8d 48 04             	lea    0x4(%eax),%ecx
     928:	8b 55 08             	mov    0x8(%ebp),%edx
     92b:	89 0a                	mov    %ecx,(%edx)
     92d:	8b 00                	mov    (%eax),%eax
     92f:	ba 00 00 00 00       	mov    $0x0,%edx
     934:	eb 14                	jmp    94a <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     936:	8b 45 08             	mov    0x8(%ebp),%eax
     939:	8b 00                	mov    (%eax),%eax
     93b:	8d 48 04             	lea    0x4(%eax),%ecx
     93e:	8b 55 08             	mov    0x8(%ebp),%edx
     941:	89 0a                	mov    %ecx,(%edx)
     943:	8b 00                	mov    (%eax),%eax
     945:	ba 00 00 00 00       	mov    $0x0,%edx
}
     94a:	5d                   	pop    %ebp
     94b:	c3                   	ret    

0000094c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     94c:	55                   	push   %ebp
     94d:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     94f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     953:	7e 14                	jle    969 <getint+0x1d>
    return va_arg(*ap, long long);
     955:	8b 45 08             	mov    0x8(%ebp),%eax
     958:	8b 00                	mov    (%eax),%eax
     95a:	8d 48 08             	lea    0x8(%eax),%ecx
     95d:	8b 55 08             	mov    0x8(%ebp),%edx
     960:	89 0a                	mov    %ecx,(%edx)
     962:	8b 50 04             	mov    0x4(%eax),%edx
     965:	8b 00                	mov    (%eax),%eax
     967:	eb 28                	jmp    991 <getint+0x45>
  else if (lflag)
     969:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     96d:	74 12                	je     981 <getint+0x35>
    return va_arg(*ap, long);
     96f:	8b 45 08             	mov    0x8(%ebp),%eax
     972:	8b 00                	mov    (%eax),%eax
     974:	8d 48 04             	lea    0x4(%eax),%ecx
     977:	8b 55 08             	mov    0x8(%ebp),%edx
     97a:	89 0a                	mov    %ecx,(%edx)
     97c:	8b 00                	mov    (%eax),%eax
     97e:	99                   	cltd   
     97f:	eb 10                	jmp    991 <getint+0x45>
  else
    return va_arg(*ap, int);
     981:	8b 45 08             	mov    0x8(%ebp),%eax
     984:	8b 00                	mov    (%eax),%eax
     986:	8d 48 04             	lea    0x4(%eax),%ecx
     989:	8b 55 08             	mov    0x8(%ebp),%edx
     98c:	89 0a                	mov    %ecx,(%edx)
     98e:	8b 00                	mov    (%eax),%eax
     990:	99                   	cltd   
}
     991:	5d                   	pop    %ebp
     992:	c3                   	ret    

00000993 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     993:	55                   	push   %ebp
     994:	89 e5                	mov    %esp,%ebp
     996:	56                   	push   %esi
     997:	53                   	push   %ebx
     998:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     99b:	eb 17                	jmp    9b4 <vprintfmt+0x21>
      if (ch == '\0')
     99d:	85 db                	test   %ebx,%ebx
     99f:	0f 84 a0 03 00 00    	je     d45 <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     9a5:	83 ec 08             	sub    $0x8,%esp
     9a8:	ff 75 0c             	pushl  0xc(%ebp)
     9ab:	53                   	push   %ebx
     9ac:	8b 45 08             	mov    0x8(%ebp),%eax
     9af:	ff d0                	call   *%eax
     9b1:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     9b4:	8b 45 10             	mov    0x10(%ebp),%eax
     9b7:	8d 50 01             	lea    0x1(%eax),%edx
     9ba:	89 55 10             	mov    %edx,0x10(%ebp)
     9bd:	0f b6 00             	movzbl (%eax),%eax
     9c0:	0f b6 d8             	movzbl %al,%ebx
     9c3:	83 fb 25             	cmp    $0x25,%ebx
     9c6:	75 d5                	jne    99d <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     9c8:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     9cc:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     9d3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     9da:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     9e1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     9e8:	8b 45 10             	mov    0x10(%ebp),%eax
     9eb:	8d 50 01             	lea    0x1(%eax),%edx
     9ee:	89 55 10             	mov    %edx,0x10(%ebp)
     9f1:	0f b6 00             	movzbl (%eax),%eax
     9f4:	0f b6 d8             	movzbl %al,%ebx
     9f7:	8d 43 dd             	lea    -0x23(%ebx),%eax
     9fa:	83 f8 55             	cmp    $0x55,%eax
     9fd:	0f 87 15 03 00 00    	ja     d18 <vprintfmt+0x385>
     a03:	8b 04 85 a4 11 00 00 	mov    0x11a4(,%eax,4),%eax
     a0a:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     a0c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     a10:	eb d6                	jmp    9e8 <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     a12:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     a16:	eb d0                	jmp    9e8 <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     a18:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     a1f:	8b 55 e0             	mov    -0x20(%ebp),%edx
     a22:	89 d0                	mov    %edx,%eax
     a24:	c1 e0 02             	shl    $0x2,%eax
     a27:	01 d0                	add    %edx,%eax
     a29:	01 c0                	add    %eax,%eax
     a2b:	01 d8                	add    %ebx,%eax
     a2d:	83 e8 30             	sub    $0x30,%eax
     a30:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     a33:	8b 45 10             	mov    0x10(%ebp),%eax
     a36:	0f b6 00             	movzbl (%eax),%eax
     a39:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     a3c:	83 fb 2f             	cmp    $0x2f,%ebx
     a3f:	7e 39                	jle    a7a <vprintfmt+0xe7>
     a41:	83 fb 39             	cmp    $0x39,%ebx
     a44:	7f 34                	jg     a7a <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     a46:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     a4a:	eb d3                	jmp    a1f <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     a4c:	8b 45 14             	mov    0x14(%ebp),%eax
     a4f:	8d 50 04             	lea    0x4(%eax),%edx
     a52:	89 55 14             	mov    %edx,0x14(%ebp)
     a55:	8b 00                	mov    (%eax),%eax
     a57:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     a5a:	eb 1f                	jmp    a7b <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     a5c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a60:	79 86                	jns    9e8 <vprintfmt+0x55>
        width = 0;
     a62:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     a69:	e9 7a ff ff ff       	jmp    9e8 <vprintfmt+0x55>

    case '#':
      altflag = 1;
     a6e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     a75:	e9 6e ff ff ff       	jmp    9e8 <vprintfmt+0x55>
      goto process_precision;
     a7a:	90                   	nop

process_precision:
      if (width < 0)
     a7b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a7f:	0f 89 63 ff ff ff    	jns    9e8 <vprintfmt+0x55>
        width = precision, precision = -1;
     a85:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a88:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a8b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     a92:	e9 51 ff ff ff       	jmp    9e8 <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     a97:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     a9b:	e9 48 ff ff ff       	jmp    9e8 <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     aa0:	8b 45 14             	mov    0x14(%ebp),%eax
     aa3:	8d 50 04             	lea    0x4(%eax),%edx
     aa6:	89 55 14             	mov    %edx,0x14(%ebp)
     aa9:	8b 00                	mov    (%eax),%eax
     aab:	83 ec 08             	sub    $0x8,%esp
     aae:	ff 75 0c             	pushl  0xc(%ebp)
     ab1:	50                   	push   %eax
     ab2:	8b 45 08             	mov    0x8(%ebp),%eax
     ab5:	ff d0                	call   *%eax
     ab7:	83 c4 10             	add    $0x10,%esp
      break;
     aba:	e9 81 02 00 00       	jmp    d40 <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     abf:	8b 45 14             	mov    0x14(%ebp),%eax
     ac2:	8d 50 04             	lea    0x4(%eax),%edx
     ac5:	89 55 14             	mov    %edx,0x14(%ebp)
     ac8:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     aca:	85 db                	test   %ebx,%ebx
     acc:	79 02                	jns    ad0 <vprintfmt+0x13d>
        err = -err;
     ace:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     ad0:	83 fb 0f             	cmp    $0xf,%ebx
     ad3:	7f 0b                	jg     ae0 <vprintfmt+0x14d>
     ad5:	8b 34 9d 40 11 00 00 	mov    0x1140(,%ebx,4),%esi
     adc:	85 f6                	test   %esi,%esi
     ade:	75 19                	jne    af9 <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     ae0:	53                   	push   %ebx
     ae1:	68 91 11 00 00       	push   $0x1191
     ae6:	ff 75 0c             	pushl  0xc(%ebp)
     ae9:	ff 75 08             	pushl  0x8(%ebp)
     aec:	e8 5c 02 00 00       	call   d4d <printfmt>
     af1:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     af4:	e9 47 02 00 00       	jmp    d40 <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     af9:	56                   	push   %esi
     afa:	68 9a 11 00 00       	push   $0x119a
     aff:	ff 75 0c             	pushl  0xc(%ebp)
     b02:	ff 75 08             	pushl  0x8(%ebp)
     b05:	e8 43 02 00 00       	call   d4d <printfmt>
     b0a:	83 c4 10             	add    $0x10,%esp
      break;
     b0d:	e9 2e 02 00 00       	jmp    d40 <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     b12:	8b 45 14             	mov    0x14(%ebp),%eax
     b15:	8d 50 04             	lea    0x4(%eax),%edx
     b18:	89 55 14             	mov    %edx,0x14(%ebp)
     b1b:	8b 30                	mov    (%eax),%esi
     b1d:	85 f6                	test   %esi,%esi
     b1f:	75 05                	jne    b26 <vprintfmt+0x193>
        p = "(null)";
     b21:	be 9d 11 00 00       	mov    $0x119d,%esi
      if (width > 0 && padc != '-')
     b26:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b2a:	7e 6f                	jle    b9b <vprintfmt+0x208>
     b2c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     b30:	74 69                	je     b9b <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     b32:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b35:	83 ec 08             	sub    $0x8,%esp
     b38:	50                   	push   %eax
     b39:	56                   	push   %esi
     b3a:	e8 f1 f5 ff ff       	call   130 <strnlen>
     b3f:	83 c4 10             	add    $0x10,%esp
     b42:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     b45:	eb 17                	jmp    b5e <vprintfmt+0x1cb>
          putch(padc, putdat);
     b47:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     b4b:	83 ec 08             	sub    $0x8,%esp
     b4e:	ff 75 0c             	pushl  0xc(%ebp)
     b51:	50                   	push   %eax
     b52:	8b 45 08             	mov    0x8(%ebp),%eax
     b55:	ff d0                	call   *%eax
     b57:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     b5a:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b5e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b62:	7f e3                	jg     b47 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b64:	eb 35                	jmp    b9b <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     b66:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     b6a:	74 1c                	je     b88 <vprintfmt+0x1f5>
     b6c:	83 fb 1f             	cmp    $0x1f,%ebx
     b6f:	7e 05                	jle    b76 <vprintfmt+0x1e3>
     b71:	83 fb 7e             	cmp    $0x7e,%ebx
     b74:	7e 12                	jle    b88 <vprintfmt+0x1f5>
          putch('?', putdat);
     b76:	83 ec 08             	sub    $0x8,%esp
     b79:	ff 75 0c             	pushl  0xc(%ebp)
     b7c:	6a 3f                	push   $0x3f
     b7e:	8b 45 08             	mov    0x8(%ebp),%eax
     b81:	ff d0                	call   *%eax
     b83:	83 c4 10             	add    $0x10,%esp
     b86:	eb 0f                	jmp    b97 <vprintfmt+0x204>
        else
          putch(ch, putdat);
     b88:	83 ec 08             	sub    $0x8,%esp
     b8b:	ff 75 0c             	pushl  0xc(%ebp)
     b8e:	53                   	push   %ebx
     b8f:	8b 45 08             	mov    0x8(%ebp),%eax
     b92:	ff d0                	call   *%eax
     b94:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b97:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b9b:	89 f0                	mov    %esi,%eax
     b9d:	8d 70 01             	lea    0x1(%eax),%esi
     ba0:	0f b6 00             	movzbl (%eax),%eax
     ba3:	0f be d8             	movsbl %al,%ebx
     ba6:	85 db                	test   %ebx,%ebx
     ba8:	74 26                	je     bd0 <vprintfmt+0x23d>
     baa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     bae:	78 b6                	js     b66 <vprintfmt+0x1d3>
     bb0:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     bb4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     bb8:	79 ac                	jns    b66 <vprintfmt+0x1d3>
      for (; width > 0; width--)
     bba:	eb 14                	jmp    bd0 <vprintfmt+0x23d>
        putch(' ', putdat);
     bbc:	83 ec 08             	sub    $0x8,%esp
     bbf:	ff 75 0c             	pushl  0xc(%ebp)
     bc2:	6a 20                	push   $0x20
     bc4:	8b 45 08             	mov    0x8(%ebp),%eax
     bc7:	ff d0                	call   *%eax
     bc9:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     bcc:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     bd0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bd4:	7f e6                	jg     bbc <vprintfmt+0x229>
      break;
     bd6:	e9 65 01 00 00       	jmp    d40 <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     bdb:	83 ec 08             	sub    $0x8,%esp
     bde:	ff 75 e8             	pushl  -0x18(%ebp)
     be1:	8d 45 14             	lea    0x14(%ebp),%eax
     be4:	50                   	push   %eax
     be5:	e8 62 fd ff ff       	call   94c <getint>
     bea:	83 c4 10             	add    $0x10,%esp
     bed:	89 45 f0             	mov    %eax,-0x10(%ebp)
     bf0:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     bf3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bf6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bf9:	85 d2                	test   %edx,%edx
     bfb:	79 23                	jns    c20 <vprintfmt+0x28d>
        putch('-', putdat);
     bfd:	83 ec 08             	sub    $0x8,%esp
     c00:	ff 75 0c             	pushl  0xc(%ebp)
     c03:	6a 2d                	push   $0x2d
     c05:	8b 45 08             	mov    0x8(%ebp),%eax
     c08:	ff d0                	call   *%eax
     c0a:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     c0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c10:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c13:	f7 d8                	neg    %eax
     c15:	83 d2 00             	adc    $0x0,%edx
     c18:	f7 da                	neg    %edx
     c1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c1d:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     c20:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c27:	e9 b6 00 00 00       	jmp    ce2 <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     c2c:	83 ec 08             	sub    $0x8,%esp
     c2f:	ff 75 e8             	pushl  -0x18(%ebp)
     c32:	8d 45 14             	lea    0x14(%ebp),%eax
     c35:	50                   	push   %eax
     c36:	e8 c2 fc ff ff       	call   8fd <getuint>
     c3b:	83 c4 10             	add    $0x10,%esp
     c3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c41:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     c44:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c4b:	e9 92 00 00 00       	jmp    ce2 <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     c50:	83 ec 08             	sub    $0x8,%esp
     c53:	ff 75 0c             	pushl  0xc(%ebp)
     c56:	6a 58                	push   $0x58
     c58:	8b 45 08             	mov    0x8(%ebp),%eax
     c5b:	ff d0                	call   *%eax
     c5d:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c60:	83 ec 08             	sub    $0x8,%esp
     c63:	ff 75 0c             	pushl  0xc(%ebp)
     c66:	6a 58                	push   $0x58
     c68:	8b 45 08             	mov    0x8(%ebp),%eax
     c6b:	ff d0                	call   *%eax
     c6d:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c70:	83 ec 08             	sub    $0x8,%esp
     c73:	ff 75 0c             	pushl  0xc(%ebp)
     c76:	6a 58                	push   $0x58
     c78:	8b 45 08             	mov    0x8(%ebp),%eax
     c7b:	ff d0                	call   *%eax
     c7d:	83 c4 10             	add    $0x10,%esp
      break;
     c80:	e9 bb 00 00 00       	jmp    d40 <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     c85:	83 ec 08             	sub    $0x8,%esp
     c88:	ff 75 0c             	pushl  0xc(%ebp)
     c8b:	6a 30                	push   $0x30
     c8d:	8b 45 08             	mov    0x8(%ebp),%eax
     c90:	ff d0                	call   *%eax
     c92:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     c95:	83 ec 08             	sub    $0x8,%esp
     c98:	ff 75 0c             	pushl  0xc(%ebp)
     c9b:	6a 78                	push   $0x78
     c9d:	8b 45 08             	mov    0x8(%ebp),%eax
     ca0:	ff d0                	call   *%eax
     ca2:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     ca5:	8b 45 14             	mov    0x14(%ebp),%eax
     ca8:	8d 50 04             	lea    0x4(%eax),%edx
     cab:	89 55 14             	mov    %edx,0x14(%ebp)
     cae:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     cb0:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cb3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     cba:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     cc1:	eb 1f                	jmp    ce2 <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     cc3:	83 ec 08             	sub    $0x8,%esp
     cc6:	ff 75 e8             	pushl  -0x18(%ebp)
     cc9:	8d 45 14             	lea    0x14(%ebp),%eax
     ccc:	50                   	push   %eax
     ccd:	e8 2b fc ff ff       	call   8fd <getuint>
     cd2:	83 c4 10             	add    $0x10,%esp
     cd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cd8:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     cdb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     ce2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     ce6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     ce9:	83 ec 04             	sub    $0x4,%esp
     cec:	52                   	push   %edx
     ced:	ff 75 e4             	pushl  -0x1c(%ebp)
     cf0:	50                   	push   %eax
     cf1:	ff 75 f4             	pushl  -0xc(%ebp)
     cf4:	ff 75 f0             	pushl  -0x10(%ebp)
     cf7:	ff 75 0c             	pushl  0xc(%ebp)
     cfa:	ff 75 08             	pushl  0x8(%ebp)
     cfd:	e8 42 fb ff ff       	call   844 <printnum>
     d02:	83 c4 20             	add    $0x20,%esp
      break;
     d05:	eb 39                	jmp    d40 <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     d07:	83 ec 08             	sub    $0x8,%esp
     d0a:	ff 75 0c             	pushl  0xc(%ebp)
     d0d:	53                   	push   %ebx
     d0e:	8b 45 08             	mov    0x8(%ebp),%eax
     d11:	ff d0                	call   *%eax
     d13:	83 c4 10             	add    $0x10,%esp
      break;
     d16:	eb 28                	jmp    d40 <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     d18:	83 ec 08             	sub    $0x8,%esp
     d1b:	ff 75 0c             	pushl  0xc(%ebp)
     d1e:	6a 25                	push   $0x25
     d20:	8b 45 08             	mov    0x8(%ebp),%eax
     d23:	ff d0                	call   *%eax
     d25:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     d28:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d2c:	eb 04                	jmp    d32 <vprintfmt+0x39f>
     d2e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d32:	8b 45 10             	mov    0x10(%ebp),%eax
     d35:	83 e8 01             	sub    $0x1,%eax
     d38:	0f b6 00             	movzbl (%eax),%eax
     d3b:	3c 25                	cmp    $0x25,%al
     d3d:	75 ef                	jne    d2e <vprintfmt+0x39b>
        /* do nothing */;
      break;
     d3f:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     d40:	e9 6f fc ff ff       	jmp    9b4 <vprintfmt+0x21>
        return;
     d45:	90                   	nop
    }
  }
}
     d46:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d49:	5b                   	pop    %ebx
     d4a:	5e                   	pop    %esi
     d4b:	5d                   	pop    %ebp
     d4c:	c3                   	ret    

00000d4d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     d4d:	55                   	push   %ebp
     d4e:	89 e5                	mov    %esp,%ebp
     d50:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     d53:	8d 45 14             	lea    0x14(%ebp),%eax
     d56:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     d59:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d5c:	50                   	push   %eax
     d5d:	ff 75 10             	pushl  0x10(%ebp)
     d60:	ff 75 0c             	pushl  0xc(%ebp)
     d63:	ff 75 08             	pushl  0x8(%ebp)
     d66:	e8 28 fc ff ff       	call   993 <vprintfmt>
     d6b:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     d6e:	90                   	nop
     d6f:	c9                   	leave  
     d70:	c3                   	ret    

00000d71 <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     d71:	55                   	push   %ebp
     d72:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     d74:	8b 45 0c             	mov    0xc(%ebp),%eax
     d77:	8b 40 08             	mov    0x8(%eax),%eax
     d7a:	8d 50 01             	lea    0x1(%eax),%edx
     d7d:	8b 45 0c             	mov    0xc(%ebp),%eax
     d80:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     d83:	8b 45 0c             	mov    0xc(%ebp),%eax
     d86:	8b 10                	mov    (%eax),%edx
     d88:	8b 45 0c             	mov    0xc(%ebp),%eax
     d8b:	8b 40 04             	mov    0x4(%eax),%eax
     d8e:	39 c2                	cmp    %eax,%edx
     d90:	73 12                	jae    da4 <sprintputch+0x33>
    *b->buf++ = ch;
     d92:	8b 45 0c             	mov    0xc(%ebp),%eax
     d95:	8b 00                	mov    (%eax),%eax
     d97:	8d 48 01             	lea    0x1(%eax),%ecx
     d9a:	8b 55 0c             	mov    0xc(%ebp),%edx
     d9d:	89 0a                	mov    %ecx,(%edx)
     d9f:	8b 55 08             	mov    0x8(%ebp),%edx
     da2:	88 10                	mov    %dl,(%eax)
}
     da4:	90                   	nop
     da5:	5d                   	pop    %ebp
     da6:	c3                   	ret    

00000da7 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     da7:	55                   	push   %ebp
     da8:	89 e5                	mov    %esp,%ebp
     daa:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     dad:	8b 45 08             	mov    0x8(%ebp),%eax
     db0:	89 45 ec             	mov    %eax,-0x14(%ebp)
     db3:	8b 45 0c             	mov    0xc(%ebp),%eax
     db6:	8d 50 ff             	lea    -0x1(%eax),%edx
     db9:	8b 45 08             	mov    0x8(%ebp),%eax
     dbc:	01 d0                	add    %edx,%eax
     dbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
     dc1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     dc8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     dcc:	74 06                	je     dd4 <vsnprintf+0x2d>
     dce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dd2:	7f 07                	jg     ddb <vsnprintf+0x34>
    return -E_INVAL;
     dd4:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     dd9:	eb 20                	jmp    dfb <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     ddb:	ff 75 14             	pushl  0x14(%ebp)
     dde:	ff 75 10             	pushl  0x10(%ebp)
     de1:	8d 45 ec             	lea    -0x14(%ebp),%eax
     de4:	50                   	push   %eax
     de5:	68 71 0d 00 00       	push   $0xd71
     dea:	e8 a4 fb ff ff       	call   993 <vprintfmt>
     def:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     df2:	8b 45 ec             	mov    -0x14(%ebp),%eax
     df5:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     df8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     dfb:	c9                   	leave  
     dfc:	c3                   	ret    

00000dfd <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     dfd:	55                   	push   %ebp
     dfe:	89 e5                	mov    %esp,%ebp
     e00:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     e03:	8d 45 14             	lea    0x14(%ebp),%eax
     e06:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     e09:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e0c:	50                   	push   %eax
     e0d:	ff 75 10             	pushl  0x10(%ebp)
     e10:	ff 75 0c             	pushl  0xc(%ebp)
     e13:	ff 75 08             	pushl  0x8(%ebp)
     e16:	e8 8c ff ff ff       	call   da7 <vsnprintf>
     e1b:	83 c4 10             	add    $0x10,%esp
     e1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     e21:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e24:	c9                   	leave  
     e25:	c3                   	ret    
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
