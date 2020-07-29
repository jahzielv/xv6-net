
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
       6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
       d:	8b 45 e8             	mov    -0x18(%ebp),%eax
      10:	89 45 ec             	mov    %eax,-0x14(%ebp)
      13:	8b 45 ec             	mov    -0x14(%ebp),%eax
      16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
      19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
      20:	eb 69                	jmp    8b <wc+0x8b>
    for(i=0; i<n; i++){
      22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      29:	eb 58                	jmp    83 <wc+0x83>
      c++;
      2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
      2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      32:	05 00 19 00 00       	add    $0x1900,%eax
      37:	0f b6 00             	movzbl (%eax),%eax
      3a:	3c 0a                	cmp    $0xa,%al
      3c:	75 04                	jne    42 <wc+0x42>
        l++;
      3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
      42:	8b 45 f4             	mov    -0xc(%ebp),%eax
      45:	05 00 19 00 00       	add    $0x1900,%eax
      4a:	0f b6 00             	movzbl (%eax),%eax
      4d:	0f be c0             	movsbl %al,%eax
      50:	83 ec 08             	sub    $0x8,%esp
      53:	50                   	push   %eax
      54:	68 c0 11 00 00       	push   $0x11c0
      59:	e8 65 02 00 00       	call   2c3 <strchr>
      5e:	83 c4 10             	add    $0x10,%esp
      61:	85 c0                	test   %eax,%eax
      63:	74 09                	je     6e <wc+0x6e>
        inword = 0;
      65:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      6c:	eb 11                	jmp    7f <wc+0x7f>
      else if(!inword){
      6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
      72:	75 0b                	jne    7f <wc+0x7f>
        w++;
      74:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
      78:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
      7f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      83:	8b 45 f4             	mov    -0xc(%ebp),%eax
      86:	3b 45 e0             	cmp    -0x20(%ebp),%eax
      89:	7c a0                	jl     2b <wc+0x2b>
  while((n = read(fd, buf, sizeof(buf))) > 0){
      8b:	83 ec 04             	sub    $0x4,%esp
      8e:	68 00 02 00 00       	push   $0x200
      93:	68 00 19 00 00       	push   $0x1900
      98:	ff 75 08             	pushl  0x8(%ebp)
      9b:	e8 bc 03 00 00       	call   45c <read>
      a0:	83 c4 10             	add    $0x10,%esp
      a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
      a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      aa:	0f 8f 72 ff ff ff    	jg     22 <wc+0x22>
      }
    }
  }
  if(n < 0){
      b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
      b4:	79 17                	jns    cd <wc+0xcd>
    printf(1, "wc: read error\n");
      b6:	83 ec 08             	sub    $0x8,%esp
      b9:	68 c6 11 00 00       	push   $0x11c6
      be:	6a 01                	push   $0x1
      c0:	e8 12 05 00 00       	call   5d7 <printf>
      c5:	83 c4 10             	add    $0x10,%esp
    exit();
      c8:	e8 77 03 00 00       	call   444 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
      cd:	83 ec 08             	sub    $0x8,%esp
      d0:	ff 75 0c             	pushl  0xc(%ebp)
      d3:	ff 75 e8             	pushl  -0x18(%ebp)
      d6:	ff 75 ec             	pushl  -0x14(%ebp)
      d9:	ff 75 f0             	pushl  -0x10(%ebp)
      dc:	68 d6 11 00 00       	push   $0x11d6
      e1:	6a 01                	push   $0x1
      e3:	e8 ef 04 00 00       	call   5d7 <printf>
      e8:	83 c4 20             	add    $0x20,%esp
}
      eb:	90                   	nop
      ec:	c9                   	leave  
      ed:	c3                   	ret    

000000ee <main>:

int
main(int argc, char *argv[])
{
      ee:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      f2:	83 e4 f0             	and    $0xfffffff0,%esp
      f5:	ff 71 fc             	pushl  -0x4(%ecx)
      f8:	55                   	push   %ebp
      f9:	89 e5                	mov    %esp,%ebp
      fb:	53                   	push   %ebx
      fc:	51                   	push   %ecx
      fd:	83 ec 10             	sub    $0x10,%esp
     100:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
     102:	83 3b 01             	cmpl   $0x1,(%ebx)
     105:	7f 17                	jg     11e <main+0x30>
    wc(0, "");
     107:	83 ec 08             	sub    $0x8,%esp
     10a:	68 e3 11 00 00       	push   $0x11e3
     10f:	6a 00                	push   $0x0
     111:	e8 ea fe ff ff       	call   0 <wc>
     116:	83 c4 10             	add    $0x10,%esp
    exit();
     119:	e8 26 03 00 00       	call   444 <exit>
  }

  for(i = 1; i < argc; i++){
     11e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
     125:	e9 83 00 00 00       	jmp    1ad <main+0xbf>
    if((fd = open(argv[i], 0)) < 0){
     12a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     12d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     134:	8b 43 04             	mov    0x4(%ebx),%eax
     137:	01 d0                	add    %edx,%eax
     139:	8b 00                	mov    (%eax),%eax
     13b:	83 ec 08             	sub    $0x8,%esp
     13e:	6a 00                	push   $0x0
     140:	50                   	push   %eax
     141:	e8 3e 03 00 00       	call   484 <open>
     146:	83 c4 10             	add    $0x10,%esp
     149:	89 45 f0             	mov    %eax,-0x10(%ebp)
     14c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     150:	79 29                	jns    17b <main+0x8d>
      printf(1, "wc: cannot open %s\n", argv[i]);
     152:	8b 45 f4             	mov    -0xc(%ebp),%eax
     155:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     15c:	8b 43 04             	mov    0x4(%ebx),%eax
     15f:	01 d0                	add    %edx,%eax
     161:	8b 00                	mov    (%eax),%eax
     163:	83 ec 04             	sub    $0x4,%esp
     166:	50                   	push   %eax
     167:	68 e4 11 00 00       	push   $0x11e4
     16c:	6a 01                	push   $0x1
     16e:	e8 64 04 00 00       	call   5d7 <printf>
     173:	83 c4 10             	add    $0x10,%esp
      exit();
     176:	e8 c9 02 00 00       	call   444 <exit>
    }
    wc(fd, argv[i]);
     17b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     17e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
     185:	8b 43 04             	mov    0x4(%ebx),%eax
     188:	01 d0                	add    %edx,%eax
     18a:	8b 00                	mov    (%eax),%eax
     18c:	83 ec 08             	sub    $0x8,%esp
     18f:	50                   	push   %eax
     190:	ff 75 f0             	pushl  -0x10(%ebp)
     193:	e8 68 fe ff ff       	call   0 <wc>
     198:	83 c4 10             	add    $0x10,%esp
    close(fd);
     19b:	83 ec 0c             	sub    $0xc,%esp
     19e:	ff 75 f0             	pushl  -0x10(%ebp)
     1a1:	e8 c6 02 00 00       	call   46c <close>
     1a6:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
     1a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     1ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1b0:	3b 03                	cmp    (%ebx),%eax
     1b2:	0f 8c 72 ff ff ff    	jl     12a <main+0x3c>
  }
  exit();
     1b8:	e8 87 02 00 00       	call   444 <exit>

000001bd <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
     1bd:	55                   	push   %ebp
     1be:	89 e5                	mov    %esp,%ebp
     1c0:	57                   	push   %edi
     1c1:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     1c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
     1c5:	8b 55 10             	mov    0x10(%ebp),%edx
     1c8:	8b 45 0c             	mov    0xc(%ebp),%eax
     1cb:	89 cb                	mov    %ecx,%ebx
     1cd:	89 df                	mov    %ebx,%edi
     1cf:	89 d1                	mov    %edx,%ecx
     1d1:	fc                   	cld    
     1d2:	f3 aa                	rep stos %al,%es:(%edi)
     1d4:	89 ca                	mov    %ecx,%edx
     1d6:	89 fb                	mov    %edi,%ebx
     1d8:	89 5d 08             	mov    %ebx,0x8(%ebp)
     1db:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     1de:	90                   	nop
     1df:	5b                   	pop    %ebx
     1e0:	5f                   	pop    %edi
     1e1:	5d                   	pop    %ebp
     1e2:	c3                   	ret    

000001e3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     1e3:	55                   	push   %ebp
     1e4:	89 e5                	mov    %esp,%ebp
     1e6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     1e9:	8b 45 08             	mov    0x8(%ebp),%eax
     1ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     1ef:	90                   	nop
     1f0:	8b 55 0c             	mov    0xc(%ebp),%edx
     1f3:	8d 42 01             	lea    0x1(%edx),%eax
     1f6:	89 45 0c             	mov    %eax,0xc(%ebp)
     1f9:	8b 45 08             	mov    0x8(%ebp),%eax
     1fc:	8d 48 01             	lea    0x1(%eax),%ecx
     1ff:	89 4d 08             	mov    %ecx,0x8(%ebp)
     202:	0f b6 12             	movzbl (%edx),%edx
     205:	88 10                	mov    %dl,(%eax)
     207:	0f b6 00             	movzbl (%eax),%eax
     20a:	84 c0                	test   %al,%al
     20c:	75 e2                	jne    1f0 <strcpy+0xd>
    ;
  return os;
     20e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     211:	c9                   	leave  
     212:	c3                   	ret    

00000213 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     213:	55                   	push   %ebp
     214:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     216:	eb 08                	jmp    220 <strcmp+0xd>
    p++, q++;
     218:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     21c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     220:	8b 45 08             	mov    0x8(%ebp),%eax
     223:	0f b6 00             	movzbl (%eax),%eax
     226:	84 c0                	test   %al,%al
     228:	74 10                	je     23a <strcmp+0x27>
     22a:	8b 45 08             	mov    0x8(%ebp),%eax
     22d:	0f b6 10             	movzbl (%eax),%edx
     230:	8b 45 0c             	mov    0xc(%ebp),%eax
     233:	0f b6 00             	movzbl (%eax),%eax
     236:	38 c2                	cmp    %al,%dl
     238:	74 de                	je     218 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     23a:	8b 45 08             	mov    0x8(%ebp),%eax
     23d:	0f b6 00             	movzbl (%eax),%eax
     240:	0f b6 d0             	movzbl %al,%edx
     243:	8b 45 0c             	mov    0xc(%ebp),%eax
     246:	0f b6 00             	movzbl (%eax),%eax
     249:	0f b6 c0             	movzbl %al,%eax
     24c:	29 c2                	sub    %eax,%edx
     24e:	89 d0                	mov    %edx,%eax
}
     250:	5d                   	pop    %ebp
     251:	c3                   	ret    

00000252 <strlen>:

uint
strlen(char *s)
{
     252:	55                   	push   %ebp
     253:	89 e5                	mov    %esp,%ebp
     255:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     25f:	eb 04                	jmp    265 <strlen+0x13>
     261:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     265:	8b 55 fc             	mov    -0x4(%ebp),%edx
     268:	8b 45 08             	mov    0x8(%ebp),%eax
     26b:	01 d0                	add    %edx,%eax
     26d:	0f b6 00             	movzbl (%eax),%eax
     270:	84 c0                	test   %al,%al
     272:	75 ed                	jne    261 <strlen+0xf>
    ;
  return n;
     274:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     277:	c9                   	leave  
     278:	c3                   	ret    

00000279 <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     279:	55                   	push   %ebp
     27a:	89 e5                	mov    %esp,%ebp
     27c:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     27f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     286:	eb 0c                	jmp    294 <strnlen+0x1b>
     n++; 
     288:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     28c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     290:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     294:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     298:	74 0a                	je     2a4 <strnlen+0x2b>
     29a:	8b 45 08             	mov    0x8(%ebp),%eax
     29d:	0f b6 00             	movzbl (%eax),%eax
     2a0:	84 c0                	test   %al,%al
     2a2:	75 e4                	jne    288 <strnlen+0xf>
   return n; 
     2a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     2a7:	c9                   	leave  
     2a8:	c3                   	ret    

000002a9 <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     2a9:	55                   	push   %ebp
     2aa:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     2ac:	8b 45 10             	mov    0x10(%ebp),%eax
     2af:	50                   	push   %eax
     2b0:	ff 75 0c             	pushl  0xc(%ebp)
     2b3:	ff 75 08             	pushl  0x8(%ebp)
     2b6:	e8 02 ff ff ff       	call   1bd <stosb>
     2bb:	83 c4 0c             	add    $0xc,%esp
  return dst;
     2be:	8b 45 08             	mov    0x8(%ebp),%eax
}
     2c1:	c9                   	leave  
     2c2:	c3                   	ret    

000002c3 <strchr>:

char*
strchr(const char *s, char c)
{
     2c3:	55                   	push   %ebp
     2c4:	89 e5                	mov    %esp,%ebp
     2c6:	83 ec 04             	sub    $0x4,%esp
     2c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     2cc:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     2cf:	eb 14                	jmp    2e5 <strchr+0x22>
    if(*s == c)
     2d1:	8b 45 08             	mov    0x8(%ebp),%eax
     2d4:	0f b6 00             	movzbl (%eax),%eax
     2d7:	38 45 fc             	cmp    %al,-0x4(%ebp)
     2da:	75 05                	jne    2e1 <strchr+0x1e>
      return (char*)s;
     2dc:	8b 45 08             	mov    0x8(%ebp),%eax
     2df:	eb 13                	jmp    2f4 <strchr+0x31>
  for(; *s; s++)
     2e1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     2e5:	8b 45 08             	mov    0x8(%ebp),%eax
     2e8:	0f b6 00             	movzbl (%eax),%eax
     2eb:	84 c0                	test   %al,%al
     2ed:	75 e2                	jne    2d1 <strchr+0xe>
  return 0;
     2ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
     2f4:	c9                   	leave  
     2f5:	c3                   	ret    

000002f6 <gets>:

char*
gets(char *buf, int max)
{
     2f6:	55                   	push   %ebp
     2f7:	89 e5                	mov    %esp,%ebp
     2f9:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     303:	eb 42                	jmp    347 <gets+0x51>
    cc = read(0, &c, 1);
     305:	83 ec 04             	sub    $0x4,%esp
     308:	6a 01                	push   $0x1
     30a:	8d 45 ef             	lea    -0x11(%ebp),%eax
     30d:	50                   	push   %eax
     30e:	6a 00                	push   $0x0
     310:	e8 47 01 00 00       	call   45c <read>
     315:	83 c4 10             	add    $0x10,%esp
     318:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     31b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     31f:	7e 33                	jle    354 <gets+0x5e>
      break;
    buf[i++] = c;
     321:	8b 45 f4             	mov    -0xc(%ebp),%eax
     324:	8d 50 01             	lea    0x1(%eax),%edx
     327:	89 55 f4             	mov    %edx,-0xc(%ebp)
     32a:	89 c2                	mov    %eax,%edx
     32c:	8b 45 08             	mov    0x8(%ebp),%eax
     32f:	01 c2                	add    %eax,%edx
     331:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     335:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     337:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     33b:	3c 0a                	cmp    $0xa,%al
     33d:	74 16                	je     355 <gets+0x5f>
     33f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     343:	3c 0d                	cmp    $0xd,%al
     345:	74 0e                	je     355 <gets+0x5f>
  for(i=0; i+1 < max; ){
     347:	8b 45 f4             	mov    -0xc(%ebp),%eax
     34a:	83 c0 01             	add    $0x1,%eax
     34d:	39 45 0c             	cmp    %eax,0xc(%ebp)
     350:	7f b3                	jg     305 <gets+0xf>
     352:	eb 01                	jmp    355 <gets+0x5f>
      break;
     354:	90                   	nop
      break;
  }
  buf[i] = '\0';
     355:	8b 55 f4             	mov    -0xc(%ebp),%edx
     358:	8b 45 08             	mov    0x8(%ebp),%eax
     35b:	01 d0                	add    %edx,%eax
     35d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     360:	8b 45 08             	mov    0x8(%ebp),%eax
}
     363:	c9                   	leave  
     364:	c3                   	ret    

00000365 <stat>:

int
stat(char *n, struct stat *st)
{
     365:	55                   	push   %ebp
     366:	89 e5                	mov    %esp,%ebp
     368:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     36b:	83 ec 08             	sub    $0x8,%esp
     36e:	6a 00                	push   $0x0
     370:	ff 75 08             	pushl  0x8(%ebp)
     373:	e8 0c 01 00 00       	call   484 <open>
     378:	83 c4 10             	add    $0x10,%esp
     37b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     37e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     382:	79 07                	jns    38b <stat+0x26>
    return -1;
     384:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     389:	eb 25                	jmp    3b0 <stat+0x4b>
  r = fstat(fd, st);
     38b:	83 ec 08             	sub    $0x8,%esp
     38e:	ff 75 0c             	pushl  0xc(%ebp)
     391:	ff 75 f4             	pushl  -0xc(%ebp)
     394:	e8 03 01 00 00       	call   49c <fstat>
     399:	83 c4 10             	add    $0x10,%esp
     39c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     39f:	83 ec 0c             	sub    $0xc,%esp
     3a2:	ff 75 f4             	pushl  -0xc(%ebp)
     3a5:	e8 c2 00 00 00       	call   46c <close>
     3aa:	83 c4 10             	add    $0x10,%esp
  return r;
     3ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     3b0:	c9                   	leave  
     3b1:	c3                   	ret    

000003b2 <atoi>:

int
atoi(const char *s)
{
     3b2:	55                   	push   %ebp
     3b3:	89 e5                	mov    %esp,%ebp
     3b5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     3b8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     3bf:	eb 25                	jmp    3e6 <atoi+0x34>
    n = n*10 + *s++ - '0';
     3c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
     3c4:	89 d0                	mov    %edx,%eax
     3c6:	c1 e0 02             	shl    $0x2,%eax
     3c9:	01 d0                	add    %edx,%eax
     3cb:	01 c0                	add    %eax,%eax
     3cd:	89 c1                	mov    %eax,%ecx
     3cf:	8b 45 08             	mov    0x8(%ebp),%eax
     3d2:	8d 50 01             	lea    0x1(%eax),%edx
     3d5:	89 55 08             	mov    %edx,0x8(%ebp)
     3d8:	0f b6 00             	movzbl (%eax),%eax
     3db:	0f be c0             	movsbl %al,%eax
     3de:	01 c8                	add    %ecx,%eax
     3e0:	83 e8 30             	sub    $0x30,%eax
     3e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     3e6:	8b 45 08             	mov    0x8(%ebp),%eax
     3e9:	0f b6 00             	movzbl (%eax),%eax
     3ec:	3c 2f                	cmp    $0x2f,%al
     3ee:	7e 0a                	jle    3fa <atoi+0x48>
     3f0:	8b 45 08             	mov    0x8(%ebp),%eax
     3f3:	0f b6 00             	movzbl (%eax),%eax
     3f6:	3c 39                	cmp    $0x39,%al
     3f8:	7e c7                	jle    3c1 <atoi+0xf>
  return n;
     3fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     3fd:	c9                   	leave  
     3fe:	c3                   	ret    

000003ff <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     3ff:	55                   	push   %ebp
     400:	89 e5                	mov    %esp,%ebp
     402:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     405:	8b 45 08             	mov    0x8(%ebp),%eax
     408:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     40b:	8b 45 0c             	mov    0xc(%ebp),%eax
     40e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     411:	eb 17                	jmp    42a <memmove+0x2b>
    *dst++ = *src++;
     413:	8b 55 f8             	mov    -0x8(%ebp),%edx
     416:	8d 42 01             	lea    0x1(%edx),%eax
     419:	89 45 f8             	mov    %eax,-0x8(%ebp)
     41c:	8b 45 fc             	mov    -0x4(%ebp),%eax
     41f:	8d 48 01             	lea    0x1(%eax),%ecx
     422:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     425:	0f b6 12             	movzbl (%edx),%edx
     428:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     42a:	8b 45 10             	mov    0x10(%ebp),%eax
     42d:	8d 50 ff             	lea    -0x1(%eax),%edx
     430:	89 55 10             	mov    %edx,0x10(%ebp)
     433:	85 c0                	test   %eax,%eax
     435:	7f dc                	jg     413 <memmove+0x14>
  return vdst;
     437:	8b 45 08             	mov    0x8(%ebp),%eax
}
     43a:	c9                   	leave  
     43b:	c3                   	ret    

0000043c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     43c:	b8 01 00 00 00       	mov    $0x1,%eax
     441:	cd 40                	int    $0x40
     443:	c3                   	ret    

00000444 <exit>:
SYSCALL(exit)
     444:	b8 02 00 00 00       	mov    $0x2,%eax
     449:	cd 40                	int    $0x40
     44b:	c3                   	ret    

0000044c <wait>:
SYSCALL(wait)
     44c:	b8 03 00 00 00       	mov    $0x3,%eax
     451:	cd 40                	int    $0x40
     453:	c3                   	ret    

00000454 <pipe>:
SYSCALL(pipe)
     454:	b8 04 00 00 00       	mov    $0x4,%eax
     459:	cd 40                	int    $0x40
     45b:	c3                   	ret    

0000045c <read>:
SYSCALL(read)
     45c:	b8 05 00 00 00       	mov    $0x5,%eax
     461:	cd 40                	int    $0x40
     463:	c3                   	ret    

00000464 <write>:
SYSCALL(write)
     464:	b8 10 00 00 00       	mov    $0x10,%eax
     469:	cd 40                	int    $0x40
     46b:	c3                   	ret    

0000046c <close>:
SYSCALL(close)
     46c:	b8 15 00 00 00       	mov    $0x15,%eax
     471:	cd 40                	int    $0x40
     473:	c3                   	ret    

00000474 <kill>:
SYSCALL(kill)
     474:	b8 06 00 00 00       	mov    $0x6,%eax
     479:	cd 40                	int    $0x40
     47b:	c3                   	ret    

0000047c <exec>:
SYSCALL(exec)
     47c:	b8 07 00 00 00       	mov    $0x7,%eax
     481:	cd 40                	int    $0x40
     483:	c3                   	ret    

00000484 <open>:
SYSCALL(open)
     484:	b8 0f 00 00 00       	mov    $0xf,%eax
     489:	cd 40                	int    $0x40
     48b:	c3                   	ret    

0000048c <mknod>:
SYSCALL(mknod)
     48c:	b8 11 00 00 00       	mov    $0x11,%eax
     491:	cd 40                	int    $0x40
     493:	c3                   	ret    

00000494 <unlink>:
SYSCALL(unlink)
     494:	b8 12 00 00 00       	mov    $0x12,%eax
     499:	cd 40                	int    $0x40
     49b:	c3                   	ret    

0000049c <fstat>:
SYSCALL(fstat)
     49c:	b8 08 00 00 00       	mov    $0x8,%eax
     4a1:	cd 40                	int    $0x40
     4a3:	c3                   	ret    

000004a4 <link>:
SYSCALL(link)
     4a4:	b8 13 00 00 00       	mov    $0x13,%eax
     4a9:	cd 40                	int    $0x40
     4ab:	c3                   	ret    

000004ac <mkdir>:
SYSCALL(mkdir)
     4ac:	b8 14 00 00 00       	mov    $0x14,%eax
     4b1:	cd 40                	int    $0x40
     4b3:	c3                   	ret    

000004b4 <chdir>:
SYSCALL(chdir)
     4b4:	b8 09 00 00 00       	mov    $0x9,%eax
     4b9:	cd 40                	int    $0x40
     4bb:	c3                   	ret    

000004bc <dup>:
SYSCALL(dup)
     4bc:	b8 0a 00 00 00       	mov    $0xa,%eax
     4c1:	cd 40                	int    $0x40
     4c3:	c3                   	ret    

000004c4 <getpid>:
SYSCALL(getpid)
     4c4:	b8 0b 00 00 00       	mov    $0xb,%eax
     4c9:	cd 40                	int    $0x40
     4cb:	c3                   	ret    

000004cc <sbrk>:
SYSCALL(sbrk)
     4cc:	b8 0c 00 00 00       	mov    $0xc,%eax
     4d1:	cd 40                	int    $0x40
     4d3:	c3                   	ret    

000004d4 <sleep>:
SYSCALL(sleep)
     4d4:	b8 0d 00 00 00       	mov    $0xd,%eax
     4d9:	cd 40                	int    $0x40
     4db:	c3                   	ret    

000004dc <uptime>:
SYSCALL(uptime)
     4dc:	b8 0e 00 00 00       	mov    $0xe,%eax
     4e1:	cd 40                	int    $0x40
     4e3:	c3                   	ret    

000004e4 <select>:
SYSCALL(select)
     4e4:	b8 16 00 00 00       	mov    $0x16,%eax
     4e9:	cd 40                	int    $0x40
     4eb:	c3                   	ret    

000004ec <arp>:
SYSCALL(arp)
     4ec:	b8 17 00 00 00       	mov    $0x17,%eax
     4f1:	cd 40                	int    $0x40
     4f3:	c3                   	ret    

000004f4 <arpserv>:
SYSCALL(arpserv)
     4f4:	b8 18 00 00 00       	mov    $0x18,%eax
     4f9:	cd 40                	int    $0x40
     4fb:	c3                   	ret    

000004fc <arp_receive>:
SYSCALL(arp_receive)
     4fc:	b8 19 00 00 00       	mov    $0x19,%eax
     501:	cd 40                	int    $0x40
     503:	c3                   	ret    

00000504 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     504:	55                   	push   %ebp
     505:	89 e5                	mov    %esp,%ebp
     507:	83 ec 18             	sub    $0x18,%esp
     50a:	8b 45 0c             	mov    0xc(%ebp),%eax
     50d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     510:	83 ec 04             	sub    $0x4,%esp
     513:	6a 01                	push   $0x1
     515:	8d 45 f4             	lea    -0xc(%ebp),%eax
     518:	50                   	push   %eax
     519:	ff 75 08             	pushl  0x8(%ebp)
     51c:	e8 43 ff ff ff       	call   464 <write>
     521:	83 c4 10             	add    $0x10,%esp
}
     524:	90                   	nop
     525:	c9                   	leave  
     526:	c3                   	ret    

00000527 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     527:	55                   	push   %ebp
     528:	89 e5                	mov    %esp,%ebp
     52a:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     52d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     534:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     538:	74 17                	je     551 <printint+0x2a>
     53a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     53e:	79 11                	jns    551 <printint+0x2a>
    neg = 1;
     540:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     547:	8b 45 0c             	mov    0xc(%ebp),%eax
     54a:	f7 d8                	neg    %eax
     54c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     54f:	eb 06                	jmp    557 <printint+0x30>
  } else {
    x = xx;
     551:	8b 45 0c             	mov    0xc(%ebp),%eax
     554:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     557:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     55e:	8b 4d 10             	mov    0x10(%ebp),%ecx
     561:	8b 45 ec             	mov    -0x14(%ebp),%eax
     564:	ba 00 00 00 00       	mov    $0x0,%edx
     569:	f7 f1                	div    %ecx
     56b:	89 d1                	mov    %edx,%ecx
     56d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     570:	8d 50 01             	lea    0x1(%eax),%edx
     573:	89 55 f4             	mov    %edx,-0xc(%ebp)
     576:	0f b6 91 b0 18 00 00 	movzbl 0x18b0(%ecx),%edx
     57d:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     581:	8b 4d 10             	mov    0x10(%ebp),%ecx
     584:	8b 45 ec             	mov    -0x14(%ebp),%eax
     587:	ba 00 00 00 00       	mov    $0x0,%edx
     58c:	f7 f1                	div    %ecx
     58e:	89 45 ec             	mov    %eax,-0x14(%ebp)
     591:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     595:	75 c7                	jne    55e <printint+0x37>
  if(neg)
     597:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     59b:	74 2d                	je     5ca <printint+0xa3>
    buf[i++] = '-';
     59d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a0:	8d 50 01             	lea    0x1(%eax),%edx
     5a3:	89 55 f4             	mov    %edx,-0xc(%ebp)
     5a6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     5ab:	eb 1d                	jmp    5ca <printint+0xa3>
    putc(fd, buf[i]);
     5ad:	8d 55 dc             	lea    -0x24(%ebp),%edx
     5b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5b3:	01 d0                	add    %edx,%eax
     5b5:	0f b6 00             	movzbl (%eax),%eax
     5b8:	0f be c0             	movsbl %al,%eax
     5bb:	83 ec 08             	sub    $0x8,%esp
     5be:	50                   	push   %eax
     5bf:	ff 75 08             	pushl  0x8(%ebp)
     5c2:	e8 3d ff ff ff       	call   504 <putc>
     5c7:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     5ca:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     5ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5d2:	79 d9                	jns    5ad <printint+0x86>
}
     5d4:	90                   	nop
     5d5:	c9                   	leave  
     5d6:	c3                   	ret    

000005d7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     5d7:	55                   	push   %ebp
     5d8:	89 e5                	mov    %esp,%ebp
     5da:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     5dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     5e4:	8d 45 0c             	lea    0xc(%ebp),%eax
     5e7:	83 c0 04             	add    $0x4,%eax
     5ea:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     5ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     5f4:	e9 59 01 00 00       	jmp    752 <printf+0x17b>
    c = fmt[i] & 0xff;
     5f9:	8b 55 0c             	mov    0xc(%ebp),%edx
     5fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
     5ff:	01 d0                	add    %edx,%eax
     601:	0f b6 00             	movzbl (%eax),%eax
     604:	0f be c0             	movsbl %al,%eax
     607:	25 ff 00 00 00       	and    $0xff,%eax
     60c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     60f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     613:	75 2c                	jne    641 <printf+0x6a>
      if(c == '%'){
     615:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     619:	75 0c                	jne    627 <printf+0x50>
        state = '%';
     61b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     622:	e9 27 01 00 00       	jmp    74e <printf+0x177>
      } else {
        putc(fd, c);
     627:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     62a:	0f be c0             	movsbl %al,%eax
     62d:	83 ec 08             	sub    $0x8,%esp
     630:	50                   	push   %eax
     631:	ff 75 08             	pushl  0x8(%ebp)
     634:	e8 cb fe ff ff       	call   504 <putc>
     639:	83 c4 10             	add    $0x10,%esp
     63c:	e9 0d 01 00 00       	jmp    74e <printf+0x177>
      }
    } else if(state == '%'){
     641:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     645:	0f 85 03 01 00 00    	jne    74e <printf+0x177>
      if(c == 'd'){
     64b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     64f:	75 1e                	jne    66f <printf+0x98>
        printint(fd, *ap, 10, 1);
     651:	8b 45 e8             	mov    -0x18(%ebp),%eax
     654:	8b 00                	mov    (%eax),%eax
     656:	6a 01                	push   $0x1
     658:	6a 0a                	push   $0xa
     65a:	50                   	push   %eax
     65b:	ff 75 08             	pushl  0x8(%ebp)
     65e:	e8 c4 fe ff ff       	call   527 <printint>
     663:	83 c4 10             	add    $0x10,%esp
        ap++;
     666:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     66a:	e9 d8 00 00 00       	jmp    747 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     66f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     673:	74 06                	je     67b <printf+0xa4>
     675:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     679:	75 1e                	jne    699 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     67b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     67e:	8b 00                	mov    (%eax),%eax
     680:	6a 00                	push   $0x0
     682:	6a 10                	push   $0x10
     684:	50                   	push   %eax
     685:	ff 75 08             	pushl  0x8(%ebp)
     688:	e8 9a fe ff ff       	call   527 <printint>
     68d:	83 c4 10             	add    $0x10,%esp
        ap++;
     690:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     694:	e9 ae 00 00 00       	jmp    747 <printf+0x170>
      } else if(c == 's'){
     699:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     69d:	75 43                	jne    6e2 <printf+0x10b>
        s = (char*)*ap;
     69f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6a2:	8b 00                	mov    (%eax),%eax
     6a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     6a7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     6ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6af:	75 25                	jne    6d6 <printf+0xff>
          s = "(null)";
     6b1:	c7 45 f4 f8 11 00 00 	movl   $0x11f8,-0xc(%ebp)
        while(*s != 0){
     6b8:	eb 1c                	jmp    6d6 <printf+0xff>
          putc(fd, *s);
     6ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6bd:	0f b6 00             	movzbl (%eax),%eax
     6c0:	0f be c0             	movsbl %al,%eax
     6c3:	83 ec 08             	sub    $0x8,%esp
     6c6:	50                   	push   %eax
     6c7:	ff 75 08             	pushl  0x8(%ebp)
     6ca:	e8 35 fe ff ff       	call   504 <putc>
     6cf:	83 c4 10             	add    $0x10,%esp
          s++;
     6d2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     6d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d9:	0f b6 00             	movzbl (%eax),%eax
     6dc:	84 c0                	test   %al,%al
     6de:	75 da                	jne    6ba <printf+0xe3>
     6e0:	eb 65                	jmp    747 <printf+0x170>
        }
      } else if(c == 'c'){
     6e2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     6e6:	75 1d                	jne    705 <printf+0x12e>
        putc(fd, *ap);
     6e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     6eb:	8b 00                	mov    (%eax),%eax
     6ed:	0f be c0             	movsbl %al,%eax
     6f0:	83 ec 08             	sub    $0x8,%esp
     6f3:	50                   	push   %eax
     6f4:	ff 75 08             	pushl  0x8(%ebp)
     6f7:	e8 08 fe ff ff       	call   504 <putc>
     6fc:	83 c4 10             	add    $0x10,%esp
        ap++;
     6ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     703:	eb 42                	jmp    747 <printf+0x170>
      } else if(c == '%'){
     705:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     709:	75 17                	jne    722 <printf+0x14b>
        putc(fd, c);
     70b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     70e:	0f be c0             	movsbl %al,%eax
     711:	83 ec 08             	sub    $0x8,%esp
     714:	50                   	push   %eax
     715:	ff 75 08             	pushl  0x8(%ebp)
     718:	e8 e7 fd ff ff       	call   504 <putc>
     71d:	83 c4 10             	add    $0x10,%esp
     720:	eb 25                	jmp    747 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     722:	83 ec 08             	sub    $0x8,%esp
     725:	6a 25                	push   $0x25
     727:	ff 75 08             	pushl  0x8(%ebp)
     72a:	e8 d5 fd ff ff       	call   504 <putc>
     72f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     732:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     735:	0f be c0             	movsbl %al,%eax
     738:	83 ec 08             	sub    $0x8,%esp
     73b:	50                   	push   %eax
     73c:	ff 75 08             	pushl  0x8(%ebp)
     73f:	e8 c0 fd ff ff       	call   504 <putc>
     744:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     747:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     74e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     752:	8b 55 0c             	mov    0xc(%ebp),%edx
     755:	8b 45 f0             	mov    -0x10(%ebp),%eax
     758:	01 d0                	add    %edx,%eax
     75a:	0f b6 00             	movzbl (%eax),%eax
     75d:	84 c0                	test   %al,%al
     75f:	0f 85 94 fe ff ff    	jne    5f9 <printf+0x22>
    }
  }
}
     765:	90                   	nop
     766:	c9                   	leave  
     767:	c3                   	ret    

00000768 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     768:	55                   	push   %ebp
     769:	89 e5                	mov    %esp,%ebp
     76b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     76e:	8b 45 08             	mov    0x8(%ebp),%eax
     771:	83 e8 08             	sub    $0x8,%eax
     774:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     777:	a1 e8 18 00 00       	mov    0x18e8,%eax
     77c:	89 45 fc             	mov    %eax,-0x4(%ebp)
     77f:	eb 24                	jmp    7a5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     781:	8b 45 fc             	mov    -0x4(%ebp),%eax
     784:	8b 00                	mov    (%eax),%eax
     786:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     789:	72 12                	jb     79d <free+0x35>
     78b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     78e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     791:	77 24                	ja     7b7 <free+0x4f>
     793:	8b 45 fc             	mov    -0x4(%ebp),%eax
     796:	8b 00                	mov    (%eax),%eax
     798:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     79b:	72 1a                	jb     7b7 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     79d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7a0:	8b 00                	mov    (%eax),%eax
     7a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
     7a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7a8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     7ab:	76 d4                	jbe    781 <free+0x19>
     7ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7b0:	8b 00                	mov    (%eax),%eax
     7b2:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     7b5:	73 ca                	jae    781 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     7b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7ba:	8b 40 04             	mov    0x4(%eax),%eax
     7bd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     7c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7c7:	01 c2                	add    %eax,%edx
     7c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7cc:	8b 00                	mov    (%eax),%eax
     7ce:	39 c2                	cmp    %eax,%edx
     7d0:	75 24                	jne    7f6 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     7d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7d5:	8b 50 04             	mov    0x4(%eax),%edx
     7d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7db:	8b 00                	mov    (%eax),%eax
     7dd:	8b 40 04             	mov    0x4(%eax),%eax
     7e0:	01 c2                	add    %eax,%edx
     7e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7e5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     7e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7eb:	8b 00                	mov    (%eax),%eax
     7ed:	8b 10                	mov    (%eax),%edx
     7ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7f2:	89 10                	mov    %edx,(%eax)
     7f4:	eb 0a                	jmp    800 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     7f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     7f9:	8b 10                	mov    (%eax),%edx
     7fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
     7fe:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     800:	8b 45 fc             	mov    -0x4(%ebp),%eax
     803:	8b 40 04             	mov    0x4(%eax),%eax
     806:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     80d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     810:	01 d0                	add    %edx,%eax
     812:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     815:	75 20                	jne    837 <free+0xcf>
    p->s.size += bp->s.size;
     817:	8b 45 fc             	mov    -0x4(%ebp),%eax
     81a:	8b 50 04             	mov    0x4(%eax),%edx
     81d:	8b 45 f8             	mov    -0x8(%ebp),%eax
     820:	8b 40 04             	mov    0x4(%eax),%eax
     823:	01 c2                	add    %eax,%edx
     825:	8b 45 fc             	mov    -0x4(%ebp),%eax
     828:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     82b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     82e:	8b 10                	mov    (%eax),%edx
     830:	8b 45 fc             	mov    -0x4(%ebp),%eax
     833:	89 10                	mov    %edx,(%eax)
     835:	eb 08                	jmp    83f <free+0xd7>
  } else
    p->s.ptr = bp;
     837:	8b 45 fc             	mov    -0x4(%ebp),%eax
     83a:	8b 55 f8             	mov    -0x8(%ebp),%edx
     83d:	89 10                	mov    %edx,(%eax)
  freep = p;
     83f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     842:	a3 e8 18 00 00       	mov    %eax,0x18e8
}
     847:	90                   	nop
     848:	c9                   	leave  
     849:	c3                   	ret    

0000084a <morecore>:

static Header*
morecore(uint nu)
{
     84a:	55                   	push   %ebp
     84b:	89 e5                	mov    %esp,%ebp
     84d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     850:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     857:	77 07                	ja     860 <morecore+0x16>
    nu = 4096;
     859:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     860:	8b 45 08             	mov    0x8(%ebp),%eax
     863:	c1 e0 03             	shl    $0x3,%eax
     866:	83 ec 0c             	sub    $0xc,%esp
     869:	50                   	push   %eax
     86a:	e8 5d fc ff ff       	call   4cc <sbrk>
     86f:	83 c4 10             	add    $0x10,%esp
     872:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     875:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     879:	75 07                	jne    882 <morecore+0x38>
    return 0;
     87b:	b8 00 00 00 00       	mov    $0x0,%eax
     880:	eb 26                	jmp    8a8 <morecore+0x5e>
  hp = (Header*)p;
     882:	8b 45 f4             	mov    -0xc(%ebp),%eax
     885:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     888:	8b 45 f0             	mov    -0x10(%ebp),%eax
     88b:	8b 55 08             	mov    0x8(%ebp),%edx
     88e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     891:	8b 45 f0             	mov    -0x10(%ebp),%eax
     894:	83 c0 08             	add    $0x8,%eax
     897:	83 ec 0c             	sub    $0xc,%esp
     89a:	50                   	push   %eax
     89b:	e8 c8 fe ff ff       	call   768 <free>
     8a0:	83 c4 10             	add    $0x10,%esp
  return freep;
     8a3:	a1 e8 18 00 00       	mov    0x18e8,%eax
}
     8a8:	c9                   	leave  
     8a9:	c3                   	ret    

000008aa <malloc>:

void*
malloc(uint nbytes)
{
     8aa:	55                   	push   %ebp
     8ab:	89 e5                	mov    %esp,%ebp
     8ad:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     8b0:	8b 45 08             	mov    0x8(%ebp),%eax
     8b3:	83 c0 07             	add    $0x7,%eax
     8b6:	c1 e8 03             	shr    $0x3,%eax
     8b9:	83 c0 01             	add    $0x1,%eax
     8bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     8bf:	a1 e8 18 00 00       	mov    0x18e8,%eax
     8c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8cb:	75 23                	jne    8f0 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     8cd:	c7 45 f0 e0 18 00 00 	movl   $0x18e0,-0x10(%ebp)
     8d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8d7:	a3 e8 18 00 00       	mov    %eax,0x18e8
     8dc:	a1 e8 18 00 00       	mov    0x18e8,%eax
     8e1:	a3 e0 18 00 00       	mov    %eax,0x18e0
    base.s.size = 0;
     8e6:	c7 05 e4 18 00 00 00 	movl   $0x0,0x18e4
     8ed:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     8f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
     8f3:	8b 00                	mov    (%eax),%eax
     8f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     8f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     8fb:	8b 40 04             	mov    0x4(%eax),%eax
     8fe:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     901:	77 4d                	ja     950 <malloc+0xa6>
      if(p->s.size == nunits)
     903:	8b 45 f4             	mov    -0xc(%ebp),%eax
     906:	8b 40 04             	mov    0x4(%eax),%eax
     909:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     90c:	75 0c                	jne    91a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     90e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     911:	8b 10                	mov    (%eax),%edx
     913:	8b 45 f0             	mov    -0x10(%ebp),%eax
     916:	89 10                	mov    %edx,(%eax)
     918:	eb 26                	jmp    940 <malloc+0x96>
      else {
        p->s.size -= nunits;
     91a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     91d:	8b 40 04             	mov    0x4(%eax),%eax
     920:	2b 45 ec             	sub    -0x14(%ebp),%eax
     923:	89 c2                	mov    %eax,%edx
     925:	8b 45 f4             	mov    -0xc(%ebp),%eax
     928:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     92b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     92e:	8b 40 04             	mov    0x4(%eax),%eax
     931:	c1 e0 03             	shl    $0x3,%eax
     934:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     937:	8b 45 f4             	mov    -0xc(%ebp),%eax
     93a:	8b 55 ec             	mov    -0x14(%ebp),%edx
     93d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     940:	8b 45 f0             	mov    -0x10(%ebp),%eax
     943:	a3 e8 18 00 00       	mov    %eax,0x18e8
      return (void*)(p + 1);
     948:	8b 45 f4             	mov    -0xc(%ebp),%eax
     94b:	83 c0 08             	add    $0x8,%eax
     94e:	eb 3b                	jmp    98b <malloc+0xe1>
    }
    if(p == freep)
     950:	a1 e8 18 00 00       	mov    0x18e8,%eax
     955:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     958:	75 1e                	jne    978 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     95a:	83 ec 0c             	sub    $0xc,%esp
     95d:	ff 75 ec             	pushl  -0x14(%ebp)
     960:	e8 e5 fe ff ff       	call   84a <morecore>
     965:	83 c4 10             	add    $0x10,%esp
     968:	89 45 f4             	mov    %eax,-0xc(%ebp)
     96b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     96f:	75 07                	jne    978 <malloc+0xce>
        return 0;
     971:	b8 00 00 00 00       	mov    $0x0,%eax
     976:	eb 13                	jmp    98b <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     978:	8b 45 f4             	mov    -0xc(%ebp),%eax
     97b:	89 45 f0             	mov    %eax,-0x10(%ebp)
     97e:	8b 45 f4             	mov    -0xc(%ebp),%eax
     981:	8b 00                	mov    (%eax),%eax
     983:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     986:	e9 6d ff ff ff       	jmp    8f8 <malloc+0x4e>
  }
}
     98b:	c9                   	leave  
     98c:	c3                   	ret    

0000098d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     98d:	55                   	push   %ebp
     98e:	89 e5                	mov    %esp,%ebp
     990:	53                   	push   %ebx
     991:	83 ec 14             	sub    $0x14,%esp
     994:	8b 45 10             	mov    0x10(%ebp),%eax
     997:	89 45 f0             	mov    %eax,-0x10(%ebp)
     99a:	8b 45 14             	mov    0x14(%ebp),%eax
     99d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     9a0:	8b 45 18             	mov    0x18(%ebp),%eax
     9a3:	ba 00 00 00 00       	mov    $0x0,%edx
     9a8:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     9ab:	72 55                	jb     a02 <printnum+0x75>
     9ad:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     9b0:	77 05                	ja     9b7 <printnum+0x2a>
     9b2:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     9b5:	72 4b                	jb     a02 <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     9b7:	8b 45 1c             	mov    0x1c(%ebp),%eax
     9ba:	8d 58 ff             	lea    -0x1(%eax),%ebx
     9bd:	8b 45 18             	mov    0x18(%ebp),%eax
     9c0:	ba 00 00 00 00       	mov    $0x0,%edx
     9c5:	52                   	push   %edx
     9c6:	50                   	push   %eax
     9c7:	ff 75 f4             	pushl  -0xc(%ebp)
     9ca:	ff 75 f0             	pushl  -0x10(%ebp)
     9cd:	e8 9e 05 00 00       	call   f70 <__udivdi3>
     9d2:	83 c4 10             	add    $0x10,%esp
     9d5:	83 ec 04             	sub    $0x4,%esp
     9d8:	ff 75 20             	pushl  0x20(%ebp)
     9db:	53                   	push   %ebx
     9dc:	ff 75 18             	pushl  0x18(%ebp)
     9df:	52                   	push   %edx
     9e0:	50                   	push   %eax
     9e1:	ff 75 0c             	pushl  0xc(%ebp)
     9e4:	ff 75 08             	pushl  0x8(%ebp)
     9e7:	e8 a1 ff ff ff       	call   98d <printnum>
     9ec:	83 c4 20             	add    $0x20,%esp
     9ef:	eb 1b                	jmp    a0c <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     9f1:	83 ec 08             	sub    $0x8,%esp
     9f4:	ff 75 0c             	pushl  0xc(%ebp)
     9f7:	ff 75 20             	pushl  0x20(%ebp)
     9fa:	8b 45 08             	mov    0x8(%ebp),%eax
     9fd:	ff d0                	call   *%eax
     9ff:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     a02:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     a06:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     a0a:	7f e5                	jg     9f1 <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     a0c:	8b 4d 18             	mov    0x18(%ebp),%ecx
     a0f:	bb 00 00 00 00       	mov    $0x0,%ebx
     a14:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a17:	8b 55 f4             	mov    -0xc(%ebp),%edx
     a1a:	53                   	push   %ebx
     a1b:	51                   	push   %ecx
     a1c:	52                   	push   %edx
     a1d:	50                   	push   %eax
     a1e:	e8 6d 06 00 00       	call   1090 <__umoddi3>
     a23:	83 c4 10             	add    $0x10,%esp
     a26:	05 c0 12 00 00       	add    $0x12c0,%eax
     a2b:	0f b6 00             	movzbl (%eax),%eax
     a2e:	0f be c0             	movsbl %al,%eax
     a31:	83 ec 08             	sub    $0x8,%esp
     a34:	ff 75 0c             	pushl  0xc(%ebp)
     a37:	50                   	push   %eax
     a38:	8b 45 08             	mov    0x8(%ebp),%eax
     a3b:	ff d0                	call   *%eax
     a3d:	83 c4 10             	add    $0x10,%esp
}
     a40:	90                   	nop
     a41:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a44:	c9                   	leave  
     a45:	c3                   	ret    

00000a46 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     a46:	55                   	push   %ebp
     a47:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     a49:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     a4d:	7e 14                	jle    a63 <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     a4f:	8b 45 08             	mov    0x8(%ebp),%eax
     a52:	8b 00                	mov    (%eax),%eax
     a54:	8d 48 08             	lea    0x8(%eax),%ecx
     a57:	8b 55 08             	mov    0x8(%ebp),%edx
     a5a:	89 0a                	mov    %ecx,(%edx)
     a5c:	8b 50 04             	mov    0x4(%eax),%edx
     a5f:	8b 00                	mov    (%eax),%eax
     a61:	eb 30                	jmp    a93 <getuint+0x4d>
  else if (lflag)
     a63:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     a67:	74 16                	je     a7f <getuint+0x39>
    return va_arg(*ap, unsigned long);
     a69:	8b 45 08             	mov    0x8(%ebp),%eax
     a6c:	8b 00                	mov    (%eax),%eax
     a6e:	8d 48 04             	lea    0x4(%eax),%ecx
     a71:	8b 55 08             	mov    0x8(%ebp),%edx
     a74:	89 0a                	mov    %ecx,(%edx)
     a76:	8b 00                	mov    (%eax),%eax
     a78:	ba 00 00 00 00       	mov    $0x0,%edx
     a7d:	eb 14                	jmp    a93 <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     a7f:	8b 45 08             	mov    0x8(%ebp),%eax
     a82:	8b 00                	mov    (%eax),%eax
     a84:	8d 48 04             	lea    0x4(%eax),%ecx
     a87:	8b 55 08             	mov    0x8(%ebp),%edx
     a8a:	89 0a                	mov    %ecx,(%edx)
     a8c:	8b 00                	mov    (%eax),%eax
     a8e:	ba 00 00 00 00       	mov    $0x0,%edx
}
     a93:	5d                   	pop    %ebp
     a94:	c3                   	ret    

00000a95 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     a95:	55                   	push   %ebp
     a96:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     a98:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     a9c:	7e 14                	jle    ab2 <getint+0x1d>
    return va_arg(*ap, long long);
     a9e:	8b 45 08             	mov    0x8(%ebp),%eax
     aa1:	8b 00                	mov    (%eax),%eax
     aa3:	8d 48 08             	lea    0x8(%eax),%ecx
     aa6:	8b 55 08             	mov    0x8(%ebp),%edx
     aa9:	89 0a                	mov    %ecx,(%edx)
     aab:	8b 50 04             	mov    0x4(%eax),%edx
     aae:	8b 00                	mov    (%eax),%eax
     ab0:	eb 28                	jmp    ada <getint+0x45>
  else if (lflag)
     ab2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     ab6:	74 12                	je     aca <getint+0x35>
    return va_arg(*ap, long);
     ab8:	8b 45 08             	mov    0x8(%ebp),%eax
     abb:	8b 00                	mov    (%eax),%eax
     abd:	8d 48 04             	lea    0x4(%eax),%ecx
     ac0:	8b 55 08             	mov    0x8(%ebp),%edx
     ac3:	89 0a                	mov    %ecx,(%edx)
     ac5:	8b 00                	mov    (%eax),%eax
     ac7:	99                   	cltd   
     ac8:	eb 10                	jmp    ada <getint+0x45>
  else
    return va_arg(*ap, int);
     aca:	8b 45 08             	mov    0x8(%ebp),%eax
     acd:	8b 00                	mov    (%eax),%eax
     acf:	8d 48 04             	lea    0x4(%eax),%ecx
     ad2:	8b 55 08             	mov    0x8(%ebp),%edx
     ad5:	89 0a                	mov    %ecx,(%edx)
     ad7:	8b 00                	mov    (%eax),%eax
     ad9:	99                   	cltd   
}
     ada:	5d                   	pop    %ebp
     adb:	c3                   	ret    

00000adc <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     adc:	55                   	push   %ebp
     add:	89 e5                	mov    %esp,%ebp
     adf:	56                   	push   %esi
     ae0:	53                   	push   %ebx
     ae1:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     ae4:	eb 17                	jmp    afd <vprintfmt+0x21>
      if (ch == '\0')
     ae6:	85 db                	test   %ebx,%ebx
     ae8:	0f 84 a0 03 00 00    	je     e8e <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     aee:	83 ec 08             	sub    $0x8,%esp
     af1:	ff 75 0c             	pushl  0xc(%ebp)
     af4:	53                   	push   %ebx
     af5:	8b 45 08             	mov    0x8(%ebp),%eax
     af8:	ff d0                	call   *%eax
     afa:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     afd:	8b 45 10             	mov    0x10(%ebp),%eax
     b00:	8d 50 01             	lea    0x1(%eax),%edx
     b03:	89 55 10             	mov    %edx,0x10(%ebp)
     b06:	0f b6 00             	movzbl (%eax),%eax
     b09:	0f b6 d8             	movzbl %al,%ebx
     b0c:	83 fb 25             	cmp    $0x25,%ebx
     b0f:	75 d5                	jne    ae6 <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     b11:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     b15:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     b1c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     b23:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     b2a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     b31:	8b 45 10             	mov    0x10(%ebp),%eax
     b34:	8d 50 01             	lea    0x1(%eax),%edx
     b37:	89 55 10             	mov    %edx,0x10(%ebp)
     b3a:	0f b6 00             	movzbl (%eax),%eax
     b3d:	0f b6 d8             	movzbl %al,%ebx
     b40:	8d 43 dd             	lea    -0x23(%ebx),%eax
     b43:	83 f8 55             	cmp    $0x55,%eax
     b46:	0f 87 15 03 00 00    	ja     e61 <vprintfmt+0x385>
     b4c:	8b 04 85 e4 12 00 00 	mov    0x12e4(,%eax,4),%eax
     b53:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     b55:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     b59:	eb d6                	jmp    b31 <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     b5b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     b5f:	eb d0                	jmp    b31 <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     b61:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     b68:	8b 55 e0             	mov    -0x20(%ebp),%edx
     b6b:	89 d0                	mov    %edx,%eax
     b6d:	c1 e0 02             	shl    $0x2,%eax
     b70:	01 d0                	add    %edx,%eax
     b72:	01 c0                	add    %eax,%eax
     b74:	01 d8                	add    %ebx,%eax
     b76:	83 e8 30             	sub    $0x30,%eax
     b79:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     b7c:	8b 45 10             	mov    0x10(%ebp),%eax
     b7f:	0f b6 00             	movzbl (%eax),%eax
     b82:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     b85:	83 fb 2f             	cmp    $0x2f,%ebx
     b88:	7e 39                	jle    bc3 <vprintfmt+0xe7>
     b8a:	83 fb 39             	cmp    $0x39,%ebx
     b8d:	7f 34                	jg     bc3 <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     b8f:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     b93:	eb d3                	jmp    b68 <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     b95:	8b 45 14             	mov    0x14(%ebp),%eax
     b98:	8d 50 04             	lea    0x4(%eax),%edx
     b9b:	89 55 14             	mov    %edx,0x14(%ebp)
     b9e:	8b 00                	mov    (%eax),%eax
     ba0:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     ba3:	eb 1f                	jmp    bc4 <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     ba5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     ba9:	79 86                	jns    b31 <vprintfmt+0x55>
        width = 0;
     bab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     bb2:	e9 7a ff ff ff       	jmp    b31 <vprintfmt+0x55>

    case '#':
      altflag = 1;
     bb7:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     bbe:	e9 6e ff ff ff       	jmp    b31 <vprintfmt+0x55>
      goto process_precision;
     bc3:	90                   	nop

process_precision:
      if (width < 0)
     bc4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bc8:	0f 89 63 ff ff ff    	jns    b31 <vprintfmt+0x55>
        width = precision, precision = -1;
     bce:	8b 45 e0             	mov    -0x20(%ebp),%eax
     bd1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     bd4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     bdb:	e9 51 ff ff ff       	jmp    b31 <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     be0:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     be4:	e9 48 ff ff ff       	jmp    b31 <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     be9:	8b 45 14             	mov    0x14(%ebp),%eax
     bec:	8d 50 04             	lea    0x4(%eax),%edx
     bef:	89 55 14             	mov    %edx,0x14(%ebp)
     bf2:	8b 00                	mov    (%eax),%eax
     bf4:	83 ec 08             	sub    $0x8,%esp
     bf7:	ff 75 0c             	pushl  0xc(%ebp)
     bfa:	50                   	push   %eax
     bfb:	8b 45 08             	mov    0x8(%ebp),%eax
     bfe:	ff d0                	call   *%eax
     c00:	83 c4 10             	add    $0x10,%esp
      break;
     c03:	e9 81 02 00 00       	jmp    e89 <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     c08:	8b 45 14             	mov    0x14(%ebp),%eax
     c0b:	8d 50 04             	lea    0x4(%eax),%edx
     c0e:	89 55 14             	mov    %edx,0x14(%ebp)
     c11:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     c13:	85 db                	test   %ebx,%ebx
     c15:	79 02                	jns    c19 <vprintfmt+0x13d>
        err = -err;
     c17:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     c19:	83 fb 0f             	cmp    $0xf,%ebx
     c1c:	7f 0b                	jg     c29 <vprintfmt+0x14d>
     c1e:	8b 34 9d 80 12 00 00 	mov    0x1280(,%ebx,4),%esi
     c25:	85 f6                	test   %esi,%esi
     c27:	75 19                	jne    c42 <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     c29:	53                   	push   %ebx
     c2a:	68 d1 12 00 00       	push   $0x12d1
     c2f:	ff 75 0c             	pushl  0xc(%ebp)
     c32:	ff 75 08             	pushl  0x8(%ebp)
     c35:	e8 5c 02 00 00       	call   e96 <printfmt>
     c3a:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     c3d:	e9 47 02 00 00       	jmp    e89 <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     c42:	56                   	push   %esi
     c43:	68 da 12 00 00       	push   $0x12da
     c48:	ff 75 0c             	pushl  0xc(%ebp)
     c4b:	ff 75 08             	pushl  0x8(%ebp)
     c4e:	e8 43 02 00 00       	call   e96 <printfmt>
     c53:	83 c4 10             	add    $0x10,%esp
      break;
     c56:	e9 2e 02 00 00       	jmp    e89 <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     c5b:	8b 45 14             	mov    0x14(%ebp),%eax
     c5e:	8d 50 04             	lea    0x4(%eax),%edx
     c61:	89 55 14             	mov    %edx,0x14(%ebp)
     c64:	8b 30                	mov    (%eax),%esi
     c66:	85 f6                	test   %esi,%esi
     c68:	75 05                	jne    c6f <vprintfmt+0x193>
        p = "(null)";
     c6a:	be dd 12 00 00       	mov    $0x12dd,%esi
      if (width > 0 && padc != '-')
     c6f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c73:	7e 6f                	jle    ce4 <vprintfmt+0x208>
     c75:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     c79:	74 69                	je     ce4 <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     c7b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c7e:	83 ec 08             	sub    $0x8,%esp
     c81:	50                   	push   %eax
     c82:	56                   	push   %esi
     c83:	e8 f1 f5 ff ff       	call   279 <strnlen>
     c88:	83 c4 10             	add    $0x10,%esp
     c8b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     c8e:	eb 17                	jmp    ca7 <vprintfmt+0x1cb>
          putch(padc, putdat);
     c90:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     c94:	83 ec 08             	sub    $0x8,%esp
     c97:	ff 75 0c             	pushl  0xc(%ebp)
     c9a:	50                   	push   %eax
     c9b:	8b 45 08             	mov    0x8(%ebp),%eax
     c9e:	ff d0                	call   *%eax
     ca0:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     ca3:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     ca7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     cab:	7f e3                	jg     c90 <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     cad:	eb 35                	jmp    ce4 <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     caf:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     cb3:	74 1c                	je     cd1 <vprintfmt+0x1f5>
     cb5:	83 fb 1f             	cmp    $0x1f,%ebx
     cb8:	7e 05                	jle    cbf <vprintfmt+0x1e3>
     cba:	83 fb 7e             	cmp    $0x7e,%ebx
     cbd:	7e 12                	jle    cd1 <vprintfmt+0x1f5>
          putch('?', putdat);
     cbf:	83 ec 08             	sub    $0x8,%esp
     cc2:	ff 75 0c             	pushl  0xc(%ebp)
     cc5:	6a 3f                	push   $0x3f
     cc7:	8b 45 08             	mov    0x8(%ebp),%eax
     cca:	ff d0                	call   *%eax
     ccc:	83 c4 10             	add    $0x10,%esp
     ccf:	eb 0f                	jmp    ce0 <vprintfmt+0x204>
        else
          putch(ch, putdat);
     cd1:	83 ec 08             	sub    $0x8,%esp
     cd4:	ff 75 0c             	pushl  0xc(%ebp)
     cd7:	53                   	push   %ebx
     cd8:	8b 45 08             	mov    0x8(%ebp),%eax
     cdb:	ff d0                	call   *%eax
     cdd:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     ce0:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     ce4:	89 f0                	mov    %esi,%eax
     ce6:	8d 70 01             	lea    0x1(%eax),%esi
     ce9:	0f b6 00             	movzbl (%eax),%eax
     cec:	0f be d8             	movsbl %al,%ebx
     cef:	85 db                	test   %ebx,%ebx
     cf1:	74 26                	je     d19 <vprintfmt+0x23d>
     cf3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     cf7:	78 b6                	js     caf <vprintfmt+0x1d3>
     cf9:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     cfd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     d01:	79 ac                	jns    caf <vprintfmt+0x1d3>
      for (; width > 0; width--)
     d03:	eb 14                	jmp    d19 <vprintfmt+0x23d>
        putch(' ', putdat);
     d05:	83 ec 08             	sub    $0x8,%esp
     d08:	ff 75 0c             	pushl  0xc(%ebp)
     d0b:	6a 20                	push   $0x20
     d0d:	8b 45 08             	mov    0x8(%ebp),%eax
     d10:	ff d0                	call   *%eax
     d12:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     d15:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     d19:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     d1d:	7f e6                	jg     d05 <vprintfmt+0x229>
      break;
     d1f:	e9 65 01 00 00       	jmp    e89 <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     d24:	83 ec 08             	sub    $0x8,%esp
     d27:	ff 75 e8             	pushl  -0x18(%ebp)
     d2a:	8d 45 14             	lea    0x14(%ebp),%eax
     d2d:	50                   	push   %eax
     d2e:	e8 62 fd ff ff       	call   a95 <getint>
     d33:	83 c4 10             	add    $0x10,%esp
     d36:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d39:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     d3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d3f:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d42:	85 d2                	test   %edx,%edx
     d44:	79 23                	jns    d69 <vprintfmt+0x28d>
        putch('-', putdat);
     d46:	83 ec 08             	sub    $0x8,%esp
     d49:	ff 75 0c             	pushl  0xc(%ebp)
     d4c:	6a 2d                	push   $0x2d
     d4e:	8b 45 08             	mov    0x8(%ebp),%eax
     d51:	ff d0                	call   *%eax
     d53:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     d56:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d59:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d5c:	f7 d8                	neg    %eax
     d5e:	83 d2 00             	adc    $0x0,%edx
     d61:	f7 da                	neg    %edx
     d63:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d66:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     d69:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     d70:	e9 b6 00 00 00       	jmp    e2b <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     d75:	83 ec 08             	sub    $0x8,%esp
     d78:	ff 75 e8             	pushl  -0x18(%ebp)
     d7b:	8d 45 14             	lea    0x14(%ebp),%eax
     d7e:	50                   	push   %eax
     d7f:	e8 c2 fc ff ff       	call   a46 <getuint>
     d84:	83 c4 10             	add    $0x10,%esp
     d87:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d8a:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     d8d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     d94:	e9 92 00 00 00       	jmp    e2b <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     d99:	83 ec 08             	sub    $0x8,%esp
     d9c:	ff 75 0c             	pushl  0xc(%ebp)
     d9f:	6a 58                	push   $0x58
     da1:	8b 45 08             	mov    0x8(%ebp),%eax
     da4:	ff d0                	call   *%eax
     da6:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     da9:	83 ec 08             	sub    $0x8,%esp
     dac:	ff 75 0c             	pushl  0xc(%ebp)
     daf:	6a 58                	push   $0x58
     db1:	8b 45 08             	mov    0x8(%ebp),%eax
     db4:	ff d0                	call   *%eax
     db6:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     db9:	83 ec 08             	sub    $0x8,%esp
     dbc:	ff 75 0c             	pushl  0xc(%ebp)
     dbf:	6a 58                	push   $0x58
     dc1:	8b 45 08             	mov    0x8(%ebp),%eax
     dc4:	ff d0                	call   *%eax
     dc6:	83 c4 10             	add    $0x10,%esp
      break;
     dc9:	e9 bb 00 00 00       	jmp    e89 <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     dce:	83 ec 08             	sub    $0x8,%esp
     dd1:	ff 75 0c             	pushl  0xc(%ebp)
     dd4:	6a 30                	push   $0x30
     dd6:	8b 45 08             	mov    0x8(%ebp),%eax
     dd9:	ff d0                	call   *%eax
     ddb:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     dde:	83 ec 08             	sub    $0x8,%esp
     de1:	ff 75 0c             	pushl  0xc(%ebp)
     de4:	6a 78                	push   $0x78
     de6:	8b 45 08             	mov    0x8(%ebp),%eax
     de9:	ff d0                	call   *%eax
     deb:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     dee:	8b 45 14             	mov    0x14(%ebp),%eax
     df1:	8d 50 04             	lea    0x4(%eax),%edx
     df4:	89 55 14             	mov    %edx,0x14(%ebp)
     df7:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     df9:	89 45 f0             	mov    %eax,-0x10(%ebp)
     dfc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     e03:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     e0a:	eb 1f                	jmp    e2b <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     e0c:	83 ec 08             	sub    $0x8,%esp
     e0f:	ff 75 e8             	pushl  -0x18(%ebp)
     e12:	8d 45 14             	lea    0x14(%ebp),%eax
     e15:	50                   	push   %eax
     e16:	e8 2b fc ff ff       	call   a46 <getuint>
     e1b:	83 c4 10             	add    $0x10,%esp
     e1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e21:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     e24:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     e2b:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     e2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e32:	83 ec 04             	sub    $0x4,%esp
     e35:	52                   	push   %edx
     e36:	ff 75 e4             	pushl  -0x1c(%ebp)
     e39:	50                   	push   %eax
     e3a:	ff 75 f4             	pushl  -0xc(%ebp)
     e3d:	ff 75 f0             	pushl  -0x10(%ebp)
     e40:	ff 75 0c             	pushl  0xc(%ebp)
     e43:	ff 75 08             	pushl  0x8(%ebp)
     e46:	e8 42 fb ff ff       	call   98d <printnum>
     e4b:	83 c4 20             	add    $0x20,%esp
      break;
     e4e:	eb 39                	jmp    e89 <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     e50:	83 ec 08             	sub    $0x8,%esp
     e53:	ff 75 0c             	pushl  0xc(%ebp)
     e56:	53                   	push   %ebx
     e57:	8b 45 08             	mov    0x8(%ebp),%eax
     e5a:	ff d0                	call   *%eax
     e5c:	83 c4 10             	add    $0x10,%esp
      break;
     e5f:	eb 28                	jmp    e89 <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     e61:	83 ec 08             	sub    $0x8,%esp
     e64:	ff 75 0c             	pushl  0xc(%ebp)
     e67:	6a 25                	push   $0x25
     e69:	8b 45 08             	mov    0x8(%ebp),%eax
     e6c:	ff d0                	call   *%eax
     e6e:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     e71:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     e75:	eb 04                	jmp    e7b <vprintfmt+0x39f>
     e77:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     e7b:	8b 45 10             	mov    0x10(%ebp),%eax
     e7e:	83 e8 01             	sub    $0x1,%eax
     e81:	0f b6 00             	movzbl (%eax),%eax
     e84:	3c 25                	cmp    $0x25,%al
     e86:	75 ef                	jne    e77 <vprintfmt+0x39b>
        /* do nothing */;
      break;
     e88:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     e89:	e9 6f fc ff ff       	jmp    afd <vprintfmt+0x21>
        return;
     e8e:	90                   	nop
    }
  }
}
     e8f:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e92:	5b                   	pop    %ebx
     e93:	5e                   	pop    %esi
     e94:	5d                   	pop    %ebp
     e95:	c3                   	ret    

00000e96 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     e96:	55                   	push   %ebp
     e97:	89 e5                	mov    %esp,%ebp
     e99:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     e9c:	8d 45 14             	lea    0x14(%ebp),%eax
     e9f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     ea2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ea5:	50                   	push   %eax
     ea6:	ff 75 10             	pushl  0x10(%ebp)
     ea9:	ff 75 0c             	pushl  0xc(%ebp)
     eac:	ff 75 08             	pushl  0x8(%ebp)
     eaf:	e8 28 fc ff ff       	call   adc <vprintfmt>
     eb4:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     eb7:	90                   	nop
     eb8:	c9                   	leave  
     eb9:	c3                   	ret    

00000eba <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     eba:	55                   	push   %ebp
     ebb:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     ebd:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec0:	8b 40 08             	mov    0x8(%eax),%eax
     ec3:	8d 50 01             	lea    0x1(%eax),%edx
     ec6:	8b 45 0c             	mov    0xc(%ebp),%eax
     ec9:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     ecc:	8b 45 0c             	mov    0xc(%ebp),%eax
     ecf:	8b 10                	mov    (%eax),%edx
     ed1:	8b 45 0c             	mov    0xc(%ebp),%eax
     ed4:	8b 40 04             	mov    0x4(%eax),%eax
     ed7:	39 c2                	cmp    %eax,%edx
     ed9:	73 12                	jae    eed <sprintputch+0x33>
    *b->buf++ = ch;
     edb:	8b 45 0c             	mov    0xc(%ebp),%eax
     ede:	8b 00                	mov    (%eax),%eax
     ee0:	8d 48 01             	lea    0x1(%eax),%ecx
     ee3:	8b 55 0c             	mov    0xc(%ebp),%edx
     ee6:	89 0a                	mov    %ecx,(%edx)
     ee8:	8b 55 08             	mov    0x8(%ebp),%edx
     eeb:	88 10                	mov    %dl,(%eax)
}
     eed:	90                   	nop
     eee:	5d                   	pop    %ebp
     eef:	c3                   	ret    

00000ef0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     ef6:	8b 45 08             	mov    0x8(%ebp),%eax
     ef9:	89 45 ec             	mov    %eax,-0x14(%ebp)
     efc:	8b 45 0c             	mov    0xc(%ebp),%eax
     eff:	8d 50 ff             	lea    -0x1(%eax),%edx
     f02:	8b 45 08             	mov    0x8(%ebp),%eax
     f05:	01 d0                	add    %edx,%eax
     f07:	89 45 f0             	mov    %eax,-0x10(%ebp)
     f0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     f11:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     f15:	74 06                	je     f1d <vsnprintf+0x2d>
     f17:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     f1b:	7f 07                	jg     f24 <vsnprintf+0x34>
    return -E_INVAL;
     f1d:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     f22:	eb 20                	jmp    f44 <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     f24:	ff 75 14             	pushl  0x14(%ebp)
     f27:	ff 75 10             	pushl  0x10(%ebp)
     f2a:	8d 45 ec             	lea    -0x14(%ebp),%eax
     f2d:	50                   	push   %eax
     f2e:	68 ba 0e 00 00       	push   $0xeba
     f33:	e8 a4 fb ff ff       	call   adc <vprintfmt>
     f38:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     f3b:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f3e:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     f41:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     f44:	c9                   	leave  
     f45:	c3                   	ret    

00000f46 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     f46:	55                   	push   %ebp
     f47:	89 e5                	mov    %esp,%ebp
     f49:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     f4c:	8d 45 14             	lea    0x14(%ebp),%eax
     f4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     f52:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f55:	50                   	push   %eax
     f56:	ff 75 10             	pushl  0x10(%ebp)
     f59:	ff 75 0c             	pushl  0xc(%ebp)
     f5c:	ff 75 08             	pushl  0x8(%ebp)
     f5f:	e8 8c ff ff ff       	call   ef0 <vsnprintf>
     f64:	83 c4 10             	add    $0x10,%esp
     f67:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     f6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     f6d:	c9                   	leave  
     f6e:	c3                   	ret    
     f6f:	90                   	nop

00000f70 <__udivdi3>:
     f70:	55                   	push   %ebp
     f71:	57                   	push   %edi
     f72:	56                   	push   %esi
     f73:	53                   	push   %ebx
     f74:	83 ec 1c             	sub    $0x1c,%esp
     f77:	8b 54 24 3c          	mov    0x3c(%esp),%edx
     f7b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
     f7f:	8b 74 24 34          	mov    0x34(%esp),%esi
     f83:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     f87:	85 d2                	test   %edx,%edx
     f89:	75 35                	jne    fc0 <__udivdi3+0x50>
     f8b:	39 f3                	cmp    %esi,%ebx
     f8d:	0f 87 bd 00 00 00    	ja     1050 <__udivdi3+0xe0>
     f93:	85 db                	test   %ebx,%ebx
     f95:	89 d9                	mov    %ebx,%ecx
     f97:	75 0b                	jne    fa4 <__udivdi3+0x34>
     f99:	b8 01 00 00 00       	mov    $0x1,%eax
     f9e:	31 d2                	xor    %edx,%edx
     fa0:	f7 f3                	div    %ebx
     fa2:	89 c1                	mov    %eax,%ecx
     fa4:	31 d2                	xor    %edx,%edx
     fa6:	89 f0                	mov    %esi,%eax
     fa8:	f7 f1                	div    %ecx
     faa:	89 c6                	mov    %eax,%esi
     fac:	89 e8                	mov    %ebp,%eax
     fae:	89 f7                	mov    %esi,%edi
     fb0:	f7 f1                	div    %ecx
     fb2:	89 fa                	mov    %edi,%edx
     fb4:	83 c4 1c             	add    $0x1c,%esp
     fb7:	5b                   	pop    %ebx
     fb8:	5e                   	pop    %esi
     fb9:	5f                   	pop    %edi
     fba:	5d                   	pop    %ebp
     fbb:	c3                   	ret    
     fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     fc0:	39 f2                	cmp    %esi,%edx
     fc2:	77 7c                	ja     1040 <__udivdi3+0xd0>
     fc4:	0f bd fa             	bsr    %edx,%edi
     fc7:	83 f7 1f             	xor    $0x1f,%edi
     fca:	0f 84 98 00 00 00    	je     1068 <__udivdi3+0xf8>
     fd0:	89 f9                	mov    %edi,%ecx
     fd2:	b8 20 00 00 00       	mov    $0x20,%eax
     fd7:	29 f8                	sub    %edi,%eax
     fd9:	d3 e2                	shl    %cl,%edx
     fdb:	89 54 24 08          	mov    %edx,0x8(%esp)
     fdf:	89 c1                	mov    %eax,%ecx
     fe1:	89 da                	mov    %ebx,%edx
     fe3:	d3 ea                	shr    %cl,%edx
     fe5:	8b 4c 24 08          	mov    0x8(%esp),%ecx
     fe9:	09 d1                	or     %edx,%ecx
     feb:	89 f2                	mov    %esi,%edx
     fed:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     ff1:	89 f9                	mov    %edi,%ecx
     ff3:	d3 e3                	shl    %cl,%ebx
     ff5:	89 c1                	mov    %eax,%ecx
     ff7:	d3 ea                	shr    %cl,%edx
     ff9:	89 f9                	mov    %edi,%ecx
     ffb:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     fff:	d3 e6                	shl    %cl,%esi
    1001:	89 eb                	mov    %ebp,%ebx
    1003:	89 c1                	mov    %eax,%ecx
    1005:	d3 eb                	shr    %cl,%ebx
    1007:	09 de                	or     %ebx,%esi
    1009:	89 f0                	mov    %esi,%eax
    100b:	f7 74 24 08          	divl   0x8(%esp)
    100f:	89 d6                	mov    %edx,%esi
    1011:	89 c3                	mov    %eax,%ebx
    1013:	f7 64 24 0c          	mull   0xc(%esp)
    1017:	39 d6                	cmp    %edx,%esi
    1019:	72 0c                	jb     1027 <__udivdi3+0xb7>
    101b:	89 f9                	mov    %edi,%ecx
    101d:	d3 e5                	shl    %cl,%ebp
    101f:	39 c5                	cmp    %eax,%ebp
    1021:	73 5d                	jae    1080 <__udivdi3+0x110>
    1023:	39 d6                	cmp    %edx,%esi
    1025:	75 59                	jne    1080 <__udivdi3+0x110>
    1027:	8d 43 ff             	lea    -0x1(%ebx),%eax
    102a:	31 ff                	xor    %edi,%edi
    102c:	89 fa                	mov    %edi,%edx
    102e:	83 c4 1c             	add    $0x1c,%esp
    1031:	5b                   	pop    %ebx
    1032:	5e                   	pop    %esi
    1033:	5f                   	pop    %edi
    1034:	5d                   	pop    %ebp
    1035:	c3                   	ret    
    1036:	8d 76 00             	lea    0x0(%esi),%esi
    1039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1040:	31 ff                	xor    %edi,%edi
    1042:	31 c0                	xor    %eax,%eax
    1044:	89 fa                	mov    %edi,%edx
    1046:	83 c4 1c             	add    $0x1c,%esp
    1049:	5b                   	pop    %ebx
    104a:	5e                   	pop    %esi
    104b:	5f                   	pop    %edi
    104c:	5d                   	pop    %ebp
    104d:	c3                   	ret    
    104e:	66 90                	xchg   %ax,%ax
    1050:	31 ff                	xor    %edi,%edi
    1052:	89 e8                	mov    %ebp,%eax
    1054:	89 f2                	mov    %esi,%edx
    1056:	f7 f3                	div    %ebx
    1058:	89 fa                	mov    %edi,%edx
    105a:	83 c4 1c             	add    $0x1c,%esp
    105d:	5b                   	pop    %ebx
    105e:	5e                   	pop    %esi
    105f:	5f                   	pop    %edi
    1060:	5d                   	pop    %ebp
    1061:	c3                   	ret    
    1062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1068:	39 f2                	cmp    %esi,%edx
    106a:	72 06                	jb     1072 <__udivdi3+0x102>
    106c:	31 c0                	xor    %eax,%eax
    106e:	39 eb                	cmp    %ebp,%ebx
    1070:	77 d2                	ja     1044 <__udivdi3+0xd4>
    1072:	b8 01 00 00 00       	mov    $0x1,%eax
    1077:	eb cb                	jmp    1044 <__udivdi3+0xd4>
    1079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1080:	89 d8                	mov    %ebx,%eax
    1082:	31 ff                	xor    %edi,%edi
    1084:	eb be                	jmp    1044 <__udivdi3+0xd4>
    1086:	66 90                	xchg   %ax,%ax
    1088:	66 90                	xchg   %ax,%ax
    108a:	66 90                	xchg   %ax,%ax
    108c:	66 90                	xchg   %ax,%ax
    108e:	66 90                	xchg   %ax,%ax

00001090 <__umoddi3>:
    1090:	55                   	push   %ebp
    1091:	57                   	push   %edi
    1092:	56                   	push   %esi
    1093:	53                   	push   %ebx
    1094:	83 ec 1c             	sub    $0x1c,%esp
    1097:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
    109b:	8b 74 24 30          	mov    0x30(%esp),%esi
    109f:	8b 5c 24 34          	mov    0x34(%esp),%ebx
    10a3:	8b 7c 24 38          	mov    0x38(%esp),%edi
    10a7:	85 ed                	test   %ebp,%ebp
    10a9:	89 f0                	mov    %esi,%eax
    10ab:	89 da                	mov    %ebx,%edx
    10ad:	75 19                	jne    10c8 <__umoddi3+0x38>
    10af:	39 df                	cmp    %ebx,%edi
    10b1:	0f 86 b1 00 00 00    	jbe    1168 <__umoddi3+0xd8>
    10b7:	f7 f7                	div    %edi
    10b9:	89 d0                	mov    %edx,%eax
    10bb:	31 d2                	xor    %edx,%edx
    10bd:	83 c4 1c             	add    $0x1c,%esp
    10c0:	5b                   	pop    %ebx
    10c1:	5e                   	pop    %esi
    10c2:	5f                   	pop    %edi
    10c3:	5d                   	pop    %ebp
    10c4:	c3                   	ret    
    10c5:	8d 76 00             	lea    0x0(%esi),%esi
    10c8:	39 dd                	cmp    %ebx,%ebp
    10ca:	77 f1                	ja     10bd <__umoddi3+0x2d>
    10cc:	0f bd cd             	bsr    %ebp,%ecx
    10cf:	83 f1 1f             	xor    $0x1f,%ecx
    10d2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
    10d6:	0f 84 b4 00 00 00    	je     1190 <__umoddi3+0x100>
    10dc:	b8 20 00 00 00       	mov    $0x20,%eax
    10e1:	89 c2                	mov    %eax,%edx
    10e3:	8b 44 24 04          	mov    0x4(%esp),%eax
    10e7:	29 c2                	sub    %eax,%edx
    10e9:	89 c1                	mov    %eax,%ecx
    10eb:	89 f8                	mov    %edi,%eax
    10ed:	d3 e5                	shl    %cl,%ebp
    10ef:	89 d1                	mov    %edx,%ecx
    10f1:	89 54 24 0c          	mov    %edx,0xc(%esp)
    10f5:	d3 e8                	shr    %cl,%eax
    10f7:	09 c5                	or     %eax,%ebp
    10f9:	8b 44 24 04          	mov    0x4(%esp),%eax
    10fd:	89 c1                	mov    %eax,%ecx
    10ff:	d3 e7                	shl    %cl,%edi
    1101:	89 d1                	mov    %edx,%ecx
    1103:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1107:	89 df                	mov    %ebx,%edi
    1109:	d3 ef                	shr    %cl,%edi
    110b:	89 c1                	mov    %eax,%ecx
    110d:	89 f0                	mov    %esi,%eax
    110f:	d3 e3                	shl    %cl,%ebx
    1111:	89 d1                	mov    %edx,%ecx
    1113:	89 fa                	mov    %edi,%edx
    1115:	d3 e8                	shr    %cl,%eax
    1117:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
    111c:	09 d8                	or     %ebx,%eax
    111e:	f7 f5                	div    %ebp
    1120:	d3 e6                	shl    %cl,%esi
    1122:	89 d1                	mov    %edx,%ecx
    1124:	f7 64 24 08          	mull   0x8(%esp)
    1128:	39 d1                	cmp    %edx,%ecx
    112a:	89 c3                	mov    %eax,%ebx
    112c:	89 d7                	mov    %edx,%edi
    112e:	72 06                	jb     1136 <__umoddi3+0xa6>
    1130:	75 0e                	jne    1140 <__umoddi3+0xb0>
    1132:	39 c6                	cmp    %eax,%esi
    1134:	73 0a                	jae    1140 <__umoddi3+0xb0>
    1136:	2b 44 24 08          	sub    0x8(%esp),%eax
    113a:	19 ea                	sbb    %ebp,%edx
    113c:	89 d7                	mov    %edx,%edi
    113e:	89 c3                	mov    %eax,%ebx
    1140:	89 ca                	mov    %ecx,%edx
    1142:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
    1147:	29 de                	sub    %ebx,%esi
    1149:	19 fa                	sbb    %edi,%edx
    114b:	8b 5c 24 04          	mov    0x4(%esp),%ebx
    114f:	89 d0                	mov    %edx,%eax
    1151:	d3 e0                	shl    %cl,%eax
    1153:	89 d9                	mov    %ebx,%ecx
    1155:	d3 ee                	shr    %cl,%esi
    1157:	d3 ea                	shr    %cl,%edx
    1159:	09 f0                	or     %esi,%eax
    115b:	83 c4 1c             	add    $0x1c,%esp
    115e:	5b                   	pop    %ebx
    115f:	5e                   	pop    %esi
    1160:	5f                   	pop    %edi
    1161:	5d                   	pop    %ebp
    1162:	c3                   	ret    
    1163:	90                   	nop
    1164:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1168:	85 ff                	test   %edi,%edi
    116a:	89 f9                	mov    %edi,%ecx
    116c:	75 0b                	jne    1179 <__umoddi3+0xe9>
    116e:	b8 01 00 00 00       	mov    $0x1,%eax
    1173:	31 d2                	xor    %edx,%edx
    1175:	f7 f7                	div    %edi
    1177:	89 c1                	mov    %eax,%ecx
    1179:	89 d8                	mov    %ebx,%eax
    117b:	31 d2                	xor    %edx,%edx
    117d:	f7 f1                	div    %ecx
    117f:	89 f0                	mov    %esi,%eax
    1181:	f7 f1                	div    %ecx
    1183:	e9 31 ff ff ff       	jmp    10b9 <__umoddi3+0x29>
    1188:	90                   	nop
    1189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1190:	39 dd                	cmp    %ebx,%ebp
    1192:	72 08                	jb     119c <__umoddi3+0x10c>
    1194:	39 f7                	cmp    %esi,%edi
    1196:	0f 87 21 ff ff ff    	ja     10bd <__umoddi3+0x2d>
    119c:	89 da                	mov    %ebx,%edx
    119e:	89 f0                	mov    %esi,%eax
    11a0:	29 f8                	sub    %edi,%eax
    11a2:	19 ea                	sbb    %ebp,%edx
    11a4:	e9 14 ff ff ff       	jmp    10bd <__umoddi3+0x2d>
