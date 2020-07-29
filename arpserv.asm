
_arpserv:     file format elf32-i386


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
  while (1) {
    int status = arpserv("mynet0");
      11:	83 ec 0c             	sub    $0xc,%esp
      14:	68 60 10 00 00       	push   $0x1060
      19:	e8 72 03 00 00       	call   390 <arpserv>
      1e:	83 c4 10             	add    $0x10,%esp
      21:	89 45 f4             	mov    %eax,-0xc(%ebp)
    printf(1, "Served ARP request!\n");
      24:	83 ec 08             	sub    $0x8,%esp
      27:	68 67 10 00 00       	push   $0x1067
      2c:	6a 01                	push   $0x1
      2e:	e8 40 04 00 00       	call   473 <printf>
      33:	83 c4 10             	add    $0x10,%esp
    if(status < 0)
      36:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      3a:	78 17                	js     53 <main+0x53>
      break;
    else
	printf(1, "Status: %d\n", status);
      3c:	83 ec 04             	sub    $0x4,%esp
      3f:	ff 75 f4             	pushl  -0xc(%ebp)
      42:	68 7c 10 00 00       	push   $0x107c
      47:	6a 01                	push   $0x1
      49:	e8 25 04 00 00       	call   473 <printf>
      4e:	83 c4 10             	add    $0x10,%esp
  while (1) {
      51:	eb be                	jmp    11 <main+0x11>
      break;
      53:	90                   	nop
  }
  exit();
      54:	e8 87 02 00 00       	call   2e0 <exit>

00000059 <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
      59:	55                   	push   %ebp
      5a:	89 e5                	mov    %esp,%ebp
      5c:	57                   	push   %edi
      5d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      5e:	8b 4d 08             	mov    0x8(%ebp),%ecx
      61:	8b 55 10             	mov    0x10(%ebp),%edx
      64:	8b 45 0c             	mov    0xc(%ebp),%eax
      67:	89 cb                	mov    %ecx,%ebx
      69:	89 df                	mov    %ebx,%edi
      6b:	89 d1                	mov    %edx,%ecx
      6d:	fc                   	cld    
      6e:	f3 aa                	rep stos %al,%es:(%edi)
      70:	89 ca                	mov    %ecx,%edx
      72:	89 fb                	mov    %edi,%ebx
      74:	89 5d 08             	mov    %ebx,0x8(%ebp)
      77:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      7a:	90                   	nop
      7b:	5b                   	pop    %ebx
      7c:	5f                   	pop    %edi
      7d:	5d                   	pop    %ebp
      7e:	c3                   	ret    

0000007f <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      7f:	55                   	push   %ebp
      80:	89 e5                	mov    %esp,%ebp
      82:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      85:	8b 45 08             	mov    0x8(%ebp),%eax
      88:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      8b:	90                   	nop
      8c:	8b 55 0c             	mov    0xc(%ebp),%edx
      8f:	8d 42 01             	lea    0x1(%edx),%eax
      92:	89 45 0c             	mov    %eax,0xc(%ebp)
      95:	8b 45 08             	mov    0x8(%ebp),%eax
      98:	8d 48 01             	lea    0x1(%eax),%ecx
      9b:	89 4d 08             	mov    %ecx,0x8(%ebp)
      9e:	0f b6 12             	movzbl (%edx),%edx
      a1:	88 10                	mov    %dl,(%eax)
      a3:	0f b6 00             	movzbl (%eax),%eax
      a6:	84 c0                	test   %al,%al
      a8:	75 e2                	jne    8c <strcpy+0xd>
    ;
  return os;
      aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
      ad:	c9                   	leave  
      ae:	c3                   	ret    

000000af <strcmp>:

int
strcmp(const char *p, const char *q)
{
      af:	55                   	push   %ebp
      b0:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
      b2:	eb 08                	jmp    bc <strcmp+0xd>
    p++, q++;
      b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
      b8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
      bc:	8b 45 08             	mov    0x8(%ebp),%eax
      bf:	0f b6 00             	movzbl (%eax),%eax
      c2:	84 c0                	test   %al,%al
      c4:	74 10                	je     d6 <strcmp+0x27>
      c6:	8b 45 08             	mov    0x8(%ebp),%eax
      c9:	0f b6 10             	movzbl (%eax),%edx
      cc:	8b 45 0c             	mov    0xc(%ebp),%eax
      cf:	0f b6 00             	movzbl (%eax),%eax
      d2:	38 c2                	cmp    %al,%dl
      d4:	74 de                	je     b4 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
      d6:	8b 45 08             	mov    0x8(%ebp),%eax
      d9:	0f b6 00             	movzbl (%eax),%eax
      dc:	0f b6 d0             	movzbl %al,%edx
      df:	8b 45 0c             	mov    0xc(%ebp),%eax
      e2:	0f b6 00             	movzbl (%eax),%eax
      e5:	0f b6 c0             	movzbl %al,%eax
      e8:	29 c2                	sub    %eax,%edx
      ea:	89 d0                	mov    %edx,%eax
}
      ec:	5d                   	pop    %ebp
      ed:	c3                   	ret    

000000ee <strlen>:

uint
strlen(char *s)
{
      ee:	55                   	push   %ebp
      ef:	89 e5                	mov    %esp,%ebp
      f1:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
      f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
      fb:	eb 04                	jmp    101 <strlen+0x13>
      fd:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     101:	8b 55 fc             	mov    -0x4(%ebp),%edx
     104:	8b 45 08             	mov    0x8(%ebp),%eax
     107:	01 d0                	add    %edx,%eax
     109:	0f b6 00             	movzbl (%eax),%eax
     10c:	84 c0                	test   %al,%al
     10e:	75 ed                	jne    fd <strlen+0xf>
    ;
  return n;
     110:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     113:	c9                   	leave  
     114:	c3                   	ret    

00000115 <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     115:	55                   	push   %ebp
     116:	89 e5                	mov    %esp,%ebp
     118:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     11b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     122:	eb 0c                	jmp    130 <strnlen+0x1b>
     n++; 
     124:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     128:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     12c:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     130:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     134:	74 0a                	je     140 <strnlen+0x2b>
     136:	8b 45 08             	mov    0x8(%ebp),%eax
     139:	0f b6 00             	movzbl (%eax),%eax
     13c:	84 c0                	test   %al,%al
     13e:	75 e4                	jne    124 <strnlen+0xf>
   return n; 
     140:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     143:	c9                   	leave  
     144:	c3                   	ret    

00000145 <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     145:	55                   	push   %ebp
     146:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     148:	8b 45 10             	mov    0x10(%ebp),%eax
     14b:	50                   	push   %eax
     14c:	ff 75 0c             	pushl  0xc(%ebp)
     14f:	ff 75 08             	pushl  0x8(%ebp)
     152:	e8 02 ff ff ff       	call   59 <stosb>
     157:	83 c4 0c             	add    $0xc,%esp
  return dst;
     15a:	8b 45 08             	mov    0x8(%ebp),%eax
}
     15d:	c9                   	leave  
     15e:	c3                   	ret    

0000015f <strchr>:

char*
strchr(const char *s, char c)
{
     15f:	55                   	push   %ebp
     160:	89 e5                	mov    %esp,%ebp
     162:	83 ec 04             	sub    $0x4,%esp
     165:	8b 45 0c             	mov    0xc(%ebp),%eax
     168:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     16b:	eb 14                	jmp    181 <strchr+0x22>
    if(*s == c)
     16d:	8b 45 08             	mov    0x8(%ebp),%eax
     170:	0f b6 00             	movzbl (%eax),%eax
     173:	38 45 fc             	cmp    %al,-0x4(%ebp)
     176:	75 05                	jne    17d <strchr+0x1e>
      return (char*)s;
     178:	8b 45 08             	mov    0x8(%ebp),%eax
     17b:	eb 13                	jmp    190 <strchr+0x31>
  for(; *s; s++)
     17d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     181:	8b 45 08             	mov    0x8(%ebp),%eax
     184:	0f b6 00             	movzbl (%eax),%eax
     187:	84 c0                	test   %al,%al
     189:	75 e2                	jne    16d <strchr+0xe>
  return 0;
     18b:	b8 00 00 00 00       	mov    $0x0,%eax
}
     190:	c9                   	leave  
     191:	c3                   	ret    

00000192 <gets>:

char*
gets(char *buf, int max)
{
     192:	55                   	push   %ebp
     193:	89 e5                	mov    %esp,%ebp
     195:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     198:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     19f:	eb 42                	jmp    1e3 <gets+0x51>
    cc = read(0, &c, 1);
     1a1:	83 ec 04             	sub    $0x4,%esp
     1a4:	6a 01                	push   $0x1
     1a6:	8d 45 ef             	lea    -0x11(%ebp),%eax
     1a9:	50                   	push   %eax
     1aa:	6a 00                	push   $0x0
     1ac:	e8 47 01 00 00       	call   2f8 <read>
     1b1:	83 c4 10             	add    $0x10,%esp
     1b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     1b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1bb:	7e 33                	jle    1f0 <gets+0x5e>
      break;
    buf[i++] = c;
     1bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1c0:	8d 50 01             	lea    0x1(%eax),%edx
     1c3:	89 55 f4             	mov    %edx,-0xc(%ebp)
     1c6:	89 c2                	mov    %eax,%edx
     1c8:	8b 45 08             	mov    0x8(%ebp),%eax
     1cb:	01 c2                	add    %eax,%edx
     1cd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1d1:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     1d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1d7:	3c 0a                	cmp    $0xa,%al
     1d9:	74 16                	je     1f1 <gets+0x5f>
     1db:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     1df:	3c 0d                	cmp    $0xd,%al
     1e1:	74 0e                	je     1f1 <gets+0x5f>
  for(i=0; i+1 < max; ){
     1e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1e6:	83 c0 01             	add    $0x1,%eax
     1e9:	39 45 0c             	cmp    %eax,0xc(%ebp)
     1ec:	7f b3                	jg     1a1 <gets+0xf>
     1ee:	eb 01                	jmp    1f1 <gets+0x5f>
      break;
     1f0:	90                   	nop
      break;
  }
  buf[i] = '\0';
     1f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
     1f4:	8b 45 08             	mov    0x8(%ebp),%eax
     1f7:	01 d0                	add    %edx,%eax
     1f9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     1fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1ff:	c9                   	leave  
     200:	c3                   	ret    

00000201 <stat>:

int
stat(char *n, struct stat *st)
{
     201:	55                   	push   %ebp
     202:	89 e5                	mov    %esp,%ebp
     204:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     207:	83 ec 08             	sub    $0x8,%esp
     20a:	6a 00                	push   $0x0
     20c:	ff 75 08             	pushl  0x8(%ebp)
     20f:	e8 0c 01 00 00       	call   320 <open>
     214:	83 c4 10             	add    $0x10,%esp
     217:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     21a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     21e:	79 07                	jns    227 <stat+0x26>
    return -1;
     220:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     225:	eb 25                	jmp    24c <stat+0x4b>
  r = fstat(fd, st);
     227:	83 ec 08             	sub    $0x8,%esp
     22a:	ff 75 0c             	pushl  0xc(%ebp)
     22d:	ff 75 f4             	pushl  -0xc(%ebp)
     230:	e8 03 01 00 00       	call   338 <fstat>
     235:	83 c4 10             	add    $0x10,%esp
     238:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     23b:	83 ec 0c             	sub    $0xc,%esp
     23e:	ff 75 f4             	pushl  -0xc(%ebp)
     241:	e8 c2 00 00 00       	call   308 <close>
     246:	83 c4 10             	add    $0x10,%esp
  return r;
     249:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     24c:	c9                   	leave  
     24d:	c3                   	ret    

0000024e <atoi>:

int
atoi(const char *s)
{
     24e:	55                   	push   %ebp
     24f:	89 e5                	mov    %esp,%ebp
     251:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     25b:	eb 25                	jmp    282 <atoi+0x34>
    n = n*10 + *s++ - '0';
     25d:	8b 55 fc             	mov    -0x4(%ebp),%edx
     260:	89 d0                	mov    %edx,%eax
     262:	c1 e0 02             	shl    $0x2,%eax
     265:	01 d0                	add    %edx,%eax
     267:	01 c0                	add    %eax,%eax
     269:	89 c1                	mov    %eax,%ecx
     26b:	8b 45 08             	mov    0x8(%ebp),%eax
     26e:	8d 50 01             	lea    0x1(%eax),%edx
     271:	89 55 08             	mov    %edx,0x8(%ebp)
     274:	0f b6 00             	movzbl (%eax),%eax
     277:	0f be c0             	movsbl %al,%eax
     27a:	01 c8                	add    %ecx,%eax
     27c:	83 e8 30             	sub    $0x30,%eax
     27f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     282:	8b 45 08             	mov    0x8(%ebp),%eax
     285:	0f b6 00             	movzbl (%eax),%eax
     288:	3c 2f                	cmp    $0x2f,%al
     28a:	7e 0a                	jle    296 <atoi+0x48>
     28c:	8b 45 08             	mov    0x8(%ebp),%eax
     28f:	0f b6 00             	movzbl (%eax),%eax
     292:	3c 39                	cmp    $0x39,%al
     294:	7e c7                	jle    25d <atoi+0xf>
  return n;
     296:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     299:	c9                   	leave  
     29a:	c3                   	ret    

0000029b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     29b:	55                   	push   %ebp
     29c:	89 e5                	mov    %esp,%ebp
     29e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     2a1:	8b 45 08             	mov    0x8(%ebp),%eax
     2a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     2a7:	8b 45 0c             	mov    0xc(%ebp),%eax
     2aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     2ad:	eb 17                	jmp    2c6 <memmove+0x2b>
    *dst++ = *src++;
     2af:	8b 55 f8             	mov    -0x8(%ebp),%edx
     2b2:	8d 42 01             	lea    0x1(%edx),%eax
     2b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
     2b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     2bb:	8d 48 01             	lea    0x1(%eax),%ecx
     2be:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     2c1:	0f b6 12             	movzbl (%edx),%edx
     2c4:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     2c6:	8b 45 10             	mov    0x10(%ebp),%eax
     2c9:	8d 50 ff             	lea    -0x1(%eax),%edx
     2cc:	89 55 10             	mov    %edx,0x10(%ebp)
     2cf:	85 c0                	test   %eax,%eax
     2d1:	7f dc                	jg     2af <memmove+0x14>
  return vdst;
     2d3:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2d6:	c9                   	leave  
     2d7:	c3                   	ret    

000002d8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     2d8:	b8 01 00 00 00       	mov    $0x1,%eax
     2dd:	cd 40                	int    $0x40
     2df:	c3                   	ret    

000002e0 <exit>:
SYSCALL(exit)
     2e0:	b8 02 00 00 00       	mov    $0x2,%eax
     2e5:	cd 40                	int    $0x40
     2e7:	c3                   	ret    

000002e8 <wait>:
SYSCALL(wait)
     2e8:	b8 03 00 00 00       	mov    $0x3,%eax
     2ed:	cd 40                	int    $0x40
     2ef:	c3                   	ret    

000002f0 <pipe>:
SYSCALL(pipe)
     2f0:	b8 04 00 00 00       	mov    $0x4,%eax
     2f5:	cd 40                	int    $0x40
     2f7:	c3                   	ret    

000002f8 <read>:
SYSCALL(read)
     2f8:	b8 05 00 00 00       	mov    $0x5,%eax
     2fd:	cd 40                	int    $0x40
     2ff:	c3                   	ret    

00000300 <write>:
SYSCALL(write)
     300:	b8 10 00 00 00       	mov    $0x10,%eax
     305:	cd 40                	int    $0x40
     307:	c3                   	ret    

00000308 <close>:
SYSCALL(close)
     308:	b8 15 00 00 00       	mov    $0x15,%eax
     30d:	cd 40                	int    $0x40
     30f:	c3                   	ret    

00000310 <kill>:
SYSCALL(kill)
     310:	b8 06 00 00 00       	mov    $0x6,%eax
     315:	cd 40                	int    $0x40
     317:	c3                   	ret    

00000318 <exec>:
SYSCALL(exec)
     318:	b8 07 00 00 00       	mov    $0x7,%eax
     31d:	cd 40                	int    $0x40
     31f:	c3                   	ret    

00000320 <open>:
SYSCALL(open)
     320:	b8 0f 00 00 00       	mov    $0xf,%eax
     325:	cd 40                	int    $0x40
     327:	c3                   	ret    

00000328 <mknod>:
SYSCALL(mknod)
     328:	b8 11 00 00 00       	mov    $0x11,%eax
     32d:	cd 40                	int    $0x40
     32f:	c3                   	ret    

00000330 <unlink>:
SYSCALL(unlink)
     330:	b8 12 00 00 00       	mov    $0x12,%eax
     335:	cd 40                	int    $0x40
     337:	c3                   	ret    

00000338 <fstat>:
SYSCALL(fstat)
     338:	b8 08 00 00 00       	mov    $0x8,%eax
     33d:	cd 40                	int    $0x40
     33f:	c3                   	ret    

00000340 <link>:
SYSCALL(link)
     340:	b8 13 00 00 00       	mov    $0x13,%eax
     345:	cd 40                	int    $0x40
     347:	c3                   	ret    

00000348 <mkdir>:
SYSCALL(mkdir)
     348:	b8 14 00 00 00       	mov    $0x14,%eax
     34d:	cd 40                	int    $0x40
     34f:	c3                   	ret    

00000350 <chdir>:
SYSCALL(chdir)
     350:	b8 09 00 00 00       	mov    $0x9,%eax
     355:	cd 40                	int    $0x40
     357:	c3                   	ret    

00000358 <dup>:
SYSCALL(dup)
     358:	b8 0a 00 00 00       	mov    $0xa,%eax
     35d:	cd 40                	int    $0x40
     35f:	c3                   	ret    

00000360 <getpid>:
SYSCALL(getpid)
     360:	b8 0b 00 00 00       	mov    $0xb,%eax
     365:	cd 40                	int    $0x40
     367:	c3                   	ret    

00000368 <sbrk>:
SYSCALL(sbrk)
     368:	b8 0c 00 00 00       	mov    $0xc,%eax
     36d:	cd 40                	int    $0x40
     36f:	c3                   	ret    

00000370 <sleep>:
SYSCALL(sleep)
     370:	b8 0d 00 00 00       	mov    $0xd,%eax
     375:	cd 40                	int    $0x40
     377:	c3                   	ret    

00000378 <uptime>:
SYSCALL(uptime)
     378:	b8 0e 00 00 00       	mov    $0xe,%eax
     37d:	cd 40                	int    $0x40
     37f:	c3                   	ret    

00000380 <select>:
SYSCALL(select)
     380:	b8 16 00 00 00       	mov    $0x16,%eax
     385:	cd 40                	int    $0x40
     387:	c3                   	ret    

00000388 <arp>:
SYSCALL(arp)
     388:	b8 17 00 00 00       	mov    $0x17,%eax
     38d:	cd 40                	int    $0x40
     38f:	c3                   	ret    

00000390 <arpserv>:
SYSCALL(arpserv)
     390:	b8 18 00 00 00       	mov    $0x18,%eax
     395:	cd 40                	int    $0x40
     397:	c3                   	ret    

00000398 <arp_receive>:
SYSCALL(arp_receive)
     398:	b8 19 00 00 00       	mov    $0x19,%eax
     39d:	cd 40                	int    $0x40
     39f:	c3                   	ret    

000003a0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	83 ec 18             	sub    $0x18,%esp
     3a6:	8b 45 0c             	mov    0xc(%ebp),%eax
     3a9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     3ac:	83 ec 04             	sub    $0x4,%esp
     3af:	6a 01                	push   $0x1
     3b1:	8d 45 f4             	lea    -0xc(%ebp),%eax
     3b4:	50                   	push   %eax
     3b5:	ff 75 08             	pushl  0x8(%ebp)
     3b8:	e8 43 ff ff ff       	call   300 <write>
     3bd:	83 c4 10             	add    $0x10,%esp
}
     3c0:	90                   	nop
     3c1:	c9                   	leave  
     3c2:	c3                   	ret    

000003c3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     3c3:	55                   	push   %ebp
     3c4:	89 e5                	mov    %esp,%ebp
     3c6:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     3c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     3d0:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     3d4:	74 17                	je     3ed <printint+0x2a>
     3d6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     3da:	79 11                	jns    3ed <printint+0x2a>
    neg = 1;
     3dc:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     3e3:	8b 45 0c             	mov    0xc(%ebp),%eax
     3e6:	f7 d8                	neg    %eax
     3e8:	89 45 ec             	mov    %eax,-0x14(%ebp)
     3eb:	eb 06                	jmp    3f3 <printint+0x30>
  } else {
    x = xx;
     3ed:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     3f3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     3fa:	8b 4d 10             	mov    0x10(%ebp),%ecx
     3fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
     400:	ba 00 00 00 00       	mov    $0x0,%edx
     405:	f7 f1                	div    %ecx
     407:	89 d1                	mov    %edx,%ecx
     409:	8b 45 f4             	mov    -0xc(%ebp),%eax
     40c:	8d 50 01             	lea    0x1(%eax),%edx
     40f:	89 55 f4             	mov    %edx,-0xc(%ebp)
     412:	0f b6 91 2c 17 00 00 	movzbl 0x172c(%ecx),%edx
     419:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     41d:	8b 4d 10             	mov    0x10(%ebp),%ecx
     420:	8b 45 ec             	mov    -0x14(%ebp),%eax
     423:	ba 00 00 00 00       	mov    $0x0,%edx
     428:	f7 f1                	div    %ecx
     42a:	89 45 ec             	mov    %eax,-0x14(%ebp)
     42d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     431:	75 c7                	jne    3fa <printint+0x37>
  if(neg)
     433:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     437:	74 2d                	je     466 <printint+0xa3>
    buf[i++] = '-';
     439:	8b 45 f4             	mov    -0xc(%ebp),%eax
     43c:	8d 50 01             	lea    0x1(%eax),%edx
     43f:	89 55 f4             	mov    %edx,-0xc(%ebp)
     442:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     447:	eb 1d                	jmp    466 <printint+0xa3>
    putc(fd, buf[i]);
     449:	8d 55 dc             	lea    -0x24(%ebp),%edx
     44c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     44f:	01 d0                	add    %edx,%eax
     451:	0f b6 00             	movzbl (%eax),%eax
     454:	0f be c0             	movsbl %al,%eax
     457:	83 ec 08             	sub    $0x8,%esp
     45a:	50                   	push   %eax
     45b:	ff 75 08             	pushl  0x8(%ebp)
     45e:	e8 3d ff ff ff       	call   3a0 <putc>
     463:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     466:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     46a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     46e:	79 d9                	jns    449 <printint+0x86>
}
     470:	90                   	nop
     471:	c9                   	leave  
     472:	c3                   	ret    

00000473 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     473:	55                   	push   %ebp
     474:	89 e5                	mov    %esp,%ebp
     476:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     479:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     480:	8d 45 0c             	lea    0xc(%ebp),%eax
     483:	83 c0 04             	add    $0x4,%eax
     486:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     489:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     490:	e9 59 01 00 00       	jmp    5ee <printf+0x17b>
    c = fmt[i] & 0xff;
     495:	8b 55 0c             	mov    0xc(%ebp),%edx
     498:	8b 45 f0             	mov    -0x10(%ebp),%eax
     49b:	01 d0                	add    %edx,%eax
     49d:	0f b6 00             	movzbl (%eax),%eax
     4a0:	0f be c0             	movsbl %al,%eax
     4a3:	25 ff 00 00 00       	and    $0xff,%eax
     4a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     4ab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4af:	75 2c                	jne    4dd <printf+0x6a>
      if(c == '%'){
     4b1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     4b5:	75 0c                	jne    4c3 <printf+0x50>
        state = '%';
     4b7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     4be:	e9 27 01 00 00       	jmp    5ea <printf+0x177>
      } else {
        putc(fd, c);
     4c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     4c6:	0f be c0             	movsbl %al,%eax
     4c9:	83 ec 08             	sub    $0x8,%esp
     4cc:	50                   	push   %eax
     4cd:	ff 75 08             	pushl  0x8(%ebp)
     4d0:	e8 cb fe ff ff       	call   3a0 <putc>
     4d5:	83 c4 10             	add    $0x10,%esp
     4d8:	e9 0d 01 00 00       	jmp    5ea <printf+0x177>
      }
    } else if(state == '%'){
     4dd:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     4e1:	0f 85 03 01 00 00    	jne    5ea <printf+0x177>
      if(c == 'd'){
     4e7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     4eb:	75 1e                	jne    50b <printf+0x98>
        printint(fd, *ap, 10, 1);
     4ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
     4f0:	8b 00                	mov    (%eax),%eax
     4f2:	6a 01                	push   $0x1
     4f4:	6a 0a                	push   $0xa
     4f6:	50                   	push   %eax
     4f7:	ff 75 08             	pushl  0x8(%ebp)
     4fa:	e8 c4 fe ff ff       	call   3c3 <printint>
     4ff:	83 c4 10             	add    $0x10,%esp
        ap++;
     502:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     506:	e9 d8 00 00 00       	jmp    5e3 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     50b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     50f:	74 06                	je     517 <printf+0xa4>
     511:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     515:	75 1e                	jne    535 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     517:	8b 45 e8             	mov    -0x18(%ebp),%eax
     51a:	8b 00                	mov    (%eax),%eax
     51c:	6a 00                	push   $0x0
     51e:	6a 10                	push   $0x10
     520:	50                   	push   %eax
     521:	ff 75 08             	pushl  0x8(%ebp)
     524:	e8 9a fe ff ff       	call   3c3 <printint>
     529:	83 c4 10             	add    $0x10,%esp
        ap++;
     52c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     530:	e9 ae 00 00 00       	jmp    5e3 <printf+0x170>
      } else if(c == 's'){
     535:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     539:	75 43                	jne    57e <printf+0x10b>
        s = (char*)*ap;
     53b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     53e:	8b 00                	mov    (%eax),%eax
     540:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     543:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     547:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     54b:	75 25                	jne    572 <printf+0xff>
          s = "(null)";
     54d:	c7 45 f4 88 10 00 00 	movl   $0x1088,-0xc(%ebp)
        while(*s != 0){
     554:	eb 1c                	jmp    572 <printf+0xff>
          putc(fd, *s);
     556:	8b 45 f4             	mov    -0xc(%ebp),%eax
     559:	0f b6 00             	movzbl (%eax),%eax
     55c:	0f be c0             	movsbl %al,%eax
     55f:	83 ec 08             	sub    $0x8,%esp
     562:	50                   	push   %eax
     563:	ff 75 08             	pushl  0x8(%ebp)
     566:	e8 35 fe ff ff       	call   3a0 <putc>
     56b:	83 c4 10             	add    $0x10,%esp
          s++;
     56e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     572:	8b 45 f4             	mov    -0xc(%ebp),%eax
     575:	0f b6 00             	movzbl (%eax),%eax
     578:	84 c0                	test   %al,%al
     57a:	75 da                	jne    556 <printf+0xe3>
     57c:	eb 65                	jmp    5e3 <printf+0x170>
        }
      } else if(c == 'c'){
     57e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     582:	75 1d                	jne    5a1 <printf+0x12e>
        putc(fd, *ap);
     584:	8b 45 e8             	mov    -0x18(%ebp),%eax
     587:	8b 00                	mov    (%eax),%eax
     589:	0f be c0             	movsbl %al,%eax
     58c:	83 ec 08             	sub    $0x8,%esp
     58f:	50                   	push   %eax
     590:	ff 75 08             	pushl  0x8(%ebp)
     593:	e8 08 fe ff ff       	call   3a0 <putc>
     598:	83 c4 10             	add    $0x10,%esp
        ap++;
     59b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     59f:	eb 42                	jmp    5e3 <printf+0x170>
      } else if(c == '%'){
     5a1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     5a5:	75 17                	jne    5be <printf+0x14b>
        putc(fd, c);
     5a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5aa:	0f be c0             	movsbl %al,%eax
     5ad:	83 ec 08             	sub    $0x8,%esp
     5b0:	50                   	push   %eax
     5b1:	ff 75 08             	pushl  0x8(%ebp)
     5b4:	e8 e7 fd ff ff       	call   3a0 <putc>
     5b9:	83 c4 10             	add    $0x10,%esp
     5bc:	eb 25                	jmp    5e3 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     5be:	83 ec 08             	sub    $0x8,%esp
     5c1:	6a 25                	push   $0x25
     5c3:	ff 75 08             	pushl  0x8(%ebp)
     5c6:	e8 d5 fd ff ff       	call   3a0 <putc>
     5cb:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     5ce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     5d1:	0f be c0             	movsbl %al,%eax
     5d4:	83 ec 08             	sub    $0x8,%esp
     5d7:	50                   	push   %eax
     5d8:	ff 75 08             	pushl  0x8(%ebp)
     5db:	e8 c0 fd ff ff       	call   3a0 <putc>
     5e0:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     5e3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     5ea:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     5ee:	8b 55 0c             	mov    0xc(%ebp),%edx
     5f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5f4:	01 d0                	add    %edx,%eax
     5f6:	0f b6 00             	movzbl (%eax),%eax
     5f9:	84 c0                	test   %al,%al
     5fb:	0f 85 94 fe ff ff    	jne    495 <printf+0x22>
    }
  }
}
     601:	90                   	nop
     602:	c9                   	leave  
     603:	c3                   	ret    

00000604 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     604:	55                   	push   %ebp
     605:	89 e5                	mov    %esp,%ebp
     607:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     60a:	8b 45 08             	mov    0x8(%ebp),%eax
     60d:	83 e8 08             	sub    $0x8,%eax
     610:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     613:	a1 48 17 00 00       	mov    0x1748,%eax
     618:	89 45 fc             	mov    %eax,-0x4(%ebp)
     61b:	eb 24                	jmp    641 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     61d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     620:	8b 00                	mov    (%eax),%eax
     622:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     625:	72 12                	jb     639 <free+0x35>
     627:	8b 45 f8             	mov    -0x8(%ebp),%eax
     62a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     62d:	77 24                	ja     653 <free+0x4f>
     62f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     632:	8b 00                	mov    (%eax),%eax
     634:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     637:	72 1a                	jb     653 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     639:	8b 45 fc             	mov    -0x4(%ebp),%eax
     63c:	8b 00                	mov    (%eax),%eax
     63e:	89 45 fc             	mov    %eax,-0x4(%ebp)
     641:	8b 45 f8             	mov    -0x8(%ebp),%eax
     644:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     647:	76 d4                	jbe    61d <free+0x19>
     649:	8b 45 fc             	mov    -0x4(%ebp),%eax
     64c:	8b 00                	mov    (%eax),%eax
     64e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     651:	73 ca                	jae    61d <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     653:	8b 45 f8             	mov    -0x8(%ebp),%eax
     656:	8b 40 04             	mov    0x4(%eax),%eax
     659:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     660:	8b 45 f8             	mov    -0x8(%ebp),%eax
     663:	01 c2                	add    %eax,%edx
     665:	8b 45 fc             	mov    -0x4(%ebp),%eax
     668:	8b 00                	mov    (%eax),%eax
     66a:	39 c2                	cmp    %eax,%edx
     66c:	75 24                	jne    692 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     671:	8b 50 04             	mov    0x4(%eax),%edx
     674:	8b 45 fc             	mov    -0x4(%ebp),%eax
     677:	8b 00                	mov    (%eax),%eax
     679:	8b 40 04             	mov    0x4(%eax),%eax
     67c:	01 c2                	add    %eax,%edx
     67e:	8b 45 f8             	mov    -0x8(%ebp),%eax
     681:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     684:	8b 45 fc             	mov    -0x4(%ebp),%eax
     687:	8b 00                	mov    (%eax),%eax
     689:	8b 10                	mov    (%eax),%edx
     68b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     68e:	89 10                	mov    %edx,(%eax)
     690:	eb 0a                	jmp    69c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     692:	8b 45 fc             	mov    -0x4(%ebp),%eax
     695:	8b 10                	mov    (%eax),%edx
     697:	8b 45 f8             	mov    -0x8(%ebp),%eax
     69a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     69f:	8b 40 04             	mov    0x4(%eax),%eax
     6a2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ac:	01 d0                	add    %edx,%eax
     6ae:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6b1:	75 20                	jne    6d3 <free+0xcf>
    p->s.size += bp->s.size;
     6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6b6:	8b 50 04             	mov    0x4(%eax),%edx
     6b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6bc:	8b 40 04             	mov    0x4(%eax),%eax
     6bf:	01 c2                	add    %eax,%edx
     6c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     6c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ca:	8b 10                	mov    (%eax),%edx
     6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6cf:	89 10                	mov    %edx,(%eax)
     6d1:	eb 08                	jmp    6db <free+0xd7>
  } else
    p->s.ptr = bp;
     6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d6:	8b 55 f8             	mov    -0x8(%ebp),%edx
     6d9:	89 10                	mov    %edx,(%eax)
  freep = p;
     6db:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6de:	a3 48 17 00 00       	mov    %eax,0x1748
}
     6e3:	90                   	nop
     6e4:	c9                   	leave  
     6e5:	c3                   	ret    

000006e6 <morecore>:

static Header*
morecore(uint nu)
{
     6e6:	55                   	push   %ebp
     6e7:	89 e5                	mov    %esp,%ebp
     6e9:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     6ec:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     6f3:	77 07                	ja     6fc <morecore+0x16>
    nu = 4096;
     6f5:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     6fc:	8b 45 08             	mov    0x8(%ebp),%eax
     6ff:	c1 e0 03             	shl    $0x3,%eax
     702:	83 ec 0c             	sub    $0xc,%esp
     705:	50                   	push   %eax
     706:	e8 5d fc ff ff       	call   368 <sbrk>
     70b:	83 c4 10             	add    $0x10,%esp
     70e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     711:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     715:	75 07                	jne    71e <morecore+0x38>
    return 0;
     717:	b8 00 00 00 00       	mov    $0x0,%eax
     71c:	eb 26                	jmp    744 <morecore+0x5e>
  hp = (Header*)p;
     71e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     721:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     724:	8b 45 f0             	mov    -0x10(%ebp),%eax
     727:	8b 55 08             	mov    0x8(%ebp),%edx
     72a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     72d:	8b 45 f0             	mov    -0x10(%ebp),%eax
     730:	83 c0 08             	add    $0x8,%eax
     733:	83 ec 0c             	sub    $0xc,%esp
     736:	50                   	push   %eax
     737:	e8 c8 fe ff ff       	call   604 <free>
     73c:	83 c4 10             	add    $0x10,%esp
  return freep;
     73f:	a1 48 17 00 00       	mov    0x1748,%eax
}
     744:	c9                   	leave  
     745:	c3                   	ret    

00000746 <malloc>:

void*
malloc(uint nbytes)
{
     746:	55                   	push   %ebp
     747:	89 e5                	mov    %esp,%ebp
     749:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     74c:	8b 45 08             	mov    0x8(%ebp),%eax
     74f:	83 c0 07             	add    $0x7,%eax
     752:	c1 e8 03             	shr    $0x3,%eax
     755:	83 c0 01             	add    $0x1,%eax
     758:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     75b:	a1 48 17 00 00       	mov    0x1748,%eax
     760:	89 45 f0             	mov    %eax,-0x10(%ebp)
     763:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     767:	75 23                	jne    78c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     769:	c7 45 f0 40 17 00 00 	movl   $0x1740,-0x10(%ebp)
     770:	8b 45 f0             	mov    -0x10(%ebp),%eax
     773:	a3 48 17 00 00       	mov    %eax,0x1748
     778:	a1 48 17 00 00       	mov    0x1748,%eax
     77d:	a3 40 17 00 00       	mov    %eax,0x1740
    base.s.size = 0;
     782:	c7 05 44 17 00 00 00 	movl   $0x0,0x1744
     789:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     78c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     78f:	8b 00                	mov    (%eax),%eax
     791:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     794:	8b 45 f4             	mov    -0xc(%ebp),%eax
     797:	8b 40 04             	mov    0x4(%eax),%eax
     79a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     79d:	77 4d                	ja     7ec <malloc+0xa6>
      if(p->s.size == nunits)
     79f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a2:	8b 40 04             	mov    0x4(%eax),%eax
     7a5:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     7a8:	75 0c                	jne    7b6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     7aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ad:	8b 10                	mov    (%eax),%edx
     7af:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7b2:	89 10                	mov    %edx,(%eax)
     7b4:	eb 26                	jmp    7dc <malloc+0x96>
      else {
        p->s.size -= nunits;
     7b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7b9:	8b 40 04             	mov    0x4(%eax),%eax
     7bc:	2b 45 ec             	sub    -0x14(%ebp),%eax
     7bf:	89 c2                	mov    %eax,%edx
     7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     7c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7ca:	8b 40 04             	mov    0x4(%eax),%eax
     7cd:	c1 e0 03             	shl    $0x3,%eax
     7d0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     7d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d6:	8b 55 ec             	mov    -0x14(%ebp),%edx
     7d9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     7dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7df:	a3 48 17 00 00       	mov    %eax,0x1748
      return (void*)(p + 1);
     7e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7e7:	83 c0 08             	add    $0x8,%eax
     7ea:	eb 3b                	jmp    827 <malloc+0xe1>
    }
    if(p == freep)
     7ec:	a1 48 17 00 00       	mov    0x1748,%eax
     7f1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     7f4:	75 1e                	jne    814 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     7f6:	83 ec 0c             	sub    $0xc,%esp
     7f9:	ff 75 ec             	pushl  -0x14(%ebp)
     7fc:	e8 e5 fe ff ff       	call   6e6 <morecore>
     801:	83 c4 10             	add    $0x10,%esp
     804:	89 45 f4             	mov    %eax,-0xc(%ebp)
     807:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     80b:	75 07                	jne    814 <malloc+0xce>
        return 0;
     80d:	b8 00 00 00 00       	mov    $0x0,%eax
     812:	eb 13                	jmp    827 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     814:	8b 45 f4             	mov    -0xc(%ebp),%eax
     817:	89 45 f0             	mov    %eax,-0x10(%ebp)
     81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81d:	8b 00                	mov    (%eax),%eax
     81f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     822:	e9 6d ff ff ff       	jmp    794 <malloc+0x4e>
  }
}
     827:	c9                   	leave  
     828:	c3                   	ret    

00000829 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     829:	55                   	push   %ebp
     82a:	89 e5                	mov    %esp,%ebp
     82c:	53                   	push   %ebx
     82d:	83 ec 14             	sub    $0x14,%esp
     830:	8b 45 10             	mov    0x10(%ebp),%eax
     833:	89 45 f0             	mov    %eax,-0x10(%ebp)
     836:	8b 45 14             	mov    0x14(%ebp),%eax
     839:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     83c:	8b 45 18             	mov    0x18(%ebp),%eax
     83f:	ba 00 00 00 00       	mov    $0x0,%edx
     844:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     847:	72 55                	jb     89e <printnum+0x75>
     849:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     84c:	77 05                	ja     853 <printnum+0x2a>
     84e:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     851:	72 4b                	jb     89e <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     853:	8b 45 1c             	mov    0x1c(%ebp),%eax
     856:	8d 58 ff             	lea    -0x1(%eax),%ebx
     859:	8b 45 18             	mov    0x18(%ebp),%eax
     85c:	ba 00 00 00 00       	mov    $0x0,%edx
     861:	52                   	push   %edx
     862:	50                   	push   %eax
     863:	ff 75 f4             	pushl  -0xc(%ebp)
     866:	ff 75 f0             	pushl  -0x10(%ebp)
     869:	e8 a2 05 00 00       	call   e10 <__udivdi3>
     86e:	83 c4 10             	add    $0x10,%esp
     871:	83 ec 04             	sub    $0x4,%esp
     874:	ff 75 20             	pushl  0x20(%ebp)
     877:	53                   	push   %ebx
     878:	ff 75 18             	pushl  0x18(%ebp)
     87b:	52                   	push   %edx
     87c:	50                   	push   %eax
     87d:	ff 75 0c             	pushl  0xc(%ebp)
     880:	ff 75 08             	pushl  0x8(%ebp)
     883:	e8 a1 ff ff ff       	call   829 <printnum>
     888:	83 c4 20             	add    $0x20,%esp
     88b:	eb 1b                	jmp    8a8 <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     88d:	83 ec 08             	sub    $0x8,%esp
     890:	ff 75 0c             	pushl  0xc(%ebp)
     893:	ff 75 20             	pushl  0x20(%ebp)
     896:	8b 45 08             	mov    0x8(%ebp),%eax
     899:	ff d0                	call   *%eax
     89b:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     89e:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     8a2:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     8a6:	7f e5                	jg     88d <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     8a8:	8b 4d 18             	mov    0x18(%ebp),%ecx
     8ab:	bb 00 00 00 00       	mov    $0x0,%ebx
     8b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     8b6:	53                   	push   %ebx
     8b7:	51                   	push   %ecx
     8b8:	52                   	push   %edx
     8b9:	50                   	push   %eax
     8ba:	e8 71 06 00 00       	call   f30 <__umoddi3>
     8bf:	83 c4 10             	add    $0x10,%esp
     8c2:	05 60 11 00 00       	add    $0x1160,%eax
     8c7:	0f b6 00             	movzbl (%eax),%eax
     8ca:	0f be c0             	movsbl %al,%eax
     8cd:	83 ec 08             	sub    $0x8,%esp
     8d0:	ff 75 0c             	pushl  0xc(%ebp)
     8d3:	50                   	push   %eax
     8d4:	8b 45 08             	mov    0x8(%ebp),%eax
     8d7:	ff d0                	call   *%eax
     8d9:	83 c4 10             	add    $0x10,%esp
}
     8dc:	90                   	nop
     8dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8e0:	c9                   	leave  
     8e1:	c3                   	ret    

000008e2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     8e2:	55                   	push   %ebp
     8e3:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     8e5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     8e9:	7e 14                	jle    8ff <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     8eb:	8b 45 08             	mov    0x8(%ebp),%eax
     8ee:	8b 00                	mov    (%eax),%eax
     8f0:	8d 48 08             	lea    0x8(%eax),%ecx
     8f3:	8b 55 08             	mov    0x8(%ebp),%edx
     8f6:	89 0a                	mov    %ecx,(%edx)
     8f8:	8b 50 04             	mov    0x4(%eax),%edx
     8fb:	8b 00                	mov    (%eax),%eax
     8fd:	eb 30                	jmp    92f <getuint+0x4d>
  else if (lflag)
     8ff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     903:	74 16                	je     91b <getuint+0x39>
    return va_arg(*ap, unsigned long);
     905:	8b 45 08             	mov    0x8(%ebp),%eax
     908:	8b 00                	mov    (%eax),%eax
     90a:	8d 48 04             	lea    0x4(%eax),%ecx
     90d:	8b 55 08             	mov    0x8(%ebp),%edx
     910:	89 0a                	mov    %ecx,(%edx)
     912:	8b 00                	mov    (%eax),%eax
     914:	ba 00 00 00 00       	mov    $0x0,%edx
     919:	eb 14                	jmp    92f <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     91b:	8b 45 08             	mov    0x8(%ebp),%eax
     91e:	8b 00                	mov    (%eax),%eax
     920:	8d 48 04             	lea    0x4(%eax),%ecx
     923:	8b 55 08             	mov    0x8(%ebp),%edx
     926:	89 0a                	mov    %ecx,(%edx)
     928:	8b 00                	mov    (%eax),%eax
     92a:	ba 00 00 00 00       	mov    $0x0,%edx
}
     92f:	5d                   	pop    %ebp
     930:	c3                   	ret    

00000931 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     931:	55                   	push   %ebp
     932:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     934:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     938:	7e 14                	jle    94e <getint+0x1d>
    return va_arg(*ap, long long);
     93a:	8b 45 08             	mov    0x8(%ebp),%eax
     93d:	8b 00                	mov    (%eax),%eax
     93f:	8d 48 08             	lea    0x8(%eax),%ecx
     942:	8b 55 08             	mov    0x8(%ebp),%edx
     945:	89 0a                	mov    %ecx,(%edx)
     947:	8b 50 04             	mov    0x4(%eax),%edx
     94a:	8b 00                	mov    (%eax),%eax
     94c:	eb 28                	jmp    976 <getint+0x45>
  else if (lflag)
     94e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     952:	74 12                	je     966 <getint+0x35>
    return va_arg(*ap, long);
     954:	8b 45 08             	mov    0x8(%ebp),%eax
     957:	8b 00                	mov    (%eax),%eax
     959:	8d 48 04             	lea    0x4(%eax),%ecx
     95c:	8b 55 08             	mov    0x8(%ebp),%edx
     95f:	89 0a                	mov    %ecx,(%edx)
     961:	8b 00                	mov    (%eax),%eax
     963:	99                   	cltd   
     964:	eb 10                	jmp    976 <getint+0x45>
  else
    return va_arg(*ap, int);
     966:	8b 45 08             	mov    0x8(%ebp),%eax
     969:	8b 00                	mov    (%eax),%eax
     96b:	8d 48 04             	lea    0x4(%eax),%ecx
     96e:	8b 55 08             	mov    0x8(%ebp),%edx
     971:	89 0a                	mov    %ecx,(%edx)
     973:	8b 00                	mov    (%eax),%eax
     975:	99                   	cltd   
}
     976:	5d                   	pop    %ebp
     977:	c3                   	ret    

00000978 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     978:	55                   	push   %ebp
     979:	89 e5                	mov    %esp,%ebp
     97b:	56                   	push   %esi
     97c:	53                   	push   %ebx
     97d:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     980:	eb 17                	jmp    999 <vprintfmt+0x21>
      if (ch == '\0')
     982:	85 db                	test   %ebx,%ebx
     984:	0f 84 a0 03 00 00    	je     d2a <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     98a:	83 ec 08             	sub    $0x8,%esp
     98d:	ff 75 0c             	pushl  0xc(%ebp)
     990:	53                   	push   %ebx
     991:	8b 45 08             	mov    0x8(%ebp),%eax
     994:	ff d0                	call   *%eax
     996:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     999:	8b 45 10             	mov    0x10(%ebp),%eax
     99c:	8d 50 01             	lea    0x1(%eax),%edx
     99f:	89 55 10             	mov    %edx,0x10(%ebp)
     9a2:	0f b6 00             	movzbl (%eax),%eax
     9a5:	0f b6 d8             	movzbl %al,%ebx
     9a8:	83 fb 25             	cmp    $0x25,%ebx
     9ab:	75 d5                	jne    982 <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     9ad:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     9b1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     9b8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     9bf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     9c6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     9cd:	8b 45 10             	mov    0x10(%ebp),%eax
     9d0:	8d 50 01             	lea    0x1(%eax),%edx
     9d3:	89 55 10             	mov    %edx,0x10(%ebp)
     9d6:	0f b6 00             	movzbl (%eax),%eax
     9d9:	0f b6 d8             	movzbl %al,%ebx
     9dc:	8d 43 dd             	lea    -0x23(%ebx),%eax
     9df:	83 f8 55             	cmp    $0x55,%eax
     9e2:	0f 87 15 03 00 00    	ja     cfd <vprintfmt+0x385>
     9e8:	8b 04 85 84 11 00 00 	mov    0x1184(,%eax,4),%eax
     9ef:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     9f1:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     9f5:	eb d6                	jmp    9cd <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     9f7:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     9fb:	eb d0                	jmp    9cd <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     9fd:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     a04:	8b 55 e0             	mov    -0x20(%ebp),%edx
     a07:	89 d0                	mov    %edx,%eax
     a09:	c1 e0 02             	shl    $0x2,%eax
     a0c:	01 d0                	add    %edx,%eax
     a0e:	01 c0                	add    %eax,%eax
     a10:	01 d8                	add    %ebx,%eax
     a12:	83 e8 30             	sub    $0x30,%eax
     a15:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     a18:	8b 45 10             	mov    0x10(%ebp),%eax
     a1b:	0f b6 00             	movzbl (%eax),%eax
     a1e:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     a21:	83 fb 2f             	cmp    $0x2f,%ebx
     a24:	7e 39                	jle    a5f <vprintfmt+0xe7>
     a26:	83 fb 39             	cmp    $0x39,%ebx
     a29:	7f 34                	jg     a5f <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     a2b:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     a2f:	eb d3                	jmp    a04 <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     a31:	8b 45 14             	mov    0x14(%ebp),%eax
     a34:	8d 50 04             	lea    0x4(%eax),%edx
     a37:	89 55 14             	mov    %edx,0x14(%ebp)
     a3a:	8b 00                	mov    (%eax),%eax
     a3c:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     a3f:	eb 1f                	jmp    a60 <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     a41:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a45:	79 86                	jns    9cd <vprintfmt+0x55>
        width = 0;
     a47:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     a4e:	e9 7a ff ff ff       	jmp    9cd <vprintfmt+0x55>

    case '#':
      altflag = 1;
     a53:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     a5a:	e9 6e ff ff ff       	jmp    9cd <vprintfmt+0x55>
      goto process_precision;
     a5f:	90                   	nop

process_precision:
      if (width < 0)
     a60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     a64:	0f 89 63 ff ff ff    	jns    9cd <vprintfmt+0x55>
        width = precision, precision = -1;
     a6a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     a70:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     a77:	e9 51 ff ff ff       	jmp    9cd <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     a7c:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     a80:	e9 48 ff ff ff       	jmp    9cd <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     a85:	8b 45 14             	mov    0x14(%ebp),%eax
     a88:	8d 50 04             	lea    0x4(%eax),%edx
     a8b:	89 55 14             	mov    %edx,0x14(%ebp)
     a8e:	8b 00                	mov    (%eax),%eax
     a90:	83 ec 08             	sub    $0x8,%esp
     a93:	ff 75 0c             	pushl  0xc(%ebp)
     a96:	50                   	push   %eax
     a97:	8b 45 08             	mov    0x8(%ebp),%eax
     a9a:	ff d0                	call   *%eax
     a9c:	83 c4 10             	add    $0x10,%esp
      break;
     a9f:	e9 81 02 00 00       	jmp    d25 <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     aa4:	8b 45 14             	mov    0x14(%ebp),%eax
     aa7:	8d 50 04             	lea    0x4(%eax),%edx
     aaa:	89 55 14             	mov    %edx,0x14(%ebp)
     aad:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     aaf:	85 db                	test   %ebx,%ebx
     ab1:	79 02                	jns    ab5 <vprintfmt+0x13d>
        err = -err;
     ab3:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     ab5:	83 fb 0f             	cmp    $0xf,%ebx
     ab8:	7f 0b                	jg     ac5 <vprintfmt+0x14d>
     aba:	8b 34 9d 20 11 00 00 	mov    0x1120(,%ebx,4),%esi
     ac1:	85 f6                	test   %esi,%esi
     ac3:	75 19                	jne    ade <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     ac5:	53                   	push   %ebx
     ac6:	68 71 11 00 00       	push   $0x1171
     acb:	ff 75 0c             	pushl  0xc(%ebp)
     ace:	ff 75 08             	pushl  0x8(%ebp)
     ad1:	e8 5c 02 00 00       	call   d32 <printfmt>
     ad6:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     ad9:	e9 47 02 00 00       	jmp    d25 <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     ade:	56                   	push   %esi
     adf:	68 7a 11 00 00       	push   $0x117a
     ae4:	ff 75 0c             	pushl  0xc(%ebp)
     ae7:	ff 75 08             	pushl  0x8(%ebp)
     aea:	e8 43 02 00 00       	call   d32 <printfmt>
     aef:	83 c4 10             	add    $0x10,%esp
      break;
     af2:	e9 2e 02 00 00       	jmp    d25 <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     af7:	8b 45 14             	mov    0x14(%ebp),%eax
     afa:	8d 50 04             	lea    0x4(%eax),%edx
     afd:	89 55 14             	mov    %edx,0x14(%ebp)
     b00:	8b 30                	mov    (%eax),%esi
     b02:	85 f6                	test   %esi,%esi
     b04:	75 05                	jne    b0b <vprintfmt+0x193>
        p = "(null)";
     b06:	be 7d 11 00 00       	mov    $0x117d,%esi
      if (width > 0 && padc != '-')
     b0b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b0f:	7e 6f                	jle    b80 <vprintfmt+0x208>
     b11:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     b15:	74 69                	je     b80 <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     b17:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b1a:	83 ec 08             	sub    $0x8,%esp
     b1d:	50                   	push   %eax
     b1e:	56                   	push   %esi
     b1f:	e8 f1 f5 ff ff       	call   115 <strnlen>
     b24:	83 c4 10             	add    $0x10,%esp
     b27:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     b2a:	eb 17                	jmp    b43 <vprintfmt+0x1cb>
          putch(padc, putdat);
     b2c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     b30:	83 ec 08             	sub    $0x8,%esp
     b33:	ff 75 0c             	pushl  0xc(%ebp)
     b36:	50                   	push   %eax
     b37:	8b 45 08             	mov    0x8(%ebp),%eax
     b3a:	ff d0                	call   *%eax
     b3c:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     b3f:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b47:	7f e3                	jg     b2c <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b49:	eb 35                	jmp    b80 <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     b4b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     b4f:	74 1c                	je     b6d <vprintfmt+0x1f5>
     b51:	83 fb 1f             	cmp    $0x1f,%ebx
     b54:	7e 05                	jle    b5b <vprintfmt+0x1e3>
     b56:	83 fb 7e             	cmp    $0x7e,%ebx
     b59:	7e 12                	jle    b6d <vprintfmt+0x1f5>
          putch('?', putdat);
     b5b:	83 ec 08             	sub    $0x8,%esp
     b5e:	ff 75 0c             	pushl  0xc(%ebp)
     b61:	6a 3f                	push   $0x3f
     b63:	8b 45 08             	mov    0x8(%ebp),%eax
     b66:	ff d0                	call   *%eax
     b68:	83 c4 10             	add    $0x10,%esp
     b6b:	eb 0f                	jmp    b7c <vprintfmt+0x204>
        else
          putch(ch, putdat);
     b6d:	83 ec 08             	sub    $0x8,%esp
     b70:	ff 75 0c             	pushl  0xc(%ebp)
     b73:	53                   	push   %ebx
     b74:	8b 45 08             	mov    0x8(%ebp),%eax
     b77:	ff d0                	call   *%eax
     b79:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     b7c:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     b80:	89 f0                	mov    %esi,%eax
     b82:	8d 70 01             	lea    0x1(%eax),%esi
     b85:	0f b6 00             	movzbl (%eax),%eax
     b88:	0f be d8             	movsbl %al,%ebx
     b8b:	85 db                	test   %ebx,%ebx
     b8d:	74 26                	je     bb5 <vprintfmt+0x23d>
     b8f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     b93:	78 b6                	js     b4b <vprintfmt+0x1d3>
     b95:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     b99:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     b9d:	79 ac                	jns    b4b <vprintfmt+0x1d3>
      for (; width > 0; width--)
     b9f:	eb 14                	jmp    bb5 <vprintfmt+0x23d>
        putch(' ', putdat);
     ba1:	83 ec 08             	sub    $0x8,%esp
     ba4:	ff 75 0c             	pushl  0xc(%ebp)
     ba7:	6a 20                	push   $0x20
     ba9:	8b 45 08             	mov    0x8(%ebp),%eax
     bac:	ff d0                	call   *%eax
     bae:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     bb1:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     bb5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bb9:	7f e6                	jg     ba1 <vprintfmt+0x229>
      break;
     bbb:	e9 65 01 00 00       	jmp    d25 <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     bc0:	83 ec 08             	sub    $0x8,%esp
     bc3:	ff 75 e8             	pushl  -0x18(%ebp)
     bc6:	8d 45 14             	lea    0x14(%ebp),%eax
     bc9:	50                   	push   %eax
     bca:	e8 62 fd ff ff       	call   931 <getint>
     bcf:	83 c4 10             	add    $0x10,%esp
     bd2:	89 45 f0             	mov    %eax,-0x10(%ebp)
     bd5:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     bd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bdb:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bde:	85 d2                	test   %edx,%edx
     be0:	79 23                	jns    c05 <vprintfmt+0x28d>
        putch('-', putdat);
     be2:	83 ec 08             	sub    $0x8,%esp
     be5:	ff 75 0c             	pushl  0xc(%ebp)
     be8:	6a 2d                	push   $0x2d
     bea:	8b 45 08             	mov    0x8(%ebp),%eax
     bed:	ff d0                	call   *%eax
     bef:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     bf2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     bf5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     bf8:	f7 d8                	neg    %eax
     bfa:	83 d2 00             	adc    $0x0,%edx
     bfd:	f7 da                	neg    %edx
     bff:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c02:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     c05:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c0c:	e9 b6 00 00 00       	jmp    cc7 <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     c11:	83 ec 08             	sub    $0x8,%esp
     c14:	ff 75 e8             	pushl  -0x18(%ebp)
     c17:	8d 45 14             	lea    0x14(%ebp),%eax
     c1a:	50                   	push   %eax
     c1b:	e8 c2 fc ff ff       	call   8e2 <getuint>
     c20:	83 c4 10             	add    $0x10,%esp
     c23:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c26:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     c29:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c30:	e9 92 00 00 00       	jmp    cc7 <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     c35:	83 ec 08             	sub    $0x8,%esp
     c38:	ff 75 0c             	pushl  0xc(%ebp)
     c3b:	6a 58                	push   $0x58
     c3d:	8b 45 08             	mov    0x8(%ebp),%eax
     c40:	ff d0                	call   *%eax
     c42:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c45:	83 ec 08             	sub    $0x8,%esp
     c48:	ff 75 0c             	pushl  0xc(%ebp)
     c4b:	6a 58                	push   $0x58
     c4d:	8b 45 08             	mov    0x8(%ebp),%eax
     c50:	ff d0                	call   *%eax
     c52:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     c55:	83 ec 08             	sub    $0x8,%esp
     c58:	ff 75 0c             	pushl  0xc(%ebp)
     c5b:	6a 58                	push   $0x58
     c5d:	8b 45 08             	mov    0x8(%ebp),%eax
     c60:	ff d0                	call   *%eax
     c62:	83 c4 10             	add    $0x10,%esp
      break;
     c65:	e9 bb 00 00 00       	jmp    d25 <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     c6a:	83 ec 08             	sub    $0x8,%esp
     c6d:	ff 75 0c             	pushl  0xc(%ebp)
     c70:	6a 30                	push   $0x30
     c72:	8b 45 08             	mov    0x8(%ebp),%eax
     c75:	ff d0                	call   *%eax
     c77:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     c7a:	83 ec 08             	sub    $0x8,%esp
     c7d:	ff 75 0c             	pushl  0xc(%ebp)
     c80:	6a 78                	push   $0x78
     c82:	8b 45 08             	mov    0x8(%ebp),%eax
     c85:	ff d0                	call   *%eax
     c87:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     c8a:	8b 45 14             	mov    0x14(%ebp),%eax
     c8d:	8d 50 04             	lea    0x4(%eax),%edx
     c90:	89 55 14             	mov    %edx,0x14(%ebp)
     c93:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     c95:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     c9f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     ca6:	eb 1f                	jmp    cc7 <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     ca8:	83 ec 08             	sub    $0x8,%esp
     cab:	ff 75 e8             	pushl  -0x18(%ebp)
     cae:	8d 45 14             	lea    0x14(%ebp),%eax
     cb1:	50                   	push   %eax
     cb2:	e8 2b fc ff ff       	call   8e2 <getuint>
     cb7:	83 c4 10             	add    $0x10,%esp
     cba:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cbd:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     cc0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     cc7:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     ccb:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cce:	83 ec 04             	sub    $0x4,%esp
     cd1:	52                   	push   %edx
     cd2:	ff 75 e4             	pushl  -0x1c(%ebp)
     cd5:	50                   	push   %eax
     cd6:	ff 75 f4             	pushl  -0xc(%ebp)
     cd9:	ff 75 f0             	pushl  -0x10(%ebp)
     cdc:	ff 75 0c             	pushl  0xc(%ebp)
     cdf:	ff 75 08             	pushl  0x8(%ebp)
     ce2:	e8 42 fb ff ff       	call   829 <printnum>
     ce7:	83 c4 20             	add    $0x20,%esp
      break;
     cea:	eb 39                	jmp    d25 <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     cec:	83 ec 08             	sub    $0x8,%esp
     cef:	ff 75 0c             	pushl  0xc(%ebp)
     cf2:	53                   	push   %ebx
     cf3:	8b 45 08             	mov    0x8(%ebp),%eax
     cf6:	ff d0                	call   *%eax
     cf8:	83 c4 10             	add    $0x10,%esp
      break;
     cfb:	eb 28                	jmp    d25 <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     cfd:	83 ec 08             	sub    $0x8,%esp
     d00:	ff 75 0c             	pushl  0xc(%ebp)
     d03:	6a 25                	push   $0x25
     d05:	8b 45 08             	mov    0x8(%ebp),%eax
     d08:	ff d0                	call   *%eax
     d0a:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     d0d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d11:	eb 04                	jmp    d17 <vprintfmt+0x39f>
     d13:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d17:	8b 45 10             	mov    0x10(%ebp),%eax
     d1a:	83 e8 01             	sub    $0x1,%eax
     d1d:	0f b6 00             	movzbl (%eax),%eax
     d20:	3c 25                	cmp    $0x25,%al
     d22:	75 ef                	jne    d13 <vprintfmt+0x39b>
        /* do nothing */;
      break;
     d24:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     d25:	e9 6f fc ff ff       	jmp    999 <vprintfmt+0x21>
        return;
     d2a:	90                   	nop
    }
  }
}
     d2b:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d2e:	5b                   	pop    %ebx
     d2f:	5e                   	pop    %esi
     d30:	5d                   	pop    %ebp
     d31:	c3                   	ret    

00000d32 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     d32:	55                   	push   %ebp
     d33:	89 e5                	mov    %esp,%ebp
     d35:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     d38:	8d 45 14             	lea    0x14(%ebp),%eax
     d3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     d41:	50                   	push   %eax
     d42:	ff 75 10             	pushl  0x10(%ebp)
     d45:	ff 75 0c             	pushl  0xc(%ebp)
     d48:	ff 75 08             	pushl  0x8(%ebp)
     d4b:	e8 28 fc ff ff       	call   978 <vprintfmt>
     d50:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     d53:	90                   	nop
     d54:	c9                   	leave  
     d55:	c3                   	ret    

00000d56 <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     d56:	55                   	push   %ebp
     d57:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     d59:	8b 45 0c             	mov    0xc(%ebp),%eax
     d5c:	8b 40 08             	mov    0x8(%eax),%eax
     d5f:	8d 50 01             	lea    0x1(%eax),%edx
     d62:	8b 45 0c             	mov    0xc(%ebp),%eax
     d65:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     d68:	8b 45 0c             	mov    0xc(%ebp),%eax
     d6b:	8b 10                	mov    (%eax),%edx
     d6d:	8b 45 0c             	mov    0xc(%ebp),%eax
     d70:	8b 40 04             	mov    0x4(%eax),%eax
     d73:	39 c2                	cmp    %eax,%edx
     d75:	73 12                	jae    d89 <sprintputch+0x33>
    *b->buf++ = ch;
     d77:	8b 45 0c             	mov    0xc(%ebp),%eax
     d7a:	8b 00                	mov    (%eax),%eax
     d7c:	8d 48 01             	lea    0x1(%eax),%ecx
     d7f:	8b 55 0c             	mov    0xc(%ebp),%edx
     d82:	89 0a                	mov    %ecx,(%edx)
     d84:	8b 55 08             	mov    0x8(%ebp),%edx
     d87:	88 10                	mov    %dl,(%eax)
}
     d89:	90                   	nop
     d8a:	5d                   	pop    %ebp
     d8b:	c3                   	ret    

00000d8c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     d8c:	55                   	push   %ebp
     d8d:	89 e5                	mov    %esp,%ebp
     d8f:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     d92:	8b 45 08             	mov    0x8(%ebp),%eax
     d95:	89 45 ec             	mov    %eax,-0x14(%ebp)
     d98:	8b 45 0c             	mov    0xc(%ebp),%eax
     d9b:	8d 50 ff             	lea    -0x1(%eax),%edx
     d9e:	8b 45 08             	mov    0x8(%ebp),%eax
     da1:	01 d0                	add    %edx,%eax
     da3:	89 45 f0             	mov    %eax,-0x10(%ebp)
     da6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     dad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     db1:	74 06                	je     db9 <vsnprintf+0x2d>
     db3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     db7:	7f 07                	jg     dc0 <vsnprintf+0x34>
    return -E_INVAL;
     db9:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     dbe:	eb 20                	jmp    de0 <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     dc0:	ff 75 14             	pushl  0x14(%ebp)
     dc3:	ff 75 10             	pushl  0x10(%ebp)
     dc6:	8d 45 ec             	lea    -0x14(%ebp),%eax
     dc9:	50                   	push   %eax
     dca:	68 56 0d 00 00       	push   $0xd56
     dcf:	e8 a4 fb ff ff       	call   978 <vprintfmt>
     dd4:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     dd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
     dda:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     ddd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     de0:	c9                   	leave  
     de1:	c3                   	ret    

00000de2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     de2:	55                   	push   %ebp
     de3:	89 e5                	mov    %esp,%ebp
     de5:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     de8:	8d 45 14             	lea    0x14(%ebp),%eax
     deb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     dee:	8b 45 f0             	mov    -0x10(%ebp),%eax
     df1:	50                   	push   %eax
     df2:	ff 75 10             	pushl  0x10(%ebp)
     df5:	ff 75 0c             	pushl  0xc(%ebp)
     df8:	ff 75 08             	pushl  0x8(%ebp)
     dfb:	e8 8c ff ff ff       	call   d8c <vsnprintf>
     e00:	83 c4 10             	add    $0x10,%esp
     e03:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     e06:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e09:	c9                   	leave  
     e0a:	c3                   	ret    
     e0b:	66 90                	xchg   %ax,%ax
     e0d:	66 90                	xchg   %ax,%ax
     e0f:	90                   	nop

00000e10 <__udivdi3>:
     e10:	55                   	push   %ebp
     e11:	57                   	push   %edi
     e12:	56                   	push   %esi
     e13:	53                   	push   %ebx
     e14:	83 ec 1c             	sub    $0x1c,%esp
     e17:	8b 54 24 3c          	mov    0x3c(%esp),%edx
     e1b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
     e1f:	8b 74 24 34          	mov    0x34(%esp),%esi
     e23:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     e27:	85 d2                	test   %edx,%edx
     e29:	75 35                	jne    e60 <__udivdi3+0x50>
     e2b:	39 f3                	cmp    %esi,%ebx
     e2d:	0f 87 bd 00 00 00    	ja     ef0 <__udivdi3+0xe0>
     e33:	85 db                	test   %ebx,%ebx
     e35:	89 d9                	mov    %ebx,%ecx
     e37:	75 0b                	jne    e44 <__udivdi3+0x34>
     e39:	b8 01 00 00 00       	mov    $0x1,%eax
     e3e:	31 d2                	xor    %edx,%edx
     e40:	f7 f3                	div    %ebx
     e42:	89 c1                	mov    %eax,%ecx
     e44:	31 d2                	xor    %edx,%edx
     e46:	89 f0                	mov    %esi,%eax
     e48:	f7 f1                	div    %ecx
     e4a:	89 c6                	mov    %eax,%esi
     e4c:	89 e8                	mov    %ebp,%eax
     e4e:	89 f7                	mov    %esi,%edi
     e50:	f7 f1                	div    %ecx
     e52:	89 fa                	mov    %edi,%edx
     e54:	83 c4 1c             	add    $0x1c,%esp
     e57:	5b                   	pop    %ebx
     e58:	5e                   	pop    %esi
     e59:	5f                   	pop    %edi
     e5a:	5d                   	pop    %ebp
     e5b:	c3                   	ret    
     e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e60:	39 f2                	cmp    %esi,%edx
     e62:	77 7c                	ja     ee0 <__udivdi3+0xd0>
     e64:	0f bd fa             	bsr    %edx,%edi
     e67:	83 f7 1f             	xor    $0x1f,%edi
     e6a:	0f 84 98 00 00 00    	je     f08 <__udivdi3+0xf8>
     e70:	89 f9                	mov    %edi,%ecx
     e72:	b8 20 00 00 00       	mov    $0x20,%eax
     e77:	29 f8                	sub    %edi,%eax
     e79:	d3 e2                	shl    %cl,%edx
     e7b:	89 54 24 08          	mov    %edx,0x8(%esp)
     e7f:	89 c1                	mov    %eax,%ecx
     e81:	89 da                	mov    %ebx,%edx
     e83:	d3 ea                	shr    %cl,%edx
     e85:	8b 4c 24 08          	mov    0x8(%esp),%ecx
     e89:	09 d1                	or     %edx,%ecx
     e8b:	89 f2                	mov    %esi,%edx
     e8d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     e91:	89 f9                	mov    %edi,%ecx
     e93:	d3 e3                	shl    %cl,%ebx
     e95:	89 c1                	mov    %eax,%ecx
     e97:	d3 ea                	shr    %cl,%edx
     e99:	89 f9                	mov    %edi,%ecx
     e9b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     e9f:	d3 e6                	shl    %cl,%esi
     ea1:	89 eb                	mov    %ebp,%ebx
     ea3:	89 c1                	mov    %eax,%ecx
     ea5:	d3 eb                	shr    %cl,%ebx
     ea7:	09 de                	or     %ebx,%esi
     ea9:	89 f0                	mov    %esi,%eax
     eab:	f7 74 24 08          	divl   0x8(%esp)
     eaf:	89 d6                	mov    %edx,%esi
     eb1:	89 c3                	mov    %eax,%ebx
     eb3:	f7 64 24 0c          	mull   0xc(%esp)
     eb7:	39 d6                	cmp    %edx,%esi
     eb9:	72 0c                	jb     ec7 <__udivdi3+0xb7>
     ebb:	89 f9                	mov    %edi,%ecx
     ebd:	d3 e5                	shl    %cl,%ebp
     ebf:	39 c5                	cmp    %eax,%ebp
     ec1:	73 5d                	jae    f20 <__udivdi3+0x110>
     ec3:	39 d6                	cmp    %edx,%esi
     ec5:	75 59                	jne    f20 <__udivdi3+0x110>
     ec7:	8d 43 ff             	lea    -0x1(%ebx),%eax
     eca:	31 ff                	xor    %edi,%edi
     ecc:	89 fa                	mov    %edi,%edx
     ece:	83 c4 1c             	add    $0x1c,%esp
     ed1:	5b                   	pop    %ebx
     ed2:	5e                   	pop    %esi
     ed3:	5f                   	pop    %edi
     ed4:	5d                   	pop    %ebp
     ed5:	c3                   	ret    
     ed6:	8d 76 00             	lea    0x0(%esi),%esi
     ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     ee0:	31 ff                	xor    %edi,%edi
     ee2:	31 c0                	xor    %eax,%eax
     ee4:	89 fa                	mov    %edi,%edx
     ee6:	83 c4 1c             	add    $0x1c,%esp
     ee9:	5b                   	pop    %ebx
     eea:	5e                   	pop    %esi
     eeb:	5f                   	pop    %edi
     eec:	5d                   	pop    %ebp
     eed:	c3                   	ret    
     eee:	66 90                	xchg   %ax,%ax
     ef0:	31 ff                	xor    %edi,%edi
     ef2:	89 e8                	mov    %ebp,%eax
     ef4:	89 f2                	mov    %esi,%edx
     ef6:	f7 f3                	div    %ebx
     ef8:	89 fa                	mov    %edi,%edx
     efa:	83 c4 1c             	add    $0x1c,%esp
     efd:	5b                   	pop    %ebx
     efe:	5e                   	pop    %esi
     eff:	5f                   	pop    %edi
     f00:	5d                   	pop    %ebp
     f01:	c3                   	ret    
     f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f08:	39 f2                	cmp    %esi,%edx
     f0a:	72 06                	jb     f12 <__udivdi3+0x102>
     f0c:	31 c0                	xor    %eax,%eax
     f0e:	39 eb                	cmp    %ebp,%ebx
     f10:	77 d2                	ja     ee4 <__udivdi3+0xd4>
     f12:	b8 01 00 00 00       	mov    $0x1,%eax
     f17:	eb cb                	jmp    ee4 <__udivdi3+0xd4>
     f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f20:	89 d8                	mov    %ebx,%eax
     f22:	31 ff                	xor    %edi,%edi
     f24:	eb be                	jmp    ee4 <__udivdi3+0xd4>
     f26:	66 90                	xchg   %ax,%ax
     f28:	66 90                	xchg   %ax,%ax
     f2a:	66 90                	xchg   %ax,%ax
     f2c:	66 90                	xchg   %ax,%ax
     f2e:	66 90                	xchg   %ax,%ax

00000f30 <__umoddi3>:
     f30:	55                   	push   %ebp
     f31:	57                   	push   %edi
     f32:	56                   	push   %esi
     f33:	53                   	push   %ebx
     f34:	83 ec 1c             	sub    $0x1c,%esp
     f37:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
     f3b:	8b 74 24 30          	mov    0x30(%esp),%esi
     f3f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
     f43:	8b 7c 24 38          	mov    0x38(%esp),%edi
     f47:	85 ed                	test   %ebp,%ebp
     f49:	89 f0                	mov    %esi,%eax
     f4b:	89 da                	mov    %ebx,%edx
     f4d:	75 19                	jne    f68 <__umoddi3+0x38>
     f4f:	39 df                	cmp    %ebx,%edi
     f51:	0f 86 b1 00 00 00    	jbe    1008 <__umoddi3+0xd8>
     f57:	f7 f7                	div    %edi
     f59:	89 d0                	mov    %edx,%eax
     f5b:	31 d2                	xor    %edx,%edx
     f5d:	83 c4 1c             	add    $0x1c,%esp
     f60:	5b                   	pop    %ebx
     f61:	5e                   	pop    %esi
     f62:	5f                   	pop    %edi
     f63:	5d                   	pop    %ebp
     f64:	c3                   	ret    
     f65:	8d 76 00             	lea    0x0(%esi),%esi
     f68:	39 dd                	cmp    %ebx,%ebp
     f6a:	77 f1                	ja     f5d <__umoddi3+0x2d>
     f6c:	0f bd cd             	bsr    %ebp,%ecx
     f6f:	83 f1 1f             	xor    $0x1f,%ecx
     f72:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     f76:	0f 84 b4 00 00 00    	je     1030 <__umoddi3+0x100>
     f7c:	b8 20 00 00 00       	mov    $0x20,%eax
     f81:	89 c2                	mov    %eax,%edx
     f83:	8b 44 24 04          	mov    0x4(%esp),%eax
     f87:	29 c2                	sub    %eax,%edx
     f89:	89 c1                	mov    %eax,%ecx
     f8b:	89 f8                	mov    %edi,%eax
     f8d:	d3 e5                	shl    %cl,%ebp
     f8f:	89 d1                	mov    %edx,%ecx
     f91:	89 54 24 0c          	mov    %edx,0xc(%esp)
     f95:	d3 e8                	shr    %cl,%eax
     f97:	09 c5                	or     %eax,%ebp
     f99:	8b 44 24 04          	mov    0x4(%esp),%eax
     f9d:	89 c1                	mov    %eax,%ecx
     f9f:	d3 e7                	shl    %cl,%edi
     fa1:	89 d1                	mov    %edx,%ecx
     fa3:	89 7c 24 08          	mov    %edi,0x8(%esp)
     fa7:	89 df                	mov    %ebx,%edi
     fa9:	d3 ef                	shr    %cl,%edi
     fab:	89 c1                	mov    %eax,%ecx
     fad:	89 f0                	mov    %esi,%eax
     faf:	d3 e3                	shl    %cl,%ebx
     fb1:	89 d1                	mov    %edx,%ecx
     fb3:	89 fa                	mov    %edi,%edx
     fb5:	d3 e8                	shr    %cl,%eax
     fb7:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
     fbc:	09 d8                	or     %ebx,%eax
     fbe:	f7 f5                	div    %ebp
     fc0:	d3 e6                	shl    %cl,%esi
     fc2:	89 d1                	mov    %edx,%ecx
     fc4:	f7 64 24 08          	mull   0x8(%esp)
     fc8:	39 d1                	cmp    %edx,%ecx
     fca:	89 c3                	mov    %eax,%ebx
     fcc:	89 d7                	mov    %edx,%edi
     fce:	72 06                	jb     fd6 <__umoddi3+0xa6>
     fd0:	75 0e                	jne    fe0 <__umoddi3+0xb0>
     fd2:	39 c6                	cmp    %eax,%esi
     fd4:	73 0a                	jae    fe0 <__umoddi3+0xb0>
     fd6:	2b 44 24 08          	sub    0x8(%esp),%eax
     fda:	19 ea                	sbb    %ebp,%edx
     fdc:	89 d7                	mov    %edx,%edi
     fde:	89 c3                	mov    %eax,%ebx
     fe0:	89 ca                	mov    %ecx,%edx
     fe2:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
     fe7:	29 de                	sub    %ebx,%esi
     fe9:	19 fa                	sbb    %edi,%edx
     feb:	8b 5c 24 04          	mov    0x4(%esp),%ebx
     fef:	89 d0                	mov    %edx,%eax
     ff1:	d3 e0                	shl    %cl,%eax
     ff3:	89 d9                	mov    %ebx,%ecx
     ff5:	d3 ee                	shr    %cl,%esi
     ff7:	d3 ea                	shr    %cl,%edx
     ff9:	09 f0                	or     %esi,%eax
     ffb:	83 c4 1c             	add    $0x1c,%esp
     ffe:	5b                   	pop    %ebx
     fff:	5e                   	pop    %esi
    1000:	5f                   	pop    %edi
    1001:	5d                   	pop    %ebp
    1002:	c3                   	ret    
    1003:	90                   	nop
    1004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1008:	85 ff                	test   %edi,%edi
    100a:	89 f9                	mov    %edi,%ecx
    100c:	75 0b                	jne    1019 <__umoddi3+0xe9>
    100e:	b8 01 00 00 00       	mov    $0x1,%eax
    1013:	31 d2                	xor    %edx,%edx
    1015:	f7 f7                	div    %edi
    1017:	89 c1                	mov    %eax,%ecx
    1019:	89 d8                	mov    %ebx,%eax
    101b:	31 d2                	xor    %edx,%edx
    101d:	f7 f1                	div    %ecx
    101f:	89 f0                	mov    %esi,%eax
    1021:	f7 f1                	div    %ecx
    1023:	e9 31 ff ff ff       	jmp    f59 <__umoddi3+0x29>
    1028:	90                   	nop
    1029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1030:	39 dd                	cmp    %ebx,%ebp
    1032:	72 08                	jb     103c <__umoddi3+0x10c>
    1034:	39 f7                	cmp    %esi,%edi
    1036:	0f 87 21 ff ff ff    	ja     f5d <__umoddi3+0x2d>
    103c:	89 da                	mov    %ebx,%edx
    103e:	89 f0                	mov    %esi,%eax
    1040:	29 f8                	sub    %edi,%eax
    1042:	19 ea                	sbb    %ebp,%edx
    1044:	e9 14 ff ff ff       	jmp    f5d <__umoddi3+0x2d>
