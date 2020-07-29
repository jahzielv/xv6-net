
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
      11:	83 ec 08             	sub    $0x8,%esp
      14:	6a 02                	push   $0x2
      16:	68 03 11 00 00       	push   $0x1103
      1b:	e8 a8 03 00 00       	call   3c8 <open>
      20:	83 c4 10             	add    $0x10,%esp
      23:	85 c0                	test   %eax,%eax
      25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
      27:	83 ec 04             	sub    $0x4,%esp
      2a:	6a 01                	push   $0x1
      2c:	6a 01                	push   $0x1
      2e:	68 03 11 00 00       	push   $0x1103
      33:	e8 98 03 00 00       	call   3d0 <mknod>
      38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
      3b:	83 ec 08             	sub    $0x8,%esp
      3e:	6a 02                	push   $0x2
      40:	68 03 11 00 00       	push   $0x1103
      45:	e8 7e 03 00 00       	call   3c8 <open>
      4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
      4d:	83 ec 0c             	sub    $0xc,%esp
      50:	6a 00                	push   $0x0
      52:	e8 a9 03 00 00       	call   400 <dup>
      57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
      5a:	83 ec 0c             	sub    $0xc,%esp
      5d:	6a 00                	push   $0x0
      5f:	e8 9c 03 00 00       	call   400 <dup>
      64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	68 0b 11 00 00       	push   $0x110b
      6f:	6a 01                	push   $0x1
      71:	e8 a5 04 00 00       	call   51b <printf>
      76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
      79:	e8 02 03 00 00       	call   380 <fork>
      7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
      81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
      87:	83 ec 08             	sub    $0x8,%esp
      8a:	68 1e 11 00 00       	push   $0x111e
      8f:	6a 01                	push   $0x1
      91:	e8 85 04 00 00       	call   51b <printf>
      96:	83 c4 10             	add    $0x10,%esp
      exit();
      99:	e8 ea 02 00 00       	call   388 <exit>
    }
    if(pid == 0){
      9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      a2:	75 3e                	jne    e2 <main+0xe2>
      exec("sh", argv);
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	68 ec 17 00 00       	push   $0x17ec
      ac:	68 00 11 00 00       	push   $0x1100
      b1:	e8 0a 03 00 00       	call   3c0 <exec>
      b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
      b9:	83 ec 08             	sub    $0x8,%esp
      bc:	68 31 11 00 00       	push   $0x1131
      c1:	6a 01                	push   $0x1
      c3:	e8 53 04 00 00       	call   51b <printf>
      c8:	83 c4 10             	add    $0x10,%esp
      exit();
      cb:	e8 b8 02 00 00       	call   388 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 47 11 00 00       	push   $0x1147
      d8:	6a 01                	push   $0x1
      da:	e8 3c 04 00 00       	call   51b <printf>
      df:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
      e2:	e8 a9 02 00 00       	call   390 <wait>
      e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
      ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      ee:	0f 88 73 ff ff ff    	js     67 <main+0x67>
      f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
      f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
      fa:	75 d4                	jne    d0 <main+0xd0>
    printf(1, "init: starting sh\n");
      fc:	e9 66 ff ff ff       	jmp    67 <main+0x67>

00000101 <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
     101:	55                   	push   %ebp
     102:	89 e5                	mov    %esp,%ebp
     104:	57                   	push   %edi
     105:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     106:	8b 4d 08             	mov    0x8(%ebp),%ecx
     109:	8b 55 10             	mov    0x10(%ebp),%edx
     10c:	8b 45 0c             	mov    0xc(%ebp),%eax
     10f:	89 cb                	mov    %ecx,%ebx
     111:	89 df                	mov    %ebx,%edi
     113:	89 d1                	mov    %edx,%ecx
     115:	fc                   	cld    
     116:	f3 aa                	rep stos %al,%es:(%edi)
     118:	89 ca                	mov    %ecx,%edx
     11a:	89 fb                	mov    %edi,%ebx
     11c:	89 5d 08             	mov    %ebx,0x8(%ebp)
     11f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     122:	90                   	nop
     123:	5b                   	pop    %ebx
     124:	5f                   	pop    %edi
     125:	5d                   	pop    %ebp
     126:	c3                   	ret    

00000127 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     127:	55                   	push   %ebp
     128:	89 e5                	mov    %esp,%ebp
     12a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     12d:	8b 45 08             	mov    0x8(%ebp),%eax
     130:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     133:	90                   	nop
     134:	8b 55 0c             	mov    0xc(%ebp),%edx
     137:	8d 42 01             	lea    0x1(%edx),%eax
     13a:	89 45 0c             	mov    %eax,0xc(%ebp)
     13d:	8b 45 08             	mov    0x8(%ebp),%eax
     140:	8d 48 01             	lea    0x1(%eax),%ecx
     143:	89 4d 08             	mov    %ecx,0x8(%ebp)
     146:	0f b6 12             	movzbl (%edx),%edx
     149:	88 10                	mov    %dl,(%eax)
     14b:	0f b6 00             	movzbl (%eax),%eax
     14e:	84 c0                	test   %al,%al
     150:	75 e2                	jne    134 <strcpy+0xd>
    ;
  return os;
     152:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     155:	c9                   	leave  
     156:	c3                   	ret    

00000157 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     157:	55                   	push   %ebp
     158:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     15a:	eb 08                	jmp    164 <strcmp+0xd>
    p++, q++;
     15c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     160:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     164:	8b 45 08             	mov    0x8(%ebp),%eax
     167:	0f b6 00             	movzbl (%eax),%eax
     16a:	84 c0                	test   %al,%al
     16c:	74 10                	je     17e <strcmp+0x27>
     16e:	8b 45 08             	mov    0x8(%ebp),%eax
     171:	0f b6 10             	movzbl (%eax),%edx
     174:	8b 45 0c             	mov    0xc(%ebp),%eax
     177:	0f b6 00             	movzbl (%eax),%eax
     17a:	38 c2                	cmp    %al,%dl
     17c:	74 de                	je     15c <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     17e:	8b 45 08             	mov    0x8(%ebp),%eax
     181:	0f b6 00             	movzbl (%eax),%eax
     184:	0f b6 d0             	movzbl %al,%edx
     187:	8b 45 0c             	mov    0xc(%ebp),%eax
     18a:	0f b6 00             	movzbl (%eax),%eax
     18d:	0f b6 c0             	movzbl %al,%eax
     190:	29 c2                	sub    %eax,%edx
     192:	89 d0                	mov    %edx,%eax
}
     194:	5d                   	pop    %ebp
     195:	c3                   	ret    

00000196 <strlen>:

uint
strlen(char *s)
{
     196:	55                   	push   %ebp
     197:	89 e5                	mov    %esp,%ebp
     199:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     19c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1a3:	eb 04                	jmp    1a9 <strlen+0x13>
     1a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
     1ac:	8b 45 08             	mov    0x8(%ebp),%eax
     1af:	01 d0                	add    %edx,%eax
     1b1:	0f b6 00             	movzbl (%eax),%eax
     1b4:	84 c0                	test   %al,%al
     1b6:	75 ed                	jne    1a5 <strlen+0xf>
    ;
  return n;
     1b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1bb:	c9                   	leave  
     1bc:	c3                   	ret    

000001bd <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     1bd:	55                   	push   %ebp
     1be:	89 e5                	mov    %esp,%ebp
     1c0:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     1c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1ca:	eb 0c                	jmp    1d8 <strnlen+0x1b>
     n++; 
     1cc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     1d0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1d4:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     1d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     1dc:	74 0a                	je     1e8 <strnlen+0x2b>
     1de:	8b 45 08             	mov    0x8(%ebp),%eax
     1e1:	0f b6 00             	movzbl (%eax),%eax
     1e4:	84 c0                	test   %al,%al
     1e6:	75 e4                	jne    1cc <strnlen+0xf>
   return n; 
     1e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     1eb:	c9                   	leave  
     1ec:	c3                   	ret    

000001ed <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     1ed:	55                   	push   %ebp
     1ee:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     1f0:	8b 45 10             	mov    0x10(%ebp),%eax
     1f3:	50                   	push   %eax
     1f4:	ff 75 0c             	pushl  0xc(%ebp)
     1f7:	ff 75 08             	pushl  0x8(%ebp)
     1fa:	e8 02 ff ff ff       	call   101 <stosb>
     1ff:	83 c4 0c             	add    $0xc,%esp
  return dst;
     202:	8b 45 08             	mov    0x8(%ebp),%eax
}
     205:	c9                   	leave  
     206:	c3                   	ret    

00000207 <strchr>:

char*
strchr(const char *s, char c)
{
     207:	55                   	push   %ebp
     208:	89 e5                	mov    %esp,%ebp
     20a:	83 ec 04             	sub    $0x4,%esp
     20d:	8b 45 0c             	mov    0xc(%ebp),%eax
     210:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     213:	eb 14                	jmp    229 <strchr+0x22>
    if(*s == c)
     215:	8b 45 08             	mov    0x8(%ebp),%eax
     218:	0f b6 00             	movzbl (%eax),%eax
     21b:	38 45 fc             	cmp    %al,-0x4(%ebp)
     21e:	75 05                	jne    225 <strchr+0x1e>
      return (char*)s;
     220:	8b 45 08             	mov    0x8(%ebp),%eax
     223:	eb 13                	jmp    238 <strchr+0x31>
  for(; *s; s++)
     225:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     229:	8b 45 08             	mov    0x8(%ebp),%eax
     22c:	0f b6 00             	movzbl (%eax),%eax
     22f:	84 c0                	test   %al,%al
     231:	75 e2                	jne    215 <strchr+0xe>
  return 0;
     233:	b8 00 00 00 00       	mov    $0x0,%eax
}
     238:	c9                   	leave  
     239:	c3                   	ret    

0000023a <gets>:

char*
gets(char *buf, int max)
{
     23a:	55                   	push   %ebp
     23b:	89 e5                	mov    %esp,%ebp
     23d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     240:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     247:	eb 42                	jmp    28b <gets+0x51>
    cc = read(0, &c, 1);
     249:	83 ec 04             	sub    $0x4,%esp
     24c:	6a 01                	push   $0x1
     24e:	8d 45 ef             	lea    -0x11(%ebp),%eax
     251:	50                   	push   %eax
     252:	6a 00                	push   $0x0
     254:	e8 47 01 00 00       	call   3a0 <read>
     259:	83 c4 10             	add    $0x10,%esp
     25c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     25f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     263:	7e 33                	jle    298 <gets+0x5e>
      break;
    buf[i++] = c;
     265:	8b 45 f4             	mov    -0xc(%ebp),%eax
     268:	8d 50 01             	lea    0x1(%eax),%edx
     26b:	89 55 f4             	mov    %edx,-0xc(%ebp)
     26e:	89 c2                	mov    %eax,%edx
     270:	8b 45 08             	mov    0x8(%ebp),%eax
     273:	01 c2                	add    %eax,%edx
     275:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     279:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     27b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     27f:	3c 0a                	cmp    $0xa,%al
     281:	74 16                	je     299 <gets+0x5f>
     283:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     287:	3c 0d                	cmp    $0xd,%al
     289:	74 0e                	je     299 <gets+0x5f>
  for(i=0; i+1 < max; ){
     28b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     28e:	83 c0 01             	add    $0x1,%eax
     291:	39 45 0c             	cmp    %eax,0xc(%ebp)
     294:	7f b3                	jg     249 <gets+0xf>
     296:	eb 01                	jmp    299 <gets+0x5f>
      break;
     298:	90                   	nop
      break;
  }
  buf[i] = '\0';
     299:	8b 55 f4             	mov    -0xc(%ebp),%edx
     29c:	8b 45 08             	mov    0x8(%ebp),%eax
     29f:	01 d0                	add    %edx,%eax
     2a1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     2a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2a7:	c9                   	leave  
     2a8:	c3                   	ret    

000002a9 <stat>:

int
stat(char *n, struct stat *st)
{
     2a9:	55                   	push   %ebp
     2aa:	89 e5                	mov    %esp,%ebp
     2ac:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2af:	83 ec 08             	sub    $0x8,%esp
     2b2:	6a 00                	push   $0x0
     2b4:	ff 75 08             	pushl  0x8(%ebp)
     2b7:	e8 0c 01 00 00       	call   3c8 <open>
     2bc:	83 c4 10             	add    $0x10,%esp
     2bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     2c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2c6:	79 07                	jns    2cf <stat+0x26>
    return -1;
     2c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2cd:	eb 25                	jmp    2f4 <stat+0x4b>
  r = fstat(fd, st);
     2cf:	83 ec 08             	sub    $0x8,%esp
     2d2:	ff 75 0c             	pushl  0xc(%ebp)
     2d5:	ff 75 f4             	pushl  -0xc(%ebp)
     2d8:	e8 03 01 00 00       	call   3e0 <fstat>
     2dd:	83 c4 10             	add    $0x10,%esp
     2e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     2e3:	83 ec 0c             	sub    $0xc,%esp
     2e6:	ff 75 f4             	pushl  -0xc(%ebp)
     2e9:	e8 c2 00 00 00       	call   3b0 <close>
     2ee:	83 c4 10             	add    $0x10,%esp
  return r;
     2f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     2f4:	c9                   	leave  
     2f5:	c3                   	ret    

000002f6 <atoi>:

int
atoi(const char *s)
{
     2f6:	55                   	push   %ebp
     2f7:	89 e5                	mov    %esp,%ebp
     2f9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     2fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     303:	eb 25                	jmp    32a <atoi+0x34>
    n = n*10 + *s++ - '0';
     305:	8b 55 fc             	mov    -0x4(%ebp),%edx
     308:	89 d0                	mov    %edx,%eax
     30a:	c1 e0 02             	shl    $0x2,%eax
     30d:	01 d0                	add    %edx,%eax
     30f:	01 c0                	add    %eax,%eax
     311:	89 c1                	mov    %eax,%ecx
     313:	8b 45 08             	mov    0x8(%ebp),%eax
     316:	8d 50 01             	lea    0x1(%eax),%edx
     319:	89 55 08             	mov    %edx,0x8(%ebp)
     31c:	0f b6 00             	movzbl (%eax),%eax
     31f:	0f be c0             	movsbl %al,%eax
     322:	01 c8                	add    %ecx,%eax
     324:	83 e8 30             	sub    $0x30,%eax
     327:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     32a:	8b 45 08             	mov    0x8(%ebp),%eax
     32d:	0f b6 00             	movzbl (%eax),%eax
     330:	3c 2f                	cmp    $0x2f,%al
     332:	7e 0a                	jle    33e <atoi+0x48>
     334:	8b 45 08             	mov    0x8(%ebp),%eax
     337:	0f b6 00             	movzbl (%eax),%eax
     33a:	3c 39                	cmp    $0x39,%al
     33c:	7e c7                	jle    305 <atoi+0xf>
  return n;
     33e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     341:	c9                   	leave  
     342:	c3                   	ret    

00000343 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     343:	55                   	push   %ebp
     344:	89 e5                	mov    %esp,%ebp
     346:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     349:	8b 45 08             	mov    0x8(%ebp),%eax
     34c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     34f:	8b 45 0c             	mov    0xc(%ebp),%eax
     352:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     355:	eb 17                	jmp    36e <memmove+0x2b>
    *dst++ = *src++;
     357:	8b 55 f8             	mov    -0x8(%ebp),%edx
     35a:	8d 42 01             	lea    0x1(%edx),%eax
     35d:	89 45 f8             	mov    %eax,-0x8(%ebp)
     360:	8b 45 fc             	mov    -0x4(%ebp),%eax
     363:	8d 48 01             	lea    0x1(%eax),%ecx
     366:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     369:	0f b6 12             	movzbl (%edx),%edx
     36c:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     36e:	8b 45 10             	mov    0x10(%ebp),%eax
     371:	8d 50 ff             	lea    -0x1(%eax),%edx
     374:	89 55 10             	mov    %edx,0x10(%ebp)
     377:	85 c0                	test   %eax,%eax
     379:	7f dc                	jg     357 <memmove+0x14>
  return vdst;
     37b:	8b 45 08             	mov    0x8(%ebp),%eax
}
     37e:	c9                   	leave  
     37f:	c3                   	ret    

00000380 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     380:	b8 01 00 00 00       	mov    $0x1,%eax
     385:	cd 40                	int    $0x40
     387:	c3                   	ret    

00000388 <exit>:
SYSCALL(exit)
     388:	b8 02 00 00 00       	mov    $0x2,%eax
     38d:	cd 40                	int    $0x40
     38f:	c3                   	ret    

00000390 <wait>:
SYSCALL(wait)
     390:	b8 03 00 00 00       	mov    $0x3,%eax
     395:	cd 40                	int    $0x40
     397:	c3                   	ret    

00000398 <pipe>:
SYSCALL(pipe)
     398:	b8 04 00 00 00       	mov    $0x4,%eax
     39d:	cd 40                	int    $0x40
     39f:	c3                   	ret    

000003a0 <read>:
SYSCALL(read)
     3a0:	b8 05 00 00 00       	mov    $0x5,%eax
     3a5:	cd 40                	int    $0x40
     3a7:	c3                   	ret    

000003a8 <write>:
SYSCALL(write)
     3a8:	b8 10 00 00 00       	mov    $0x10,%eax
     3ad:	cd 40                	int    $0x40
     3af:	c3                   	ret    

000003b0 <close>:
SYSCALL(close)
     3b0:	b8 15 00 00 00       	mov    $0x15,%eax
     3b5:	cd 40                	int    $0x40
     3b7:	c3                   	ret    

000003b8 <kill>:
SYSCALL(kill)
     3b8:	b8 06 00 00 00       	mov    $0x6,%eax
     3bd:	cd 40                	int    $0x40
     3bf:	c3                   	ret    

000003c0 <exec>:
SYSCALL(exec)
     3c0:	b8 07 00 00 00       	mov    $0x7,%eax
     3c5:	cd 40                	int    $0x40
     3c7:	c3                   	ret    

000003c8 <open>:
SYSCALL(open)
     3c8:	b8 0f 00 00 00       	mov    $0xf,%eax
     3cd:	cd 40                	int    $0x40
     3cf:	c3                   	ret    

000003d0 <mknod>:
SYSCALL(mknod)
     3d0:	b8 11 00 00 00       	mov    $0x11,%eax
     3d5:	cd 40                	int    $0x40
     3d7:	c3                   	ret    

000003d8 <unlink>:
SYSCALL(unlink)
     3d8:	b8 12 00 00 00       	mov    $0x12,%eax
     3dd:	cd 40                	int    $0x40
     3df:	c3                   	ret    

000003e0 <fstat>:
SYSCALL(fstat)
     3e0:	b8 08 00 00 00       	mov    $0x8,%eax
     3e5:	cd 40                	int    $0x40
     3e7:	c3                   	ret    

000003e8 <link>:
SYSCALL(link)
     3e8:	b8 13 00 00 00       	mov    $0x13,%eax
     3ed:	cd 40                	int    $0x40
     3ef:	c3                   	ret    

000003f0 <mkdir>:
SYSCALL(mkdir)
     3f0:	b8 14 00 00 00       	mov    $0x14,%eax
     3f5:	cd 40                	int    $0x40
     3f7:	c3                   	ret    

000003f8 <chdir>:
SYSCALL(chdir)
     3f8:	b8 09 00 00 00       	mov    $0x9,%eax
     3fd:	cd 40                	int    $0x40
     3ff:	c3                   	ret    

00000400 <dup>:
SYSCALL(dup)
     400:	b8 0a 00 00 00       	mov    $0xa,%eax
     405:	cd 40                	int    $0x40
     407:	c3                   	ret    

00000408 <getpid>:
SYSCALL(getpid)
     408:	b8 0b 00 00 00       	mov    $0xb,%eax
     40d:	cd 40                	int    $0x40
     40f:	c3                   	ret    

00000410 <sbrk>:
SYSCALL(sbrk)
     410:	b8 0c 00 00 00       	mov    $0xc,%eax
     415:	cd 40                	int    $0x40
     417:	c3                   	ret    

00000418 <sleep>:
SYSCALL(sleep)
     418:	b8 0d 00 00 00       	mov    $0xd,%eax
     41d:	cd 40                	int    $0x40
     41f:	c3                   	ret    

00000420 <uptime>:
SYSCALL(uptime)
     420:	b8 0e 00 00 00       	mov    $0xe,%eax
     425:	cd 40                	int    $0x40
     427:	c3                   	ret    

00000428 <select>:
SYSCALL(select)
     428:	b8 16 00 00 00       	mov    $0x16,%eax
     42d:	cd 40                	int    $0x40
     42f:	c3                   	ret    

00000430 <arp>:
SYSCALL(arp)
     430:	b8 17 00 00 00       	mov    $0x17,%eax
     435:	cd 40                	int    $0x40
     437:	c3                   	ret    

00000438 <arpserv>:
SYSCALL(arpserv)
     438:	b8 18 00 00 00       	mov    $0x18,%eax
     43d:	cd 40                	int    $0x40
     43f:	c3                   	ret    

00000440 <arp_receive>:
SYSCALL(arp_receive)
     440:	b8 19 00 00 00       	mov    $0x19,%eax
     445:	cd 40                	int    $0x40
     447:	c3                   	ret    

00000448 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     448:	55                   	push   %ebp
     449:	89 e5                	mov    %esp,%ebp
     44b:	83 ec 18             	sub    $0x18,%esp
     44e:	8b 45 0c             	mov    0xc(%ebp),%eax
     451:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     454:	83 ec 04             	sub    $0x4,%esp
     457:	6a 01                	push   $0x1
     459:	8d 45 f4             	lea    -0xc(%ebp),%eax
     45c:	50                   	push   %eax
     45d:	ff 75 08             	pushl  0x8(%ebp)
     460:	e8 43 ff ff ff       	call   3a8 <write>
     465:	83 c4 10             	add    $0x10,%esp
}
     468:	90                   	nop
     469:	c9                   	leave  
     46a:	c3                   	ret    

0000046b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     46b:	55                   	push   %ebp
     46c:	89 e5                	mov    %esp,%ebp
     46e:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     471:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     478:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     47c:	74 17                	je     495 <printint+0x2a>
     47e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     482:	79 11                	jns    495 <printint+0x2a>
    neg = 1;
     484:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     48b:	8b 45 0c             	mov    0xc(%ebp),%eax
     48e:	f7 d8                	neg    %eax
     490:	89 45 ec             	mov    %eax,-0x14(%ebp)
     493:	eb 06                	jmp    49b <printint+0x30>
  } else {
    x = xx;
     495:	8b 45 0c             	mov    0xc(%ebp),%eax
     498:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     49b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4a2:	8b 4d 10             	mov    0x10(%ebp),%ecx
     4a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4a8:	ba 00 00 00 00       	mov    $0x0,%edx
     4ad:	f7 f1                	div    %ecx
     4af:	89 d1                	mov    %edx,%ecx
     4b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4b4:	8d 50 01             	lea    0x1(%eax),%edx
     4b7:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4ba:	0f b6 91 f4 17 00 00 	movzbl 0x17f4(%ecx),%edx
     4c1:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     4c5:	8b 4d 10             	mov    0x10(%ebp),%ecx
     4c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4cb:	ba 00 00 00 00       	mov    $0x0,%edx
     4d0:	f7 f1                	div    %ecx
     4d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4d9:	75 c7                	jne    4a2 <printint+0x37>
  if(neg)
     4db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4df:	74 2d                	je     50e <printint+0xa3>
    buf[i++] = '-';
     4e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4e4:	8d 50 01             	lea    0x1(%eax),%edx
     4e7:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4ea:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4ef:	eb 1d                	jmp    50e <printint+0xa3>
    putc(fd, buf[i]);
     4f1:	8d 55 dc             	lea    -0x24(%ebp),%edx
     4f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f7:	01 d0                	add    %edx,%eax
     4f9:	0f b6 00             	movzbl (%eax),%eax
     4fc:	0f be c0             	movsbl %al,%eax
     4ff:	83 ec 08             	sub    $0x8,%esp
     502:	50                   	push   %eax
     503:	ff 75 08             	pushl  0x8(%ebp)
     506:	e8 3d ff ff ff       	call   448 <putc>
     50b:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     50e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     512:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     516:	79 d9                	jns    4f1 <printint+0x86>
}
     518:	90                   	nop
     519:	c9                   	leave  
     51a:	c3                   	ret    

0000051b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     51b:	55                   	push   %ebp
     51c:	89 e5                	mov    %esp,%ebp
     51e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     521:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     528:	8d 45 0c             	lea    0xc(%ebp),%eax
     52b:	83 c0 04             	add    $0x4,%eax
     52e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     531:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     538:	e9 59 01 00 00       	jmp    696 <printf+0x17b>
    c = fmt[i] & 0xff;
     53d:	8b 55 0c             	mov    0xc(%ebp),%edx
     540:	8b 45 f0             	mov    -0x10(%ebp),%eax
     543:	01 d0                	add    %edx,%eax
     545:	0f b6 00             	movzbl (%eax),%eax
     548:	0f be c0             	movsbl %al,%eax
     54b:	25 ff 00 00 00       	and    $0xff,%eax
     550:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     553:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     557:	75 2c                	jne    585 <printf+0x6a>
      if(c == '%'){
     559:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     55d:	75 0c                	jne    56b <printf+0x50>
        state = '%';
     55f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     566:	e9 27 01 00 00       	jmp    692 <printf+0x177>
      } else {
        putc(fd, c);
     56b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     56e:	0f be c0             	movsbl %al,%eax
     571:	83 ec 08             	sub    $0x8,%esp
     574:	50                   	push   %eax
     575:	ff 75 08             	pushl  0x8(%ebp)
     578:	e8 cb fe ff ff       	call   448 <putc>
     57d:	83 c4 10             	add    $0x10,%esp
     580:	e9 0d 01 00 00       	jmp    692 <printf+0x177>
      }
    } else if(state == '%'){
     585:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     589:	0f 85 03 01 00 00    	jne    692 <printf+0x177>
      if(c == 'd'){
     58f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     593:	75 1e                	jne    5b3 <printf+0x98>
        printint(fd, *ap, 10, 1);
     595:	8b 45 e8             	mov    -0x18(%ebp),%eax
     598:	8b 00                	mov    (%eax),%eax
     59a:	6a 01                	push   $0x1
     59c:	6a 0a                	push   $0xa
     59e:	50                   	push   %eax
     59f:	ff 75 08             	pushl  0x8(%ebp)
     5a2:	e8 c4 fe ff ff       	call   46b <printint>
     5a7:	83 c4 10             	add    $0x10,%esp
        ap++;
     5aa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5ae:	e9 d8 00 00 00       	jmp    68b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5b3:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5b7:	74 06                	je     5bf <printf+0xa4>
     5b9:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5bd:	75 1e                	jne    5dd <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5c2:	8b 00                	mov    (%eax),%eax
     5c4:	6a 00                	push   $0x0
     5c6:	6a 10                	push   $0x10
     5c8:	50                   	push   %eax
     5c9:	ff 75 08             	pushl  0x8(%ebp)
     5cc:	e8 9a fe ff ff       	call   46b <printint>
     5d1:	83 c4 10             	add    $0x10,%esp
        ap++;
     5d4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5d8:	e9 ae 00 00 00       	jmp    68b <printf+0x170>
      } else if(c == 's'){
     5dd:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5e1:	75 43                	jne    626 <printf+0x10b>
        s = (char*)*ap;
     5e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5e6:	8b 00                	mov    (%eax),%eax
     5e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5eb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5f3:	75 25                	jne    61a <printf+0xff>
          s = "(null)";
     5f5:	c7 45 f4 50 11 00 00 	movl   $0x1150,-0xc(%ebp)
        while(*s != 0){
     5fc:	eb 1c                	jmp    61a <printf+0xff>
          putc(fd, *s);
     5fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     601:	0f b6 00             	movzbl (%eax),%eax
     604:	0f be c0             	movsbl %al,%eax
     607:	83 ec 08             	sub    $0x8,%esp
     60a:	50                   	push   %eax
     60b:	ff 75 08             	pushl  0x8(%ebp)
     60e:	e8 35 fe ff ff       	call   448 <putc>
     613:	83 c4 10             	add    $0x10,%esp
          s++;
     616:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     61a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     61d:	0f b6 00             	movzbl (%eax),%eax
     620:	84 c0                	test   %al,%al
     622:	75 da                	jne    5fe <printf+0xe3>
     624:	eb 65                	jmp    68b <printf+0x170>
        }
      } else if(c == 'c'){
     626:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     62a:	75 1d                	jne    649 <printf+0x12e>
        putc(fd, *ap);
     62c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     62f:	8b 00                	mov    (%eax),%eax
     631:	0f be c0             	movsbl %al,%eax
     634:	83 ec 08             	sub    $0x8,%esp
     637:	50                   	push   %eax
     638:	ff 75 08             	pushl  0x8(%ebp)
     63b:	e8 08 fe ff ff       	call   448 <putc>
     640:	83 c4 10             	add    $0x10,%esp
        ap++;
     643:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     647:	eb 42                	jmp    68b <printf+0x170>
      } else if(c == '%'){
     649:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     64d:	75 17                	jne    666 <printf+0x14b>
        putc(fd, c);
     64f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     652:	0f be c0             	movsbl %al,%eax
     655:	83 ec 08             	sub    $0x8,%esp
     658:	50                   	push   %eax
     659:	ff 75 08             	pushl  0x8(%ebp)
     65c:	e8 e7 fd ff ff       	call   448 <putc>
     661:	83 c4 10             	add    $0x10,%esp
     664:	eb 25                	jmp    68b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     666:	83 ec 08             	sub    $0x8,%esp
     669:	6a 25                	push   $0x25
     66b:	ff 75 08             	pushl  0x8(%ebp)
     66e:	e8 d5 fd ff ff       	call   448 <putc>
     673:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     676:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     679:	0f be c0             	movsbl %al,%eax
     67c:	83 ec 08             	sub    $0x8,%esp
     67f:	50                   	push   %eax
     680:	ff 75 08             	pushl  0x8(%ebp)
     683:	e8 c0 fd ff ff       	call   448 <putc>
     688:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     68b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     692:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     696:	8b 55 0c             	mov    0xc(%ebp),%edx
     699:	8b 45 f0             	mov    -0x10(%ebp),%eax
     69c:	01 d0                	add    %edx,%eax
     69e:	0f b6 00             	movzbl (%eax),%eax
     6a1:	84 c0                	test   %al,%al
     6a3:	0f 85 94 fe ff ff    	jne    53d <printf+0x22>
    }
  }
}
     6a9:	90                   	nop
     6aa:	c9                   	leave  
     6ab:	c3                   	ret    

000006ac <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6ac:	55                   	push   %ebp
     6ad:	89 e5                	mov    %esp,%ebp
     6af:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6b2:	8b 45 08             	mov    0x8(%ebp),%eax
     6b5:	83 e8 08             	sub    $0x8,%eax
     6b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6bb:	a1 10 18 00 00       	mov    0x1810,%eax
     6c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6c3:	eb 24                	jmp    6e9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6c8:	8b 00                	mov    (%eax),%eax
     6ca:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     6cd:	72 12                	jb     6e1 <free+0x35>
     6cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6d5:	77 24                	ja     6fb <free+0x4f>
     6d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6da:	8b 00                	mov    (%eax),%eax
     6dc:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6df:	72 1a                	jb     6fb <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e4:	8b 00                	mov    (%eax),%eax
     6e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6ec:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6ef:	76 d4                	jbe    6c5 <free+0x19>
     6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f4:	8b 00                	mov    (%eax),%eax
     6f6:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6f9:	73 ca                	jae    6c5 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     6fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6fe:	8b 40 04             	mov    0x4(%eax),%eax
     701:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     708:	8b 45 f8             	mov    -0x8(%ebp),%eax
     70b:	01 c2                	add    %eax,%edx
     70d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     710:	8b 00                	mov    (%eax),%eax
     712:	39 c2                	cmp    %eax,%edx
     714:	75 24                	jne    73a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     716:	8b 45 f8             	mov    -0x8(%ebp),%eax
     719:	8b 50 04             	mov    0x4(%eax),%edx
     71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     71f:	8b 00                	mov    (%eax),%eax
     721:	8b 40 04             	mov    0x4(%eax),%eax
     724:	01 c2                	add    %eax,%edx
     726:	8b 45 f8             	mov    -0x8(%ebp),%eax
     729:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     72c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     72f:	8b 00                	mov    (%eax),%eax
     731:	8b 10                	mov    (%eax),%edx
     733:	8b 45 f8             	mov    -0x8(%ebp),%eax
     736:	89 10                	mov    %edx,(%eax)
     738:	eb 0a                	jmp    744 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     73a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     73d:	8b 10                	mov    (%eax),%edx
     73f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     742:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     744:	8b 45 fc             	mov    -0x4(%ebp),%eax
     747:	8b 40 04             	mov    0x4(%eax),%eax
     74a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     751:	8b 45 fc             	mov    -0x4(%ebp),%eax
     754:	01 d0                	add    %edx,%eax
     756:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     759:	75 20                	jne    77b <free+0xcf>
    p->s.size += bp->s.size;
     75b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     75e:	8b 50 04             	mov    0x4(%eax),%edx
     761:	8b 45 f8             	mov    -0x8(%ebp),%eax
     764:	8b 40 04             	mov    0x4(%eax),%eax
     767:	01 c2                	add    %eax,%edx
     769:	8b 45 fc             	mov    -0x4(%ebp),%eax
     76c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     76f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     772:	8b 10                	mov    (%eax),%edx
     774:	8b 45 fc             	mov    -0x4(%ebp),%eax
     777:	89 10                	mov    %edx,(%eax)
     779:	eb 08                	jmp    783 <free+0xd7>
  } else
    p->s.ptr = bp;
     77b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     77e:	8b 55 f8             	mov    -0x8(%ebp),%edx
     781:	89 10                	mov    %edx,(%eax)
  freep = p;
     783:	8b 45 fc             	mov    -0x4(%ebp),%eax
     786:	a3 10 18 00 00       	mov    %eax,0x1810
}
     78b:	90                   	nop
     78c:	c9                   	leave  
     78d:	c3                   	ret    

0000078e <morecore>:

static Header*
morecore(uint nu)
{
     78e:	55                   	push   %ebp
     78f:	89 e5                	mov    %esp,%ebp
     791:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     794:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     79b:	77 07                	ja     7a4 <morecore+0x16>
    nu = 4096;
     79d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7a4:	8b 45 08             	mov    0x8(%ebp),%eax
     7a7:	c1 e0 03             	shl    $0x3,%eax
     7aa:	83 ec 0c             	sub    $0xc,%esp
     7ad:	50                   	push   %eax
     7ae:	e8 5d fc ff ff       	call   410 <sbrk>
     7b3:	83 c4 10             	add    $0x10,%esp
     7b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7b9:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7bd:	75 07                	jne    7c6 <morecore+0x38>
    return 0;
     7bf:	b8 00 00 00 00       	mov    $0x0,%eax
     7c4:	eb 26                	jmp    7ec <morecore+0x5e>
  hp = (Header*)p;
     7c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7cf:	8b 55 08             	mov    0x8(%ebp),%edx
     7d2:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7d8:	83 c0 08             	add    $0x8,%eax
     7db:	83 ec 0c             	sub    $0xc,%esp
     7de:	50                   	push   %eax
     7df:	e8 c8 fe ff ff       	call   6ac <free>
     7e4:	83 c4 10             	add    $0x10,%esp
  return freep;
     7e7:	a1 10 18 00 00       	mov    0x1810,%eax
}
     7ec:	c9                   	leave  
     7ed:	c3                   	ret    

000007ee <malloc>:

void*
malloc(uint nbytes)
{
     7ee:	55                   	push   %ebp
     7ef:	89 e5                	mov    %esp,%ebp
     7f1:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7f4:	8b 45 08             	mov    0x8(%ebp),%eax
     7f7:	83 c0 07             	add    $0x7,%eax
     7fa:	c1 e8 03             	shr    $0x3,%eax
     7fd:	83 c0 01             	add    $0x1,%eax
     800:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     803:	a1 10 18 00 00       	mov    0x1810,%eax
     808:	89 45 f0             	mov    %eax,-0x10(%ebp)
     80b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     80f:	75 23                	jne    834 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     811:	c7 45 f0 08 18 00 00 	movl   $0x1808,-0x10(%ebp)
     818:	8b 45 f0             	mov    -0x10(%ebp),%eax
     81b:	a3 10 18 00 00       	mov    %eax,0x1810
     820:	a1 10 18 00 00       	mov    0x1810,%eax
     825:	a3 08 18 00 00       	mov    %eax,0x1808
    base.s.size = 0;
     82a:	c7 05 0c 18 00 00 00 	movl   $0x0,0x180c
     831:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     834:	8b 45 f0             	mov    -0x10(%ebp),%eax
     837:	8b 00                	mov    (%eax),%eax
     839:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     83c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83f:	8b 40 04             	mov    0x4(%eax),%eax
     842:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     845:	77 4d                	ja     894 <malloc+0xa6>
      if(p->s.size == nunits)
     847:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84a:	8b 40 04             	mov    0x4(%eax),%eax
     84d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     850:	75 0c                	jne    85e <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     852:	8b 45 f4             	mov    -0xc(%ebp),%eax
     855:	8b 10                	mov    (%eax),%edx
     857:	8b 45 f0             	mov    -0x10(%ebp),%eax
     85a:	89 10                	mov    %edx,(%eax)
     85c:	eb 26                	jmp    884 <malloc+0x96>
      else {
        p->s.size -= nunits;
     85e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     861:	8b 40 04             	mov    0x4(%eax),%eax
     864:	2b 45 ec             	sub    -0x14(%ebp),%eax
     867:	89 c2                	mov    %eax,%edx
     869:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     86f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     872:	8b 40 04             	mov    0x4(%eax),%eax
     875:	c1 e0 03             	shl    $0x3,%eax
     878:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     87b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87e:	8b 55 ec             	mov    -0x14(%ebp),%edx
     881:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     884:	8b 45 f0             	mov    -0x10(%ebp),%eax
     887:	a3 10 18 00 00       	mov    %eax,0x1810
      return (void*)(p + 1);
     88c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88f:	83 c0 08             	add    $0x8,%eax
     892:	eb 3b                	jmp    8cf <malloc+0xe1>
    }
    if(p == freep)
     894:	a1 10 18 00 00       	mov    0x1810,%eax
     899:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     89c:	75 1e                	jne    8bc <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     89e:	83 ec 0c             	sub    $0xc,%esp
     8a1:	ff 75 ec             	pushl  -0x14(%ebp)
     8a4:	e8 e5 fe ff ff       	call   78e <morecore>
     8a9:	83 c4 10             	add    $0x10,%esp
     8ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8b3:	75 07                	jne    8bc <malloc+0xce>
        return 0;
     8b5:	b8 00 00 00 00       	mov    $0x0,%eax
     8ba:	eb 13                	jmp    8cf <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8c5:	8b 00                	mov    (%eax),%eax
     8c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     8ca:	e9 6d ff ff ff       	jmp    83c <malloc+0x4e>
  }
}
     8cf:	c9                   	leave  
     8d0:	c3                   	ret    

000008d1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     8d1:	55                   	push   %ebp
     8d2:	89 e5                	mov    %esp,%ebp
     8d4:	53                   	push   %ebx
     8d5:	83 ec 14             	sub    $0x14,%esp
     8d8:	8b 45 10             	mov    0x10(%ebp),%eax
     8db:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8de:	8b 45 14             	mov    0x14(%ebp),%eax
     8e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     8e4:	8b 45 18             	mov    0x18(%ebp),%eax
     8e7:	ba 00 00 00 00       	mov    $0x0,%edx
     8ec:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     8ef:	72 55                	jb     946 <printnum+0x75>
     8f1:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     8f4:	77 05                	ja     8fb <printnum+0x2a>
     8f6:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     8f9:	72 4b                	jb     946 <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     8fb:	8b 45 1c             	mov    0x1c(%ebp),%eax
     8fe:	8d 58 ff             	lea    -0x1(%eax),%ebx
     901:	8b 45 18             	mov    0x18(%ebp),%eax
     904:	ba 00 00 00 00       	mov    $0x0,%edx
     909:	52                   	push   %edx
     90a:	50                   	push   %eax
     90b:	ff 75 f4             	pushl  -0xc(%ebp)
     90e:	ff 75 f0             	pushl  -0x10(%ebp)
     911:	e8 aa 05 00 00       	call   ec0 <__udivdi3>
     916:	83 c4 10             	add    $0x10,%esp
     919:	83 ec 04             	sub    $0x4,%esp
     91c:	ff 75 20             	pushl  0x20(%ebp)
     91f:	53                   	push   %ebx
     920:	ff 75 18             	pushl  0x18(%ebp)
     923:	52                   	push   %edx
     924:	50                   	push   %eax
     925:	ff 75 0c             	pushl  0xc(%ebp)
     928:	ff 75 08             	pushl  0x8(%ebp)
     92b:	e8 a1 ff ff ff       	call   8d1 <printnum>
     930:	83 c4 20             	add    $0x20,%esp
     933:	eb 1b                	jmp    950 <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     935:	83 ec 08             	sub    $0x8,%esp
     938:	ff 75 0c             	pushl  0xc(%ebp)
     93b:	ff 75 20             	pushl  0x20(%ebp)
     93e:	8b 45 08             	mov    0x8(%ebp),%eax
     941:	ff d0                	call   *%eax
     943:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     946:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     94a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     94e:	7f e5                	jg     935 <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     950:	8b 4d 18             	mov    0x18(%ebp),%ecx
     953:	bb 00 00 00 00       	mov    $0x0,%ebx
     958:	8b 45 f0             	mov    -0x10(%ebp),%eax
     95b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     95e:	53                   	push   %ebx
     95f:	51                   	push   %ecx
     960:	52                   	push   %edx
     961:	50                   	push   %eax
     962:	e8 79 06 00 00       	call   fe0 <__umoddi3>
     967:	83 c4 10             	add    $0x10,%esp
     96a:	05 20 12 00 00       	add    $0x1220,%eax
     96f:	0f b6 00             	movzbl (%eax),%eax
     972:	0f be c0             	movsbl %al,%eax
     975:	83 ec 08             	sub    $0x8,%esp
     978:	ff 75 0c             	pushl  0xc(%ebp)
     97b:	50                   	push   %eax
     97c:	8b 45 08             	mov    0x8(%ebp),%eax
     97f:	ff d0                	call   *%eax
     981:	83 c4 10             	add    $0x10,%esp
}
     984:	90                   	nop
     985:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     988:	c9                   	leave  
     989:	c3                   	ret    

0000098a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     98a:	55                   	push   %ebp
     98b:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     98d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     991:	7e 14                	jle    9a7 <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     993:	8b 45 08             	mov    0x8(%ebp),%eax
     996:	8b 00                	mov    (%eax),%eax
     998:	8d 48 08             	lea    0x8(%eax),%ecx
     99b:	8b 55 08             	mov    0x8(%ebp),%edx
     99e:	89 0a                	mov    %ecx,(%edx)
     9a0:	8b 50 04             	mov    0x4(%eax),%edx
     9a3:	8b 00                	mov    (%eax),%eax
     9a5:	eb 30                	jmp    9d7 <getuint+0x4d>
  else if (lflag)
     9a7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     9ab:	74 16                	je     9c3 <getuint+0x39>
    return va_arg(*ap, unsigned long);
     9ad:	8b 45 08             	mov    0x8(%ebp),%eax
     9b0:	8b 00                	mov    (%eax),%eax
     9b2:	8d 48 04             	lea    0x4(%eax),%ecx
     9b5:	8b 55 08             	mov    0x8(%ebp),%edx
     9b8:	89 0a                	mov    %ecx,(%edx)
     9ba:	8b 00                	mov    (%eax),%eax
     9bc:	ba 00 00 00 00       	mov    $0x0,%edx
     9c1:	eb 14                	jmp    9d7 <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     9c3:	8b 45 08             	mov    0x8(%ebp),%eax
     9c6:	8b 00                	mov    (%eax),%eax
     9c8:	8d 48 04             	lea    0x4(%eax),%ecx
     9cb:	8b 55 08             	mov    0x8(%ebp),%edx
     9ce:	89 0a                	mov    %ecx,(%edx)
     9d0:	8b 00                	mov    (%eax),%eax
     9d2:	ba 00 00 00 00       	mov    $0x0,%edx
}
     9d7:	5d                   	pop    %ebp
     9d8:	c3                   	ret    

000009d9 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     9d9:	55                   	push   %ebp
     9da:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     9dc:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     9e0:	7e 14                	jle    9f6 <getint+0x1d>
    return va_arg(*ap, long long);
     9e2:	8b 45 08             	mov    0x8(%ebp),%eax
     9e5:	8b 00                	mov    (%eax),%eax
     9e7:	8d 48 08             	lea    0x8(%eax),%ecx
     9ea:	8b 55 08             	mov    0x8(%ebp),%edx
     9ed:	89 0a                	mov    %ecx,(%edx)
     9ef:	8b 50 04             	mov    0x4(%eax),%edx
     9f2:	8b 00                	mov    (%eax),%eax
     9f4:	eb 28                	jmp    a1e <getint+0x45>
  else if (lflag)
     9f6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     9fa:	74 12                	je     a0e <getint+0x35>
    return va_arg(*ap, long);
     9fc:	8b 45 08             	mov    0x8(%ebp),%eax
     9ff:	8b 00                	mov    (%eax),%eax
     a01:	8d 48 04             	lea    0x4(%eax),%ecx
     a04:	8b 55 08             	mov    0x8(%ebp),%edx
     a07:	89 0a                	mov    %ecx,(%edx)
     a09:	8b 00                	mov    (%eax),%eax
     a0b:	99                   	cltd   
     a0c:	eb 10                	jmp    a1e <getint+0x45>
  else
    return va_arg(*ap, int);
     a0e:	8b 45 08             	mov    0x8(%ebp),%eax
     a11:	8b 00                	mov    (%eax),%eax
     a13:	8d 48 04             	lea    0x4(%eax),%ecx
     a16:	8b 55 08             	mov    0x8(%ebp),%edx
     a19:	89 0a                	mov    %ecx,(%edx)
     a1b:	8b 00                	mov    (%eax),%eax
     a1d:	99                   	cltd   
}
     a1e:	5d                   	pop    %ebp
     a1f:	c3                   	ret    

00000a20 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	56                   	push   %esi
     a24:	53                   	push   %ebx
     a25:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     a28:	eb 17                	jmp    a41 <vprintfmt+0x21>
      if (ch == '\0')
     a2a:	85 db                	test   %ebx,%ebx
     a2c:	0f 84 a0 03 00 00    	je     dd2 <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     a32:	83 ec 08             	sub    $0x8,%esp
     a35:	ff 75 0c             	pushl  0xc(%ebp)
     a38:	53                   	push   %ebx
     a39:	8b 45 08             	mov    0x8(%ebp),%eax
     a3c:	ff d0                	call   *%eax
     a3e:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     a41:	8b 45 10             	mov    0x10(%ebp),%eax
     a44:	8d 50 01             	lea    0x1(%eax),%edx
     a47:	89 55 10             	mov    %edx,0x10(%ebp)
     a4a:	0f b6 00             	movzbl (%eax),%eax
     a4d:	0f b6 d8             	movzbl %al,%ebx
     a50:	83 fb 25             	cmp    $0x25,%ebx
     a53:	75 d5                	jne    a2a <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     a55:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     a59:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     a60:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     a67:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     a6e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     a75:	8b 45 10             	mov    0x10(%ebp),%eax
     a78:	8d 50 01             	lea    0x1(%eax),%edx
     a7b:	89 55 10             	mov    %edx,0x10(%ebp)
     a7e:	0f b6 00             	movzbl (%eax),%eax
     a81:	0f b6 d8             	movzbl %al,%ebx
     a84:	8d 43 dd             	lea    -0x23(%ebx),%eax
     a87:	83 f8 55             	cmp    $0x55,%eax
     a8a:	0f 87 15 03 00 00    	ja     da5 <vprintfmt+0x385>
     a90:	8b 04 85 44 12 00 00 	mov    0x1244(,%eax,4),%eax
     a97:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     a99:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     a9d:	eb d6                	jmp    a75 <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     a9f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     aa3:	eb d0                	jmp    a75 <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     aa5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     aac:	8b 55 e0             	mov    -0x20(%ebp),%edx
     aaf:	89 d0                	mov    %edx,%eax
     ab1:	c1 e0 02             	shl    $0x2,%eax
     ab4:	01 d0                	add    %edx,%eax
     ab6:	01 c0                	add    %eax,%eax
     ab8:	01 d8                	add    %ebx,%eax
     aba:	83 e8 30             	sub    $0x30,%eax
     abd:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     ac0:	8b 45 10             	mov    0x10(%ebp),%eax
     ac3:	0f b6 00             	movzbl (%eax),%eax
     ac6:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     ac9:	83 fb 2f             	cmp    $0x2f,%ebx
     acc:	7e 39                	jle    b07 <vprintfmt+0xe7>
     ace:	83 fb 39             	cmp    $0x39,%ebx
     ad1:	7f 34                	jg     b07 <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     ad3:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     ad7:	eb d3                	jmp    aac <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     ad9:	8b 45 14             	mov    0x14(%ebp),%eax
     adc:	8d 50 04             	lea    0x4(%eax),%edx
     adf:	89 55 14             	mov    %edx,0x14(%ebp)
     ae2:	8b 00                	mov    (%eax),%eax
     ae4:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     ae7:	eb 1f                	jmp    b08 <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     ae9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     aed:	79 86                	jns    a75 <vprintfmt+0x55>
        width = 0;
     aef:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     af6:	e9 7a ff ff ff       	jmp    a75 <vprintfmt+0x55>

    case '#':
      altflag = 1;
     afb:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     b02:	e9 6e ff ff ff       	jmp    a75 <vprintfmt+0x55>
      goto process_precision;
     b07:	90                   	nop

process_precision:
      if (width < 0)
     b08:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b0c:	0f 89 63 ff ff ff    	jns    a75 <vprintfmt+0x55>
        width = precision, precision = -1;
     b12:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     b18:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     b1f:	e9 51 ff ff ff       	jmp    a75 <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     b24:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     b28:	e9 48 ff ff ff       	jmp    a75 <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     b2d:	8b 45 14             	mov    0x14(%ebp),%eax
     b30:	8d 50 04             	lea    0x4(%eax),%edx
     b33:	89 55 14             	mov    %edx,0x14(%ebp)
     b36:	8b 00                	mov    (%eax),%eax
     b38:	83 ec 08             	sub    $0x8,%esp
     b3b:	ff 75 0c             	pushl  0xc(%ebp)
     b3e:	50                   	push   %eax
     b3f:	8b 45 08             	mov    0x8(%ebp),%eax
     b42:	ff d0                	call   *%eax
     b44:	83 c4 10             	add    $0x10,%esp
      break;
     b47:	e9 81 02 00 00       	jmp    dcd <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     b4c:	8b 45 14             	mov    0x14(%ebp),%eax
     b4f:	8d 50 04             	lea    0x4(%eax),%edx
     b52:	89 55 14             	mov    %edx,0x14(%ebp)
     b55:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     b57:	85 db                	test   %ebx,%ebx
     b59:	79 02                	jns    b5d <vprintfmt+0x13d>
        err = -err;
     b5b:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     b5d:	83 fb 0f             	cmp    $0xf,%ebx
     b60:	7f 0b                	jg     b6d <vprintfmt+0x14d>
     b62:	8b 34 9d e0 11 00 00 	mov    0x11e0(,%ebx,4),%esi
     b69:	85 f6                	test   %esi,%esi
     b6b:	75 19                	jne    b86 <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     b6d:	53                   	push   %ebx
     b6e:	68 31 12 00 00       	push   $0x1231
     b73:	ff 75 0c             	pushl  0xc(%ebp)
     b76:	ff 75 08             	pushl  0x8(%ebp)
     b79:	e8 5c 02 00 00       	call   dda <printfmt>
     b7e:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     b81:	e9 47 02 00 00       	jmp    dcd <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     b86:	56                   	push   %esi
     b87:	68 3a 12 00 00       	push   $0x123a
     b8c:	ff 75 0c             	pushl  0xc(%ebp)
     b8f:	ff 75 08             	pushl  0x8(%ebp)
     b92:	e8 43 02 00 00       	call   dda <printfmt>
     b97:	83 c4 10             	add    $0x10,%esp
      break;
     b9a:	e9 2e 02 00 00       	jmp    dcd <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     b9f:	8b 45 14             	mov    0x14(%ebp),%eax
     ba2:	8d 50 04             	lea    0x4(%eax),%edx
     ba5:	89 55 14             	mov    %edx,0x14(%ebp)
     ba8:	8b 30                	mov    (%eax),%esi
     baa:	85 f6                	test   %esi,%esi
     bac:	75 05                	jne    bb3 <vprintfmt+0x193>
        p = "(null)";
     bae:	be 3d 12 00 00       	mov    $0x123d,%esi
      if (width > 0 && padc != '-')
     bb3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bb7:	7e 6f                	jle    c28 <vprintfmt+0x208>
     bb9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     bbd:	74 69                	je     c28 <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     bbf:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bc2:	83 ec 08             	sub    $0x8,%esp
     bc5:	50                   	push   %eax
     bc6:	56                   	push   %esi
     bc7:	e8 f1 f5 ff ff       	call   1bd <strnlen>
     bcc:	83 c4 10             	add    $0x10,%esp
     bcf:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     bd2:	eb 17                	jmp    beb <vprintfmt+0x1cb>
          putch(padc, putdat);
     bd4:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     bd8:	83 ec 08             	sub    $0x8,%esp
     bdb:	ff 75 0c             	pushl  0xc(%ebp)
     bde:	50                   	push   %eax
     bdf:	8b 45 08             	mov    0x8(%ebp),%eax
     be2:	ff d0                	call   *%eax
     be4:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     be7:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     beb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bef:	7f e3                	jg     bd4 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     bf1:	eb 35                	jmp    c28 <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     bf3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     bf7:	74 1c                	je     c15 <vprintfmt+0x1f5>
     bf9:	83 fb 1f             	cmp    $0x1f,%ebx
     bfc:	7e 05                	jle    c03 <vprintfmt+0x1e3>
     bfe:	83 fb 7e             	cmp    $0x7e,%ebx
     c01:	7e 12                	jle    c15 <vprintfmt+0x1f5>
          putch('?', putdat);
     c03:	83 ec 08             	sub    $0x8,%esp
     c06:	ff 75 0c             	pushl  0xc(%ebp)
     c09:	6a 3f                	push   $0x3f
     c0b:	8b 45 08             	mov    0x8(%ebp),%eax
     c0e:	ff d0                	call   *%eax
     c10:	83 c4 10             	add    $0x10,%esp
     c13:	eb 0f                	jmp    c24 <vprintfmt+0x204>
        else
          putch(ch, putdat);
     c15:	83 ec 08             	sub    $0x8,%esp
     c18:	ff 75 0c             	pushl  0xc(%ebp)
     c1b:	53                   	push   %ebx
     c1c:	8b 45 08             	mov    0x8(%ebp),%eax
     c1f:	ff d0                	call   *%eax
     c21:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     c24:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     c28:	89 f0                	mov    %esi,%eax
     c2a:	8d 70 01             	lea    0x1(%eax),%esi
     c2d:	0f b6 00             	movzbl (%eax),%eax
     c30:	0f be d8             	movsbl %al,%ebx
     c33:	85 db                	test   %ebx,%ebx
     c35:	74 26                	je     c5d <vprintfmt+0x23d>
     c37:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     c3b:	78 b6                	js     bf3 <vprintfmt+0x1d3>
     c3d:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     c41:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     c45:	79 ac                	jns    bf3 <vprintfmt+0x1d3>
      for (; width > 0; width--)
     c47:	eb 14                	jmp    c5d <vprintfmt+0x23d>
        putch(' ', putdat);
     c49:	83 ec 08             	sub    $0x8,%esp
     c4c:	ff 75 0c             	pushl  0xc(%ebp)
     c4f:	6a 20                	push   $0x20
     c51:	8b 45 08             	mov    0x8(%ebp),%eax
     c54:	ff d0                	call   *%eax
     c56:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     c59:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     c5d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c61:	7f e6                	jg     c49 <vprintfmt+0x229>
      break;
     c63:	e9 65 01 00 00       	jmp    dcd <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     c68:	83 ec 08             	sub    $0x8,%esp
     c6b:	ff 75 e8             	pushl  -0x18(%ebp)
     c6e:	8d 45 14             	lea    0x14(%ebp),%eax
     c71:	50                   	push   %eax
     c72:	e8 62 fd ff ff       	call   9d9 <getint>
     c77:	83 c4 10             	add    $0x10,%esp
     c7a:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c7d:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     c80:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c83:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c86:	85 d2                	test   %edx,%edx
     c88:	79 23                	jns    cad <vprintfmt+0x28d>
        putch('-', putdat);
     c8a:	83 ec 08             	sub    $0x8,%esp
     c8d:	ff 75 0c             	pushl  0xc(%ebp)
     c90:	6a 2d                	push   $0x2d
     c92:	8b 45 08             	mov    0x8(%ebp),%eax
     c95:	ff d0                	call   *%eax
     c97:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     c9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c9d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ca0:	f7 d8                	neg    %eax
     ca2:	83 d2 00             	adc    $0x0,%edx
     ca5:	f7 da                	neg    %edx
     ca7:	89 45 f0             	mov    %eax,-0x10(%ebp)
     caa:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     cad:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     cb4:	e9 b6 00 00 00       	jmp    d6f <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     cb9:	83 ec 08             	sub    $0x8,%esp
     cbc:	ff 75 e8             	pushl  -0x18(%ebp)
     cbf:	8d 45 14             	lea    0x14(%ebp),%eax
     cc2:	50                   	push   %eax
     cc3:	e8 c2 fc ff ff       	call   98a <getuint>
     cc8:	83 c4 10             	add    $0x10,%esp
     ccb:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cce:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     cd1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     cd8:	e9 92 00 00 00       	jmp    d6f <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     cdd:	83 ec 08             	sub    $0x8,%esp
     ce0:	ff 75 0c             	pushl  0xc(%ebp)
     ce3:	6a 58                	push   $0x58
     ce5:	8b 45 08             	mov    0x8(%ebp),%eax
     ce8:	ff d0                	call   *%eax
     cea:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     ced:	83 ec 08             	sub    $0x8,%esp
     cf0:	ff 75 0c             	pushl  0xc(%ebp)
     cf3:	6a 58                	push   $0x58
     cf5:	8b 45 08             	mov    0x8(%ebp),%eax
     cf8:	ff d0                	call   *%eax
     cfa:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     cfd:	83 ec 08             	sub    $0x8,%esp
     d00:	ff 75 0c             	pushl  0xc(%ebp)
     d03:	6a 58                	push   $0x58
     d05:	8b 45 08             	mov    0x8(%ebp),%eax
     d08:	ff d0                	call   *%eax
     d0a:	83 c4 10             	add    $0x10,%esp
      break;
     d0d:	e9 bb 00 00 00       	jmp    dcd <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     d12:	83 ec 08             	sub    $0x8,%esp
     d15:	ff 75 0c             	pushl  0xc(%ebp)
     d18:	6a 30                	push   $0x30
     d1a:	8b 45 08             	mov    0x8(%ebp),%eax
     d1d:	ff d0                	call   *%eax
     d1f:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     d22:	83 ec 08             	sub    $0x8,%esp
     d25:	ff 75 0c             	pushl  0xc(%ebp)
     d28:	6a 78                	push   $0x78
     d2a:	8b 45 08             	mov    0x8(%ebp),%eax
     d2d:	ff d0                	call   *%eax
     d2f:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     d32:	8b 45 14             	mov    0x14(%ebp),%eax
     d35:	8d 50 04             	lea    0x4(%eax),%edx
     d38:	89 55 14             	mov    %edx,0x14(%ebp)
     d3b:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     d3d:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d40:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     d47:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     d4e:	eb 1f                	jmp    d6f <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     d50:	83 ec 08             	sub    $0x8,%esp
     d53:	ff 75 e8             	pushl  -0x18(%ebp)
     d56:	8d 45 14             	lea    0x14(%ebp),%eax
     d59:	50                   	push   %eax
     d5a:	e8 2b fc ff ff       	call   98a <getuint>
     d5f:	83 c4 10             	add    $0x10,%esp
     d62:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d65:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     d68:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     d6f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     d73:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d76:	83 ec 04             	sub    $0x4,%esp
     d79:	52                   	push   %edx
     d7a:	ff 75 e4             	pushl  -0x1c(%ebp)
     d7d:	50                   	push   %eax
     d7e:	ff 75 f4             	pushl  -0xc(%ebp)
     d81:	ff 75 f0             	pushl  -0x10(%ebp)
     d84:	ff 75 0c             	pushl  0xc(%ebp)
     d87:	ff 75 08             	pushl  0x8(%ebp)
     d8a:	e8 42 fb ff ff       	call   8d1 <printnum>
     d8f:	83 c4 20             	add    $0x20,%esp
      break;
     d92:	eb 39                	jmp    dcd <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     d94:	83 ec 08             	sub    $0x8,%esp
     d97:	ff 75 0c             	pushl  0xc(%ebp)
     d9a:	53                   	push   %ebx
     d9b:	8b 45 08             	mov    0x8(%ebp),%eax
     d9e:	ff d0                	call   *%eax
     da0:	83 c4 10             	add    $0x10,%esp
      break;
     da3:	eb 28                	jmp    dcd <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     da5:	83 ec 08             	sub    $0x8,%esp
     da8:	ff 75 0c             	pushl  0xc(%ebp)
     dab:	6a 25                	push   $0x25
     dad:	8b 45 08             	mov    0x8(%ebp),%eax
     db0:	ff d0                	call   *%eax
     db2:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     db5:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     db9:	eb 04                	jmp    dbf <vprintfmt+0x39f>
     dbb:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     dbf:	8b 45 10             	mov    0x10(%ebp),%eax
     dc2:	83 e8 01             	sub    $0x1,%eax
     dc5:	0f b6 00             	movzbl (%eax),%eax
     dc8:	3c 25                	cmp    $0x25,%al
     dca:	75 ef                	jne    dbb <vprintfmt+0x39b>
        /* do nothing */;
      break;
     dcc:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     dcd:	e9 6f fc ff ff       	jmp    a41 <vprintfmt+0x21>
        return;
     dd2:	90                   	nop
    }
  }
}
     dd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
     dd6:	5b                   	pop    %ebx
     dd7:	5e                   	pop    %esi
     dd8:	5d                   	pop    %ebp
     dd9:	c3                   	ret    

00000dda <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     dda:	55                   	push   %ebp
     ddb:	89 e5                	mov    %esp,%ebp
     ddd:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     de0:	8d 45 14             	lea    0x14(%ebp),%eax
     de3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     de6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     de9:	50                   	push   %eax
     dea:	ff 75 10             	pushl  0x10(%ebp)
     ded:	ff 75 0c             	pushl  0xc(%ebp)
     df0:	ff 75 08             	pushl  0x8(%ebp)
     df3:	e8 28 fc ff ff       	call   a20 <vprintfmt>
     df8:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     dfb:	90                   	nop
     dfc:	c9                   	leave  
     dfd:	c3                   	ret    

00000dfe <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     dfe:	55                   	push   %ebp
     dff:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     e01:	8b 45 0c             	mov    0xc(%ebp),%eax
     e04:	8b 40 08             	mov    0x8(%eax),%eax
     e07:	8d 50 01             	lea    0x1(%eax),%edx
     e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e0d:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     e10:	8b 45 0c             	mov    0xc(%ebp),%eax
     e13:	8b 10                	mov    (%eax),%edx
     e15:	8b 45 0c             	mov    0xc(%ebp),%eax
     e18:	8b 40 04             	mov    0x4(%eax),%eax
     e1b:	39 c2                	cmp    %eax,%edx
     e1d:	73 12                	jae    e31 <sprintputch+0x33>
    *b->buf++ = ch;
     e1f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e22:	8b 00                	mov    (%eax),%eax
     e24:	8d 48 01             	lea    0x1(%eax),%ecx
     e27:	8b 55 0c             	mov    0xc(%ebp),%edx
     e2a:	89 0a                	mov    %ecx,(%edx)
     e2c:	8b 55 08             	mov    0x8(%ebp),%edx
     e2f:	88 10                	mov    %dl,(%eax)
}
     e31:	90                   	nop
     e32:	5d                   	pop    %ebp
     e33:	c3                   	ret    

00000e34 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     e34:	55                   	push   %ebp
     e35:	89 e5                	mov    %esp,%ebp
     e37:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     e3a:	8b 45 08             	mov    0x8(%ebp),%eax
     e3d:	89 45 ec             	mov    %eax,-0x14(%ebp)
     e40:	8b 45 0c             	mov    0xc(%ebp),%eax
     e43:	8d 50 ff             	lea    -0x1(%eax),%edx
     e46:	8b 45 08             	mov    0x8(%ebp),%eax
     e49:	01 d0                	add    %edx,%eax
     e4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e4e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     e55:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     e59:	74 06                	je     e61 <vsnprintf+0x2d>
     e5b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e5f:	7f 07                	jg     e68 <vsnprintf+0x34>
    return -E_INVAL;
     e61:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     e66:	eb 20                	jmp    e88 <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     e68:	ff 75 14             	pushl  0x14(%ebp)
     e6b:	ff 75 10             	pushl  0x10(%ebp)
     e6e:	8d 45 ec             	lea    -0x14(%ebp),%eax
     e71:	50                   	push   %eax
     e72:	68 fe 0d 00 00       	push   $0xdfe
     e77:	e8 a4 fb ff ff       	call   a20 <vprintfmt>
     e7c:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     e7f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e82:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     e85:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e88:	c9                   	leave  
     e89:	c3                   	ret    

00000e8a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     e8a:	55                   	push   %ebp
     e8b:	89 e5                	mov    %esp,%ebp
     e8d:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     e90:	8d 45 14             	lea    0x14(%ebp),%eax
     e93:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     e96:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e99:	50                   	push   %eax
     e9a:	ff 75 10             	pushl  0x10(%ebp)
     e9d:	ff 75 0c             	pushl  0xc(%ebp)
     ea0:	ff 75 08             	pushl  0x8(%ebp)
     ea3:	e8 8c ff ff ff       	call   e34 <vsnprintf>
     ea8:	83 c4 10             	add    $0x10,%esp
     eab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     eae:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     eb1:	c9                   	leave  
     eb2:	c3                   	ret    
     eb3:	66 90                	xchg   %ax,%ax
     eb5:	66 90                	xchg   %ax,%ax
     eb7:	66 90                	xchg   %ax,%ax
     eb9:	66 90                	xchg   %ax,%ax
     ebb:	66 90                	xchg   %ax,%ax
     ebd:	66 90                	xchg   %ax,%ax
     ebf:	90                   	nop

00000ec0 <__udivdi3>:
     ec0:	55                   	push   %ebp
     ec1:	57                   	push   %edi
     ec2:	56                   	push   %esi
     ec3:	53                   	push   %ebx
     ec4:	83 ec 1c             	sub    $0x1c,%esp
     ec7:	8b 54 24 3c          	mov    0x3c(%esp),%edx
     ecb:	8b 6c 24 30          	mov    0x30(%esp),%ebp
     ecf:	8b 74 24 34          	mov    0x34(%esp),%esi
     ed3:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     ed7:	85 d2                	test   %edx,%edx
     ed9:	75 35                	jne    f10 <__udivdi3+0x50>
     edb:	39 f3                	cmp    %esi,%ebx
     edd:	0f 87 bd 00 00 00    	ja     fa0 <__udivdi3+0xe0>
     ee3:	85 db                	test   %ebx,%ebx
     ee5:	89 d9                	mov    %ebx,%ecx
     ee7:	75 0b                	jne    ef4 <__udivdi3+0x34>
     ee9:	b8 01 00 00 00       	mov    $0x1,%eax
     eee:	31 d2                	xor    %edx,%edx
     ef0:	f7 f3                	div    %ebx
     ef2:	89 c1                	mov    %eax,%ecx
     ef4:	31 d2                	xor    %edx,%edx
     ef6:	89 f0                	mov    %esi,%eax
     ef8:	f7 f1                	div    %ecx
     efa:	89 c6                	mov    %eax,%esi
     efc:	89 e8                	mov    %ebp,%eax
     efe:	89 f7                	mov    %esi,%edi
     f00:	f7 f1                	div    %ecx
     f02:	89 fa                	mov    %edi,%edx
     f04:	83 c4 1c             	add    $0x1c,%esp
     f07:	5b                   	pop    %ebx
     f08:	5e                   	pop    %esi
     f09:	5f                   	pop    %edi
     f0a:	5d                   	pop    %ebp
     f0b:	c3                   	ret    
     f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f10:	39 f2                	cmp    %esi,%edx
     f12:	77 7c                	ja     f90 <__udivdi3+0xd0>
     f14:	0f bd fa             	bsr    %edx,%edi
     f17:	83 f7 1f             	xor    $0x1f,%edi
     f1a:	0f 84 98 00 00 00    	je     fb8 <__udivdi3+0xf8>
     f20:	89 f9                	mov    %edi,%ecx
     f22:	b8 20 00 00 00       	mov    $0x20,%eax
     f27:	29 f8                	sub    %edi,%eax
     f29:	d3 e2                	shl    %cl,%edx
     f2b:	89 54 24 08          	mov    %edx,0x8(%esp)
     f2f:	89 c1                	mov    %eax,%ecx
     f31:	89 da                	mov    %ebx,%edx
     f33:	d3 ea                	shr    %cl,%edx
     f35:	8b 4c 24 08          	mov    0x8(%esp),%ecx
     f39:	09 d1                	or     %edx,%ecx
     f3b:	89 f2                	mov    %esi,%edx
     f3d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     f41:	89 f9                	mov    %edi,%ecx
     f43:	d3 e3                	shl    %cl,%ebx
     f45:	89 c1                	mov    %eax,%ecx
     f47:	d3 ea                	shr    %cl,%edx
     f49:	89 f9                	mov    %edi,%ecx
     f4b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     f4f:	d3 e6                	shl    %cl,%esi
     f51:	89 eb                	mov    %ebp,%ebx
     f53:	89 c1                	mov    %eax,%ecx
     f55:	d3 eb                	shr    %cl,%ebx
     f57:	09 de                	or     %ebx,%esi
     f59:	89 f0                	mov    %esi,%eax
     f5b:	f7 74 24 08          	divl   0x8(%esp)
     f5f:	89 d6                	mov    %edx,%esi
     f61:	89 c3                	mov    %eax,%ebx
     f63:	f7 64 24 0c          	mull   0xc(%esp)
     f67:	39 d6                	cmp    %edx,%esi
     f69:	72 0c                	jb     f77 <__udivdi3+0xb7>
     f6b:	89 f9                	mov    %edi,%ecx
     f6d:	d3 e5                	shl    %cl,%ebp
     f6f:	39 c5                	cmp    %eax,%ebp
     f71:	73 5d                	jae    fd0 <__udivdi3+0x110>
     f73:	39 d6                	cmp    %edx,%esi
     f75:	75 59                	jne    fd0 <__udivdi3+0x110>
     f77:	8d 43 ff             	lea    -0x1(%ebx),%eax
     f7a:	31 ff                	xor    %edi,%edi
     f7c:	89 fa                	mov    %edi,%edx
     f7e:	83 c4 1c             	add    $0x1c,%esp
     f81:	5b                   	pop    %ebx
     f82:	5e                   	pop    %esi
     f83:	5f                   	pop    %edi
     f84:	5d                   	pop    %ebp
     f85:	c3                   	ret    
     f86:	8d 76 00             	lea    0x0(%esi),%esi
     f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     f90:	31 ff                	xor    %edi,%edi
     f92:	31 c0                	xor    %eax,%eax
     f94:	89 fa                	mov    %edi,%edx
     f96:	83 c4 1c             	add    $0x1c,%esp
     f99:	5b                   	pop    %ebx
     f9a:	5e                   	pop    %esi
     f9b:	5f                   	pop    %edi
     f9c:	5d                   	pop    %ebp
     f9d:	c3                   	ret    
     f9e:	66 90                	xchg   %ax,%ax
     fa0:	31 ff                	xor    %edi,%edi
     fa2:	89 e8                	mov    %ebp,%eax
     fa4:	89 f2                	mov    %esi,%edx
     fa6:	f7 f3                	div    %ebx
     fa8:	89 fa                	mov    %edi,%edx
     faa:	83 c4 1c             	add    $0x1c,%esp
     fad:	5b                   	pop    %ebx
     fae:	5e                   	pop    %esi
     faf:	5f                   	pop    %edi
     fb0:	5d                   	pop    %ebp
     fb1:	c3                   	ret    
     fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fb8:	39 f2                	cmp    %esi,%edx
     fba:	72 06                	jb     fc2 <__udivdi3+0x102>
     fbc:	31 c0                	xor    %eax,%eax
     fbe:	39 eb                	cmp    %ebp,%ebx
     fc0:	77 d2                	ja     f94 <__udivdi3+0xd4>
     fc2:	b8 01 00 00 00       	mov    $0x1,%eax
     fc7:	eb cb                	jmp    f94 <__udivdi3+0xd4>
     fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fd0:	89 d8                	mov    %ebx,%eax
     fd2:	31 ff                	xor    %edi,%edi
     fd4:	eb be                	jmp    f94 <__udivdi3+0xd4>
     fd6:	66 90                	xchg   %ax,%ax
     fd8:	66 90                	xchg   %ax,%ax
     fda:	66 90                	xchg   %ax,%ax
     fdc:	66 90                	xchg   %ax,%ax
     fde:	66 90                	xchg   %ax,%ax

00000fe0 <__umoddi3>:
     fe0:	55                   	push   %ebp
     fe1:	57                   	push   %edi
     fe2:	56                   	push   %esi
     fe3:	53                   	push   %ebx
     fe4:	83 ec 1c             	sub    $0x1c,%esp
     fe7:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
     feb:	8b 74 24 30          	mov    0x30(%esp),%esi
     fef:	8b 5c 24 34          	mov    0x34(%esp),%ebx
     ff3:	8b 7c 24 38          	mov    0x38(%esp),%edi
     ff7:	85 ed                	test   %ebp,%ebp
     ff9:	89 f0                	mov    %esi,%eax
     ffb:	89 da                	mov    %ebx,%edx
     ffd:	75 19                	jne    1018 <__umoddi3+0x38>
     fff:	39 df                	cmp    %ebx,%edi
    1001:	0f 86 b1 00 00 00    	jbe    10b8 <__umoddi3+0xd8>
    1007:	f7 f7                	div    %edi
    1009:	89 d0                	mov    %edx,%eax
    100b:	31 d2                	xor    %edx,%edx
    100d:	83 c4 1c             	add    $0x1c,%esp
    1010:	5b                   	pop    %ebx
    1011:	5e                   	pop    %esi
    1012:	5f                   	pop    %edi
    1013:	5d                   	pop    %ebp
    1014:	c3                   	ret    
    1015:	8d 76 00             	lea    0x0(%esi),%esi
    1018:	39 dd                	cmp    %ebx,%ebp
    101a:	77 f1                	ja     100d <__umoddi3+0x2d>
    101c:	0f bd cd             	bsr    %ebp,%ecx
    101f:	83 f1 1f             	xor    $0x1f,%ecx
    1022:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1026:	0f 84 b4 00 00 00    	je     10e0 <__umoddi3+0x100>
    102c:	b8 20 00 00 00       	mov    $0x20,%eax
    1031:	89 c2                	mov    %eax,%edx
    1033:	8b 44 24 04          	mov    0x4(%esp),%eax
    1037:	29 c2                	sub    %eax,%edx
    1039:	89 c1                	mov    %eax,%ecx
    103b:	89 f8                	mov    %edi,%eax
    103d:	d3 e5                	shl    %cl,%ebp
    103f:	89 d1                	mov    %edx,%ecx
    1041:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1045:	d3 e8                	shr    %cl,%eax
    1047:	09 c5                	or     %eax,%ebp
    1049:	8b 44 24 04          	mov    0x4(%esp),%eax
    104d:	89 c1                	mov    %eax,%ecx
    104f:	d3 e7                	shl    %cl,%edi
    1051:	89 d1                	mov    %edx,%ecx
    1053:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1057:	89 df                	mov    %ebx,%edi
    1059:	d3 ef                	shr    %cl,%edi
    105b:	89 c1                	mov    %eax,%ecx
    105d:	89 f0                	mov    %esi,%eax
    105f:	d3 e3                	shl    %cl,%ebx
    1061:	89 d1                	mov    %edx,%ecx
    1063:	89 fa                	mov    %edi,%edx
    1065:	d3 e8                	shr    %cl,%eax
    1067:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
    106c:	09 d8                	or     %ebx,%eax
    106e:	f7 f5                	div    %ebp
    1070:	d3 e6                	shl    %cl,%esi
    1072:	89 d1                	mov    %edx,%ecx
    1074:	f7 64 24 08          	mull   0x8(%esp)
    1078:	39 d1                	cmp    %edx,%ecx
    107a:	89 c3                	mov    %eax,%ebx
    107c:	89 d7                	mov    %edx,%edi
    107e:	72 06                	jb     1086 <__umoddi3+0xa6>
    1080:	75 0e                	jne    1090 <__umoddi3+0xb0>
    1082:	39 c6                	cmp    %eax,%esi
    1084:	73 0a                	jae    1090 <__umoddi3+0xb0>
    1086:	2b 44 24 08          	sub    0x8(%esp),%eax
    108a:	19 ea                	sbb    %ebp,%edx
    108c:	89 d7                	mov    %edx,%edi
    108e:	89 c3                	mov    %eax,%ebx
    1090:	89 ca                	mov    %ecx,%edx
    1092:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
    1097:	29 de                	sub    %ebx,%esi
    1099:	19 fa                	sbb    %edi,%edx
    109b:	8b 5c 24 04          	mov    0x4(%esp),%ebx
    109f:	89 d0                	mov    %edx,%eax
    10a1:	d3 e0                	shl    %cl,%eax
    10a3:	89 d9                	mov    %ebx,%ecx
    10a5:	d3 ee                	shr    %cl,%esi
    10a7:	d3 ea                	shr    %cl,%edx
    10a9:	09 f0                	or     %esi,%eax
    10ab:	83 c4 1c             	add    $0x1c,%esp
    10ae:	5b                   	pop    %ebx
    10af:	5e                   	pop    %esi
    10b0:	5f                   	pop    %edi
    10b1:	5d                   	pop    %ebp
    10b2:	c3                   	ret    
    10b3:	90                   	nop
    10b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10b8:	85 ff                	test   %edi,%edi
    10ba:	89 f9                	mov    %edi,%ecx
    10bc:	75 0b                	jne    10c9 <__umoddi3+0xe9>
    10be:	b8 01 00 00 00       	mov    $0x1,%eax
    10c3:	31 d2                	xor    %edx,%edx
    10c5:	f7 f7                	div    %edi
    10c7:	89 c1                	mov    %eax,%ecx
    10c9:	89 d8                	mov    %ebx,%eax
    10cb:	31 d2                	xor    %edx,%edx
    10cd:	f7 f1                	div    %ecx
    10cf:	89 f0                	mov    %esi,%eax
    10d1:	f7 f1                	div    %ecx
    10d3:	e9 31 ff ff ff       	jmp    1009 <__umoddi3+0x29>
    10d8:	90                   	nop
    10d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10e0:	39 dd                	cmp    %ebx,%ebp
    10e2:	72 08                	jb     10ec <__umoddi3+0x10c>
    10e4:	39 f7                	cmp    %esi,%edi
    10e6:	0f 87 21 ff ff ff    	ja     100d <__umoddi3+0x2d>
    10ec:	89 da                	mov    %ebx,%edx
    10ee:	89 f0                	mov    %esi,%eax
    10f0:	29 f8                	sub    %edi,%eax
    10f2:	19 ea                	sbb    %ebp,%edx
    10f4:	e9 14 ff ff ff       	jmp    100d <__umoddi3+0x2d>
