
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
  write(fd, s, strlen(s));
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	ff 75 0c             	pushl  0xc(%ebp)
   c:	e8 97 01 00 00       	call   1a8 <strlen>
  11:	83 c4 10             	add    $0x10,%esp
  14:	83 ec 04             	sub    $0x4,%esp
  17:	50                   	push   %eax
  18:	ff 75 0c             	pushl  0xc(%ebp)
  1b:	ff 75 08             	pushl  0x8(%ebp)
  1e:	e8 97 03 00 00       	call   3ba <write>
  23:	83 c4 10             	add    $0x10,%esp
}
  26:	90                   	nop
  27:	c9                   	leave  
  28:	c3                   	ret    

00000029 <forktest>:

void
forktest(void)
{
  29:	55                   	push   %ebp
  2a:	89 e5                	mov    %esp,%ebp
  2c:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
  2f:	83 ec 08             	sub    $0x8,%esp
  32:	68 5c 04 00 00       	push   $0x45c
  37:	6a 01                	push   $0x1
  39:	e8 c2 ff ff ff       	call   0 <printf>
  3e:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  48:	eb 1d                	jmp    67 <forktest+0x3e>
    pid = fork();
  4a:	e8 43 03 00 00       	call   392 <fork>
  4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
  52:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  56:	78 1a                	js     72 <forktest+0x49>
      break;
    if(pid == 0)
  58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  5c:	75 05                	jne    63 <forktest+0x3a>
      exit();
  5e:	e8 37 03 00 00       	call   39a <exit>
  for(n=0; n<N; n++){
  63:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  67:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  6e:	7e da                	jle    4a <forktest+0x21>
  70:	eb 01                	jmp    73 <forktest+0x4a>
      break;
  72:	90                   	nop
  }

  if(n == N){
  73:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
  7a:	75 40                	jne    bc <forktest+0x93>
    printf(1, "fork claimed to work N times!\n", N);
  7c:	83 ec 04             	sub    $0x4,%esp
  7f:	68 e8 03 00 00       	push   $0x3e8
  84:	68 68 04 00 00       	push   $0x468
  89:	6a 01                	push   $0x1
  8b:	e8 70 ff ff ff       	call   0 <printf>
  90:	83 c4 10             	add    $0x10,%esp
    exit();
  93:	e8 02 03 00 00       	call   39a <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
  98:	e8 05 03 00 00       	call   3a2 <wait>
  9d:	85 c0                	test   %eax,%eax
  9f:	79 17                	jns    b8 <forktest+0x8f>
      printf(1, "wait stopped early\n");
  a1:	83 ec 08             	sub    $0x8,%esp
  a4:	68 87 04 00 00       	push   $0x487
  a9:	6a 01                	push   $0x1
  ab:	e8 50 ff ff ff       	call   0 <printf>
  b0:	83 c4 10             	add    $0x10,%esp
      exit();
  b3:	e8 e2 02 00 00       	call   39a <exit>
  for(; n > 0; n--){
  b8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  c0:	7f d6                	jg     98 <forktest+0x6f>
    }
  }

  if(wait() != -1){
  c2:	e8 db 02 00 00       	call   3a2 <wait>
  c7:	83 f8 ff             	cmp    $0xffffffff,%eax
  ca:	74 17                	je     e3 <forktest+0xba>
    printf(1, "wait got too many\n");
  cc:	83 ec 08             	sub    $0x8,%esp
  cf:	68 9b 04 00 00       	push   $0x49b
  d4:	6a 01                	push   $0x1
  d6:	e8 25 ff ff ff       	call   0 <printf>
  db:	83 c4 10             	add    $0x10,%esp
    exit();
  de:	e8 b7 02 00 00       	call   39a <exit>
  }

  printf(1, "fork test OK\n");
  e3:	83 ec 08             	sub    $0x8,%esp
  e6:	68 ae 04 00 00       	push   $0x4ae
  eb:	6a 01                	push   $0x1
  ed:	e8 0e ff ff ff       	call   0 <printf>
  f2:	83 c4 10             	add    $0x10,%esp
}
  f5:	90                   	nop
  f6:	c9                   	leave  
  f7:	c3                   	ret    

000000f8 <main>:

int
main(void)
{
  f8:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  fc:	83 e4 f0             	and    $0xfffffff0,%esp
  ff:	ff 71 fc             	pushl  -0x4(%ecx)
 102:	55                   	push   %ebp
 103:	89 e5                	mov    %esp,%ebp
 105:	51                   	push   %ecx
 106:	83 ec 04             	sub    $0x4,%esp
  forktest();
 109:	e8 1b ff ff ff       	call   29 <forktest>
  exit();
 10e:	e8 87 02 00 00       	call   39a <exit>

00000113 <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
 113:	55                   	push   %ebp
 114:	89 e5                	mov    %esp,%ebp
 116:	57                   	push   %edi
 117:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 118:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11b:	8b 55 10             	mov    0x10(%ebp),%edx
 11e:	8b 45 0c             	mov    0xc(%ebp),%eax
 121:	89 cb                	mov    %ecx,%ebx
 123:	89 df                	mov    %ebx,%edi
 125:	89 d1                	mov    %edx,%ecx
 127:	fc                   	cld    
 128:	f3 aa                	rep stos %al,%es:(%edi)
 12a:	89 ca                	mov    %ecx,%edx
 12c:	89 fb                	mov    %edi,%ebx
 12e:	89 5d 08             	mov    %ebx,0x8(%ebp)
 131:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 134:	90                   	nop
 135:	5b                   	pop    %ebx
 136:	5f                   	pop    %edi
 137:	5d                   	pop    %ebp
 138:	c3                   	ret    

00000139 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
 13c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 145:	90                   	nop
 146:	8b 55 0c             	mov    0xc(%ebp),%edx
 149:	8d 42 01             	lea    0x1(%edx),%eax
 14c:	89 45 0c             	mov    %eax,0xc(%ebp)
 14f:	8b 45 08             	mov    0x8(%ebp),%eax
 152:	8d 48 01             	lea    0x1(%eax),%ecx
 155:	89 4d 08             	mov    %ecx,0x8(%ebp)
 158:	0f b6 12             	movzbl (%edx),%edx
 15b:	88 10                	mov    %dl,(%eax)
 15d:	0f b6 00             	movzbl (%eax),%eax
 160:	84 c0                	test   %al,%al
 162:	75 e2                	jne    146 <strcpy+0xd>
    ;
  return os;
 164:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 167:	c9                   	leave  
 168:	c3                   	ret    

00000169 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 169:	55                   	push   %ebp
 16a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 16c:	eb 08                	jmp    176 <strcmp+0xd>
    p++, q++;
 16e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 172:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	0f b6 00             	movzbl (%eax),%eax
 17c:	84 c0                	test   %al,%al
 17e:	74 10                	je     190 <strcmp+0x27>
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	0f b6 10             	movzbl (%eax),%edx
 186:	8b 45 0c             	mov    0xc(%ebp),%eax
 189:	0f b6 00             	movzbl (%eax),%eax
 18c:	38 c2                	cmp    %al,%dl
 18e:	74 de                	je     16e <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	0f b6 00             	movzbl (%eax),%eax
 196:	0f b6 d0             	movzbl %al,%edx
 199:	8b 45 0c             	mov    0xc(%ebp),%eax
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	0f b6 c0             	movzbl %al,%eax
 1a2:	29 c2                	sub    %eax,%edx
 1a4:	89 d0                	mov    %edx,%eax
}
 1a6:	5d                   	pop    %ebp
 1a7:	c3                   	ret    

000001a8 <strlen>:

uint
strlen(char *s)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
 1ab:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b5:	eb 04                	jmp    1bb <strlen+0x13>
 1b7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1be:	8b 45 08             	mov    0x8(%ebp),%eax
 1c1:	01 d0                	add    %edx,%eax
 1c3:	0f b6 00             	movzbl (%eax),%eax
 1c6:	84 c0                	test   %al,%al
 1c8:	75 ed                	jne    1b7 <strlen+0xf>
    ;
  return n;
 1ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1cd:	c9                   	leave  
 1ce:	c3                   	ret    

000001cf <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
 1cf:	55                   	push   %ebp
 1d0:	89 e5                	mov    %esp,%ebp
 1d2:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
 1d5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1dc:	eb 0c                	jmp    1ea <strnlen+0x1b>
     n++; 
 1de:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
 1e2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1e6:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
 1ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 1ee:	74 0a                	je     1fa <strnlen+0x2b>
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
 1f3:	0f b6 00             	movzbl (%eax),%eax
 1f6:	84 c0                	test   %al,%al
 1f8:	75 e4                	jne    1de <strnlen+0xf>
   return n; 
 1fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
 1fd:	c9                   	leave  
 1fe:	c3                   	ret    

000001ff <memset>:
 

void*
memset(void *dst, int c, uint n)
{
 1ff:	55                   	push   %ebp
 200:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 202:	8b 45 10             	mov    0x10(%ebp),%eax
 205:	50                   	push   %eax
 206:	ff 75 0c             	pushl  0xc(%ebp)
 209:	ff 75 08             	pushl  0x8(%ebp)
 20c:	e8 02 ff ff ff       	call   113 <stosb>
 211:	83 c4 0c             	add    $0xc,%esp
  return dst;
 214:	8b 45 08             	mov    0x8(%ebp),%eax
}
 217:	c9                   	leave  
 218:	c3                   	ret    

00000219 <strchr>:

char*
strchr(const char *s, char c)
{
 219:	55                   	push   %ebp
 21a:	89 e5                	mov    %esp,%ebp
 21c:	83 ec 04             	sub    $0x4,%esp
 21f:	8b 45 0c             	mov    0xc(%ebp),%eax
 222:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 225:	eb 14                	jmp    23b <strchr+0x22>
    if(*s == c)
 227:	8b 45 08             	mov    0x8(%ebp),%eax
 22a:	0f b6 00             	movzbl (%eax),%eax
 22d:	38 45 fc             	cmp    %al,-0x4(%ebp)
 230:	75 05                	jne    237 <strchr+0x1e>
      return (char*)s;
 232:	8b 45 08             	mov    0x8(%ebp),%eax
 235:	eb 13                	jmp    24a <strchr+0x31>
  for(; *s; s++)
 237:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 23b:	8b 45 08             	mov    0x8(%ebp),%eax
 23e:	0f b6 00             	movzbl (%eax),%eax
 241:	84 c0                	test   %al,%al
 243:	75 e2                	jne    227 <strchr+0xe>
  return 0;
 245:	b8 00 00 00 00       	mov    $0x0,%eax
}
 24a:	c9                   	leave  
 24b:	c3                   	ret    

0000024c <gets>:

char*
gets(char *buf, int max)
{
 24c:	55                   	push   %ebp
 24d:	89 e5                	mov    %esp,%ebp
 24f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 252:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 259:	eb 42                	jmp    29d <gets+0x51>
    cc = read(0, &c, 1);
 25b:	83 ec 04             	sub    $0x4,%esp
 25e:	6a 01                	push   $0x1
 260:	8d 45 ef             	lea    -0x11(%ebp),%eax
 263:	50                   	push   %eax
 264:	6a 00                	push   $0x0
 266:	e8 47 01 00 00       	call   3b2 <read>
 26b:	83 c4 10             	add    $0x10,%esp
 26e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 271:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 275:	7e 33                	jle    2aa <gets+0x5e>
      break;
    buf[i++] = c;
 277:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27a:	8d 50 01             	lea    0x1(%eax),%edx
 27d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 280:	89 c2                	mov    %eax,%edx
 282:	8b 45 08             	mov    0x8(%ebp),%eax
 285:	01 c2                	add    %eax,%edx
 287:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 28b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 28d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 291:	3c 0a                	cmp    $0xa,%al
 293:	74 16                	je     2ab <gets+0x5f>
 295:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 299:	3c 0d                	cmp    $0xd,%al
 29b:	74 0e                	je     2ab <gets+0x5f>
  for(i=0; i+1 < max; ){
 29d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2a0:	83 c0 01             	add    $0x1,%eax
 2a3:	39 45 0c             	cmp    %eax,0xc(%ebp)
 2a6:	7f b3                	jg     25b <gets+0xf>
 2a8:	eb 01                	jmp    2ab <gets+0x5f>
      break;
 2aa:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2ae:	8b 45 08             	mov    0x8(%ebp),%eax
 2b1:	01 d0                	add    %edx,%eax
 2b3:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b9:	c9                   	leave  
 2ba:	c3                   	ret    

000002bb <stat>:

int
stat(char *n, struct stat *st)
{
 2bb:	55                   	push   %ebp
 2bc:	89 e5                	mov    %esp,%ebp
 2be:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c1:	83 ec 08             	sub    $0x8,%esp
 2c4:	6a 00                	push   $0x0
 2c6:	ff 75 08             	pushl  0x8(%ebp)
 2c9:	e8 0c 01 00 00       	call   3da <open>
 2ce:	83 c4 10             	add    $0x10,%esp
 2d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2d8:	79 07                	jns    2e1 <stat+0x26>
    return -1;
 2da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2df:	eb 25                	jmp    306 <stat+0x4b>
  r = fstat(fd, st);
 2e1:	83 ec 08             	sub    $0x8,%esp
 2e4:	ff 75 0c             	pushl  0xc(%ebp)
 2e7:	ff 75 f4             	pushl  -0xc(%ebp)
 2ea:	e8 03 01 00 00       	call   3f2 <fstat>
 2ef:	83 c4 10             	add    $0x10,%esp
 2f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2f5:	83 ec 0c             	sub    $0xc,%esp
 2f8:	ff 75 f4             	pushl  -0xc(%ebp)
 2fb:	e8 c2 00 00 00       	call   3c2 <close>
 300:	83 c4 10             	add    $0x10,%esp
  return r;
 303:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 306:	c9                   	leave  
 307:	c3                   	ret    

00000308 <atoi>:

int
atoi(const char *s)
{
 308:	55                   	push   %ebp
 309:	89 e5                	mov    %esp,%ebp
 30b:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 30e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 315:	eb 25                	jmp    33c <atoi+0x34>
    n = n*10 + *s++ - '0';
 317:	8b 55 fc             	mov    -0x4(%ebp),%edx
 31a:	89 d0                	mov    %edx,%eax
 31c:	c1 e0 02             	shl    $0x2,%eax
 31f:	01 d0                	add    %edx,%eax
 321:	01 c0                	add    %eax,%eax
 323:	89 c1                	mov    %eax,%ecx
 325:	8b 45 08             	mov    0x8(%ebp),%eax
 328:	8d 50 01             	lea    0x1(%eax),%edx
 32b:	89 55 08             	mov    %edx,0x8(%ebp)
 32e:	0f b6 00             	movzbl (%eax),%eax
 331:	0f be c0             	movsbl %al,%eax
 334:	01 c8                	add    %ecx,%eax
 336:	83 e8 30             	sub    $0x30,%eax
 339:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 33c:	8b 45 08             	mov    0x8(%ebp),%eax
 33f:	0f b6 00             	movzbl (%eax),%eax
 342:	3c 2f                	cmp    $0x2f,%al
 344:	7e 0a                	jle    350 <atoi+0x48>
 346:	8b 45 08             	mov    0x8(%ebp),%eax
 349:	0f b6 00             	movzbl (%eax),%eax
 34c:	3c 39                	cmp    $0x39,%al
 34e:	7e c7                	jle    317 <atoi+0xf>
  return n;
 350:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 353:	c9                   	leave  
 354:	c3                   	ret    

00000355 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 355:	55                   	push   %ebp
 356:	89 e5                	mov    %esp,%ebp
 358:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 35b:	8b 45 08             	mov    0x8(%ebp),%eax
 35e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 361:	8b 45 0c             	mov    0xc(%ebp),%eax
 364:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 367:	eb 17                	jmp    380 <memmove+0x2b>
    *dst++ = *src++;
 369:	8b 55 f8             	mov    -0x8(%ebp),%edx
 36c:	8d 42 01             	lea    0x1(%edx),%eax
 36f:	89 45 f8             	mov    %eax,-0x8(%ebp)
 372:	8b 45 fc             	mov    -0x4(%ebp),%eax
 375:	8d 48 01             	lea    0x1(%eax),%ecx
 378:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 37b:	0f b6 12             	movzbl (%edx),%edx
 37e:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 380:	8b 45 10             	mov    0x10(%ebp),%eax
 383:	8d 50 ff             	lea    -0x1(%eax),%edx
 386:	89 55 10             	mov    %edx,0x10(%ebp)
 389:	85 c0                	test   %eax,%eax
 38b:	7f dc                	jg     369 <memmove+0x14>
  return vdst;
 38d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 390:	c9                   	leave  
 391:	c3                   	ret    

00000392 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 392:	b8 01 00 00 00       	mov    $0x1,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <exit>:
SYSCALL(exit)
 39a:	b8 02 00 00 00       	mov    $0x2,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <wait>:
SYSCALL(wait)
 3a2:	b8 03 00 00 00       	mov    $0x3,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <pipe>:
SYSCALL(pipe)
 3aa:	b8 04 00 00 00       	mov    $0x4,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <read>:
SYSCALL(read)
 3b2:	b8 05 00 00 00       	mov    $0x5,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <write>:
SYSCALL(write)
 3ba:	b8 10 00 00 00       	mov    $0x10,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <close>:
SYSCALL(close)
 3c2:	b8 15 00 00 00       	mov    $0x15,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <kill>:
SYSCALL(kill)
 3ca:	b8 06 00 00 00       	mov    $0x6,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <exec>:
SYSCALL(exec)
 3d2:	b8 07 00 00 00       	mov    $0x7,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <open>:
SYSCALL(open)
 3da:	b8 0f 00 00 00       	mov    $0xf,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <mknod>:
SYSCALL(mknod)
 3e2:	b8 11 00 00 00       	mov    $0x11,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <unlink>:
SYSCALL(unlink)
 3ea:	b8 12 00 00 00       	mov    $0x12,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <fstat>:
SYSCALL(fstat)
 3f2:	b8 08 00 00 00       	mov    $0x8,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <link>:
SYSCALL(link)
 3fa:	b8 13 00 00 00       	mov    $0x13,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <mkdir>:
SYSCALL(mkdir)
 402:	b8 14 00 00 00       	mov    $0x14,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <chdir>:
SYSCALL(chdir)
 40a:	b8 09 00 00 00       	mov    $0x9,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <dup>:
SYSCALL(dup)
 412:	b8 0a 00 00 00       	mov    $0xa,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <getpid>:
SYSCALL(getpid)
 41a:	b8 0b 00 00 00       	mov    $0xb,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <sbrk>:
SYSCALL(sbrk)
 422:	b8 0c 00 00 00       	mov    $0xc,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <sleep>:
SYSCALL(sleep)
 42a:	b8 0d 00 00 00       	mov    $0xd,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <uptime>:
SYSCALL(uptime)
 432:	b8 0e 00 00 00       	mov    $0xe,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <select>:
SYSCALL(select)
 43a:	b8 16 00 00 00       	mov    $0x16,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <arp>:
SYSCALL(arp)
 442:	b8 17 00 00 00       	mov    $0x17,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <arpserv>:
SYSCALL(arpserv)
 44a:	b8 18 00 00 00       	mov    $0x18,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <arp_receive>:
SYSCALL(arp_receive)
 452:	b8 19 00 00 00       	mov    $0x19,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    
