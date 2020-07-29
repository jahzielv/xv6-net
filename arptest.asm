
_arptest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(void) {
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 14             	sub    $0x14,%esp
  int MAC_SIZE = 18;
      11:	c7 45 f4 12 00 00 00 	movl   $0x12,-0xc(%ebp)
  char* ip = "192.168.2.1";
      18:	c7 45 f0 80 10 00 00 	movl   $0x1080,-0x10(%ebp)
  char* mac = malloc(MAC_SIZE);
      1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      22:	83 ec 0c             	sub    $0xc,%esp
      25:	50                   	push   %eax
      26:	e8 3c 07 00 00       	call   767 <malloc>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(arp("mynet0", ip, mac, MAC_SIZE) < 0) {
      31:	ff 75 f4             	pushl  -0xc(%ebp)
      34:	ff 75 ec             	pushl  -0x14(%ebp)
      37:	ff 75 f0             	pushl  -0x10(%ebp)
      3a:	68 8c 10 00 00       	push   $0x108c
      3f:	e8 65 03 00 00       	call   3a9 <arp>
      44:	83 c4 10             	add    $0x10,%esp
      47:	85 c0                	test   %eax,%eax
      49:	79 15                	jns    60 <main+0x60>
    printf(1, "ARP for IP:%s Failed.\n", ip);
      4b:	83 ec 04             	sub    $0x4,%esp
      4e:	ff 75 f0             	pushl  -0x10(%ebp)
      51:	68 93 10 00 00       	push   $0x1093
      56:	6a 01                	push   $0x1
      58:	e8 37 04 00 00       	call   494 <printf>
      5d:	83 c4 10             	add    $0x10,%esp
  }
  printf(1, "IP %s has mac %s\n", ip, mac);
      60:	ff 75 ec             	pushl  -0x14(%ebp)
      63:	ff 75 f0             	pushl  -0x10(%ebp)
      66:	68 aa 10 00 00       	push   $0x10aa
      6b:	6a 01                	push   $0x1
      6d:	e8 22 04 00 00       	call   494 <printf>
      72:	83 c4 10             	add    $0x10,%esp
  exit();
      75:	e8 87 02 00 00       	call   301 <exit>

0000007a <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
      7a:	55                   	push   %ebp
      7b:	89 e5                	mov    %esp,%ebp
      7d:	57                   	push   %edi
      7e:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
      82:	8b 55 10             	mov    0x10(%ebp),%edx
      85:	8b 45 0c             	mov    0xc(%ebp),%eax
      88:	89 cb                	mov    %ecx,%ebx
      8a:	89 df                	mov    %ebx,%edi
      8c:	89 d1                	mov    %edx,%ecx
      8e:	fc                   	cld    
      8f:	f3 aa                	rep stos %al,%es:(%edi)
      91:	89 ca                	mov    %ecx,%edx
      93:	89 fb                	mov    %edi,%ebx
      95:	89 5d 08             	mov    %ebx,0x8(%ebp)
      98:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      9b:	90                   	nop
      9c:	5b                   	pop    %ebx
      9d:	5f                   	pop    %edi
      9e:	5d                   	pop    %ebp
      9f:	c3                   	ret    

000000a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      a0:	55                   	push   %ebp
      a1:	89 e5                	mov    %esp,%ebp
      a3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      a6:	8b 45 08             	mov    0x8(%ebp),%eax
      a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      ac:	90                   	nop
      ad:	8b 55 0c             	mov    0xc(%ebp),%edx
      b0:	8d 42 01             	lea    0x1(%edx),%eax
      b3:	89 45 0c             	mov    %eax,0xc(%ebp)
      b6:	8b 45 08             	mov    0x8(%ebp),%eax
      b9:	8d 48 01             	lea    0x1(%eax),%ecx
      bc:	89 4d 08             	mov    %ecx,0x8(%ebp)
      bf:	0f b6 12             	movzbl (%edx),%edx
      c2:	88 10                	mov    %dl,(%eax)
      c4:	0f b6 00             	movzbl (%eax),%eax
      c7:	84 c0                	test   %al,%al
      c9:	75 e2                	jne    ad <strcpy+0xd>
    ;
  return os;
      cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      ce:	c9                   	leave  
      cf:	c3                   	ret    

000000d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      d0:	55                   	push   %ebp
      d1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      d3:	eb 08                	jmp    dd <strcmp+0xd>
    p++, q++;
      d5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      d9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
      dd:	8b 45 08             	mov    0x8(%ebp),%eax
      e0:	0f b6 00             	movzbl (%eax),%eax
      e3:	84 c0                	test   %al,%al
      e5:	74 10                	je     f7 <strcmp+0x27>
      e7:	8b 45 08             	mov    0x8(%ebp),%eax
      ea:	0f b6 10             	movzbl (%eax),%edx
      ed:	8b 45 0c             	mov    0xc(%ebp),%eax
      f0:	0f b6 00             	movzbl (%eax),%eax
      f3:	38 c2                	cmp    %al,%dl
      f5:	74 de                	je     d5 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
      f7:	8b 45 08             	mov    0x8(%ebp),%eax
      fa:	0f b6 00             	movzbl (%eax),%eax
      fd:	0f b6 d0             	movzbl %al,%edx
     100:	8b 45 0c             	mov    0xc(%ebp),%eax
     103:	0f b6 00             	movzbl (%eax),%eax
     106:	0f b6 c0             	movzbl %al,%eax
     109:	29 c2                	sub    %eax,%edx
     10b:	89 d0                	mov    %edx,%eax
}
     10d:	5d                   	pop    %ebp
     10e:	c3                   	ret    

0000010f <strlen>:

uint
strlen(char *s)
{
     10f:	55                   	push   %ebp
     110:	89 e5                	mov    %esp,%ebp
     112:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     115:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     11c:	eb 04                	jmp    122 <strlen+0x13>
     11e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     122:	8b 55 fc             	mov    -0x4(%ebp),%edx
     125:	8b 45 08             	mov    0x8(%ebp),%eax
     128:	01 d0                	add    %edx,%eax
     12a:	0f b6 00             	movzbl (%eax),%eax
     12d:	84 c0                	test   %al,%al
     12f:	75 ed                	jne    11e <strlen+0xf>
    ;
  return n;
     131:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     134:	c9                   	leave  
     135:	c3                   	ret    

00000136 <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     136:	55                   	push   %ebp
     137:	89 e5                	mov    %esp,%ebp
     139:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     13c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     143:	eb 0c                	jmp    151 <strnlen+0x1b>
     n++; 
     145:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     149:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     14d:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     151:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     155:	74 0a                	je     161 <strnlen+0x2b>
     157:	8b 45 08             	mov    0x8(%ebp),%eax
     15a:	0f b6 00             	movzbl (%eax),%eax
     15d:	84 c0                	test   %al,%al
     15f:	75 e4                	jne    145 <strnlen+0xf>
   return n; 
     161:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     164:	c9                   	leave  
     165:	c3                   	ret    

00000166 <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     166:	55                   	push   %ebp
     167:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     169:	8b 45 10             	mov    0x10(%ebp),%eax
     16c:	50                   	push   %eax
     16d:	ff 75 0c             	pushl  0xc(%ebp)
     170:	ff 75 08             	pushl  0x8(%ebp)
     173:	e8 02 ff ff ff       	call   7a <stosb>
     178:	83 c4 0c             	add    $0xc,%esp
  return dst;
     17b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     17e:	c9                   	leave  
     17f:	c3                   	ret    

00000180 <strchr>:

char*
strchr(const char *s, char c)
{
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	83 ec 04             	sub    $0x4,%esp
     186:	8b 45 0c             	mov    0xc(%ebp),%eax
     189:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     18c:	eb 14                	jmp    1a2 <strchr+0x22>
    if(*s == c)
     18e:	8b 45 08             	mov    0x8(%ebp),%eax
     191:	0f b6 00             	movzbl (%eax),%eax
     194:	38 45 fc             	cmp    %al,-0x4(%ebp)
     197:	75 05                	jne    19e <strchr+0x1e>
      return (char*)s;
     199:	8b 45 08             	mov    0x8(%ebp),%eax
     19c:	eb 13                	jmp    1b1 <strchr+0x31>
  for(; *s; s++)
     19e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1a2:	8b 45 08             	mov    0x8(%ebp),%eax
     1a5:	0f b6 00             	movzbl (%eax),%eax
     1a8:	84 c0                	test   %al,%al
     1aa:	75 e2                	jne    18e <strchr+0xe>
  return 0;
     1ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
     1b1:	c9                   	leave  
     1b2:	c3                   	ret    

000001b3 <gets>:

char*
gets(char *buf, int max)
{
     1b3:	55                   	push   %ebp
     1b4:	89 e5                	mov    %esp,%ebp
     1b6:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     1b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     1c0:	eb 42                	jmp    204 <gets+0x51>
    cc = read(0, &c, 1);
     1c2:	83 ec 04             	sub    $0x4,%esp
     1c5:	6a 01                	push   $0x1
     1c7:	8d 45 ef             	lea    -0x11(%ebp),%eax
     1ca:	50                   	push   %eax
     1cb:	6a 00                	push   $0x0
     1cd:	e8 47 01 00 00       	call   319 <read>
     1d2:	83 c4 10             	add    $0x10,%esp
     1d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1dc:	7e 33                	jle    211 <gets+0x5e>
      break;
    buf[i++] = c;
     1de:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1e1:	8d 50 01             	lea    0x1(%eax),%edx
     1e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1e7:	89 c2                	mov    %eax,%edx
     1e9:	8b 45 08             	mov    0x8(%ebp),%eax
     1ec:	01 c2                	add    %eax,%edx
     1ee:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1f2:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1f4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1f8:	3c 0a                	cmp    $0xa,%al
     1fa:	74 16                	je     212 <gets+0x5f>
     1fc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     200:	3c 0d                	cmp    $0xd,%al
     202:	74 0e                	je     212 <gets+0x5f>
  for(i=0; i+1 < max; ){
     204:	8b 45 f4             	mov    -0xc(%ebp),%eax
     207:	83 c0 01             	add    $0x1,%eax
     20a:	39 45 0c             	cmp    %eax,0xc(%ebp)
     20d:	7f b3                	jg     1c2 <gets+0xf>
     20f:	eb 01                	jmp    212 <gets+0x5f>
      break;
     211:	90                   	nop
      break;
  }
  buf[i] = '\0';
     212:	8b 55 f4             	mov    -0xc(%ebp),%edx
     215:	8b 45 08             	mov    0x8(%ebp),%eax
     218:	01 d0                	add    %edx,%eax
     21a:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     21d:	8b 45 08             	mov    0x8(%ebp),%eax
}
     220:	c9                   	leave  
     221:	c3                   	ret    

00000222 <stat>:

int
stat(char *n, struct stat *st)
{
     222:	55                   	push   %ebp
     223:	89 e5                	mov    %esp,%ebp
     225:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     228:	83 ec 08             	sub    $0x8,%esp
     22b:	6a 00                	push   $0x0
     22d:	ff 75 08             	pushl  0x8(%ebp)
     230:	e8 0c 01 00 00       	call   341 <open>
     235:	83 c4 10             	add    $0x10,%esp
     238:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     23b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     23f:	79 07                	jns    248 <stat+0x26>
    return -1;
     241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     246:	eb 25                	jmp    26d <stat+0x4b>
  r = fstat(fd, st);
     248:	83 ec 08             	sub    $0x8,%esp
     24b:	ff 75 0c             	pushl  0xc(%ebp)
     24e:	ff 75 f4             	pushl  -0xc(%ebp)
     251:	e8 03 01 00 00       	call   359 <fstat>
     256:	83 c4 10             	add    $0x10,%esp
     259:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     25c:	83 ec 0c             	sub    $0xc,%esp
     25f:	ff 75 f4             	pushl  -0xc(%ebp)
     262:	e8 c2 00 00 00       	call   329 <close>
     267:	83 c4 10             	add    $0x10,%esp
  return r;
     26a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     26d:	c9                   	leave  
     26e:	c3                   	ret    

0000026f <atoi>:

int
atoi(const char *s)
{
     26f:	55                   	push   %ebp
     270:	89 e5                	mov    %esp,%ebp
     272:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     275:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     27c:	eb 25                	jmp    2a3 <atoi+0x34>
    n = n*10 + *s++ - '0';
     27e:	8b 55 fc             	mov    -0x4(%ebp),%edx
     281:	89 d0                	mov    %edx,%eax
     283:	c1 e0 02             	shl    $0x2,%eax
     286:	01 d0                	add    %edx,%eax
     288:	01 c0                	add    %eax,%eax
     28a:	89 c1                	mov    %eax,%ecx
     28c:	8b 45 08             	mov    0x8(%ebp),%eax
     28f:	8d 50 01             	lea    0x1(%eax),%edx
     292:	89 55 08             	mov    %edx,0x8(%ebp)
     295:	0f b6 00             	movzbl (%eax),%eax
     298:	0f be c0             	movsbl %al,%eax
     29b:	01 c8                	add    %ecx,%eax
     29d:	83 e8 30             	sub    $0x30,%eax
     2a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2a3:	8b 45 08             	mov    0x8(%ebp),%eax
     2a6:	0f b6 00             	movzbl (%eax),%eax
     2a9:	3c 2f                	cmp    $0x2f,%al
     2ab:	7e 0a                	jle    2b7 <atoi+0x48>
     2ad:	8b 45 08             	mov    0x8(%ebp),%eax
     2b0:	0f b6 00             	movzbl (%eax),%eax
     2b3:	3c 39                	cmp    $0x39,%al
     2b5:	7e c7                	jle    27e <atoi+0xf>
  return n;
     2b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     2ba:	c9                   	leave  
     2bb:	c3                   	ret    

000002bc <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     2bc:	55                   	push   %ebp
     2bd:	89 e5                	mov    %esp,%ebp
     2bf:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     2c2:	8b 45 08             	mov    0x8(%ebp),%eax
     2c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     2c8:	8b 45 0c             	mov    0xc(%ebp),%eax
     2cb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     2ce:	eb 17                	jmp    2e7 <memmove+0x2b>
    *dst++ = *src++;
     2d0:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2d3:	8d 42 01             	lea    0x1(%edx),%eax
     2d6:	89 45 f8             	mov    %eax,-0x8(%ebp)
     2d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2dc:	8d 48 01             	lea    0x1(%eax),%ecx
     2df:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     2e2:	0f b6 12             	movzbl (%edx),%edx
     2e5:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     2e7:	8b 45 10             	mov    0x10(%ebp),%eax
     2ea:	8d 50 ff             	lea    -0x1(%eax),%edx
     2ed:	89 55 10             	mov    %edx,0x10(%ebp)
     2f0:	85 c0                	test   %eax,%eax
     2f2:	7f dc                	jg     2d0 <memmove+0x14>
  return vdst;
     2f4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2f7:	c9                   	leave  
     2f8:	c3                   	ret    

000002f9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2f9:	b8 01 00 00 00       	mov    $0x1,%eax
     2fe:	cd 40                	int    $0x40
     300:	c3                   	ret    

00000301 <exit>:
SYSCALL(exit)
     301:	b8 02 00 00 00       	mov    $0x2,%eax
     306:	cd 40                	int    $0x40
     308:	c3                   	ret    

00000309 <wait>:
SYSCALL(wait)
     309:	b8 03 00 00 00       	mov    $0x3,%eax
     30e:	cd 40                	int    $0x40
     310:	c3                   	ret    

00000311 <pipe>:
SYSCALL(pipe)
     311:	b8 04 00 00 00       	mov    $0x4,%eax
     316:	cd 40                	int    $0x40
     318:	c3                   	ret    

00000319 <read>:
SYSCALL(read)
     319:	b8 05 00 00 00       	mov    $0x5,%eax
     31e:	cd 40                	int    $0x40
     320:	c3                   	ret    

00000321 <write>:
SYSCALL(write)
     321:	b8 10 00 00 00       	mov    $0x10,%eax
     326:	cd 40                	int    $0x40
     328:	c3                   	ret    

00000329 <close>:
SYSCALL(close)
     329:	b8 15 00 00 00       	mov    $0x15,%eax
     32e:	cd 40                	int    $0x40
     330:	c3                   	ret    

00000331 <kill>:
SYSCALL(kill)
     331:	b8 06 00 00 00       	mov    $0x6,%eax
     336:	cd 40                	int    $0x40
     338:	c3                   	ret    

00000339 <exec>:
SYSCALL(exec)
     339:	b8 07 00 00 00       	mov    $0x7,%eax
     33e:	cd 40                	int    $0x40
     340:	c3                   	ret    

00000341 <open>:
SYSCALL(open)
     341:	b8 0f 00 00 00       	mov    $0xf,%eax
     346:	cd 40                	int    $0x40
     348:	c3                   	ret    

00000349 <mknod>:
SYSCALL(mknod)
     349:	b8 11 00 00 00       	mov    $0x11,%eax
     34e:	cd 40                	int    $0x40
     350:	c3                   	ret    

00000351 <unlink>:
SYSCALL(unlink)
     351:	b8 12 00 00 00       	mov    $0x12,%eax
     356:	cd 40                	int    $0x40
     358:	c3                   	ret    

00000359 <fstat>:
SYSCALL(fstat)
     359:	b8 08 00 00 00       	mov    $0x8,%eax
     35e:	cd 40                	int    $0x40
     360:	c3                   	ret    

00000361 <link>:
SYSCALL(link)
     361:	b8 13 00 00 00       	mov    $0x13,%eax
     366:	cd 40                	int    $0x40
     368:	c3                   	ret    

00000369 <mkdir>:
SYSCALL(mkdir)
     369:	b8 14 00 00 00       	mov    $0x14,%eax
     36e:	cd 40                	int    $0x40
     370:	c3                   	ret    

00000371 <chdir>:
SYSCALL(chdir)
     371:	b8 09 00 00 00       	mov    $0x9,%eax
     376:	cd 40                	int    $0x40
     378:	c3                   	ret    

00000379 <dup>:
SYSCALL(dup)
     379:	b8 0a 00 00 00       	mov    $0xa,%eax
     37e:	cd 40                	int    $0x40
     380:	c3                   	ret    

00000381 <getpid>:
SYSCALL(getpid)
     381:	b8 0b 00 00 00       	mov    $0xb,%eax
     386:	cd 40                	int    $0x40
     388:	c3                   	ret    

00000389 <sbrk>:
SYSCALL(sbrk)
     389:	b8 0c 00 00 00       	mov    $0xc,%eax
     38e:	cd 40                	int    $0x40
     390:	c3                   	ret    

00000391 <sleep>:
SYSCALL(sleep)
     391:	b8 0d 00 00 00       	mov    $0xd,%eax
     396:	cd 40                	int    $0x40
     398:	c3                   	ret    

00000399 <uptime>:
SYSCALL(uptime)
     399:	b8 0e 00 00 00       	mov    $0xe,%eax
     39e:	cd 40                	int    $0x40
     3a0:	c3                   	ret    

000003a1 <select>:
SYSCALL(select)
     3a1:	b8 16 00 00 00       	mov    $0x16,%eax
     3a6:	cd 40                	int    $0x40
     3a8:	c3                   	ret    

000003a9 <arp>:
SYSCALL(arp)
     3a9:	b8 17 00 00 00       	mov    $0x17,%eax
     3ae:	cd 40                	int    $0x40
     3b0:	c3                   	ret    

000003b1 <arpserv>:
SYSCALL(arpserv)
     3b1:	b8 18 00 00 00       	mov    $0x18,%eax
     3b6:	cd 40                	int    $0x40
     3b8:	c3                   	ret    

000003b9 <arp_receive>:
SYSCALL(arp_receive)
     3b9:	b8 19 00 00 00       	mov    $0x19,%eax
     3be:	cd 40                	int    $0x40
     3c0:	c3                   	ret    

000003c1 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3c1:	55                   	push   %ebp
     3c2:	89 e5                	mov    %esp,%ebp
     3c4:	83 ec 18             	sub    $0x18,%esp
     3c7:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ca:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3cd:	83 ec 04             	sub    $0x4,%esp
     3d0:	6a 01                	push   $0x1
     3d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3d5:	50                   	push   %eax
     3d6:	ff 75 08             	pushl  0x8(%ebp)
     3d9:	e8 43 ff ff ff       	call   321 <write>
     3de:	83 c4 10             	add    $0x10,%esp
}
     3e1:	90                   	nop
     3e2:	c9                   	leave  
     3e3:	c3                   	ret    

000003e4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3e4:	55                   	push   %ebp
     3e5:	89 e5                	mov    %esp,%ebp
     3e7:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3ea:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3f1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3f5:	74 17                	je     40e <printint+0x2a>
     3f7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3fb:	79 11                	jns    40e <printint+0x2a>
    neg = 1;
     3fd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     404:	8b 45 0c             	mov    0xc(%ebp),%eax
     407:	f7 d8                	neg    %eax
     409:	89 45 ec             	mov    %eax,-0x14(%ebp)
     40c:	eb 06                	jmp    414 <printint+0x30>
  } else {
    x = xx;
     40e:	8b 45 0c             	mov    0xc(%ebp),%eax
     411:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     414:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     41b:	8b 4d 10             	mov    0x10(%ebp),%ecx
     41e:	8b 45 ec             	mov    -0x14(%ebp),%eax
     421:	ba 00 00 00 00       	mov    $0x0,%edx
     426:	f7 f1                	div    %ecx
     428:	89 d1                	mov    %edx,%ecx
     42a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     42d:	8d 50 01             	lea    0x1(%eax),%edx
     430:	89 55 f4             	mov    %edx,-0xc(%ebp)
     433:	0f b6 91 6c 17 00 00 	movzbl 0x176c(%ecx),%edx
     43a:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     43e:	8b 4d 10             	mov    0x10(%ebp),%ecx
     441:	8b 45 ec             	mov    -0x14(%ebp),%eax
     444:	ba 00 00 00 00       	mov    $0x0,%edx
     449:	f7 f1                	div    %ecx
     44b:	89 45 ec             	mov    %eax,-0x14(%ebp)
     44e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     452:	75 c7                	jne    41b <printint+0x37>
  if(neg)
     454:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     458:	74 2d                	je     487 <printint+0xa3>
    buf[i++] = '-';
     45a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     45d:	8d 50 01             	lea    0x1(%eax),%edx
     460:	89 55 f4             	mov    %edx,-0xc(%ebp)
     463:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     468:	eb 1d                	jmp    487 <printint+0xa3>
    putc(fd, buf[i]);
     46a:	8d 55 dc             	lea    -0x24(%ebp),%edx
     46d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     470:	01 d0                	add    %edx,%eax
     472:	0f b6 00             	movzbl (%eax),%eax
     475:	0f be c0             	movsbl %al,%eax
     478:	83 ec 08             	sub    $0x8,%esp
     47b:	50                   	push   %eax
     47c:	ff 75 08             	pushl  0x8(%ebp)
     47f:	e8 3d ff ff ff       	call   3c1 <putc>
     484:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     487:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     48b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     48f:	79 d9                	jns    46a <printint+0x86>
}
     491:	90                   	nop
     492:	c9                   	leave  
     493:	c3                   	ret    

00000494 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     494:	55                   	push   %ebp
     495:	89 e5                	mov    %esp,%ebp
     497:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     49a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     4a1:	8d 45 0c             	lea    0xc(%ebp),%eax
     4a4:	83 c0 04             	add    $0x4,%eax
     4a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4aa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     4b1:	e9 59 01 00 00       	jmp    60f <printf+0x17b>
    c = fmt[i] & 0xff;
     4b6:	8b 55 0c             	mov    0xc(%ebp),%edx
     4b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     4bc:	01 d0                	add    %edx,%eax
     4be:	0f b6 00             	movzbl (%eax),%eax
     4c1:	0f be c0             	movsbl %al,%eax
     4c4:	25 ff 00 00 00       	and    $0xff,%eax
     4c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4cc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4d0:	75 2c                	jne    4fe <printf+0x6a>
      if(c == '%'){
     4d2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4d6:	75 0c                	jne    4e4 <printf+0x50>
        state = '%';
     4d8:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4df:	e9 27 01 00 00       	jmp    60b <printf+0x177>
      } else {
        putc(fd, c);
     4e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4e7:	0f be c0             	movsbl %al,%eax
     4ea:	83 ec 08             	sub    $0x8,%esp
     4ed:	50                   	push   %eax
     4ee:	ff 75 08             	pushl  0x8(%ebp)
     4f1:	e8 cb fe ff ff       	call   3c1 <putc>
     4f6:	83 c4 10             	add    $0x10,%esp
     4f9:	e9 0d 01 00 00       	jmp    60b <printf+0x177>
      }
    } else if(state == '%'){
     4fe:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     502:	0f 85 03 01 00 00    	jne    60b <printf+0x177>
      if(c == 'd'){
     508:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     50c:	75 1e                	jne    52c <printf+0x98>
        printint(fd, *ap, 10, 1);
     50e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     511:	8b 00                	mov    (%eax),%eax
     513:	6a 01                	push   $0x1
     515:	6a 0a                	push   $0xa
     517:	50                   	push   %eax
     518:	ff 75 08             	pushl  0x8(%ebp)
     51b:	e8 c4 fe ff ff       	call   3e4 <printint>
     520:	83 c4 10             	add    $0x10,%esp
        ap++;
     523:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     527:	e9 d8 00 00 00       	jmp    604 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     52c:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     530:	74 06                	je     538 <printf+0xa4>
     532:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     536:	75 1e                	jne    556 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     538:	8b 45 e8             	mov    -0x18(%ebp),%eax
     53b:	8b 00                	mov    (%eax),%eax
     53d:	6a 00                	push   $0x0
     53f:	6a 10                	push   $0x10
     541:	50                   	push   %eax
     542:	ff 75 08             	pushl  0x8(%ebp)
     545:	e8 9a fe ff ff       	call   3e4 <printint>
     54a:	83 c4 10             	add    $0x10,%esp
        ap++;
     54d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     551:	e9 ae 00 00 00       	jmp    604 <printf+0x170>
      } else if(c == 's'){
     556:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     55a:	75 43                	jne    59f <printf+0x10b>
        s = (char*)*ap;
     55c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     55f:	8b 00                	mov    (%eax),%eax
     561:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     564:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     568:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     56c:	75 25                	jne    593 <printf+0xff>
          s = "(null)";
     56e:	c7 45 f4 bc 10 00 00 	movl   $0x10bc,-0xc(%ebp)
        while(*s != 0){
     575:	eb 1c                	jmp    593 <printf+0xff>
          putc(fd, *s);
     577:	8b 45 f4             	mov    -0xc(%ebp),%eax
     57a:	0f b6 00             	movzbl (%eax),%eax
     57d:	0f be c0             	movsbl %al,%eax
     580:	83 ec 08             	sub    $0x8,%esp
     583:	50                   	push   %eax
     584:	ff 75 08             	pushl  0x8(%ebp)
     587:	e8 35 fe ff ff       	call   3c1 <putc>
     58c:	83 c4 10             	add    $0x10,%esp
          s++;
     58f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     593:	8b 45 f4             	mov    -0xc(%ebp),%eax
     596:	0f b6 00             	movzbl (%eax),%eax
     599:	84 c0                	test   %al,%al
     59b:	75 da                	jne    577 <printf+0xe3>
     59d:	eb 65                	jmp    604 <printf+0x170>
        }
      } else if(c == 'c'){
     59f:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     5a3:	75 1d                	jne    5c2 <printf+0x12e>
        putc(fd, *ap);
     5a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a8:	8b 00                	mov    (%eax),%eax
     5aa:	0f be c0             	movsbl %al,%eax
     5ad:	83 ec 08             	sub    $0x8,%esp
     5b0:	50                   	push   %eax
     5b1:	ff 75 08             	pushl  0x8(%ebp)
     5b4:	e8 08 fe ff ff       	call   3c1 <putc>
     5b9:	83 c4 10             	add    $0x10,%esp
        ap++;
     5bc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5c0:	eb 42                	jmp    604 <printf+0x170>
      } else if(c == '%'){
     5c2:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5c6:	75 17                	jne    5df <printf+0x14b>
        putc(fd, c);
     5c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5cb:	0f be c0             	movsbl %al,%eax
     5ce:	83 ec 08             	sub    $0x8,%esp
     5d1:	50                   	push   %eax
     5d2:	ff 75 08             	pushl  0x8(%ebp)
     5d5:	e8 e7 fd ff ff       	call   3c1 <putc>
     5da:	83 c4 10             	add    $0x10,%esp
     5dd:	eb 25                	jmp    604 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5df:	83 ec 08             	sub    $0x8,%esp
     5e2:	6a 25                	push   $0x25
     5e4:	ff 75 08             	pushl  0x8(%ebp)
     5e7:	e8 d5 fd ff ff       	call   3c1 <putc>
     5ec:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5f2:	0f be c0             	movsbl %al,%eax
     5f5:	83 ec 08             	sub    $0x8,%esp
     5f8:	50                   	push   %eax
     5f9:	ff 75 08             	pushl  0x8(%ebp)
     5fc:	e8 c0 fd ff ff       	call   3c1 <putc>
     601:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     604:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     60b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     60f:	8b 55 0c             	mov    0xc(%ebp),%edx
     612:	8b 45 f0             	mov    -0x10(%ebp),%eax
     615:	01 d0                	add    %edx,%eax
     617:	0f b6 00             	movzbl (%eax),%eax
     61a:	84 c0                	test   %al,%al
     61c:	0f 85 94 fe ff ff    	jne    4b6 <printf+0x22>
    }
  }
}
     622:	90                   	nop
     623:	c9                   	leave  
     624:	c3                   	ret    

00000625 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     625:	55                   	push   %ebp
     626:	89 e5                	mov    %esp,%ebp
     628:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     62b:	8b 45 08             	mov    0x8(%ebp),%eax
     62e:	83 e8 08             	sub    $0x8,%eax
     631:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     634:	a1 88 17 00 00       	mov    0x1788,%eax
     639:	89 45 fc             	mov    %eax,-0x4(%ebp)
     63c:	eb 24                	jmp    662 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     63e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     641:	8b 00                	mov    (%eax),%eax
     643:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     646:	72 12                	jb     65a <free+0x35>
     648:	8b 45 f8             	mov    -0x8(%ebp),%eax
     64b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     64e:	77 24                	ja     674 <free+0x4f>
     650:	8b 45 fc             	mov    -0x4(%ebp),%eax
     653:	8b 00                	mov    (%eax),%eax
     655:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     658:	72 1a                	jb     674 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     65a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     65d:	8b 00                	mov    (%eax),%eax
     65f:	89 45 fc             	mov    %eax,-0x4(%ebp)
     662:	8b 45 f8             	mov    -0x8(%ebp),%eax
     665:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     668:	76 d4                	jbe    63e <free+0x19>
     66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     66d:	8b 00                	mov    (%eax),%eax
     66f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     672:	73 ca                	jae    63e <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     674:	8b 45 f8             	mov    -0x8(%ebp),%eax
     677:	8b 40 04             	mov    0x4(%eax),%eax
     67a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     681:	8b 45 f8             	mov    -0x8(%ebp),%eax
     684:	01 c2                	add    %eax,%edx
     686:	8b 45 fc             	mov    -0x4(%ebp),%eax
     689:	8b 00                	mov    (%eax),%eax
     68b:	39 c2                	cmp    %eax,%edx
     68d:	75 24                	jne    6b3 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     692:	8b 50 04             	mov    0x4(%eax),%edx
     695:	8b 45 fc             	mov    -0x4(%ebp),%eax
     698:	8b 00                	mov    (%eax),%eax
     69a:	8b 40 04             	mov    0x4(%eax),%eax
     69d:	01 c2                	add    %eax,%edx
     69f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6a2:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     6a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a8:	8b 00                	mov    (%eax),%eax
     6aa:	8b 10                	mov    (%eax),%edx
     6ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6af:	89 10                	mov    %edx,(%eax)
     6b1:	eb 0a                	jmp    6bd <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b6:	8b 10                	mov    (%eax),%edx
     6b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6bb:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c0:	8b 40 04             	mov    0x4(%eax),%eax
     6c3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cd:	01 d0                	add    %edx,%eax
     6cf:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6d2:	75 20                	jne    6f4 <free+0xcf>
    p->s.size += bp->s.size;
     6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d7:	8b 50 04             	mov    0x4(%eax),%edx
     6da:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6dd:	8b 40 04             	mov    0x4(%eax),%eax
     6e0:	01 c2                	add    %eax,%edx
     6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e5:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6eb:	8b 10                	mov    (%eax),%edx
     6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f0:	89 10                	mov    %edx,(%eax)
     6f2:	eb 08                	jmp    6fc <free+0xd7>
  } else
    p->s.ptr = bp;
     6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f7:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6fa:	89 10                	mov    %edx,(%eax)
  freep = p;
     6fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ff:	a3 88 17 00 00       	mov    %eax,0x1788
}
     704:	90                   	nop
     705:	c9                   	leave  
     706:	c3                   	ret    

00000707 <morecore>:

static Header*
morecore(uint nu)
{
     707:	55                   	push   %ebp
     708:	89 e5                	mov    %esp,%ebp
     70a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     70d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     714:	77 07                	ja     71d <morecore+0x16>
    nu = 4096;
     716:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     71d:	8b 45 08             	mov    0x8(%ebp),%eax
     720:	c1 e0 03             	shl    $0x3,%eax
     723:	83 ec 0c             	sub    $0xc,%esp
     726:	50                   	push   %eax
     727:	e8 5d fc ff ff       	call   389 <sbrk>
     72c:	83 c4 10             	add    $0x10,%esp
     72f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     732:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     736:	75 07                	jne    73f <morecore+0x38>
    return 0;
     738:	b8 00 00 00 00       	mov    $0x0,%eax
     73d:	eb 26                	jmp    765 <morecore+0x5e>
  hp = (Header*)p;
     73f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     742:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     745:	8b 45 f0             	mov    -0x10(%ebp),%eax
     748:	8b 55 08             	mov    0x8(%ebp),%edx
     74b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     74e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     751:	83 c0 08             	add    $0x8,%eax
     754:	83 ec 0c             	sub    $0xc,%esp
     757:	50                   	push   %eax
     758:	e8 c8 fe ff ff       	call   625 <free>
     75d:	83 c4 10             	add    $0x10,%esp
  return freep;
     760:	a1 88 17 00 00       	mov    0x1788,%eax
}
     765:	c9                   	leave  
     766:	c3                   	ret    

00000767 <malloc>:

void*
malloc(uint nbytes)
{
     767:	55                   	push   %ebp
     768:	89 e5                	mov    %esp,%ebp
     76a:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     76d:	8b 45 08             	mov    0x8(%ebp),%eax
     770:	83 c0 07             	add    $0x7,%eax
     773:	c1 e8 03             	shr    $0x3,%eax
     776:	83 c0 01             	add    $0x1,%eax
     779:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     77c:	a1 88 17 00 00       	mov    0x1788,%eax
     781:	89 45 f0             	mov    %eax,-0x10(%ebp)
     784:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     788:	75 23                	jne    7ad <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     78a:	c7 45 f0 80 17 00 00 	movl   $0x1780,-0x10(%ebp)
     791:	8b 45 f0             	mov    -0x10(%ebp),%eax
     794:	a3 88 17 00 00       	mov    %eax,0x1788
     799:	a1 88 17 00 00       	mov    0x1788,%eax
     79e:	a3 80 17 00 00       	mov    %eax,0x1780
    base.s.size = 0;
     7a3:	c7 05 84 17 00 00 00 	movl   $0x0,0x1784
     7aa:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b0:	8b 00                	mov    (%eax),%eax
     7b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     7b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b8:	8b 40 04             	mov    0x4(%eax),%eax
     7bb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7be:	77 4d                	ja     80d <malloc+0xa6>
      if(p->s.size == nunits)
     7c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c3:	8b 40 04             	mov    0x4(%eax),%eax
     7c6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7c9:	75 0c                	jne    7d7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ce:	8b 10                	mov    (%eax),%edx
     7d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d3:	89 10                	mov    %edx,(%eax)
     7d5:	eb 26                	jmp    7fd <malloc+0x96>
      else {
        p->s.size -= nunits;
     7d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7da:	8b 40 04             	mov    0x4(%eax),%eax
     7dd:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7e0:	89 c2                	mov    %eax,%edx
     7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7eb:	8b 40 04             	mov    0x4(%eax),%eax
     7ee:	c1 e0 03             	shl    $0x3,%eax
     7f1:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f7:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7fa:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     800:	a3 88 17 00 00       	mov    %eax,0x1788
      return (void*)(p + 1);
     805:	8b 45 f4             	mov    -0xc(%ebp),%eax
     808:	83 c0 08             	add    $0x8,%eax
     80b:	eb 3b                	jmp    848 <malloc+0xe1>
    }
    if(p == freep)
     80d:	a1 88 17 00 00       	mov    0x1788,%eax
     812:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     815:	75 1e                	jne    835 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     817:	83 ec 0c             	sub    $0xc,%esp
     81a:	ff 75 ec             	pushl  -0x14(%ebp)
     81d:	e8 e5 fe ff ff       	call   707 <morecore>
     822:	83 c4 10             	add    $0x10,%esp
     825:	89 45 f4             	mov    %eax,-0xc(%ebp)
     828:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     82c:	75 07                	jne    835 <malloc+0xce>
        return 0;
     82e:	b8 00 00 00 00       	mov    $0x0,%eax
     833:	eb 13                	jmp    848 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     835:	8b 45 f4             	mov    -0xc(%ebp),%eax
     838:	89 45 f0             	mov    %eax,-0x10(%ebp)
     83b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83e:	8b 00                	mov    (%eax),%eax
     840:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     843:	e9 6d ff ff ff       	jmp    7b5 <malloc+0x4e>
  }
}
     848:	c9                   	leave  
     849:	c3                   	ret    

0000084a <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     84a:	55                   	push   %ebp
     84b:	89 e5                	mov    %esp,%ebp
     84d:	53                   	push   %ebx
     84e:	83 ec 14             	sub    $0x14,%esp
     851:	8b 45 10             	mov    0x10(%ebp),%eax
     854:	89 45 f0             	mov    %eax,-0x10(%ebp)
     857:	8b 45 14             	mov    0x14(%ebp),%eax
     85a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     85d:	8b 45 18             	mov    0x18(%ebp),%eax
     860:	ba 00 00 00 00       	mov    $0x0,%edx
     865:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     868:	72 55                	jb     8bf <printnum+0x75>
     86a:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     86d:	77 05                	ja     874 <printnum+0x2a>
     86f:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     872:	72 4b                	jb     8bf <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     874:	8b 45 1c             	mov    0x1c(%ebp),%eax
     877:	8d 58 ff             	lea    -0x1(%eax),%ebx
     87a:	8b 45 18             	mov    0x18(%ebp),%eax
     87d:	ba 00 00 00 00       	mov    $0x0,%edx
     882:	52                   	push   %edx
     883:	50                   	push   %eax
     884:	ff 75 f4             	pushl  -0xc(%ebp)
     887:	ff 75 f0             	pushl  -0x10(%ebp)
     88a:	e8 a1 05 00 00       	call   e30 <__udivdi3>
     88f:	83 c4 10             	add    $0x10,%esp
     892:	83 ec 04             	sub    $0x4,%esp
     895:	ff 75 20             	pushl  0x20(%ebp)
     898:	53                   	push   %ebx
     899:	ff 75 18             	pushl  0x18(%ebp)
     89c:	52                   	push   %edx
     89d:	50                   	push   %eax
     89e:	ff 75 0c             	pushl  0xc(%ebp)
     8a1:	ff 75 08             	pushl  0x8(%ebp)
     8a4:	e8 a1 ff ff ff       	call   84a <printnum>
     8a9:	83 c4 20             	add    $0x20,%esp
     8ac:	eb 1b                	jmp    8c9 <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     8ae:	83 ec 08             	sub    $0x8,%esp
     8b1:	ff 75 0c             	pushl  0xc(%ebp)
     8b4:	ff 75 20             	pushl  0x20(%ebp)
     8b7:	8b 45 08             	mov    0x8(%ebp),%eax
     8ba:	ff d0                	call   *%eax
     8bc:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     8bf:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     8c3:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     8c7:	7f e5                	jg     8ae <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     8c9:	8b 4d 18             	mov    0x18(%ebp),%ecx
     8cc:	bb 00 00 00 00       	mov    $0x0,%ebx
     8d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8d4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8d7:	53                   	push   %ebx
     8d8:	51                   	push   %ecx
     8d9:	52                   	push   %edx
     8da:	50                   	push   %eax
     8db:	e8 70 06 00 00       	call   f50 <__umoddi3>
     8e0:	83 c4 10             	add    $0x10,%esp
     8e3:	05 a0 11 00 00       	add    $0x11a0,%eax
     8e8:	0f b6 00             	movzbl (%eax),%eax
     8eb:	0f be c0             	movsbl %al,%eax
     8ee:	83 ec 08             	sub    $0x8,%esp
     8f1:	ff 75 0c             	pushl  0xc(%ebp)
     8f4:	50                   	push   %eax
     8f5:	8b 45 08             	mov    0x8(%ebp),%eax
     8f8:	ff d0                	call   *%eax
     8fa:	83 c4 10             	add    $0x10,%esp
}
     8fd:	90                   	nop
     8fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     901:	c9                   	leave  
     902:	c3                   	ret    

00000903 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     903:	55                   	push   %ebp
     904:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     906:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     90a:	7e 14                	jle    920 <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     90c:	8b 45 08             	mov    0x8(%ebp),%eax
     90f:	8b 00                	mov    (%eax),%eax
     911:	8d 48 08             	lea    0x8(%eax),%ecx
     914:	8b 55 08             	mov    0x8(%ebp),%edx
     917:	89 0a                	mov    %ecx,(%edx)
     919:	8b 50 04             	mov    0x4(%eax),%edx
     91c:	8b 00                	mov    (%eax),%eax
     91e:	eb 30                	jmp    950 <getuint+0x4d>
  else if (lflag)
     920:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     924:	74 16                	je     93c <getuint+0x39>
    return va_arg(*ap, unsigned long);
     926:	8b 45 08             	mov    0x8(%ebp),%eax
     929:	8b 00                	mov    (%eax),%eax
     92b:	8d 48 04             	lea    0x4(%eax),%ecx
     92e:	8b 55 08             	mov    0x8(%ebp),%edx
     931:	89 0a                	mov    %ecx,(%edx)
     933:	8b 00                	mov    (%eax),%eax
     935:	ba 00 00 00 00       	mov    $0x0,%edx
     93a:	eb 14                	jmp    950 <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     93c:	8b 45 08             	mov    0x8(%ebp),%eax
     93f:	8b 00                	mov    (%eax),%eax
     941:	8d 48 04             	lea    0x4(%eax),%ecx
     944:	8b 55 08             	mov    0x8(%ebp),%edx
     947:	89 0a                	mov    %ecx,(%edx)
     949:	8b 00                	mov    (%eax),%eax
     94b:	ba 00 00 00 00       	mov    $0x0,%edx
}
     950:	5d                   	pop    %ebp
     951:	c3                   	ret    

00000952 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     952:	55                   	push   %ebp
     953:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     955:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     959:	7e 14                	jle    96f <getint+0x1d>
    return va_arg(*ap, long long);
     95b:	8b 45 08             	mov    0x8(%ebp),%eax
     95e:	8b 00                	mov    (%eax),%eax
     960:	8d 48 08             	lea    0x8(%eax),%ecx
     963:	8b 55 08             	mov    0x8(%ebp),%edx
     966:	89 0a                	mov    %ecx,(%edx)
     968:	8b 50 04             	mov    0x4(%eax),%edx
     96b:	8b 00                	mov    (%eax),%eax
     96d:	eb 28                	jmp    997 <getint+0x45>
  else if (lflag)
     96f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     973:	74 12                	je     987 <getint+0x35>
    return va_arg(*ap, long);
     975:	8b 45 08             	mov    0x8(%ebp),%eax
     978:	8b 00                	mov    (%eax),%eax
     97a:	8d 48 04             	lea    0x4(%eax),%ecx
     97d:	8b 55 08             	mov    0x8(%ebp),%edx
     980:	89 0a                	mov    %ecx,(%edx)
     982:	8b 00                	mov    (%eax),%eax
     984:	99                   	cltd   
     985:	eb 10                	jmp    997 <getint+0x45>
  else
    return va_arg(*ap, int);
     987:	8b 45 08             	mov    0x8(%ebp),%eax
     98a:	8b 00                	mov    (%eax),%eax
     98c:	8d 48 04             	lea    0x4(%eax),%ecx
     98f:	8b 55 08             	mov    0x8(%ebp),%edx
     992:	89 0a                	mov    %ecx,(%edx)
     994:	8b 00                	mov    (%eax),%eax
     996:	99                   	cltd   
}
     997:	5d                   	pop    %ebp
     998:	c3                   	ret    

00000999 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     999:	55                   	push   %ebp
     99a:	89 e5                	mov    %esp,%ebp
     99c:	56                   	push   %esi
     99d:	53                   	push   %ebx
     99e:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     9a1:	eb 17                	jmp    9ba <vprintfmt+0x21>
      if (ch == '\0')
     9a3:	85 db                	test   %ebx,%ebx
     9a5:	0f 84 a0 03 00 00    	je     d4b <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     9ab:	83 ec 08             	sub    $0x8,%esp
     9ae:	ff 75 0c             	pushl  0xc(%ebp)
     9b1:	53                   	push   %ebx
     9b2:	8b 45 08             	mov    0x8(%ebp),%eax
     9b5:	ff d0                	call   *%eax
     9b7:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     9ba:	8b 45 10             	mov    0x10(%ebp),%eax
     9bd:	8d 50 01             	lea    0x1(%eax),%edx
     9c0:	89 55 10             	mov    %edx,0x10(%ebp)
     9c3:	0f b6 00             	movzbl (%eax),%eax
     9c6:	0f b6 d8             	movzbl %al,%ebx
     9c9:	83 fb 25             	cmp    $0x25,%ebx
     9cc:	75 d5                	jne    9a3 <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     9ce:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     9d2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     9d9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     9e0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     9e7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     9ee:	8b 45 10             	mov    0x10(%ebp),%eax
     9f1:	8d 50 01             	lea    0x1(%eax),%edx
     9f4:	89 55 10             	mov    %edx,0x10(%ebp)
     9f7:	0f b6 00             	movzbl (%eax),%eax
     9fa:	0f b6 d8             	movzbl %al,%ebx
     9fd:	8d 43 dd             	lea    -0x23(%ebx),%eax
     a00:	83 f8 55             	cmp    $0x55,%eax
     a03:	0f 87 15 03 00 00    	ja     d1e <vprintfmt+0x385>
     a09:	8b 04 85 c4 11 00 00 	mov    0x11c4(,%eax,4),%eax
     a10:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     a12:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     a16:	eb d6                	jmp    9ee <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     a18:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     a1c:	eb d0                	jmp    9ee <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     a1e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     a25:	8b 55 e0             	mov    -0x20(%ebp),%edx
     a28:	89 d0                	mov    %edx,%eax
     a2a:	c1 e0 02             	shl    $0x2,%eax
     a2d:	01 d0                	add    %edx,%eax
     a2f:	01 c0                	add    %eax,%eax
     a31:	01 d8                	add    %ebx,%eax
     a33:	83 e8 30             	sub    $0x30,%eax
     a36:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     a39:	8b 45 10             	mov    0x10(%ebp),%eax
     a3c:	0f b6 00             	movzbl (%eax),%eax
     a3f:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     a42:	83 fb 2f             	cmp    $0x2f,%ebx
     a45:	7e 39                	jle    a80 <vprintfmt+0xe7>
     a47:	83 fb 39             	cmp    $0x39,%ebx
     a4a:	7f 34                	jg     a80 <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     a4c:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     a50:	eb d3                	jmp    a25 <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     a52:	8b 45 14             	mov    0x14(%ebp),%eax
     a55:	8d 50 04             	lea    0x4(%eax),%edx
     a58:	89 55 14             	mov    %edx,0x14(%ebp)
     a5b:	8b 00                	mov    (%eax),%eax
     a5d:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     a60:	eb 1f                	jmp    a81 <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     a62:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a66:	79 86                	jns    9ee <vprintfmt+0x55>
        width = 0;
     a68:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     a6f:	e9 7a ff ff ff       	jmp    9ee <vprintfmt+0x55>

    case '#':
      altflag = 1;
     a74:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     a7b:	e9 6e ff ff ff       	jmp    9ee <vprintfmt+0x55>
      goto process_precision;
     a80:	90                   	nop

process_precision:
      if (width < 0)
     a81:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a85:	0f 89 63 ff ff ff    	jns    9ee <vprintfmt+0x55>
        width = precision, precision = -1;
     a8b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a8e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a91:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     a98:	e9 51 ff ff ff       	jmp    9ee <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     a9d:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     aa1:	e9 48 ff ff ff       	jmp    9ee <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     aa6:	8b 45 14             	mov    0x14(%ebp),%eax
     aa9:	8d 50 04             	lea    0x4(%eax),%edx
     aac:	89 55 14             	mov    %edx,0x14(%ebp)
     aaf:	8b 00                	mov    (%eax),%eax
     ab1:	83 ec 08             	sub    $0x8,%esp
     ab4:	ff 75 0c             	pushl  0xc(%ebp)
     ab7:	50                   	push   %eax
     ab8:	8b 45 08             	mov    0x8(%ebp),%eax
     abb:	ff d0                	call   *%eax
     abd:	83 c4 10             	add    $0x10,%esp
      break;
     ac0:	e9 81 02 00 00       	jmp    d46 <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     ac5:	8b 45 14             	mov    0x14(%ebp),%eax
     ac8:	8d 50 04             	lea    0x4(%eax),%edx
     acb:	89 55 14             	mov    %edx,0x14(%ebp)
     ace:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     ad0:	85 db                	test   %ebx,%ebx
     ad2:	79 02                	jns    ad6 <vprintfmt+0x13d>
        err = -err;
     ad4:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     ad6:	83 fb 0f             	cmp    $0xf,%ebx
     ad9:	7f 0b                	jg     ae6 <vprintfmt+0x14d>
     adb:	8b 34 9d 60 11 00 00 	mov    0x1160(,%ebx,4),%esi
     ae2:	85 f6                	test   %esi,%esi
     ae4:	75 19                	jne    aff <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     ae6:	53                   	push   %ebx
     ae7:	68 b1 11 00 00       	push   $0x11b1
     aec:	ff 75 0c             	pushl  0xc(%ebp)
     aef:	ff 75 08             	pushl  0x8(%ebp)
     af2:	e8 5c 02 00 00       	call   d53 <printfmt>
     af7:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     afa:	e9 47 02 00 00       	jmp    d46 <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     aff:	56                   	push   %esi
     b00:	68 ba 11 00 00       	push   $0x11ba
     b05:	ff 75 0c             	pushl  0xc(%ebp)
     b08:	ff 75 08             	pushl  0x8(%ebp)
     b0b:	e8 43 02 00 00       	call   d53 <printfmt>
     b10:	83 c4 10             	add    $0x10,%esp
      break;
     b13:	e9 2e 02 00 00       	jmp    d46 <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     b18:	8b 45 14             	mov    0x14(%ebp),%eax
     b1b:	8d 50 04             	lea    0x4(%eax),%edx
     b1e:	89 55 14             	mov    %edx,0x14(%ebp)
     b21:	8b 30                	mov    (%eax),%esi
     b23:	85 f6                	test   %esi,%esi
     b25:	75 05                	jne    b2c <vprintfmt+0x193>
        p = "(null)";
     b27:	be bd 11 00 00       	mov    $0x11bd,%esi
      if (width > 0 && padc != '-')
     b2c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b30:	7e 6f                	jle    ba1 <vprintfmt+0x208>
     b32:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     b36:	74 69                	je     ba1 <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     b38:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b3b:	83 ec 08             	sub    $0x8,%esp
     b3e:	50                   	push   %eax
     b3f:	56                   	push   %esi
     b40:	e8 f1 f5 ff ff       	call   136 <strnlen>
     b45:	83 c4 10             	add    $0x10,%esp
     b48:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     b4b:	eb 17                	jmp    b64 <vprintfmt+0x1cb>
          putch(padc, putdat);
     b4d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     b51:	83 ec 08             	sub    $0x8,%esp
     b54:	ff 75 0c             	pushl  0xc(%ebp)
     b57:	50                   	push   %eax
     b58:	8b 45 08             	mov    0x8(%ebp),%eax
     b5b:	ff d0                	call   *%eax
     b5d:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     b60:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b64:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b68:	7f e3                	jg     b4d <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b6a:	eb 35                	jmp    ba1 <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     b6c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     b70:	74 1c                	je     b8e <vprintfmt+0x1f5>
     b72:	83 fb 1f             	cmp    $0x1f,%ebx
     b75:	7e 05                	jle    b7c <vprintfmt+0x1e3>
     b77:	83 fb 7e             	cmp    $0x7e,%ebx
     b7a:	7e 12                	jle    b8e <vprintfmt+0x1f5>
          putch('?', putdat);
     b7c:	83 ec 08             	sub    $0x8,%esp
     b7f:	ff 75 0c             	pushl  0xc(%ebp)
     b82:	6a 3f                	push   $0x3f
     b84:	8b 45 08             	mov    0x8(%ebp),%eax
     b87:	ff d0                	call   *%eax
     b89:	83 c4 10             	add    $0x10,%esp
     b8c:	eb 0f                	jmp    b9d <vprintfmt+0x204>
        else
          putch(ch, putdat);
     b8e:	83 ec 08             	sub    $0x8,%esp
     b91:	ff 75 0c             	pushl  0xc(%ebp)
     b94:	53                   	push   %ebx
     b95:	8b 45 08             	mov    0x8(%ebp),%eax
     b98:	ff d0                	call   *%eax
     b9a:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b9d:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     ba1:	89 f0                	mov    %esi,%eax
     ba3:	8d 70 01             	lea    0x1(%eax),%esi
     ba6:	0f b6 00             	movzbl (%eax),%eax
     ba9:	0f be d8             	movsbl %al,%ebx
     bac:	85 db                	test   %ebx,%ebx
     bae:	74 26                	je     bd6 <vprintfmt+0x23d>
     bb0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     bb4:	78 b6                	js     b6c <vprintfmt+0x1d3>
     bb6:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     bba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     bbe:	79 ac                	jns    b6c <vprintfmt+0x1d3>
      for (; width > 0; width--)
     bc0:	eb 14                	jmp    bd6 <vprintfmt+0x23d>
        putch(' ', putdat);
     bc2:	83 ec 08             	sub    $0x8,%esp
     bc5:	ff 75 0c             	pushl  0xc(%ebp)
     bc8:	6a 20                	push   $0x20
     bca:	8b 45 08             	mov    0x8(%ebp),%eax
     bcd:	ff d0                	call   *%eax
     bcf:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     bd2:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     bd6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bda:	7f e6                	jg     bc2 <vprintfmt+0x229>
      break;
     bdc:	e9 65 01 00 00       	jmp    d46 <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     be1:	83 ec 08             	sub    $0x8,%esp
     be4:	ff 75 e8             	pushl  -0x18(%ebp)
     be7:	8d 45 14             	lea    0x14(%ebp),%eax
     bea:	50                   	push   %eax
     beb:	e8 62 fd ff ff       	call   952 <getint>
     bf0:	83 c4 10             	add    $0x10,%esp
     bf3:	89 45 f0             	mov    %eax,-0x10(%ebp)
     bf6:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     bf9:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bfc:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bff:	85 d2                	test   %edx,%edx
     c01:	79 23                	jns    c26 <vprintfmt+0x28d>
        putch('-', putdat);
     c03:	83 ec 08             	sub    $0x8,%esp
     c06:	ff 75 0c             	pushl  0xc(%ebp)
     c09:	6a 2d                	push   $0x2d
     c0b:	8b 45 08             	mov    0x8(%ebp),%eax
     c0e:	ff d0                	call   *%eax
     c10:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     c13:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c16:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c19:	f7 d8                	neg    %eax
     c1b:	83 d2 00             	adc    $0x0,%edx
     c1e:	f7 da                	neg    %edx
     c20:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c23:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     c26:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c2d:	e9 b6 00 00 00       	jmp    ce8 <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     c32:	83 ec 08             	sub    $0x8,%esp
     c35:	ff 75 e8             	pushl  -0x18(%ebp)
     c38:	8d 45 14             	lea    0x14(%ebp),%eax
     c3b:	50                   	push   %eax
     c3c:	e8 c2 fc ff ff       	call   903 <getuint>
     c41:	83 c4 10             	add    $0x10,%esp
     c44:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c47:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     c4a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c51:	e9 92 00 00 00       	jmp    ce8 <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     c56:	83 ec 08             	sub    $0x8,%esp
     c59:	ff 75 0c             	pushl  0xc(%ebp)
     c5c:	6a 58                	push   $0x58
     c5e:	8b 45 08             	mov    0x8(%ebp),%eax
     c61:	ff d0                	call   *%eax
     c63:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c66:	83 ec 08             	sub    $0x8,%esp
     c69:	ff 75 0c             	pushl  0xc(%ebp)
     c6c:	6a 58                	push   $0x58
     c6e:	8b 45 08             	mov    0x8(%ebp),%eax
     c71:	ff d0                	call   *%eax
     c73:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c76:	83 ec 08             	sub    $0x8,%esp
     c79:	ff 75 0c             	pushl  0xc(%ebp)
     c7c:	6a 58                	push   $0x58
     c7e:	8b 45 08             	mov    0x8(%ebp),%eax
     c81:	ff d0                	call   *%eax
     c83:	83 c4 10             	add    $0x10,%esp
      break;
     c86:	e9 bb 00 00 00       	jmp    d46 <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     c8b:	83 ec 08             	sub    $0x8,%esp
     c8e:	ff 75 0c             	pushl  0xc(%ebp)
     c91:	6a 30                	push   $0x30
     c93:	8b 45 08             	mov    0x8(%ebp),%eax
     c96:	ff d0                	call   *%eax
     c98:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     c9b:	83 ec 08             	sub    $0x8,%esp
     c9e:	ff 75 0c             	pushl  0xc(%ebp)
     ca1:	6a 78                	push   $0x78
     ca3:	8b 45 08             	mov    0x8(%ebp),%eax
     ca6:	ff d0                	call   *%eax
     ca8:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     cab:	8b 45 14             	mov    0x14(%ebp),%eax
     cae:	8d 50 04             	lea    0x4(%eax),%edx
     cb1:	89 55 14             	mov    %edx,0x14(%ebp)
     cb4:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     cb6:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cb9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     cc0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     cc7:	eb 1f                	jmp    ce8 <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     cc9:	83 ec 08             	sub    $0x8,%esp
     ccc:	ff 75 e8             	pushl  -0x18(%ebp)
     ccf:	8d 45 14             	lea    0x14(%ebp),%eax
     cd2:	50                   	push   %eax
     cd3:	e8 2b fc ff ff       	call   903 <getuint>
     cd8:	83 c4 10             	add    $0x10,%esp
     cdb:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cde:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     ce1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     ce8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     cec:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cef:	83 ec 04             	sub    $0x4,%esp
     cf2:	52                   	push   %edx
     cf3:	ff 75 e4             	pushl  -0x1c(%ebp)
     cf6:	50                   	push   %eax
     cf7:	ff 75 f4             	pushl  -0xc(%ebp)
     cfa:	ff 75 f0             	pushl  -0x10(%ebp)
     cfd:	ff 75 0c             	pushl  0xc(%ebp)
     d00:	ff 75 08             	pushl  0x8(%ebp)
     d03:	e8 42 fb ff ff       	call   84a <printnum>
     d08:	83 c4 20             	add    $0x20,%esp
      break;
     d0b:	eb 39                	jmp    d46 <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     d0d:	83 ec 08             	sub    $0x8,%esp
     d10:	ff 75 0c             	pushl  0xc(%ebp)
     d13:	53                   	push   %ebx
     d14:	8b 45 08             	mov    0x8(%ebp),%eax
     d17:	ff d0                	call   *%eax
     d19:	83 c4 10             	add    $0x10,%esp
      break;
     d1c:	eb 28                	jmp    d46 <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     d1e:	83 ec 08             	sub    $0x8,%esp
     d21:	ff 75 0c             	pushl  0xc(%ebp)
     d24:	6a 25                	push   $0x25
     d26:	8b 45 08             	mov    0x8(%ebp),%eax
     d29:	ff d0                	call   *%eax
     d2b:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     d2e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d32:	eb 04                	jmp    d38 <vprintfmt+0x39f>
     d34:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d38:	8b 45 10             	mov    0x10(%ebp),%eax
     d3b:	83 e8 01             	sub    $0x1,%eax
     d3e:	0f b6 00             	movzbl (%eax),%eax
     d41:	3c 25                	cmp    $0x25,%al
     d43:	75 ef                	jne    d34 <vprintfmt+0x39b>
        /* do nothing */;
      break;
     d45:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     d46:	e9 6f fc ff ff       	jmp    9ba <vprintfmt+0x21>
        return;
     d4b:	90                   	nop
    }
  }
}
     d4c:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d4f:	5b                   	pop    %ebx
     d50:	5e                   	pop    %esi
     d51:	5d                   	pop    %ebp
     d52:	c3                   	ret    

00000d53 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     d53:	55                   	push   %ebp
     d54:	89 e5                	mov    %esp,%ebp
     d56:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     d59:	8d 45 14             	lea    0x14(%ebp),%eax
     d5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     d5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d62:	50                   	push   %eax
     d63:	ff 75 10             	pushl  0x10(%ebp)
     d66:	ff 75 0c             	pushl  0xc(%ebp)
     d69:	ff 75 08             	pushl  0x8(%ebp)
     d6c:	e8 28 fc ff ff       	call   999 <vprintfmt>
     d71:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     d74:	90                   	nop
     d75:	c9                   	leave  
     d76:	c3                   	ret    

00000d77 <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     d77:	55                   	push   %ebp
     d78:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     d7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     d7d:	8b 40 08             	mov    0x8(%eax),%eax
     d80:	8d 50 01             	lea    0x1(%eax),%edx
     d83:	8b 45 0c             	mov    0xc(%ebp),%eax
     d86:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     d89:	8b 45 0c             	mov    0xc(%ebp),%eax
     d8c:	8b 10                	mov    (%eax),%edx
     d8e:	8b 45 0c             	mov    0xc(%ebp),%eax
     d91:	8b 40 04             	mov    0x4(%eax),%eax
     d94:	39 c2                	cmp    %eax,%edx
     d96:	73 12                	jae    daa <sprintputch+0x33>
    *b->buf++ = ch;
     d98:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9b:	8b 00                	mov    (%eax),%eax
     d9d:	8d 48 01             	lea    0x1(%eax),%ecx
     da0:	8b 55 0c             	mov    0xc(%ebp),%edx
     da3:	89 0a                	mov    %ecx,(%edx)
     da5:	8b 55 08             	mov    0x8(%ebp),%edx
     da8:	88 10                	mov    %dl,(%eax)
}
     daa:	90                   	nop
     dab:	5d                   	pop    %ebp
     dac:	c3                   	ret    

00000dad <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     dad:	55                   	push   %ebp
     dae:	89 e5                	mov    %esp,%ebp
     db0:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     db3:	8b 45 08             	mov    0x8(%ebp),%eax
     db6:	89 45 ec             	mov    %eax,-0x14(%ebp)
     db9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dbc:	8d 50 ff             	lea    -0x1(%eax),%edx
     dbf:	8b 45 08             	mov    0x8(%ebp),%eax
     dc2:	01 d0                	add    %edx,%eax
     dc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
     dc7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     dce:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     dd2:	74 06                	je     dda <vsnprintf+0x2d>
     dd4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     dd8:	7f 07                	jg     de1 <vsnprintf+0x34>
    return -E_INVAL;
     dda:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     ddf:	eb 20                	jmp    e01 <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     de1:	ff 75 14             	pushl  0x14(%ebp)
     de4:	ff 75 10             	pushl  0x10(%ebp)
     de7:	8d 45 ec             	lea    -0x14(%ebp),%eax
     dea:	50                   	push   %eax
     deb:	68 77 0d 00 00       	push   $0xd77
     df0:	e8 a4 fb ff ff       	call   999 <vprintfmt>
     df5:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     df8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     dfb:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     dfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e01:	c9                   	leave  
     e02:	c3                   	ret    

00000e03 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     e03:	55                   	push   %ebp
     e04:	89 e5                	mov    %esp,%ebp
     e06:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     e09:	8d 45 14             	lea    0x14(%ebp),%eax
     e0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     e0f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e12:	50                   	push   %eax
     e13:	ff 75 10             	pushl  0x10(%ebp)
     e16:	ff 75 0c             	pushl  0xc(%ebp)
     e19:	ff 75 08             	pushl  0x8(%ebp)
     e1c:	e8 8c ff ff ff       	call   dad <vsnprintf>
     e21:	83 c4 10             	add    $0x10,%esp
     e24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     e27:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e2a:	c9                   	leave  
     e2b:	c3                   	ret    
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
