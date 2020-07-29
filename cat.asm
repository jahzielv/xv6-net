
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
       6:	eb 15                	jmp    1d <cat+0x1d>
    write(1, buf, n);
       8:	83 ec 04             	sub    $0x4,%esp
       b:	ff 75 f4             	pushl  -0xc(%ebp)
       e:	68 60 18 00 00       	push   $0x1860
      13:	6a 01                	push   $0x1
      15:	e8 9c 03 00 00       	call   3b6 <write>
      1a:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf, sizeof(buf))) > 0)
      1d:	83 ec 04             	sub    $0x4,%esp
      20:	68 00 02 00 00       	push   $0x200
      25:	68 60 18 00 00       	push   $0x1860
      2a:	ff 75 08             	pushl  0x8(%ebp)
      2d:	e8 7c 03 00 00       	call   3ae <read>
      32:	83 c4 10             	add    $0x10,%esp
      35:	89 45 f4             	mov    %eax,-0xc(%ebp)
      38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      3c:	7f ca                	jg     8 <cat+0x8>
  if(n < 0){
      3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      42:	79 17                	jns    5b <cat+0x5b>
    printf(1, "cat: read error\n");
      44:	83 ec 08             	sub    $0x8,%esp
      47:	68 20 11 00 00       	push   $0x1120
      4c:	6a 01                	push   $0x1
      4e:	e8 d6 04 00 00       	call   529 <printf>
      53:	83 c4 10             	add    $0x10,%esp
    exit();
      56:	e8 3b 03 00 00       	call   396 <exit>
  }
}
      5b:	90                   	nop
      5c:	c9                   	leave  
      5d:	c3                   	ret    

0000005e <main>:

int
main(int argc, char *argv[])
{
      5e:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      62:	83 e4 f0             	and    $0xfffffff0,%esp
      65:	ff 71 fc             	pushl  -0x4(%ecx)
      68:	55                   	push   %ebp
      69:	89 e5                	mov    %esp,%ebp
      6b:	53                   	push   %ebx
      6c:	51                   	push   %ecx
      6d:	83 ec 10             	sub    $0x10,%esp
      70:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
      72:	83 3b 01             	cmpl   $0x1,(%ebx)
      75:	7f 12                	jg     89 <main+0x2b>
    cat(0);
      77:	83 ec 0c             	sub    $0xc,%esp
      7a:	6a 00                	push   $0x0
      7c:	e8 7f ff ff ff       	call   0 <cat>
      81:	83 c4 10             	add    $0x10,%esp
    exit();
      84:	e8 0d 03 00 00       	call   396 <exit>
  }

  for(i = 1; i < argc; i++){
      89:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      90:	eb 71                	jmp    103 <main+0xa5>
    if((fd = open(argv[i], 0)) < 0){
      92:	8b 45 f4             	mov    -0xc(%ebp),%eax
      95:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      9c:	8b 43 04             	mov    0x4(%ebx),%eax
      9f:	01 d0                	add    %edx,%eax
      a1:	8b 00                	mov    (%eax),%eax
      a3:	83 ec 08             	sub    $0x8,%esp
      a6:	6a 00                	push   $0x0
      a8:	50                   	push   %eax
      a9:	e8 28 03 00 00       	call   3d6 <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
      b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      b8:	79 29                	jns    e3 <main+0x85>
      printf(1, "cat: cannot open %s\n", argv[i]);
      ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
      bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
      c4:	8b 43 04             	mov    0x4(%ebx),%eax
      c7:	01 d0                	add    %edx,%eax
      c9:	8b 00                	mov    (%eax),%eax
      cb:	83 ec 04             	sub    $0x4,%esp
      ce:	50                   	push   %eax
      cf:	68 31 11 00 00       	push   $0x1131
      d4:	6a 01                	push   $0x1
      d6:	e8 4e 04 00 00       	call   529 <printf>
      db:	83 c4 10             	add    $0x10,%esp
      exit();
      de:	e8 b3 02 00 00       	call   396 <exit>
    }
    cat(fd);
      e3:	83 ec 0c             	sub    $0xc,%esp
      e6:	ff 75 f0             	pushl  -0x10(%ebp)
      e9:	e8 12 ff ff ff       	call   0 <cat>
      ee:	83 c4 10             	add    $0x10,%esp
    close(fd);
      f1:	83 ec 0c             	sub    $0xc,%esp
      f4:	ff 75 f0             	pushl  -0x10(%ebp)
      f7:	e8 c2 02 00 00       	call   3be <close>
      fc:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
      ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     103:	8b 45 f4             	mov    -0xc(%ebp),%eax
     106:	3b 03                	cmp    (%ebx),%eax
     108:	7c 88                	jl     92 <main+0x34>
  }
  exit();
     10a:	e8 87 02 00 00       	call   396 <exit>

0000010f <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
     10f:	55                   	push   %ebp
     110:	89 e5                	mov    %esp,%ebp
     112:	57                   	push   %edi
     113:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     114:	8b 4d 08             	mov    0x8(%ebp),%ecx
     117:	8b 55 10             	mov    0x10(%ebp),%edx
     11a:	8b 45 0c             	mov    0xc(%ebp),%eax
     11d:	89 cb                	mov    %ecx,%ebx
     11f:	89 df                	mov    %ebx,%edi
     121:	89 d1                	mov    %edx,%ecx
     123:	fc                   	cld    
     124:	f3 aa                	rep stos %al,%es:(%edi)
     126:	89 ca                	mov    %ecx,%edx
     128:	89 fb                	mov    %edi,%ebx
     12a:	89 5d 08             	mov    %ebx,0x8(%ebp)
     12d:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     130:	90                   	nop
     131:	5b                   	pop    %ebx
     132:	5f                   	pop    %edi
     133:	5d                   	pop    %ebp
     134:	c3                   	ret    

00000135 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     135:	55                   	push   %ebp
     136:	89 e5                	mov    %esp,%ebp
     138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     13b:	8b 45 08             	mov    0x8(%ebp),%eax
     13e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     141:	90                   	nop
     142:	8b 55 0c             	mov    0xc(%ebp),%edx
     145:	8d 42 01             	lea    0x1(%edx),%eax
     148:	89 45 0c             	mov    %eax,0xc(%ebp)
     14b:	8b 45 08             	mov    0x8(%ebp),%eax
     14e:	8d 48 01             	lea    0x1(%eax),%ecx
     151:	89 4d 08             	mov    %ecx,0x8(%ebp)
     154:	0f b6 12             	movzbl (%edx),%edx
     157:	88 10                	mov    %dl,(%eax)
     159:	0f b6 00             	movzbl (%eax),%eax
     15c:	84 c0                	test   %al,%al
     15e:	75 e2                	jne    142 <strcpy+0xd>
    ;
  return os;
     160:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     163:	c9                   	leave  
     164:	c3                   	ret    

00000165 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     165:	55                   	push   %ebp
     166:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     168:	eb 08                	jmp    172 <strcmp+0xd>
    p++, q++;
     16a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     16e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     172:	8b 45 08             	mov    0x8(%ebp),%eax
     175:	0f b6 00             	movzbl (%eax),%eax
     178:	84 c0                	test   %al,%al
     17a:	74 10                	je     18c <strcmp+0x27>
     17c:	8b 45 08             	mov    0x8(%ebp),%eax
     17f:	0f b6 10             	movzbl (%eax),%edx
     182:	8b 45 0c             	mov    0xc(%ebp),%eax
     185:	0f b6 00             	movzbl (%eax),%eax
     188:	38 c2                	cmp    %al,%dl
     18a:	74 de                	je     16a <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     18c:	8b 45 08             	mov    0x8(%ebp),%eax
     18f:	0f b6 00             	movzbl (%eax),%eax
     192:	0f b6 d0             	movzbl %al,%edx
     195:	8b 45 0c             	mov    0xc(%ebp),%eax
     198:	0f b6 00             	movzbl (%eax),%eax
     19b:	0f b6 c0             	movzbl %al,%eax
     19e:	29 c2                	sub    %eax,%edx
     1a0:	89 d0                	mov    %edx,%eax
}
     1a2:	5d                   	pop    %ebp
     1a3:	c3                   	ret    

000001a4 <strlen>:

uint
strlen(char *s)
{
     1a4:	55                   	push   %ebp
     1a5:	89 e5                	mov    %esp,%ebp
     1a7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     1aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1b1:	eb 04                	jmp    1b7 <strlen+0x13>
     1b3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     1b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
     1ba:	8b 45 08             	mov    0x8(%ebp),%eax
     1bd:	01 d0                	add    %edx,%eax
     1bf:	0f b6 00             	movzbl (%eax),%eax
     1c2:	84 c0                	test   %al,%al
     1c4:	75 ed                	jne    1b3 <strlen+0xf>
    ;
  return n;
     1c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     1c9:	c9                   	leave  
     1ca:	c3                   	ret    

000001cb <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     1cb:	55                   	push   %ebp
     1cc:	89 e5                	mov    %esp,%ebp
     1ce:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     1d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     1d8:	eb 0c                	jmp    1e6 <strnlen+0x1b>
     n++; 
     1da:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     1de:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1e2:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     1e6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     1ea:	74 0a                	je     1f6 <strnlen+0x2b>
     1ec:	8b 45 08             	mov    0x8(%ebp),%eax
     1ef:	0f b6 00             	movzbl (%eax),%eax
     1f2:	84 c0                	test   %al,%al
     1f4:	75 e4                	jne    1da <strnlen+0xf>
   return n; 
     1f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     1f9:	c9                   	leave  
     1fa:	c3                   	ret    

000001fb <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     1fb:	55                   	push   %ebp
     1fc:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     1fe:	8b 45 10             	mov    0x10(%ebp),%eax
     201:	50                   	push   %eax
     202:	ff 75 0c             	pushl  0xc(%ebp)
     205:	ff 75 08             	pushl  0x8(%ebp)
     208:	e8 02 ff ff ff       	call   10f <stosb>
     20d:	83 c4 0c             	add    $0xc,%esp
  return dst;
     210:	8b 45 08             	mov    0x8(%ebp),%eax
}
     213:	c9                   	leave  
     214:	c3                   	ret    

00000215 <strchr>:

char*
strchr(const char *s, char c)
{
     215:	55                   	push   %ebp
     216:	89 e5                	mov    %esp,%ebp
     218:	83 ec 04             	sub    $0x4,%esp
     21b:	8b 45 0c             	mov    0xc(%ebp),%eax
     21e:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     221:	eb 14                	jmp    237 <strchr+0x22>
    if(*s == c)
     223:	8b 45 08             	mov    0x8(%ebp),%eax
     226:	0f b6 00             	movzbl (%eax),%eax
     229:	38 45 fc             	cmp    %al,-0x4(%ebp)
     22c:	75 05                	jne    233 <strchr+0x1e>
      return (char*)s;
     22e:	8b 45 08             	mov    0x8(%ebp),%eax
     231:	eb 13                	jmp    246 <strchr+0x31>
  for(; *s; s++)
     233:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     237:	8b 45 08             	mov    0x8(%ebp),%eax
     23a:	0f b6 00             	movzbl (%eax),%eax
     23d:	84 c0                	test   %al,%al
     23f:	75 e2                	jne    223 <strchr+0xe>
  return 0;
     241:	b8 00 00 00 00       	mov    $0x0,%eax
}
     246:	c9                   	leave  
     247:	c3                   	ret    

00000248 <gets>:

char*
gets(char *buf, int max)
{
     248:	55                   	push   %ebp
     249:	89 e5                	mov    %esp,%ebp
     24b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     24e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     255:	eb 42                	jmp    299 <gets+0x51>
    cc = read(0, &c, 1);
     257:	83 ec 04             	sub    $0x4,%esp
     25a:	6a 01                	push   $0x1
     25c:	8d 45 ef             	lea    -0x11(%ebp),%eax
     25f:	50                   	push   %eax
     260:	6a 00                	push   $0x0
     262:	e8 47 01 00 00       	call   3ae <read>
     267:	83 c4 10             	add    $0x10,%esp
     26a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     26d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     271:	7e 33                	jle    2a6 <gets+0x5e>
      break;
    buf[i++] = c;
     273:	8b 45 f4             	mov    -0xc(%ebp),%eax
     276:	8d 50 01             	lea    0x1(%eax),%edx
     279:	89 55 f4             	mov    %edx,-0xc(%ebp)
     27c:	89 c2                	mov    %eax,%edx
     27e:	8b 45 08             	mov    0x8(%ebp),%eax
     281:	01 c2                	add    %eax,%edx
     283:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     287:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     289:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     28d:	3c 0a                	cmp    $0xa,%al
     28f:	74 16                	je     2a7 <gets+0x5f>
     291:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     295:	3c 0d                	cmp    $0xd,%al
     297:	74 0e                	je     2a7 <gets+0x5f>
  for(i=0; i+1 < max; ){
     299:	8b 45 f4             	mov    -0xc(%ebp),%eax
     29c:	83 c0 01             	add    $0x1,%eax
     29f:	39 45 0c             	cmp    %eax,0xc(%ebp)
     2a2:	7f b3                	jg     257 <gets+0xf>
     2a4:	eb 01                	jmp    2a7 <gets+0x5f>
      break;
     2a6:	90                   	nop
      break;
  }
  buf[i] = '\0';
     2a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
     2aa:	8b 45 08             	mov    0x8(%ebp),%eax
     2ad:	01 d0                	add    %edx,%eax
     2af:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     2b2:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2b5:	c9                   	leave  
     2b6:	c3                   	ret    

000002b7 <stat>:

int
stat(char *n, struct stat *st)
{
     2b7:	55                   	push   %ebp
     2b8:	89 e5                	mov    %esp,%ebp
     2ba:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2bd:	83 ec 08             	sub    $0x8,%esp
     2c0:	6a 00                	push   $0x0
     2c2:	ff 75 08             	pushl  0x8(%ebp)
     2c5:	e8 0c 01 00 00       	call   3d6 <open>
     2ca:	83 c4 10             	add    $0x10,%esp
     2cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     2d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     2d4:	79 07                	jns    2dd <stat+0x26>
    return -1;
     2d6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     2db:	eb 25                	jmp    302 <stat+0x4b>
  r = fstat(fd, st);
     2dd:	83 ec 08             	sub    $0x8,%esp
     2e0:	ff 75 0c             	pushl  0xc(%ebp)
     2e3:	ff 75 f4             	pushl  -0xc(%ebp)
     2e6:	e8 03 01 00 00       	call   3ee <fstat>
     2eb:	83 c4 10             	add    $0x10,%esp
     2ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     2f1:	83 ec 0c             	sub    $0xc,%esp
     2f4:	ff 75 f4             	pushl  -0xc(%ebp)
     2f7:	e8 c2 00 00 00       	call   3be <close>
     2fc:	83 c4 10             	add    $0x10,%esp
  return r;
     2ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     302:	c9                   	leave  
     303:	c3                   	ret    

00000304 <atoi>:

int
atoi(const char *s)
{
     304:	55                   	push   %ebp
     305:	89 e5                	mov    %esp,%ebp
     307:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     30a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     311:	eb 25                	jmp    338 <atoi+0x34>
    n = n*10 + *s++ - '0';
     313:	8b 55 fc             	mov    -0x4(%ebp),%edx
     316:	89 d0                	mov    %edx,%eax
     318:	c1 e0 02             	shl    $0x2,%eax
     31b:	01 d0                	add    %edx,%eax
     31d:	01 c0                	add    %eax,%eax
     31f:	89 c1                	mov    %eax,%ecx
     321:	8b 45 08             	mov    0x8(%ebp),%eax
     324:	8d 50 01             	lea    0x1(%eax),%edx
     327:	89 55 08             	mov    %edx,0x8(%ebp)
     32a:	0f b6 00             	movzbl (%eax),%eax
     32d:	0f be c0             	movsbl %al,%eax
     330:	01 c8                	add    %ecx,%eax
     332:	83 e8 30             	sub    $0x30,%eax
     335:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     338:	8b 45 08             	mov    0x8(%ebp),%eax
     33b:	0f b6 00             	movzbl (%eax),%eax
     33e:	3c 2f                	cmp    $0x2f,%al
     340:	7e 0a                	jle    34c <atoi+0x48>
     342:	8b 45 08             	mov    0x8(%ebp),%eax
     345:	0f b6 00             	movzbl (%eax),%eax
     348:	3c 39                	cmp    $0x39,%al
     34a:	7e c7                	jle    313 <atoi+0xf>
  return n;
     34c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     34f:	c9                   	leave  
     350:	c3                   	ret    

00000351 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     351:	55                   	push   %ebp
     352:	89 e5                	mov    %esp,%ebp
     354:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     357:	8b 45 08             	mov    0x8(%ebp),%eax
     35a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     35d:	8b 45 0c             	mov    0xc(%ebp),%eax
     360:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     363:	eb 17                	jmp    37c <memmove+0x2b>
    *dst++ = *src++;
     365:	8b 55 f8             	mov    -0x8(%ebp),%edx
     368:	8d 42 01             	lea    0x1(%edx),%eax
     36b:	89 45 f8             	mov    %eax,-0x8(%ebp)
     36e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     371:	8d 48 01             	lea    0x1(%eax),%ecx
     374:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     377:	0f b6 12             	movzbl (%edx),%edx
     37a:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     37c:	8b 45 10             	mov    0x10(%ebp),%eax
     37f:	8d 50 ff             	lea    -0x1(%eax),%edx
     382:	89 55 10             	mov    %edx,0x10(%ebp)
     385:	85 c0                	test   %eax,%eax
     387:	7f dc                	jg     365 <memmove+0x14>
  return vdst;
     389:	8b 45 08             	mov    0x8(%ebp),%eax
}
     38c:	c9                   	leave  
     38d:	c3                   	ret    

0000038e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     38e:	b8 01 00 00 00       	mov    $0x1,%eax
     393:	cd 40                	int    $0x40
     395:	c3                   	ret    

00000396 <exit>:
SYSCALL(exit)
     396:	b8 02 00 00 00       	mov    $0x2,%eax
     39b:	cd 40                	int    $0x40
     39d:	c3                   	ret    

0000039e <wait>:
SYSCALL(wait)
     39e:	b8 03 00 00 00       	mov    $0x3,%eax
     3a3:	cd 40                	int    $0x40
     3a5:	c3                   	ret    

000003a6 <pipe>:
SYSCALL(pipe)
     3a6:	b8 04 00 00 00       	mov    $0x4,%eax
     3ab:	cd 40                	int    $0x40
     3ad:	c3                   	ret    

000003ae <read>:
SYSCALL(read)
     3ae:	b8 05 00 00 00       	mov    $0x5,%eax
     3b3:	cd 40                	int    $0x40
     3b5:	c3                   	ret    

000003b6 <write>:
SYSCALL(write)
     3b6:	b8 10 00 00 00       	mov    $0x10,%eax
     3bb:	cd 40                	int    $0x40
     3bd:	c3                   	ret    

000003be <close>:
SYSCALL(close)
     3be:	b8 15 00 00 00       	mov    $0x15,%eax
     3c3:	cd 40                	int    $0x40
     3c5:	c3                   	ret    

000003c6 <kill>:
SYSCALL(kill)
     3c6:	b8 06 00 00 00       	mov    $0x6,%eax
     3cb:	cd 40                	int    $0x40
     3cd:	c3                   	ret    

000003ce <exec>:
SYSCALL(exec)
     3ce:	b8 07 00 00 00       	mov    $0x7,%eax
     3d3:	cd 40                	int    $0x40
     3d5:	c3                   	ret    

000003d6 <open>:
SYSCALL(open)
     3d6:	b8 0f 00 00 00       	mov    $0xf,%eax
     3db:	cd 40                	int    $0x40
     3dd:	c3                   	ret    

000003de <mknod>:
SYSCALL(mknod)
     3de:	b8 11 00 00 00       	mov    $0x11,%eax
     3e3:	cd 40                	int    $0x40
     3e5:	c3                   	ret    

000003e6 <unlink>:
SYSCALL(unlink)
     3e6:	b8 12 00 00 00       	mov    $0x12,%eax
     3eb:	cd 40                	int    $0x40
     3ed:	c3                   	ret    

000003ee <fstat>:
SYSCALL(fstat)
     3ee:	b8 08 00 00 00       	mov    $0x8,%eax
     3f3:	cd 40                	int    $0x40
     3f5:	c3                   	ret    

000003f6 <link>:
SYSCALL(link)
     3f6:	b8 13 00 00 00       	mov    $0x13,%eax
     3fb:	cd 40                	int    $0x40
     3fd:	c3                   	ret    

000003fe <mkdir>:
SYSCALL(mkdir)
     3fe:	b8 14 00 00 00       	mov    $0x14,%eax
     403:	cd 40                	int    $0x40
     405:	c3                   	ret    

00000406 <chdir>:
SYSCALL(chdir)
     406:	b8 09 00 00 00       	mov    $0x9,%eax
     40b:	cd 40                	int    $0x40
     40d:	c3                   	ret    

0000040e <dup>:
SYSCALL(dup)
     40e:	b8 0a 00 00 00       	mov    $0xa,%eax
     413:	cd 40                	int    $0x40
     415:	c3                   	ret    

00000416 <getpid>:
SYSCALL(getpid)
     416:	b8 0b 00 00 00       	mov    $0xb,%eax
     41b:	cd 40                	int    $0x40
     41d:	c3                   	ret    

0000041e <sbrk>:
SYSCALL(sbrk)
     41e:	b8 0c 00 00 00       	mov    $0xc,%eax
     423:	cd 40                	int    $0x40
     425:	c3                   	ret    

00000426 <sleep>:
SYSCALL(sleep)
     426:	b8 0d 00 00 00       	mov    $0xd,%eax
     42b:	cd 40                	int    $0x40
     42d:	c3                   	ret    

0000042e <uptime>:
SYSCALL(uptime)
     42e:	b8 0e 00 00 00       	mov    $0xe,%eax
     433:	cd 40                	int    $0x40
     435:	c3                   	ret    

00000436 <select>:
SYSCALL(select)
     436:	b8 16 00 00 00       	mov    $0x16,%eax
     43b:	cd 40                	int    $0x40
     43d:	c3                   	ret    

0000043e <arp>:
SYSCALL(arp)
     43e:	b8 17 00 00 00       	mov    $0x17,%eax
     443:	cd 40                	int    $0x40
     445:	c3                   	ret    

00000446 <arpserv>:
SYSCALL(arpserv)
     446:	b8 18 00 00 00       	mov    $0x18,%eax
     44b:	cd 40                	int    $0x40
     44d:	c3                   	ret    

0000044e <arp_receive>:
SYSCALL(arp_receive)
     44e:	b8 19 00 00 00       	mov    $0x19,%eax
     453:	cd 40                	int    $0x40
     455:	c3                   	ret    

00000456 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     456:	55                   	push   %ebp
     457:	89 e5                	mov    %esp,%ebp
     459:	83 ec 18             	sub    $0x18,%esp
     45c:	8b 45 0c             	mov    0xc(%ebp),%eax
     45f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     462:	83 ec 04             	sub    $0x4,%esp
     465:	6a 01                	push   $0x1
     467:	8d 45 f4             	lea    -0xc(%ebp),%eax
     46a:	50                   	push   %eax
     46b:	ff 75 08             	pushl  0x8(%ebp)
     46e:	e8 43 ff ff ff       	call   3b6 <write>
     473:	83 c4 10             	add    $0x10,%esp
}
     476:	90                   	nop
     477:	c9                   	leave  
     478:	c3                   	ret    

00000479 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     479:	55                   	push   %ebp
     47a:	89 e5                	mov    %esp,%ebp
     47c:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     47f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     486:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     48a:	74 17                	je     4a3 <printint+0x2a>
     48c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     490:	79 11                	jns    4a3 <printint+0x2a>
    neg = 1;
     492:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     499:	8b 45 0c             	mov    0xc(%ebp),%eax
     49c:	f7 d8                	neg    %eax
     49e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4a1:	eb 06                	jmp    4a9 <printint+0x30>
  } else {
    x = xx;
     4a3:	8b 45 0c             	mov    0xc(%ebp),%eax
     4a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     4a9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     4b0:	8b 4d 10             	mov    0x10(%ebp),%ecx
     4b3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4b6:	ba 00 00 00 00       	mov    $0x0,%edx
     4bb:	f7 f1                	div    %ecx
     4bd:	89 d1                	mov    %edx,%ecx
     4bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4c2:	8d 50 01             	lea    0x1(%eax),%edx
     4c5:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4c8:	0f b6 91 10 18 00 00 	movzbl 0x1810(%ecx),%edx
     4cf:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     4d3:	8b 4d 10             	mov    0x10(%ebp),%ecx
     4d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
     4d9:	ba 00 00 00 00       	mov    $0x0,%edx
     4de:	f7 f1                	div    %ecx
     4e0:	89 45 ec             	mov    %eax,-0x14(%ebp)
     4e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4e7:	75 c7                	jne    4b0 <printint+0x37>
  if(neg)
     4e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4ed:	74 2d                	je     51c <printint+0xa3>
    buf[i++] = '-';
     4ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f2:	8d 50 01             	lea    0x1(%eax),%edx
     4f5:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4f8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4fd:	eb 1d                	jmp    51c <printint+0xa3>
    putc(fd, buf[i]);
     4ff:	8d 55 dc             	lea    -0x24(%ebp),%edx
     502:	8b 45 f4             	mov    -0xc(%ebp),%eax
     505:	01 d0                	add    %edx,%eax
     507:	0f b6 00             	movzbl (%eax),%eax
     50a:	0f be c0             	movsbl %al,%eax
     50d:	83 ec 08             	sub    $0x8,%esp
     510:	50                   	push   %eax
     511:	ff 75 08             	pushl  0x8(%ebp)
     514:	e8 3d ff ff ff       	call   456 <putc>
     519:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     51c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     520:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     524:	79 d9                	jns    4ff <printint+0x86>
}
     526:	90                   	nop
     527:	c9                   	leave  
     528:	c3                   	ret    

00000529 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     529:	55                   	push   %ebp
     52a:	89 e5                	mov    %esp,%ebp
     52c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     52f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     536:	8d 45 0c             	lea    0xc(%ebp),%eax
     539:	83 c0 04             	add    $0x4,%eax
     53c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     53f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     546:	e9 59 01 00 00       	jmp    6a4 <printf+0x17b>
    c = fmt[i] & 0xff;
     54b:	8b 55 0c             	mov    0xc(%ebp),%edx
     54e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     551:	01 d0                	add    %edx,%eax
     553:	0f b6 00             	movzbl (%eax),%eax
     556:	0f be c0             	movsbl %al,%eax
     559:	25 ff 00 00 00       	and    $0xff,%eax
     55e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     561:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     565:	75 2c                	jne    593 <printf+0x6a>
      if(c == '%'){
     567:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     56b:	75 0c                	jne    579 <printf+0x50>
        state = '%';
     56d:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     574:	e9 27 01 00 00       	jmp    6a0 <printf+0x177>
      } else {
        putc(fd, c);
     579:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     57c:	0f be c0             	movsbl %al,%eax
     57f:	83 ec 08             	sub    $0x8,%esp
     582:	50                   	push   %eax
     583:	ff 75 08             	pushl  0x8(%ebp)
     586:	e8 cb fe ff ff       	call   456 <putc>
     58b:	83 c4 10             	add    $0x10,%esp
     58e:	e9 0d 01 00 00       	jmp    6a0 <printf+0x177>
      }
    } else if(state == '%'){
     593:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     597:	0f 85 03 01 00 00    	jne    6a0 <printf+0x177>
      if(c == 'd'){
     59d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     5a1:	75 1e                	jne    5c1 <printf+0x98>
        printint(fd, *ap, 10, 1);
     5a3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5a6:	8b 00                	mov    (%eax),%eax
     5a8:	6a 01                	push   $0x1
     5aa:	6a 0a                	push   $0xa
     5ac:	50                   	push   %eax
     5ad:	ff 75 08             	pushl  0x8(%ebp)
     5b0:	e8 c4 fe ff ff       	call   479 <printint>
     5b5:	83 c4 10             	add    $0x10,%esp
        ap++;
     5b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5bc:	e9 d8 00 00 00       	jmp    699 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     5c1:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     5c5:	74 06                	je     5cd <printf+0xa4>
     5c7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     5cb:	75 1e                	jne    5eb <printf+0xc2>
        printint(fd, *ap, 16, 0);
     5cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5d0:	8b 00                	mov    (%eax),%eax
     5d2:	6a 00                	push   $0x0
     5d4:	6a 10                	push   $0x10
     5d6:	50                   	push   %eax
     5d7:	ff 75 08             	pushl  0x8(%ebp)
     5da:	e8 9a fe ff ff       	call   479 <printint>
     5df:	83 c4 10             	add    $0x10,%esp
        ap++;
     5e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5e6:	e9 ae 00 00 00       	jmp    699 <printf+0x170>
      } else if(c == 's'){
     5eb:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5ef:	75 43                	jne    634 <printf+0x10b>
        s = (char*)*ap;
     5f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5f4:	8b 00                	mov    (%eax),%eax
     5f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     601:	75 25                	jne    628 <printf+0xff>
          s = "(null)";
     603:	c7 45 f4 46 11 00 00 	movl   $0x1146,-0xc(%ebp)
        while(*s != 0){
     60a:	eb 1c                	jmp    628 <printf+0xff>
          putc(fd, *s);
     60c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     60f:	0f b6 00             	movzbl (%eax),%eax
     612:	0f be c0             	movsbl %al,%eax
     615:	83 ec 08             	sub    $0x8,%esp
     618:	50                   	push   %eax
     619:	ff 75 08             	pushl  0x8(%ebp)
     61c:	e8 35 fe ff ff       	call   456 <putc>
     621:	83 c4 10             	add    $0x10,%esp
          s++;
     624:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     628:	8b 45 f4             	mov    -0xc(%ebp),%eax
     62b:	0f b6 00             	movzbl (%eax),%eax
     62e:	84 c0                	test   %al,%al
     630:	75 da                	jne    60c <printf+0xe3>
     632:	eb 65                	jmp    699 <printf+0x170>
        }
      } else if(c == 'c'){
     634:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     638:	75 1d                	jne    657 <printf+0x12e>
        putc(fd, *ap);
     63a:	8b 45 e8             	mov    -0x18(%ebp),%eax
     63d:	8b 00                	mov    (%eax),%eax
     63f:	0f be c0             	movsbl %al,%eax
     642:	83 ec 08             	sub    $0x8,%esp
     645:	50                   	push   %eax
     646:	ff 75 08             	pushl  0x8(%ebp)
     649:	e8 08 fe ff ff       	call   456 <putc>
     64e:	83 c4 10             	add    $0x10,%esp
        ap++;
     651:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     655:	eb 42                	jmp    699 <printf+0x170>
      } else if(c == '%'){
     657:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     65b:	75 17                	jne    674 <printf+0x14b>
        putc(fd, c);
     65d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     660:	0f be c0             	movsbl %al,%eax
     663:	83 ec 08             	sub    $0x8,%esp
     666:	50                   	push   %eax
     667:	ff 75 08             	pushl  0x8(%ebp)
     66a:	e8 e7 fd ff ff       	call   456 <putc>
     66f:	83 c4 10             	add    $0x10,%esp
     672:	eb 25                	jmp    699 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     674:	83 ec 08             	sub    $0x8,%esp
     677:	6a 25                	push   $0x25
     679:	ff 75 08             	pushl  0x8(%ebp)
     67c:	e8 d5 fd ff ff       	call   456 <putc>
     681:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     684:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     687:	0f be c0             	movsbl %al,%eax
     68a:	83 ec 08             	sub    $0x8,%esp
     68d:	50                   	push   %eax
     68e:	ff 75 08             	pushl  0x8(%ebp)
     691:	e8 c0 fd ff ff       	call   456 <putc>
     696:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     699:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     6a0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     6a4:	8b 55 0c             	mov    0xc(%ebp),%edx
     6a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     6aa:	01 d0                	add    %edx,%eax
     6ac:	0f b6 00             	movzbl (%eax),%eax
     6af:	84 c0                	test   %al,%al
     6b1:	0f 85 94 fe ff ff    	jne    54b <printf+0x22>
    }
  }
}
     6b7:	90                   	nop
     6b8:	c9                   	leave  
     6b9:	c3                   	ret    

000006ba <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     6ba:	55                   	push   %ebp
     6bb:	89 e5                	mov    %esp,%ebp
     6bd:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     6c0:	8b 45 08             	mov    0x8(%ebp),%eax
     6c3:	83 e8 08             	sub    $0x8,%eax
     6c6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6c9:	a1 48 18 00 00       	mov    0x1848,%eax
     6ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6d1:	eb 24                	jmp    6f7 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6d6:	8b 00                	mov    (%eax),%eax
     6d8:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     6db:	72 12                	jb     6ef <free+0x35>
     6dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6e3:	77 24                	ja     709 <free+0x4f>
     6e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e8:	8b 00                	mov    (%eax),%eax
     6ea:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6ed:	72 1a                	jb     709 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f2:	8b 00                	mov    (%eax),%eax
     6f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6fa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6fd:	76 d4                	jbe    6d3 <free+0x19>
     6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
     702:	8b 00                	mov    (%eax),%eax
     704:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     707:	73 ca                	jae    6d3 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     709:	8b 45 f8             	mov    -0x8(%ebp),%eax
     70c:	8b 40 04             	mov    0x4(%eax),%eax
     70f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     716:	8b 45 f8             	mov    -0x8(%ebp),%eax
     719:	01 c2                	add    %eax,%edx
     71b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     71e:	8b 00                	mov    (%eax),%eax
     720:	39 c2                	cmp    %eax,%edx
     722:	75 24                	jne    748 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     724:	8b 45 f8             	mov    -0x8(%ebp),%eax
     727:	8b 50 04             	mov    0x4(%eax),%edx
     72a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     72d:	8b 00                	mov    (%eax),%eax
     72f:	8b 40 04             	mov    0x4(%eax),%eax
     732:	01 c2                	add    %eax,%edx
     734:	8b 45 f8             	mov    -0x8(%ebp),%eax
     737:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     73a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     73d:	8b 00                	mov    (%eax),%eax
     73f:	8b 10                	mov    (%eax),%edx
     741:	8b 45 f8             	mov    -0x8(%ebp),%eax
     744:	89 10                	mov    %edx,(%eax)
     746:	eb 0a                	jmp    752 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     748:	8b 45 fc             	mov    -0x4(%ebp),%eax
     74b:	8b 10                	mov    (%eax),%edx
     74d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     750:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     752:	8b 45 fc             	mov    -0x4(%ebp),%eax
     755:	8b 40 04             	mov    0x4(%eax),%eax
     758:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     75f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     762:	01 d0                	add    %edx,%eax
     764:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     767:	75 20                	jne    789 <free+0xcf>
    p->s.size += bp->s.size;
     769:	8b 45 fc             	mov    -0x4(%ebp),%eax
     76c:	8b 50 04             	mov    0x4(%eax),%edx
     76f:	8b 45 f8             	mov    -0x8(%ebp),%eax
     772:	8b 40 04             	mov    0x4(%eax),%eax
     775:	01 c2                	add    %eax,%edx
     777:	8b 45 fc             	mov    -0x4(%ebp),%eax
     77a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     77d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     780:	8b 10                	mov    (%eax),%edx
     782:	8b 45 fc             	mov    -0x4(%ebp),%eax
     785:	89 10                	mov    %edx,(%eax)
     787:	eb 08                	jmp    791 <free+0xd7>
  } else
    p->s.ptr = bp;
     789:	8b 45 fc             	mov    -0x4(%ebp),%eax
     78c:	8b 55 f8             	mov    -0x8(%ebp),%edx
     78f:	89 10                	mov    %edx,(%eax)
  freep = p;
     791:	8b 45 fc             	mov    -0x4(%ebp),%eax
     794:	a3 48 18 00 00       	mov    %eax,0x1848
}
     799:	90                   	nop
     79a:	c9                   	leave  
     79b:	c3                   	ret    

0000079c <morecore>:

static Header*
morecore(uint nu)
{
     79c:	55                   	push   %ebp
     79d:	89 e5                	mov    %esp,%ebp
     79f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     7a2:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     7a9:	77 07                	ja     7b2 <morecore+0x16>
    nu = 4096;
     7ab:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     7b2:	8b 45 08             	mov    0x8(%ebp),%eax
     7b5:	c1 e0 03             	shl    $0x3,%eax
     7b8:	83 ec 0c             	sub    $0xc,%esp
     7bb:	50                   	push   %eax
     7bc:	e8 5d fc ff ff       	call   41e <sbrk>
     7c1:	83 c4 10             	add    $0x10,%esp
     7c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     7c7:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     7cb:	75 07                	jne    7d4 <morecore+0x38>
    return 0;
     7cd:	b8 00 00 00 00       	mov    $0x0,%eax
     7d2:	eb 26                	jmp    7fa <morecore+0x5e>
  hp = (Header*)p;
     7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     7da:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7dd:	8b 55 08             	mov    0x8(%ebp),%edx
     7e0:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     7e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e6:	83 c0 08             	add    $0x8,%eax
     7e9:	83 ec 0c             	sub    $0xc,%esp
     7ec:	50                   	push   %eax
     7ed:	e8 c8 fe ff ff       	call   6ba <free>
     7f2:	83 c4 10             	add    $0x10,%esp
  return freep;
     7f5:	a1 48 18 00 00       	mov    0x1848,%eax
}
     7fa:	c9                   	leave  
     7fb:	c3                   	ret    

000007fc <malloc>:

void*
malloc(uint nbytes)
{
     7fc:	55                   	push   %ebp
     7fd:	89 e5                	mov    %esp,%ebp
     7ff:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     802:	8b 45 08             	mov    0x8(%ebp),%eax
     805:	83 c0 07             	add    $0x7,%eax
     808:	c1 e8 03             	shr    $0x3,%eax
     80b:	83 c0 01             	add    $0x1,%eax
     80e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     811:	a1 48 18 00 00       	mov    0x1848,%eax
     816:	89 45 f0             	mov    %eax,-0x10(%ebp)
     819:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     81d:	75 23                	jne    842 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     81f:	c7 45 f0 40 18 00 00 	movl   $0x1840,-0x10(%ebp)
     826:	8b 45 f0             	mov    -0x10(%ebp),%eax
     829:	a3 48 18 00 00       	mov    %eax,0x1848
     82e:	a1 48 18 00 00       	mov    0x1848,%eax
     833:	a3 40 18 00 00       	mov    %eax,0x1840
    base.s.size = 0;
     838:	c7 05 44 18 00 00 00 	movl   $0x0,0x1844
     83f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     842:	8b 45 f0             	mov    -0x10(%ebp),%eax
     845:	8b 00                	mov    (%eax),%eax
     847:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84d:	8b 40 04             	mov    0x4(%eax),%eax
     850:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     853:	77 4d                	ja     8a2 <malloc+0xa6>
      if(p->s.size == nunits)
     855:	8b 45 f4             	mov    -0xc(%ebp),%eax
     858:	8b 40 04             	mov    0x4(%eax),%eax
     85b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     85e:	75 0c                	jne    86c <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     860:	8b 45 f4             	mov    -0xc(%ebp),%eax
     863:	8b 10                	mov    (%eax),%edx
     865:	8b 45 f0             	mov    -0x10(%ebp),%eax
     868:	89 10                	mov    %edx,(%eax)
     86a:	eb 26                	jmp    892 <malloc+0x96>
      else {
        p->s.size -= nunits;
     86c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     86f:	8b 40 04             	mov    0x4(%eax),%eax
     872:	2b 45 ec             	sub    -0x14(%ebp),%eax
     875:	89 c2                	mov    %eax,%edx
     877:	8b 45 f4             	mov    -0xc(%ebp),%eax
     87a:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     87d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     880:	8b 40 04             	mov    0x4(%eax),%eax
     883:	c1 e0 03             	shl    $0x3,%eax
     886:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     889:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88c:	8b 55 ec             	mov    -0x14(%ebp),%edx
     88f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     892:	8b 45 f0             	mov    -0x10(%ebp),%eax
     895:	a3 48 18 00 00       	mov    %eax,0x1848
      return (void*)(p + 1);
     89a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     89d:	83 c0 08             	add    $0x8,%eax
     8a0:	eb 3b                	jmp    8dd <malloc+0xe1>
    }
    if(p == freep)
     8a2:	a1 48 18 00 00       	mov    0x1848,%eax
     8a7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     8aa:	75 1e                	jne    8ca <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     8ac:	83 ec 0c             	sub    $0xc,%esp
     8af:	ff 75 ec             	pushl  -0x14(%ebp)
     8b2:	e8 e5 fe ff ff       	call   79c <morecore>
     8b7:	83 c4 10             	add    $0x10,%esp
     8ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
     8bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8c1:	75 07                	jne    8ca <malloc+0xce>
        return 0;
     8c3:	b8 00 00 00 00       	mov    $0x0,%eax
     8c8:	eb 13                	jmp    8dd <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8d3:	8b 00                	mov    (%eax),%eax
     8d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     8d8:	e9 6d ff ff ff       	jmp    84a <malloc+0x4e>
  }
}
     8dd:	c9                   	leave  
     8de:	c3                   	ret    

000008df <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     8df:	55                   	push   %ebp
     8e0:	89 e5                	mov    %esp,%ebp
     8e2:	53                   	push   %ebx
     8e3:	83 ec 14             	sub    $0x14,%esp
     8e6:	8b 45 10             	mov    0x10(%ebp),%eax
     8e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8ec:	8b 45 14             	mov    0x14(%ebp),%eax
     8ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     8f2:	8b 45 18             	mov    0x18(%ebp),%eax
     8f5:	ba 00 00 00 00       	mov    $0x0,%edx
     8fa:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     8fd:	72 55                	jb     954 <printnum+0x75>
     8ff:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     902:	77 05                	ja     909 <printnum+0x2a>
     904:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     907:	72 4b                	jb     954 <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     909:	8b 45 1c             	mov    0x1c(%ebp),%eax
     90c:	8d 58 ff             	lea    -0x1(%eax),%ebx
     90f:	8b 45 18             	mov    0x18(%ebp),%eax
     912:	ba 00 00 00 00       	mov    $0x0,%edx
     917:	52                   	push   %edx
     918:	50                   	push   %eax
     919:	ff 75 f4             	pushl  -0xc(%ebp)
     91c:	ff 75 f0             	pushl  -0x10(%ebp)
     91f:	e8 ac 05 00 00       	call   ed0 <__udivdi3>
     924:	83 c4 10             	add    $0x10,%esp
     927:	83 ec 04             	sub    $0x4,%esp
     92a:	ff 75 20             	pushl  0x20(%ebp)
     92d:	53                   	push   %ebx
     92e:	ff 75 18             	pushl  0x18(%ebp)
     931:	52                   	push   %edx
     932:	50                   	push   %eax
     933:	ff 75 0c             	pushl  0xc(%ebp)
     936:	ff 75 08             	pushl  0x8(%ebp)
     939:	e8 a1 ff ff ff       	call   8df <printnum>
     93e:	83 c4 20             	add    $0x20,%esp
     941:	eb 1b                	jmp    95e <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     943:	83 ec 08             	sub    $0x8,%esp
     946:	ff 75 0c             	pushl  0xc(%ebp)
     949:	ff 75 20             	pushl  0x20(%ebp)
     94c:	8b 45 08             	mov    0x8(%ebp),%eax
     94f:	ff d0                	call   *%eax
     951:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     954:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     958:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     95c:	7f e5                	jg     943 <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     95e:	8b 4d 18             	mov    0x18(%ebp),%ecx
     961:	bb 00 00 00 00       	mov    $0x0,%ebx
     966:	8b 45 f0             	mov    -0x10(%ebp),%eax
     969:	8b 55 f4             	mov    -0xc(%ebp),%edx
     96c:	53                   	push   %ebx
     96d:	51                   	push   %ecx
     96e:	52                   	push   %edx
     96f:	50                   	push   %eax
     970:	e8 7b 06 00 00       	call   ff0 <__umoddi3>
     975:	83 c4 10             	add    $0x10,%esp
     978:	05 20 12 00 00       	add    $0x1220,%eax
     97d:	0f b6 00             	movzbl (%eax),%eax
     980:	0f be c0             	movsbl %al,%eax
     983:	83 ec 08             	sub    $0x8,%esp
     986:	ff 75 0c             	pushl  0xc(%ebp)
     989:	50                   	push   %eax
     98a:	8b 45 08             	mov    0x8(%ebp),%eax
     98d:	ff d0                	call   *%eax
     98f:	83 c4 10             	add    $0x10,%esp
}
     992:	90                   	nop
     993:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     996:	c9                   	leave  
     997:	c3                   	ret    

00000998 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     998:	55                   	push   %ebp
     999:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     99b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     99f:	7e 14                	jle    9b5 <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     9a1:	8b 45 08             	mov    0x8(%ebp),%eax
     9a4:	8b 00                	mov    (%eax),%eax
     9a6:	8d 48 08             	lea    0x8(%eax),%ecx
     9a9:	8b 55 08             	mov    0x8(%ebp),%edx
     9ac:	89 0a                	mov    %ecx,(%edx)
     9ae:	8b 50 04             	mov    0x4(%eax),%edx
     9b1:	8b 00                	mov    (%eax),%eax
     9b3:	eb 30                	jmp    9e5 <getuint+0x4d>
  else if (lflag)
     9b5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     9b9:	74 16                	je     9d1 <getuint+0x39>
    return va_arg(*ap, unsigned long);
     9bb:	8b 45 08             	mov    0x8(%ebp),%eax
     9be:	8b 00                	mov    (%eax),%eax
     9c0:	8d 48 04             	lea    0x4(%eax),%ecx
     9c3:	8b 55 08             	mov    0x8(%ebp),%edx
     9c6:	89 0a                	mov    %ecx,(%edx)
     9c8:	8b 00                	mov    (%eax),%eax
     9ca:	ba 00 00 00 00       	mov    $0x0,%edx
     9cf:	eb 14                	jmp    9e5 <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     9d1:	8b 45 08             	mov    0x8(%ebp),%eax
     9d4:	8b 00                	mov    (%eax),%eax
     9d6:	8d 48 04             	lea    0x4(%eax),%ecx
     9d9:	8b 55 08             	mov    0x8(%ebp),%edx
     9dc:	89 0a                	mov    %ecx,(%edx)
     9de:	8b 00                	mov    (%eax),%eax
     9e0:	ba 00 00 00 00       	mov    $0x0,%edx
}
     9e5:	5d                   	pop    %ebp
     9e6:	c3                   	ret    

000009e7 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     9e7:	55                   	push   %ebp
     9e8:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     9ea:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     9ee:	7e 14                	jle    a04 <getint+0x1d>
    return va_arg(*ap, long long);
     9f0:	8b 45 08             	mov    0x8(%ebp),%eax
     9f3:	8b 00                	mov    (%eax),%eax
     9f5:	8d 48 08             	lea    0x8(%eax),%ecx
     9f8:	8b 55 08             	mov    0x8(%ebp),%edx
     9fb:	89 0a                	mov    %ecx,(%edx)
     9fd:	8b 50 04             	mov    0x4(%eax),%edx
     a00:	8b 00                	mov    (%eax),%eax
     a02:	eb 28                	jmp    a2c <getint+0x45>
  else if (lflag)
     a04:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     a08:	74 12                	je     a1c <getint+0x35>
    return va_arg(*ap, long);
     a0a:	8b 45 08             	mov    0x8(%ebp),%eax
     a0d:	8b 00                	mov    (%eax),%eax
     a0f:	8d 48 04             	lea    0x4(%eax),%ecx
     a12:	8b 55 08             	mov    0x8(%ebp),%edx
     a15:	89 0a                	mov    %ecx,(%edx)
     a17:	8b 00                	mov    (%eax),%eax
     a19:	99                   	cltd   
     a1a:	eb 10                	jmp    a2c <getint+0x45>
  else
    return va_arg(*ap, int);
     a1c:	8b 45 08             	mov    0x8(%ebp),%eax
     a1f:	8b 00                	mov    (%eax),%eax
     a21:	8d 48 04             	lea    0x4(%eax),%ecx
     a24:	8b 55 08             	mov    0x8(%ebp),%edx
     a27:	89 0a                	mov    %ecx,(%edx)
     a29:	8b 00                	mov    (%eax),%eax
     a2b:	99                   	cltd   
}
     a2c:	5d                   	pop    %ebp
     a2d:	c3                   	ret    

00000a2e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     a2e:	55                   	push   %ebp
     a2f:	89 e5                	mov    %esp,%ebp
     a31:	56                   	push   %esi
     a32:	53                   	push   %ebx
     a33:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     a36:	eb 17                	jmp    a4f <vprintfmt+0x21>
      if (ch == '\0')
     a38:	85 db                	test   %ebx,%ebx
     a3a:	0f 84 a0 03 00 00    	je     de0 <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     a40:	83 ec 08             	sub    $0x8,%esp
     a43:	ff 75 0c             	pushl  0xc(%ebp)
     a46:	53                   	push   %ebx
     a47:	8b 45 08             	mov    0x8(%ebp),%eax
     a4a:	ff d0                	call   *%eax
     a4c:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     a4f:	8b 45 10             	mov    0x10(%ebp),%eax
     a52:	8d 50 01             	lea    0x1(%eax),%edx
     a55:	89 55 10             	mov    %edx,0x10(%ebp)
     a58:	0f b6 00             	movzbl (%eax),%eax
     a5b:	0f b6 d8             	movzbl %al,%ebx
     a5e:	83 fb 25             	cmp    $0x25,%ebx
     a61:	75 d5                	jne    a38 <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     a63:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     a67:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     a6e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     a75:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     a7c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     a83:	8b 45 10             	mov    0x10(%ebp),%eax
     a86:	8d 50 01             	lea    0x1(%eax),%edx
     a89:	89 55 10             	mov    %edx,0x10(%ebp)
     a8c:	0f b6 00             	movzbl (%eax),%eax
     a8f:	0f b6 d8             	movzbl %al,%ebx
     a92:	8d 43 dd             	lea    -0x23(%ebx),%eax
     a95:	83 f8 55             	cmp    $0x55,%eax
     a98:	0f 87 15 03 00 00    	ja     db3 <vprintfmt+0x385>
     a9e:	8b 04 85 44 12 00 00 	mov    0x1244(,%eax,4),%eax
     aa5:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     aa7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     aab:	eb d6                	jmp    a83 <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     aad:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     ab1:	eb d0                	jmp    a83 <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     ab3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     aba:	8b 55 e0             	mov    -0x20(%ebp),%edx
     abd:	89 d0                	mov    %edx,%eax
     abf:	c1 e0 02             	shl    $0x2,%eax
     ac2:	01 d0                	add    %edx,%eax
     ac4:	01 c0                	add    %eax,%eax
     ac6:	01 d8                	add    %ebx,%eax
     ac8:	83 e8 30             	sub    $0x30,%eax
     acb:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     ace:	8b 45 10             	mov    0x10(%ebp),%eax
     ad1:	0f b6 00             	movzbl (%eax),%eax
     ad4:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     ad7:	83 fb 2f             	cmp    $0x2f,%ebx
     ada:	7e 39                	jle    b15 <vprintfmt+0xe7>
     adc:	83 fb 39             	cmp    $0x39,%ebx
     adf:	7f 34                	jg     b15 <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     ae1:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     ae5:	eb d3                	jmp    aba <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     ae7:	8b 45 14             	mov    0x14(%ebp),%eax
     aea:	8d 50 04             	lea    0x4(%eax),%edx
     aed:	89 55 14             	mov    %edx,0x14(%ebp)
     af0:	8b 00                	mov    (%eax),%eax
     af2:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     af5:	eb 1f                	jmp    b16 <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     af7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     afb:	79 86                	jns    a83 <vprintfmt+0x55>
        width = 0;
     afd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     b04:	e9 7a ff ff ff       	jmp    a83 <vprintfmt+0x55>

    case '#':
      altflag = 1;
     b09:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     b10:	e9 6e ff ff ff       	jmp    a83 <vprintfmt+0x55>
      goto process_precision;
     b15:	90                   	nop

process_precision:
      if (width < 0)
     b16:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b1a:	0f 89 63 ff ff ff    	jns    a83 <vprintfmt+0x55>
        width = precision, precision = -1;
     b20:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b23:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     b26:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     b2d:	e9 51 ff ff ff       	jmp    a83 <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     b32:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     b36:	e9 48 ff ff ff       	jmp    a83 <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     b3b:	8b 45 14             	mov    0x14(%ebp),%eax
     b3e:	8d 50 04             	lea    0x4(%eax),%edx
     b41:	89 55 14             	mov    %edx,0x14(%ebp)
     b44:	8b 00                	mov    (%eax),%eax
     b46:	83 ec 08             	sub    $0x8,%esp
     b49:	ff 75 0c             	pushl  0xc(%ebp)
     b4c:	50                   	push   %eax
     b4d:	8b 45 08             	mov    0x8(%ebp),%eax
     b50:	ff d0                	call   *%eax
     b52:	83 c4 10             	add    $0x10,%esp
      break;
     b55:	e9 81 02 00 00       	jmp    ddb <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     b5a:	8b 45 14             	mov    0x14(%ebp),%eax
     b5d:	8d 50 04             	lea    0x4(%eax),%edx
     b60:	89 55 14             	mov    %edx,0x14(%ebp)
     b63:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     b65:	85 db                	test   %ebx,%ebx
     b67:	79 02                	jns    b6b <vprintfmt+0x13d>
        err = -err;
     b69:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     b6b:	83 fb 0f             	cmp    $0xf,%ebx
     b6e:	7f 0b                	jg     b7b <vprintfmt+0x14d>
     b70:	8b 34 9d e0 11 00 00 	mov    0x11e0(,%ebx,4),%esi
     b77:	85 f6                	test   %esi,%esi
     b79:	75 19                	jne    b94 <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     b7b:	53                   	push   %ebx
     b7c:	68 31 12 00 00       	push   $0x1231
     b81:	ff 75 0c             	pushl  0xc(%ebp)
     b84:	ff 75 08             	pushl  0x8(%ebp)
     b87:	e8 5c 02 00 00       	call   de8 <printfmt>
     b8c:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     b8f:	e9 47 02 00 00       	jmp    ddb <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     b94:	56                   	push   %esi
     b95:	68 3a 12 00 00       	push   $0x123a
     b9a:	ff 75 0c             	pushl  0xc(%ebp)
     b9d:	ff 75 08             	pushl  0x8(%ebp)
     ba0:	e8 43 02 00 00       	call   de8 <printfmt>
     ba5:	83 c4 10             	add    $0x10,%esp
      break;
     ba8:	e9 2e 02 00 00       	jmp    ddb <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     bad:	8b 45 14             	mov    0x14(%ebp),%eax
     bb0:	8d 50 04             	lea    0x4(%eax),%edx
     bb3:	89 55 14             	mov    %edx,0x14(%ebp)
     bb6:	8b 30                	mov    (%eax),%esi
     bb8:	85 f6                	test   %esi,%esi
     bba:	75 05                	jne    bc1 <vprintfmt+0x193>
        p = "(null)";
     bbc:	be 3d 12 00 00       	mov    $0x123d,%esi
      if (width > 0 && padc != '-')
     bc1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bc5:	7e 6f                	jle    c36 <vprintfmt+0x208>
     bc7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     bcb:	74 69                	je     c36 <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     bcd:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bd0:	83 ec 08             	sub    $0x8,%esp
     bd3:	50                   	push   %eax
     bd4:	56                   	push   %esi
     bd5:	e8 f1 f5 ff ff       	call   1cb <strnlen>
     bda:	83 c4 10             	add    $0x10,%esp
     bdd:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     be0:	eb 17                	jmp    bf9 <vprintfmt+0x1cb>
          putch(padc, putdat);
     be2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     be6:	83 ec 08             	sub    $0x8,%esp
     be9:	ff 75 0c             	pushl  0xc(%ebp)
     bec:	50                   	push   %eax
     bed:	8b 45 08             	mov    0x8(%ebp),%eax
     bf0:	ff d0                	call   *%eax
     bf2:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     bf5:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     bf9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bfd:	7f e3                	jg     be2 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     bff:	eb 35                	jmp    c36 <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     c01:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     c05:	74 1c                	je     c23 <vprintfmt+0x1f5>
     c07:	83 fb 1f             	cmp    $0x1f,%ebx
     c0a:	7e 05                	jle    c11 <vprintfmt+0x1e3>
     c0c:	83 fb 7e             	cmp    $0x7e,%ebx
     c0f:	7e 12                	jle    c23 <vprintfmt+0x1f5>
          putch('?', putdat);
     c11:	83 ec 08             	sub    $0x8,%esp
     c14:	ff 75 0c             	pushl  0xc(%ebp)
     c17:	6a 3f                	push   $0x3f
     c19:	8b 45 08             	mov    0x8(%ebp),%eax
     c1c:	ff d0                	call   *%eax
     c1e:	83 c4 10             	add    $0x10,%esp
     c21:	eb 0f                	jmp    c32 <vprintfmt+0x204>
        else
          putch(ch, putdat);
     c23:	83 ec 08             	sub    $0x8,%esp
     c26:	ff 75 0c             	pushl  0xc(%ebp)
     c29:	53                   	push   %ebx
     c2a:	8b 45 08             	mov    0x8(%ebp),%eax
     c2d:	ff d0                	call   *%eax
     c2f:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     c32:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     c36:	89 f0                	mov    %esi,%eax
     c38:	8d 70 01             	lea    0x1(%eax),%esi
     c3b:	0f b6 00             	movzbl (%eax),%eax
     c3e:	0f be d8             	movsbl %al,%ebx
     c41:	85 db                	test   %ebx,%ebx
     c43:	74 26                	je     c6b <vprintfmt+0x23d>
     c45:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     c49:	78 b6                	js     c01 <vprintfmt+0x1d3>
     c4b:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     c4f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     c53:	79 ac                	jns    c01 <vprintfmt+0x1d3>
      for (; width > 0; width--)
     c55:	eb 14                	jmp    c6b <vprintfmt+0x23d>
        putch(' ', putdat);
     c57:	83 ec 08             	sub    $0x8,%esp
     c5a:	ff 75 0c             	pushl  0xc(%ebp)
     c5d:	6a 20                	push   $0x20
     c5f:	8b 45 08             	mov    0x8(%ebp),%eax
     c62:	ff d0                	call   *%eax
     c64:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     c67:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     c6b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c6f:	7f e6                	jg     c57 <vprintfmt+0x229>
      break;
     c71:	e9 65 01 00 00       	jmp    ddb <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     c76:	83 ec 08             	sub    $0x8,%esp
     c79:	ff 75 e8             	pushl  -0x18(%ebp)
     c7c:	8d 45 14             	lea    0x14(%ebp),%eax
     c7f:	50                   	push   %eax
     c80:	e8 62 fd ff ff       	call   9e7 <getint>
     c85:	83 c4 10             	add    $0x10,%esp
     c88:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c8b:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     c8e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c91:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c94:	85 d2                	test   %edx,%edx
     c96:	79 23                	jns    cbb <vprintfmt+0x28d>
        putch('-', putdat);
     c98:	83 ec 08             	sub    $0x8,%esp
     c9b:	ff 75 0c             	pushl  0xc(%ebp)
     c9e:	6a 2d                	push   $0x2d
     ca0:	8b 45 08             	mov    0x8(%ebp),%eax
     ca3:	ff d0                	call   *%eax
     ca5:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     ca8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     cab:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cae:	f7 d8                	neg    %eax
     cb0:	83 d2 00             	adc    $0x0,%edx
     cb3:	f7 da                	neg    %edx
     cb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cb8:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     cbb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     cc2:	e9 b6 00 00 00       	jmp    d7d <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     cc7:	83 ec 08             	sub    $0x8,%esp
     cca:	ff 75 e8             	pushl  -0x18(%ebp)
     ccd:	8d 45 14             	lea    0x14(%ebp),%eax
     cd0:	50                   	push   %eax
     cd1:	e8 c2 fc ff ff       	call   998 <getuint>
     cd6:	83 c4 10             	add    $0x10,%esp
     cd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
     cdc:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     cdf:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     ce6:	e9 92 00 00 00       	jmp    d7d <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     ceb:	83 ec 08             	sub    $0x8,%esp
     cee:	ff 75 0c             	pushl  0xc(%ebp)
     cf1:	6a 58                	push   $0x58
     cf3:	8b 45 08             	mov    0x8(%ebp),%eax
     cf6:	ff d0                	call   *%eax
     cf8:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     cfb:	83 ec 08             	sub    $0x8,%esp
     cfe:	ff 75 0c             	pushl  0xc(%ebp)
     d01:	6a 58                	push   $0x58
     d03:	8b 45 08             	mov    0x8(%ebp),%eax
     d06:	ff d0                	call   *%eax
     d08:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     d0b:	83 ec 08             	sub    $0x8,%esp
     d0e:	ff 75 0c             	pushl  0xc(%ebp)
     d11:	6a 58                	push   $0x58
     d13:	8b 45 08             	mov    0x8(%ebp),%eax
     d16:	ff d0                	call   *%eax
     d18:	83 c4 10             	add    $0x10,%esp
      break;
     d1b:	e9 bb 00 00 00       	jmp    ddb <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     d20:	83 ec 08             	sub    $0x8,%esp
     d23:	ff 75 0c             	pushl  0xc(%ebp)
     d26:	6a 30                	push   $0x30
     d28:	8b 45 08             	mov    0x8(%ebp),%eax
     d2b:	ff d0                	call   *%eax
     d2d:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     d30:	83 ec 08             	sub    $0x8,%esp
     d33:	ff 75 0c             	pushl  0xc(%ebp)
     d36:	6a 78                	push   $0x78
     d38:	8b 45 08             	mov    0x8(%ebp),%eax
     d3b:	ff d0                	call   *%eax
     d3d:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     d40:	8b 45 14             	mov    0x14(%ebp),%eax
     d43:	8d 50 04             	lea    0x4(%eax),%edx
     d46:	89 55 14             	mov    %edx,0x14(%ebp)
     d49:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     d4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d4e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     d55:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     d5c:	eb 1f                	jmp    d7d <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     d5e:	83 ec 08             	sub    $0x8,%esp
     d61:	ff 75 e8             	pushl  -0x18(%ebp)
     d64:	8d 45 14             	lea    0x14(%ebp),%eax
     d67:	50                   	push   %eax
     d68:	e8 2b fc ff ff       	call   998 <getuint>
     d6d:	83 c4 10             	add    $0x10,%esp
     d70:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d73:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     d76:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     d7d:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     d81:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d84:	83 ec 04             	sub    $0x4,%esp
     d87:	52                   	push   %edx
     d88:	ff 75 e4             	pushl  -0x1c(%ebp)
     d8b:	50                   	push   %eax
     d8c:	ff 75 f4             	pushl  -0xc(%ebp)
     d8f:	ff 75 f0             	pushl  -0x10(%ebp)
     d92:	ff 75 0c             	pushl  0xc(%ebp)
     d95:	ff 75 08             	pushl  0x8(%ebp)
     d98:	e8 42 fb ff ff       	call   8df <printnum>
     d9d:	83 c4 20             	add    $0x20,%esp
      break;
     da0:	eb 39                	jmp    ddb <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     da2:	83 ec 08             	sub    $0x8,%esp
     da5:	ff 75 0c             	pushl  0xc(%ebp)
     da8:	53                   	push   %ebx
     da9:	8b 45 08             	mov    0x8(%ebp),%eax
     dac:	ff d0                	call   *%eax
     dae:	83 c4 10             	add    $0x10,%esp
      break;
     db1:	eb 28                	jmp    ddb <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     db3:	83 ec 08             	sub    $0x8,%esp
     db6:	ff 75 0c             	pushl  0xc(%ebp)
     db9:	6a 25                	push   $0x25
     dbb:	8b 45 08             	mov    0x8(%ebp),%eax
     dbe:	ff d0                	call   *%eax
     dc0:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     dc3:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     dc7:	eb 04                	jmp    dcd <vprintfmt+0x39f>
     dc9:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     dcd:	8b 45 10             	mov    0x10(%ebp),%eax
     dd0:	83 e8 01             	sub    $0x1,%eax
     dd3:	0f b6 00             	movzbl (%eax),%eax
     dd6:	3c 25                	cmp    $0x25,%al
     dd8:	75 ef                	jne    dc9 <vprintfmt+0x39b>
        /* do nothing */;
      break;
     dda:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     ddb:	e9 6f fc ff ff       	jmp    a4f <vprintfmt+0x21>
        return;
     de0:	90                   	nop
    }
  }
}
     de1:	8d 65 f8             	lea    -0x8(%ebp),%esp
     de4:	5b                   	pop    %ebx
     de5:	5e                   	pop    %esi
     de6:	5d                   	pop    %ebp
     de7:	c3                   	ret    

00000de8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     de8:	55                   	push   %ebp
     de9:	89 e5                	mov    %esp,%ebp
     deb:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     dee:	8d 45 14             	lea    0x14(%ebp),%eax
     df1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     df4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     df7:	50                   	push   %eax
     df8:	ff 75 10             	pushl  0x10(%ebp)
     dfb:	ff 75 0c             	pushl  0xc(%ebp)
     dfe:	ff 75 08             	pushl  0x8(%ebp)
     e01:	e8 28 fc ff ff       	call   a2e <vprintfmt>
     e06:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     e09:	90                   	nop
     e0a:	c9                   	leave  
     e0b:	c3                   	ret    

00000e0c <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     e0c:	55                   	push   %ebp
     e0d:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     e0f:	8b 45 0c             	mov    0xc(%ebp),%eax
     e12:	8b 40 08             	mov    0x8(%eax),%eax
     e15:	8d 50 01             	lea    0x1(%eax),%edx
     e18:	8b 45 0c             	mov    0xc(%ebp),%eax
     e1b:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e21:	8b 10                	mov    (%eax),%edx
     e23:	8b 45 0c             	mov    0xc(%ebp),%eax
     e26:	8b 40 04             	mov    0x4(%eax),%eax
     e29:	39 c2                	cmp    %eax,%edx
     e2b:	73 12                	jae    e3f <sprintputch+0x33>
    *b->buf++ = ch;
     e2d:	8b 45 0c             	mov    0xc(%ebp),%eax
     e30:	8b 00                	mov    (%eax),%eax
     e32:	8d 48 01             	lea    0x1(%eax),%ecx
     e35:	8b 55 0c             	mov    0xc(%ebp),%edx
     e38:	89 0a                	mov    %ecx,(%edx)
     e3a:	8b 55 08             	mov    0x8(%ebp),%edx
     e3d:	88 10                	mov    %dl,(%eax)
}
     e3f:	90                   	nop
     e40:	5d                   	pop    %ebp
     e41:	c3                   	ret    

00000e42 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     e42:	55                   	push   %ebp
     e43:	89 e5                	mov    %esp,%ebp
     e45:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     e48:	8b 45 08             	mov    0x8(%ebp),%eax
     e4b:	89 45 ec             	mov    %eax,-0x14(%ebp)
     e4e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e51:	8d 50 ff             	lea    -0x1(%eax),%edx
     e54:	8b 45 08             	mov    0x8(%ebp),%eax
     e57:	01 d0                	add    %edx,%eax
     e59:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e5c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     e63:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     e67:	74 06                	je     e6f <vsnprintf+0x2d>
     e69:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e6d:	7f 07                	jg     e76 <vsnprintf+0x34>
    return -E_INVAL;
     e6f:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     e74:	eb 20                	jmp    e96 <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     e76:	ff 75 14             	pushl  0x14(%ebp)
     e79:	ff 75 10             	pushl  0x10(%ebp)
     e7c:	8d 45 ec             	lea    -0x14(%ebp),%eax
     e7f:	50                   	push   %eax
     e80:	68 0c 0e 00 00       	push   $0xe0c
     e85:	e8 a4 fb ff ff       	call   a2e <vprintfmt>
     e8a:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     e8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e90:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     e93:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e96:	c9                   	leave  
     e97:	c3                   	ret    

00000e98 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     e98:	55                   	push   %ebp
     e99:	89 e5                	mov    %esp,%ebp
     e9b:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     e9e:	8d 45 14             	lea    0x14(%ebp),%eax
     ea1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     ea4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ea7:	50                   	push   %eax
     ea8:	ff 75 10             	pushl  0x10(%ebp)
     eab:	ff 75 0c             	pushl  0xc(%ebp)
     eae:	ff 75 08             	pushl  0x8(%ebp)
     eb1:	e8 8c ff ff ff       	call   e42 <vsnprintf>
     eb6:	83 c4 10             	add    $0x10,%esp
     eb9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     ebc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     ebf:	c9                   	leave  
     ec0:	c3                   	ret    
     ec1:	66 90                	xchg   %ax,%ax
     ec3:	66 90                	xchg   %ax,%ax
     ec5:	66 90                	xchg   %ax,%ax
     ec7:	66 90                	xchg   %ax,%ax
     ec9:	66 90                	xchg   %ax,%ax
     ecb:	66 90                	xchg   %ax,%ax
     ecd:	66 90                	xchg   %ax,%ax
     ecf:	90                   	nop

00000ed0 <__udivdi3>:
     ed0:	55                   	push   %ebp
     ed1:	57                   	push   %edi
     ed2:	56                   	push   %esi
     ed3:	53                   	push   %ebx
     ed4:	83 ec 1c             	sub    $0x1c,%esp
     ed7:	8b 54 24 3c          	mov    0x3c(%esp),%edx
     edb:	8b 6c 24 30          	mov    0x30(%esp),%ebp
     edf:	8b 74 24 34          	mov    0x34(%esp),%esi
     ee3:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     ee7:	85 d2                	test   %edx,%edx
     ee9:	75 35                	jne    f20 <__udivdi3+0x50>
     eeb:	39 f3                	cmp    %esi,%ebx
     eed:	0f 87 bd 00 00 00    	ja     fb0 <__udivdi3+0xe0>
     ef3:	85 db                	test   %ebx,%ebx
     ef5:	89 d9                	mov    %ebx,%ecx
     ef7:	75 0b                	jne    f04 <__udivdi3+0x34>
     ef9:	b8 01 00 00 00       	mov    $0x1,%eax
     efe:	31 d2                	xor    %edx,%edx
     f00:	f7 f3                	div    %ebx
     f02:	89 c1                	mov    %eax,%ecx
     f04:	31 d2                	xor    %edx,%edx
     f06:	89 f0                	mov    %esi,%eax
     f08:	f7 f1                	div    %ecx
     f0a:	89 c6                	mov    %eax,%esi
     f0c:	89 e8                	mov    %ebp,%eax
     f0e:	89 f7                	mov    %esi,%edi
     f10:	f7 f1                	div    %ecx
     f12:	89 fa                	mov    %edi,%edx
     f14:	83 c4 1c             	add    $0x1c,%esp
     f17:	5b                   	pop    %ebx
     f18:	5e                   	pop    %esi
     f19:	5f                   	pop    %edi
     f1a:	5d                   	pop    %ebp
     f1b:	c3                   	ret    
     f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f20:	39 f2                	cmp    %esi,%edx
     f22:	77 7c                	ja     fa0 <__udivdi3+0xd0>
     f24:	0f bd fa             	bsr    %edx,%edi
     f27:	83 f7 1f             	xor    $0x1f,%edi
     f2a:	0f 84 98 00 00 00    	je     fc8 <__udivdi3+0xf8>
     f30:	89 f9                	mov    %edi,%ecx
     f32:	b8 20 00 00 00       	mov    $0x20,%eax
     f37:	29 f8                	sub    %edi,%eax
     f39:	d3 e2                	shl    %cl,%edx
     f3b:	89 54 24 08          	mov    %edx,0x8(%esp)
     f3f:	89 c1                	mov    %eax,%ecx
     f41:	89 da                	mov    %ebx,%edx
     f43:	d3 ea                	shr    %cl,%edx
     f45:	8b 4c 24 08          	mov    0x8(%esp),%ecx
     f49:	09 d1                	or     %edx,%ecx
     f4b:	89 f2                	mov    %esi,%edx
     f4d:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     f51:	89 f9                	mov    %edi,%ecx
     f53:	d3 e3                	shl    %cl,%ebx
     f55:	89 c1                	mov    %eax,%ecx
     f57:	d3 ea                	shr    %cl,%edx
     f59:	89 f9                	mov    %edi,%ecx
     f5b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     f5f:	d3 e6                	shl    %cl,%esi
     f61:	89 eb                	mov    %ebp,%ebx
     f63:	89 c1                	mov    %eax,%ecx
     f65:	d3 eb                	shr    %cl,%ebx
     f67:	09 de                	or     %ebx,%esi
     f69:	89 f0                	mov    %esi,%eax
     f6b:	f7 74 24 08          	divl   0x8(%esp)
     f6f:	89 d6                	mov    %edx,%esi
     f71:	89 c3                	mov    %eax,%ebx
     f73:	f7 64 24 0c          	mull   0xc(%esp)
     f77:	39 d6                	cmp    %edx,%esi
     f79:	72 0c                	jb     f87 <__udivdi3+0xb7>
     f7b:	89 f9                	mov    %edi,%ecx
     f7d:	d3 e5                	shl    %cl,%ebp
     f7f:	39 c5                	cmp    %eax,%ebp
     f81:	73 5d                	jae    fe0 <__udivdi3+0x110>
     f83:	39 d6                	cmp    %edx,%esi
     f85:	75 59                	jne    fe0 <__udivdi3+0x110>
     f87:	8d 43 ff             	lea    -0x1(%ebx),%eax
     f8a:	31 ff                	xor    %edi,%edi
     f8c:	89 fa                	mov    %edi,%edx
     f8e:	83 c4 1c             	add    $0x1c,%esp
     f91:	5b                   	pop    %ebx
     f92:	5e                   	pop    %esi
     f93:	5f                   	pop    %edi
     f94:	5d                   	pop    %ebp
     f95:	c3                   	ret    
     f96:	8d 76 00             	lea    0x0(%esi),%esi
     f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     fa0:	31 ff                	xor    %edi,%edi
     fa2:	31 c0                	xor    %eax,%eax
     fa4:	89 fa                	mov    %edi,%edx
     fa6:	83 c4 1c             	add    $0x1c,%esp
     fa9:	5b                   	pop    %ebx
     faa:	5e                   	pop    %esi
     fab:	5f                   	pop    %edi
     fac:	5d                   	pop    %ebp
     fad:	c3                   	ret    
     fae:	66 90                	xchg   %ax,%ax
     fb0:	31 ff                	xor    %edi,%edi
     fb2:	89 e8                	mov    %ebp,%eax
     fb4:	89 f2                	mov    %esi,%edx
     fb6:	f7 f3                	div    %ebx
     fb8:	89 fa                	mov    %edi,%edx
     fba:	83 c4 1c             	add    $0x1c,%esp
     fbd:	5b                   	pop    %ebx
     fbe:	5e                   	pop    %esi
     fbf:	5f                   	pop    %edi
     fc0:	5d                   	pop    %ebp
     fc1:	c3                   	ret    
     fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fc8:	39 f2                	cmp    %esi,%edx
     fca:	72 06                	jb     fd2 <__udivdi3+0x102>
     fcc:	31 c0                	xor    %eax,%eax
     fce:	39 eb                	cmp    %ebp,%ebx
     fd0:	77 d2                	ja     fa4 <__udivdi3+0xd4>
     fd2:	b8 01 00 00 00       	mov    $0x1,%eax
     fd7:	eb cb                	jmp    fa4 <__udivdi3+0xd4>
     fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fe0:	89 d8                	mov    %ebx,%eax
     fe2:	31 ff                	xor    %edi,%edi
     fe4:	eb be                	jmp    fa4 <__udivdi3+0xd4>
     fe6:	66 90                	xchg   %ax,%ax
     fe8:	66 90                	xchg   %ax,%ax
     fea:	66 90                	xchg   %ax,%ax
     fec:	66 90                	xchg   %ax,%ax
     fee:	66 90                	xchg   %ax,%ax

00000ff0 <__umoddi3>:
     ff0:	55                   	push   %ebp
     ff1:	57                   	push   %edi
     ff2:	56                   	push   %esi
     ff3:	53                   	push   %ebx
     ff4:	83 ec 1c             	sub    $0x1c,%esp
     ff7:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
     ffb:	8b 74 24 30          	mov    0x30(%esp),%esi
     fff:	8b 5c 24 34          	mov    0x34(%esp),%ebx
    1003:	8b 7c 24 38          	mov    0x38(%esp),%edi
    1007:	85 ed                	test   %ebp,%ebp
    1009:	89 f0                	mov    %esi,%eax
    100b:	89 da                	mov    %ebx,%edx
    100d:	75 19                	jne    1028 <__umoddi3+0x38>
    100f:	39 df                	cmp    %ebx,%edi
    1011:	0f 86 b1 00 00 00    	jbe    10c8 <__umoddi3+0xd8>
    1017:	f7 f7                	div    %edi
    1019:	89 d0                	mov    %edx,%eax
    101b:	31 d2                	xor    %edx,%edx
    101d:	83 c4 1c             	add    $0x1c,%esp
    1020:	5b                   	pop    %ebx
    1021:	5e                   	pop    %esi
    1022:	5f                   	pop    %edi
    1023:	5d                   	pop    %ebp
    1024:	c3                   	ret    
    1025:	8d 76 00             	lea    0x0(%esi),%esi
    1028:	39 dd                	cmp    %ebx,%ebp
    102a:	77 f1                	ja     101d <__umoddi3+0x2d>
    102c:	0f bd cd             	bsr    %ebp,%ecx
    102f:	83 f1 1f             	xor    $0x1f,%ecx
    1032:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    1036:	0f 84 b4 00 00 00    	je     10f0 <__umoddi3+0x100>
    103c:	b8 20 00 00 00       	mov    $0x20,%eax
    1041:	89 c2                	mov    %eax,%edx
    1043:	8b 44 24 04          	mov    0x4(%esp),%eax
    1047:	29 c2                	sub    %eax,%edx
    1049:	89 c1                	mov    %eax,%ecx
    104b:	89 f8                	mov    %edi,%eax
    104d:	d3 e5                	shl    %cl,%ebp
    104f:	89 d1                	mov    %edx,%ecx
    1051:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1055:	d3 e8                	shr    %cl,%eax
    1057:	09 c5                	or     %eax,%ebp
    1059:	8b 44 24 04          	mov    0x4(%esp),%eax
    105d:	89 c1                	mov    %eax,%ecx
    105f:	d3 e7                	shl    %cl,%edi
    1061:	89 d1                	mov    %edx,%ecx
    1063:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1067:	89 df                	mov    %ebx,%edi
    1069:	d3 ef                	shr    %cl,%edi
    106b:	89 c1                	mov    %eax,%ecx
    106d:	89 f0                	mov    %esi,%eax
    106f:	d3 e3                	shl    %cl,%ebx
    1071:	89 d1                	mov    %edx,%ecx
    1073:	89 fa                	mov    %edi,%edx
    1075:	d3 e8                	shr    %cl,%eax
    1077:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
    107c:	09 d8                	or     %ebx,%eax
    107e:	f7 f5                	div    %ebp
    1080:	d3 e6                	shl    %cl,%esi
    1082:	89 d1                	mov    %edx,%ecx
    1084:	f7 64 24 08          	mull   0x8(%esp)
    1088:	39 d1                	cmp    %edx,%ecx
    108a:	89 c3                	mov    %eax,%ebx
    108c:	89 d7                	mov    %edx,%edi
    108e:	72 06                	jb     1096 <__umoddi3+0xa6>
    1090:	75 0e                	jne    10a0 <__umoddi3+0xb0>
    1092:	39 c6                	cmp    %eax,%esi
    1094:	73 0a                	jae    10a0 <__umoddi3+0xb0>
    1096:	2b 44 24 08          	sub    0x8(%esp),%eax
    109a:	19 ea                	sbb    %ebp,%edx
    109c:	89 d7                	mov    %edx,%edi
    109e:	89 c3                	mov    %eax,%ebx
    10a0:	89 ca                	mov    %ecx,%edx
    10a2:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
    10a7:	29 de                	sub    %ebx,%esi
    10a9:	19 fa                	sbb    %edi,%edx
    10ab:	8b 5c 24 04          	mov    0x4(%esp),%ebx
    10af:	89 d0                	mov    %edx,%eax
    10b1:	d3 e0                	shl    %cl,%eax
    10b3:	89 d9                	mov    %ebx,%ecx
    10b5:	d3 ee                	shr    %cl,%esi
    10b7:	d3 ea                	shr    %cl,%edx
    10b9:	09 f0                	or     %esi,%eax
    10bb:	83 c4 1c             	add    $0x1c,%esp
    10be:	5b                   	pop    %ebx
    10bf:	5e                   	pop    %esi
    10c0:	5f                   	pop    %edi
    10c1:	5d                   	pop    %ebp
    10c2:	c3                   	ret    
    10c3:	90                   	nop
    10c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10c8:	85 ff                	test   %edi,%edi
    10ca:	89 f9                	mov    %edi,%ecx
    10cc:	75 0b                	jne    10d9 <__umoddi3+0xe9>
    10ce:	b8 01 00 00 00       	mov    $0x1,%eax
    10d3:	31 d2                	xor    %edx,%edx
    10d5:	f7 f7                	div    %edi
    10d7:	89 c1                	mov    %eax,%ecx
    10d9:	89 d8                	mov    %ebx,%eax
    10db:	31 d2                	xor    %edx,%edx
    10dd:	f7 f1                	div    %ecx
    10df:	89 f0                	mov    %esi,%eax
    10e1:	f7 f1                	div    %ecx
    10e3:	e9 31 ff ff ff       	jmp    1019 <__umoddi3+0x29>
    10e8:	90                   	nop
    10e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10f0:	39 dd                	cmp    %ebx,%ebp
    10f2:	72 08                	jb     10fc <__umoddi3+0x10c>
    10f4:	39 f7                	cmp    %esi,%edi
    10f6:	0f 87 21 ff ff ff    	ja     101d <__umoddi3+0x2d>
    10fc:	89 da                	mov    %ebx,%edx
    10fe:	89 f0                	mov    %esi,%eax
    1100:	29 f8                	sub    %edi,%eax
    1102:	19 ea                	sbb    %ebp,%edx
    1104:	e9 14 ff ff ff       	jmp    101d <__umoddi3+0x2d>
