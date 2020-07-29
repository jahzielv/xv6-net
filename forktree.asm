
_forktree:     file format elf32-i386


Disassembly of section .text:

00000000 <forkchild>:
 
 void forktree(char *cur);
 
 void
 forkchild(char *cur, char branch)
 {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
       6:	8b 45 0c             	mov    0xc(%ebp),%eax
       9:	88 45 e4             	mov    %al,-0x1c(%ebp)
   char nxt[DEPTH+1];
 
   if (strlen(cur) >= DEPTH)
       c:	83 ec 0c             	sub    $0xc,%esp
       f:	ff 75 08             	pushl  0x8(%ebp)
      12:	e8 49 01 00 00       	call   160 <strlen>
      17:	83 c4 10             	add    $0x10,%esp
      1a:	83 f8 02             	cmp    $0x2,%eax
      1d:	77 42                	ja     61 <forkchild+0x61>
     return;
 
   snprintf(nxt, DEPTH+1, "%s%c", cur, branch);
      1f:	0f be 45 e4          	movsbl -0x1c(%ebp),%eax
      23:	83 ec 0c             	sub    $0xc,%esp
      26:	50                   	push   %eax
      27:	ff 75 08             	pushl  0x8(%ebp)
      2a:	68 c0 10 00 00       	push   $0x10c0
      2f:	6a 04                	push   $0x4
      31:	8d 45 f4             	lea    -0xc(%ebp),%eax
      34:	50                   	push   %eax
      35:	e8 1a 0e 00 00       	call   e54 <snprintf>
      3a:	83 c4 20             	add    $0x20,%esp
   if (fork() == 0) {
      3d:	e8 08 03 00 00       	call   34a <fork>
      42:	85 c0                	test   %eax,%eax
      44:	75 14                	jne    5a <forkchild+0x5a>
     forktree(nxt);
      46:	83 ec 0c             	sub    $0xc,%esp
      49:	8d 45 f4             	lea    -0xc(%ebp),%eax
      4c:	50                   	push   %eax
      4d:	e8 12 00 00 00       	call   64 <forktree>
      52:	83 c4 10             	add    $0x10,%esp
     exit();
      55:	e8 f8 02 00 00       	call   352 <exit>
   } else
   {
       wait();
      5a:	e8 fb 02 00 00       	call   35a <wait>
      5f:	eb 01                	jmp    62 <forkchild+0x62>
     return;
      61:	90                   	nop
   }
 }
      62:	c9                   	leave  
      63:	c3                   	ret    

00000064 <forktree>:
 
 void
 forktree(char *cur)
 {
      64:	55                   	push   %ebp
      65:	89 e5                	mov    %esp,%ebp
      67:	83 ec 08             	sub    $0x8,%esp
   printf(1,"%d: I am '%s'\n", getpid(), cur);
      6a:	e8 63 03 00 00       	call   3d2 <getpid>
      6f:	ff 75 08             	pushl  0x8(%ebp)
      72:	50                   	push   %eax
      73:	68 c5 10 00 00       	push   $0x10c5
      78:	6a 01                	push   $0x1
      7a:	e8 66 04 00 00       	call   4e5 <printf>
      7f:	83 c4 10             	add    $0x10,%esp
 
   forkchild(cur, '0');
      82:	83 ec 08             	sub    $0x8,%esp
      85:	6a 30                	push   $0x30
      87:	ff 75 08             	pushl  0x8(%ebp)
      8a:	e8 71 ff ff ff       	call   0 <forkchild>
      8f:	83 c4 10             	add    $0x10,%esp
   forkchild(cur, '1');
      92:	83 ec 08             	sub    $0x8,%esp
      95:	6a 31                	push   $0x31
      97:	ff 75 08             	pushl  0x8(%ebp)
      9a:	e8 61 ff ff ff       	call   0 <forkchild>
      9f:	83 c4 10             	add    $0x10,%esp
 }
      a2:	90                   	nop
      a3:	c9                   	leave  
      a4:	c3                   	ret    

000000a5 <main>:
 
 int
 main(int argc, char **argv)
 {
      a5:	8d 4c 24 04          	lea    0x4(%esp),%ecx
      a9:	83 e4 f0             	and    $0xfffffff0,%esp
      ac:	ff 71 fc             	pushl  -0x4(%ecx)
      af:	55                   	push   %ebp
      b0:	89 e5                	mov    %esp,%ebp
      b2:	51                   	push   %ecx
      b3:	83 ec 04             	sub    $0x4,%esp
   forktree("");
      b6:	83 ec 0c             	sub    $0xc,%esp
      b9:	68 d4 10 00 00       	push   $0x10d4
      be:	e8 a1 ff ff ff       	call   64 <forktree>
      c3:	83 c4 10             	add    $0x10,%esp
   exit();
      c6:	e8 87 02 00 00       	call   352 <exit>

000000cb <stosb>:
  asm volatile("outl %0,%w1" : : "a" (data), "d" (port));
}

static inline void
stosb(void *addr, int data, int cnt)
{
      cb:	55                   	push   %ebp
      cc:	89 e5                	mov    %esp,%ebp
      ce:	57                   	push   %edi
      cf:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
      d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
      d3:	8b 55 10             	mov    0x10(%ebp),%edx
      d6:	8b 45 0c             	mov    0xc(%ebp),%eax
      d9:	89 cb                	mov    %ecx,%ebx
      db:	89 df                	mov    %ebx,%edi
      dd:	89 d1                	mov    %edx,%ecx
      df:	fc                   	cld    
      e0:	f3 aa                	rep stos %al,%es:(%edi)
      e2:	89 ca                	mov    %ecx,%edx
      e4:	89 fb                	mov    %edi,%ebx
      e6:	89 5d 08             	mov    %ebx,0x8(%ebp)
      e9:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
      ec:	90                   	nop
      ed:	5b                   	pop    %ebx
      ee:	5f                   	pop    %edi
      ef:	5d                   	pop    %ebp
      f0:	c3                   	ret    

000000f1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
      f1:	55                   	push   %ebp
      f2:	89 e5                	mov    %esp,%ebp
      f4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
      f7:	8b 45 08             	mov    0x8(%ebp),%eax
      fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
      fd:	90                   	nop
      fe:	8b 55 0c             	mov    0xc(%ebp),%edx
     101:	8d 42 01             	lea    0x1(%edx),%eax
     104:	89 45 0c             	mov    %eax,0xc(%ebp)
     107:	8b 45 08             	mov    0x8(%ebp),%eax
     10a:	8d 48 01             	lea    0x1(%eax),%ecx
     10d:	89 4d 08             	mov    %ecx,0x8(%ebp)
     110:	0f b6 12             	movzbl (%edx),%edx
     113:	88 10                	mov    %dl,(%eax)
     115:	0f b6 00             	movzbl (%eax),%eax
     118:	84 c0                	test   %al,%al
     11a:	75 e2                	jne    fe <strcpy+0xd>
    ;
  return os;
     11c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     11f:	c9                   	leave  
     120:	c3                   	ret    

00000121 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     121:	55                   	push   %ebp
     122:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     124:	eb 08                	jmp    12e <strcmp+0xd>
    p++, q++;
     126:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     12a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
     12e:	8b 45 08             	mov    0x8(%ebp),%eax
     131:	0f b6 00             	movzbl (%eax),%eax
     134:	84 c0                	test   %al,%al
     136:	74 10                	je     148 <strcmp+0x27>
     138:	8b 45 08             	mov    0x8(%ebp),%eax
     13b:	0f b6 10             	movzbl (%eax),%edx
     13e:	8b 45 0c             	mov    0xc(%ebp),%eax
     141:	0f b6 00             	movzbl (%eax),%eax
     144:	38 c2                	cmp    %al,%dl
     146:	74 de                	je     126 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
     148:	8b 45 08             	mov    0x8(%ebp),%eax
     14b:	0f b6 00             	movzbl (%eax),%eax
     14e:	0f b6 d0             	movzbl %al,%edx
     151:	8b 45 0c             	mov    0xc(%ebp),%eax
     154:	0f b6 00             	movzbl (%eax),%eax
     157:	0f b6 c0             	movzbl %al,%eax
     15a:	29 c2                	sub    %eax,%edx
     15c:	89 d0                	mov    %edx,%eax
}
     15e:	5d                   	pop    %ebp
     15f:	c3                   	ret    

00000160 <strlen>:

uint
strlen(char *s)
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     166:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     16d:	eb 04                	jmp    173 <strlen+0x13>
     16f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     173:	8b 55 fc             	mov    -0x4(%ebp),%edx
     176:	8b 45 08             	mov    0x8(%ebp),%eax
     179:	01 d0                	add    %edx,%eax
     17b:	0f b6 00             	movzbl (%eax),%eax
     17e:	84 c0                	test   %al,%al
     180:	75 ed                	jne    16f <strlen+0xf>
    ;
  return n;
     182:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     185:	c9                   	leave  
     186:	c3                   	ret    

00000187 <strnlen>:

 int 
 strnlen(const char *s, uint size) 
 { 
     187:	55                   	push   %ebp
     188:	89 e5                	mov    %esp,%ebp
     18a:	83 ec 10             	sub    $0x10,%esp
   int n; 
  
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     18d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     194:	eb 0c                	jmp    1a2 <strnlen+0x1b>
     n++; 
     196:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
   for (n = 0; size > 0 && *s != '\0'; s++, size--) 
     19a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     19e:	83 6d 0c 01          	subl   $0x1,0xc(%ebp)
     1a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     1a6:	74 0a                	je     1b2 <strnlen+0x2b>
     1a8:	8b 45 08             	mov    0x8(%ebp),%eax
     1ab:	0f b6 00             	movzbl (%eax),%eax
     1ae:	84 c0                	test   %al,%al
     1b0:	75 e4                	jne    196 <strnlen+0xf>
   return n; 
     1b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 } 
     1b5:	c9                   	leave  
     1b6:	c3                   	ret    

000001b7 <memset>:
 

void*
memset(void *dst, int c, uint n)
{
     1b7:	55                   	push   %ebp
     1b8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     1ba:	8b 45 10             	mov    0x10(%ebp),%eax
     1bd:	50                   	push   %eax
     1be:	ff 75 0c             	pushl  0xc(%ebp)
     1c1:	ff 75 08             	pushl  0x8(%ebp)
     1c4:	e8 02 ff ff ff       	call   cb <stosb>
     1c9:	83 c4 0c             	add    $0xc,%esp
  return dst;
     1cc:	8b 45 08             	mov    0x8(%ebp),%eax
}
     1cf:	c9                   	leave  
     1d0:	c3                   	ret    

000001d1 <strchr>:

char*
strchr(const char *s, char c)
{
     1d1:	55                   	push   %ebp
     1d2:	89 e5                	mov    %esp,%ebp
     1d4:	83 ec 04             	sub    $0x4,%esp
     1d7:	8b 45 0c             	mov    0xc(%ebp),%eax
     1da:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     1dd:	eb 14                	jmp    1f3 <strchr+0x22>
    if(*s == c)
     1df:	8b 45 08             	mov    0x8(%ebp),%eax
     1e2:	0f b6 00             	movzbl (%eax),%eax
     1e5:	38 45 fc             	cmp    %al,-0x4(%ebp)
     1e8:	75 05                	jne    1ef <strchr+0x1e>
      return (char*)s;
     1ea:	8b 45 08             	mov    0x8(%ebp),%eax
     1ed:	eb 13                	jmp    202 <strchr+0x31>
  for(; *s; s++)
     1ef:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     1f3:	8b 45 08             	mov    0x8(%ebp),%eax
     1f6:	0f b6 00             	movzbl (%eax),%eax
     1f9:	84 c0                	test   %al,%al
     1fb:	75 e2                	jne    1df <strchr+0xe>
  return 0;
     1fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
     202:	c9                   	leave  
     203:	c3                   	ret    

00000204 <gets>:

char*
gets(char *buf, int max)
{
     204:	55                   	push   %ebp
     205:	89 e5                	mov    %esp,%ebp
     207:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     20a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     211:	eb 42                	jmp    255 <gets+0x51>
    cc = read(0, &c, 1);
     213:	83 ec 04             	sub    $0x4,%esp
     216:	6a 01                	push   $0x1
     218:	8d 45 ef             	lea    -0x11(%ebp),%eax
     21b:	50                   	push   %eax
     21c:	6a 00                	push   $0x0
     21e:	e8 47 01 00 00       	call   36a <read>
     223:	83 c4 10             	add    $0x10,%esp
     226:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     229:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     22d:	7e 33                	jle    262 <gets+0x5e>
      break;
    buf[i++] = c;
     22f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     232:	8d 50 01             	lea    0x1(%eax),%edx
     235:	89 55 f4             	mov    %edx,-0xc(%ebp)
     238:	89 c2                	mov    %eax,%edx
     23a:	8b 45 08             	mov    0x8(%ebp),%eax
     23d:	01 c2                	add    %eax,%edx
     23f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     243:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     245:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     249:	3c 0a                	cmp    $0xa,%al
     24b:	74 16                	je     263 <gets+0x5f>
     24d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     251:	3c 0d                	cmp    $0xd,%al
     253:	74 0e                	je     263 <gets+0x5f>
  for(i=0; i+1 < max; ){
     255:	8b 45 f4             	mov    -0xc(%ebp),%eax
     258:	83 c0 01             	add    $0x1,%eax
     25b:	39 45 0c             	cmp    %eax,0xc(%ebp)
     25e:	7f b3                	jg     213 <gets+0xf>
     260:	eb 01                	jmp    263 <gets+0x5f>
      break;
     262:	90                   	nop
      break;
  }
  buf[i] = '\0';
     263:	8b 55 f4             	mov    -0xc(%ebp),%edx
     266:	8b 45 08             	mov    0x8(%ebp),%eax
     269:	01 d0                	add    %edx,%eax
     26b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     26e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     271:	c9                   	leave  
     272:	c3                   	ret    

00000273 <stat>:

int
stat(char *n, struct stat *st)
{
     273:	55                   	push   %ebp
     274:	89 e5                	mov    %esp,%ebp
     276:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     279:	83 ec 08             	sub    $0x8,%esp
     27c:	6a 00                	push   $0x0
     27e:	ff 75 08             	pushl  0x8(%ebp)
     281:	e8 0c 01 00 00       	call   392 <open>
     286:	83 c4 10             	add    $0x10,%esp
     289:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     28c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     290:	79 07                	jns    299 <stat+0x26>
    return -1;
     292:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     297:	eb 25                	jmp    2be <stat+0x4b>
  r = fstat(fd, st);
     299:	83 ec 08             	sub    $0x8,%esp
     29c:	ff 75 0c             	pushl  0xc(%ebp)
     29f:	ff 75 f4             	pushl  -0xc(%ebp)
     2a2:	e8 03 01 00 00       	call   3aa <fstat>
     2a7:	83 c4 10             	add    $0x10,%esp
     2aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     2ad:	83 ec 0c             	sub    $0xc,%esp
     2b0:	ff 75 f4             	pushl  -0xc(%ebp)
     2b3:	e8 c2 00 00 00       	call   37a <close>
     2b8:	83 c4 10             	add    $0x10,%esp
  return r;
     2bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     2be:	c9                   	leave  
     2bf:	c3                   	ret    

000002c0 <atoi>:

int
atoi(const char *s)
{
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     2c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2cd:	eb 25                	jmp    2f4 <atoi+0x34>
    n = n*10 + *s++ - '0';
     2cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
     2d2:	89 d0                	mov    %edx,%eax
     2d4:	c1 e0 02             	shl    $0x2,%eax
     2d7:	01 d0                	add    %edx,%eax
     2d9:	01 c0                	add    %eax,%eax
     2db:	89 c1                	mov    %eax,%ecx
     2dd:	8b 45 08             	mov    0x8(%ebp),%eax
     2e0:	8d 50 01             	lea    0x1(%eax),%edx
     2e3:	89 55 08             	mov    %edx,0x8(%ebp)
     2e6:	0f b6 00             	movzbl (%eax),%eax
     2e9:	0f be c0             	movsbl %al,%eax
     2ec:	01 c8                	add    %ecx,%eax
     2ee:	83 e8 30             	sub    $0x30,%eax
     2f1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     2f4:	8b 45 08             	mov    0x8(%ebp),%eax
     2f7:	0f b6 00             	movzbl (%eax),%eax
     2fa:	3c 2f                	cmp    $0x2f,%al
     2fc:	7e 0a                	jle    308 <atoi+0x48>
     2fe:	8b 45 08             	mov    0x8(%ebp),%eax
     301:	0f b6 00             	movzbl (%eax),%eax
     304:	3c 39                	cmp    $0x39,%al
     306:	7e c7                	jle    2cf <atoi+0xf>
  return n;
     308:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     30b:	c9                   	leave  
     30c:	c3                   	ret    

0000030d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     30d:	55                   	push   %ebp
     30e:	89 e5                	mov    %esp,%ebp
     310:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
     313:	8b 45 08             	mov    0x8(%ebp),%eax
     316:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
     319:	8b 45 0c             	mov    0xc(%ebp),%eax
     31c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
     31f:	eb 17                	jmp    338 <memmove+0x2b>
    *dst++ = *src++;
     321:	8b 55 f8             	mov    -0x8(%ebp),%edx
     324:	8d 42 01             	lea    0x1(%edx),%eax
     327:	89 45 f8             	mov    %eax,-0x8(%ebp)
     32a:	8b 45 fc             	mov    -0x4(%ebp),%eax
     32d:	8d 48 01             	lea    0x1(%eax),%ecx
     330:	89 4d fc             	mov    %ecx,-0x4(%ebp)
     333:	0f b6 12             	movzbl (%edx),%edx
     336:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
     338:	8b 45 10             	mov    0x10(%ebp),%eax
     33b:	8d 50 ff             	lea    -0x1(%eax),%edx
     33e:	89 55 10             	mov    %edx,0x10(%ebp)
     341:	85 c0                	test   %eax,%eax
     343:	7f dc                	jg     321 <memmove+0x14>
  return vdst;
     345:	8b 45 08             	mov    0x8(%ebp),%eax
}
     348:	c9                   	leave  
     349:	c3                   	ret    

0000034a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     34a:	b8 01 00 00 00       	mov    $0x1,%eax
     34f:	cd 40                	int    $0x40
     351:	c3                   	ret    

00000352 <exit>:
SYSCALL(exit)
     352:	b8 02 00 00 00       	mov    $0x2,%eax
     357:	cd 40                	int    $0x40
     359:	c3                   	ret    

0000035a <wait>:
SYSCALL(wait)
     35a:	b8 03 00 00 00       	mov    $0x3,%eax
     35f:	cd 40                	int    $0x40
     361:	c3                   	ret    

00000362 <pipe>:
SYSCALL(pipe)
     362:	b8 04 00 00 00       	mov    $0x4,%eax
     367:	cd 40                	int    $0x40
     369:	c3                   	ret    

0000036a <read>:
SYSCALL(read)
     36a:	b8 05 00 00 00       	mov    $0x5,%eax
     36f:	cd 40                	int    $0x40
     371:	c3                   	ret    

00000372 <write>:
SYSCALL(write)
     372:	b8 10 00 00 00       	mov    $0x10,%eax
     377:	cd 40                	int    $0x40
     379:	c3                   	ret    

0000037a <close>:
SYSCALL(close)
     37a:	b8 15 00 00 00       	mov    $0x15,%eax
     37f:	cd 40                	int    $0x40
     381:	c3                   	ret    

00000382 <kill>:
SYSCALL(kill)
     382:	b8 06 00 00 00       	mov    $0x6,%eax
     387:	cd 40                	int    $0x40
     389:	c3                   	ret    

0000038a <exec>:
SYSCALL(exec)
     38a:	b8 07 00 00 00       	mov    $0x7,%eax
     38f:	cd 40                	int    $0x40
     391:	c3                   	ret    

00000392 <open>:
SYSCALL(open)
     392:	b8 0f 00 00 00       	mov    $0xf,%eax
     397:	cd 40                	int    $0x40
     399:	c3                   	ret    

0000039a <mknod>:
SYSCALL(mknod)
     39a:	b8 11 00 00 00       	mov    $0x11,%eax
     39f:	cd 40                	int    $0x40
     3a1:	c3                   	ret    

000003a2 <unlink>:
SYSCALL(unlink)
     3a2:	b8 12 00 00 00       	mov    $0x12,%eax
     3a7:	cd 40                	int    $0x40
     3a9:	c3                   	ret    

000003aa <fstat>:
SYSCALL(fstat)
     3aa:	b8 08 00 00 00       	mov    $0x8,%eax
     3af:	cd 40                	int    $0x40
     3b1:	c3                   	ret    

000003b2 <link>:
SYSCALL(link)
     3b2:	b8 13 00 00 00       	mov    $0x13,%eax
     3b7:	cd 40                	int    $0x40
     3b9:	c3                   	ret    

000003ba <mkdir>:
SYSCALL(mkdir)
     3ba:	b8 14 00 00 00       	mov    $0x14,%eax
     3bf:	cd 40                	int    $0x40
     3c1:	c3                   	ret    

000003c2 <chdir>:
SYSCALL(chdir)
     3c2:	b8 09 00 00 00       	mov    $0x9,%eax
     3c7:	cd 40                	int    $0x40
     3c9:	c3                   	ret    

000003ca <dup>:
SYSCALL(dup)
     3ca:	b8 0a 00 00 00       	mov    $0xa,%eax
     3cf:	cd 40                	int    $0x40
     3d1:	c3                   	ret    

000003d2 <getpid>:
SYSCALL(getpid)
     3d2:	b8 0b 00 00 00       	mov    $0xb,%eax
     3d7:	cd 40                	int    $0x40
     3d9:	c3                   	ret    

000003da <sbrk>:
SYSCALL(sbrk)
     3da:	b8 0c 00 00 00       	mov    $0xc,%eax
     3df:	cd 40                	int    $0x40
     3e1:	c3                   	ret    

000003e2 <sleep>:
SYSCALL(sleep)
     3e2:	b8 0d 00 00 00       	mov    $0xd,%eax
     3e7:	cd 40                	int    $0x40
     3e9:	c3                   	ret    

000003ea <uptime>:
SYSCALL(uptime)
     3ea:	b8 0e 00 00 00       	mov    $0xe,%eax
     3ef:	cd 40                	int    $0x40
     3f1:	c3                   	ret    

000003f2 <select>:
SYSCALL(select)
     3f2:	b8 16 00 00 00       	mov    $0x16,%eax
     3f7:	cd 40                	int    $0x40
     3f9:	c3                   	ret    

000003fa <arp>:
SYSCALL(arp)
     3fa:	b8 17 00 00 00       	mov    $0x17,%eax
     3ff:	cd 40                	int    $0x40
     401:	c3                   	ret    

00000402 <arpserv>:
SYSCALL(arpserv)
     402:	b8 18 00 00 00       	mov    $0x18,%eax
     407:	cd 40                	int    $0x40
     409:	c3                   	ret    

0000040a <arp_receive>:
SYSCALL(arp_receive)
     40a:	b8 19 00 00 00       	mov    $0x19,%eax
     40f:	cd 40                	int    $0x40
     411:	c3                   	ret    

00000412 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     412:	55                   	push   %ebp
     413:	89 e5                	mov    %esp,%ebp
     415:	83 ec 18             	sub    $0x18,%esp
     418:	8b 45 0c             	mov    0xc(%ebp),%eax
     41b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
     41e:	83 ec 04             	sub    $0x4,%esp
     421:	6a 01                	push   $0x1
     423:	8d 45 f4             	lea    -0xc(%ebp),%eax
     426:	50                   	push   %eax
     427:	ff 75 08             	pushl  0x8(%ebp)
     42a:	e8 43 ff ff ff       	call   372 <write>
     42f:	83 c4 10             	add    $0x10,%esp
}
     432:	90                   	nop
     433:	c9                   	leave  
     434:	c3                   	ret    

00000435 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     435:	55                   	push   %ebp
     436:	89 e5                	mov    %esp,%ebp
     438:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     43b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
     442:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     446:	74 17                	je     45f <printint+0x2a>
     448:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     44c:	79 11                	jns    45f <printint+0x2a>
    neg = 1;
     44e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
     455:	8b 45 0c             	mov    0xc(%ebp),%eax
     458:	f7 d8                	neg    %eax
     45a:	89 45 ec             	mov    %eax,-0x14(%ebp)
     45d:	eb 06                	jmp    465 <printint+0x30>
  } else {
    x = xx;
     45f:	8b 45 0c             	mov    0xc(%ebp),%eax
     462:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
     465:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
     46c:	8b 4d 10             	mov    0x10(%ebp),%ecx
     46f:	8b 45 ec             	mov    -0x14(%ebp),%eax
     472:	ba 00 00 00 00       	mov    $0x0,%edx
     477:	f7 f1                	div    %ecx
     479:	89 d1                	mov    %edx,%ecx
     47b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     47e:	8d 50 01             	lea    0x1(%eax),%edx
     481:	89 55 f4             	mov    %edx,-0xc(%ebp)
     484:	0f b6 91 ac 17 00 00 	movzbl 0x17ac(%ecx),%edx
     48b:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
     48f:	8b 4d 10             	mov    0x10(%ebp),%ecx
     492:	8b 45 ec             	mov    -0x14(%ebp),%eax
     495:	ba 00 00 00 00       	mov    $0x0,%edx
     49a:	f7 f1                	div    %ecx
     49c:	89 45 ec             	mov    %eax,-0x14(%ebp)
     49f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     4a3:	75 c7                	jne    46c <printint+0x37>
  if(neg)
     4a5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4a9:	74 2d                	je     4d8 <printint+0xa3>
    buf[i++] = '-';
     4ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4ae:	8d 50 01             	lea    0x1(%eax),%edx
     4b1:	89 55 f4             	mov    %edx,-0xc(%ebp)
     4b4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
     4b9:	eb 1d                	jmp    4d8 <printint+0xa3>
    putc(fd, buf[i]);
     4bb:	8d 55 dc             	lea    -0x24(%ebp),%edx
     4be:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4c1:	01 d0                	add    %edx,%eax
     4c3:	0f b6 00             	movzbl (%eax),%eax
     4c6:	0f be c0             	movsbl %al,%eax
     4c9:	83 ec 08             	sub    $0x8,%esp
     4cc:	50                   	push   %eax
     4cd:	ff 75 08             	pushl  0x8(%ebp)
     4d0:	e8 3d ff ff ff       	call   412 <putc>
     4d5:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
     4d8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
     4dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     4e0:	79 d9                	jns    4bb <printint+0x86>
}
     4e2:	90                   	nop
     4e3:	c9                   	leave  
     4e4:	c3                   	ret    

000004e5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     4e5:	55                   	push   %ebp
     4e6:	89 e5                	mov    %esp,%ebp
     4e8:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     4eb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
     4f2:	8d 45 0c             	lea    0xc(%ebp),%eax
     4f5:	83 c0 04             	add    $0x4,%eax
     4f8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
     4fb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     502:	e9 59 01 00 00       	jmp    660 <printf+0x17b>
    c = fmt[i] & 0xff;
     507:	8b 55 0c             	mov    0xc(%ebp),%edx
     50a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     50d:	01 d0                	add    %edx,%eax
     50f:	0f b6 00             	movzbl (%eax),%eax
     512:	0f be c0             	movsbl %al,%eax
     515:	25 ff 00 00 00       	and    $0xff,%eax
     51a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
     51d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     521:	75 2c                	jne    54f <printf+0x6a>
      if(c == '%'){
     523:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     527:	75 0c                	jne    535 <printf+0x50>
        state = '%';
     529:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
     530:	e9 27 01 00 00       	jmp    65c <printf+0x177>
      } else {
        putc(fd, c);
     535:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     538:	0f be c0             	movsbl %al,%eax
     53b:	83 ec 08             	sub    $0x8,%esp
     53e:	50                   	push   %eax
     53f:	ff 75 08             	pushl  0x8(%ebp)
     542:	e8 cb fe ff ff       	call   412 <putc>
     547:	83 c4 10             	add    $0x10,%esp
     54a:	e9 0d 01 00 00       	jmp    65c <printf+0x177>
      }
    } else if(state == '%'){
     54f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
     553:	0f 85 03 01 00 00    	jne    65c <printf+0x177>
      if(c == 'd'){
     559:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
     55d:	75 1e                	jne    57d <printf+0x98>
        printint(fd, *ap, 10, 1);
     55f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     562:	8b 00                	mov    (%eax),%eax
     564:	6a 01                	push   $0x1
     566:	6a 0a                	push   $0xa
     568:	50                   	push   %eax
     569:	ff 75 08             	pushl  0x8(%ebp)
     56c:	e8 c4 fe ff ff       	call   435 <printint>
     571:	83 c4 10             	add    $0x10,%esp
        ap++;
     574:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     578:	e9 d8 00 00 00       	jmp    655 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
     57d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
     581:	74 06                	je     589 <printf+0xa4>
     583:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
     587:	75 1e                	jne    5a7 <printf+0xc2>
        printint(fd, *ap, 16, 0);
     589:	8b 45 e8             	mov    -0x18(%ebp),%eax
     58c:	8b 00                	mov    (%eax),%eax
     58e:	6a 00                	push   $0x0
     590:	6a 10                	push   $0x10
     592:	50                   	push   %eax
     593:	ff 75 08             	pushl  0x8(%ebp)
     596:	e8 9a fe ff ff       	call   435 <printint>
     59b:	83 c4 10             	add    $0x10,%esp
        ap++;
     59e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     5a2:	e9 ae 00 00 00       	jmp    655 <printf+0x170>
      } else if(c == 's'){
     5a7:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
     5ab:	75 43                	jne    5f0 <printf+0x10b>
        s = (char*)*ap;
     5ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5b0:	8b 00                	mov    (%eax),%eax
     5b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
     5b5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
     5b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     5bd:	75 25                	jne    5e4 <printf+0xff>
          s = "(null)";
     5bf:	c7 45 f4 d5 10 00 00 	movl   $0x10d5,-0xc(%ebp)
        while(*s != 0){
     5c6:	eb 1c                	jmp    5e4 <printf+0xff>
          putc(fd, *s);
     5c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5cb:	0f b6 00             	movzbl (%eax),%eax
     5ce:	0f be c0             	movsbl %al,%eax
     5d1:	83 ec 08             	sub    $0x8,%esp
     5d4:	50                   	push   %eax
     5d5:	ff 75 08             	pushl  0x8(%ebp)
     5d8:	e8 35 fe ff ff       	call   412 <putc>
     5dd:	83 c4 10             	add    $0x10,%esp
          s++;
     5e0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
     5e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e7:	0f b6 00             	movzbl (%eax),%eax
     5ea:	84 c0                	test   %al,%al
     5ec:	75 da                	jne    5c8 <printf+0xe3>
     5ee:	eb 65                	jmp    655 <printf+0x170>
        }
      } else if(c == 'c'){
     5f0:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
     5f4:	75 1d                	jne    613 <printf+0x12e>
        putc(fd, *ap);
     5f6:	8b 45 e8             	mov    -0x18(%ebp),%eax
     5f9:	8b 00                	mov    (%eax),%eax
     5fb:	0f be c0             	movsbl %al,%eax
     5fe:	83 ec 08             	sub    $0x8,%esp
     601:	50                   	push   %eax
     602:	ff 75 08             	pushl  0x8(%ebp)
     605:	e8 08 fe ff ff       	call   412 <putc>
     60a:	83 c4 10             	add    $0x10,%esp
        ap++;
     60d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
     611:	eb 42                	jmp    655 <printf+0x170>
      } else if(c == '%'){
     613:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
     617:	75 17                	jne    630 <printf+0x14b>
        putc(fd, c);
     619:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     61c:	0f be c0             	movsbl %al,%eax
     61f:	83 ec 08             	sub    $0x8,%esp
     622:	50                   	push   %eax
     623:	ff 75 08             	pushl  0x8(%ebp)
     626:	e8 e7 fd ff ff       	call   412 <putc>
     62b:	83 c4 10             	add    $0x10,%esp
     62e:	eb 25                	jmp    655 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     630:	83 ec 08             	sub    $0x8,%esp
     633:	6a 25                	push   $0x25
     635:	ff 75 08             	pushl  0x8(%ebp)
     638:	e8 d5 fd ff ff       	call   412 <putc>
     63d:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
     640:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     643:	0f be c0             	movsbl %al,%eax
     646:	83 ec 08             	sub    $0x8,%esp
     649:	50                   	push   %eax
     64a:	ff 75 08             	pushl  0x8(%ebp)
     64d:	e8 c0 fd ff ff       	call   412 <putc>
     652:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     655:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
     65c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     660:	8b 55 0c             	mov    0xc(%ebp),%edx
     663:	8b 45 f0             	mov    -0x10(%ebp),%eax
     666:	01 d0                	add    %edx,%eax
     668:	0f b6 00             	movzbl (%eax),%eax
     66b:	84 c0                	test   %al,%al
     66d:	0f 85 94 fe ff ff    	jne    507 <printf+0x22>
    }
  }
}
     673:	90                   	nop
     674:	c9                   	leave  
     675:	c3                   	ret    

00000676 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     676:	55                   	push   %ebp
     677:	89 e5                	mov    %esp,%ebp
     679:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
     67c:	8b 45 08             	mov    0x8(%ebp),%eax
     67f:	83 e8 08             	sub    $0x8,%eax
     682:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     685:	a1 c8 17 00 00       	mov    0x17c8,%eax
     68a:	89 45 fc             	mov    %eax,-0x4(%ebp)
     68d:	eb 24                	jmp    6b3 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
     692:	8b 00                	mov    (%eax),%eax
     694:	39 45 fc             	cmp    %eax,-0x4(%ebp)
     697:	72 12                	jb     6ab <free+0x35>
     699:	8b 45 f8             	mov    -0x8(%ebp),%eax
     69c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     69f:	77 24                	ja     6c5 <free+0x4f>
     6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6a4:	8b 00                	mov    (%eax),%eax
     6a6:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6a9:	72 1a                	jb     6c5 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6ae:	8b 00                	mov    (%eax),%eax
     6b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
     6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6b6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
     6b9:	76 d4                	jbe    68f <free+0x19>
     6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6be:	8b 00                	mov    (%eax),%eax
     6c0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     6c3:	73 ca                	jae    68f <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
     6c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6c8:	8b 40 04             	mov    0x4(%eax),%eax
     6cb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     6d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6d5:	01 c2                	add    %eax,%edx
     6d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6da:	8b 00                	mov    (%eax),%eax
     6dc:	39 c2                	cmp    %eax,%edx
     6de:	75 24                	jne    704 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
     6e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6e3:	8b 50 04             	mov    0x4(%eax),%edx
     6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6e9:	8b 00                	mov    (%eax),%eax
     6eb:	8b 40 04             	mov    0x4(%eax),%eax
     6ee:	01 c2                	add    %eax,%edx
     6f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
     6f3:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
     6f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
     6f9:	8b 00                	mov    (%eax),%eax
     6fb:	8b 10                	mov    (%eax),%edx
     6fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
     700:	89 10                	mov    %edx,(%eax)
     702:	eb 0a                	jmp    70e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
     704:	8b 45 fc             	mov    -0x4(%ebp),%eax
     707:	8b 10                	mov    (%eax),%edx
     709:	8b 45 f8             	mov    -0x8(%ebp),%eax
     70c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
     70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     711:	8b 40 04             	mov    0x4(%eax),%eax
     714:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
     71b:	8b 45 fc             	mov    -0x4(%ebp),%eax
     71e:	01 d0                	add    %edx,%eax
     720:	39 45 f8             	cmp    %eax,-0x8(%ebp)
     723:	75 20                	jne    745 <free+0xcf>
    p->s.size += bp->s.size;
     725:	8b 45 fc             	mov    -0x4(%ebp),%eax
     728:	8b 50 04             	mov    0x4(%eax),%edx
     72b:	8b 45 f8             	mov    -0x8(%ebp),%eax
     72e:	8b 40 04             	mov    0x4(%eax),%eax
     731:	01 c2                	add    %eax,%edx
     733:	8b 45 fc             	mov    -0x4(%ebp),%eax
     736:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     739:	8b 45 f8             	mov    -0x8(%ebp),%eax
     73c:	8b 10                	mov    (%eax),%edx
     73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
     741:	89 10                	mov    %edx,(%eax)
     743:	eb 08                	jmp    74d <free+0xd7>
  } else
    p->s.ptr = bp;
     745:	8b 45 fc             	mov    -0x4(%ebp),%eax
     748:	8b 55 f8             	mov    -0x8(%ebp),%edx
     74b:	89 10                	mov    %edx,(%eax)
  freep = p;
     74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
     750:	a3 c8 17 00 00       	mov    %eax,0x17c8
}
     755:	90                   	nop
     756:	c9                   	leave  
     757:	c3                   	ret    

00000758 <morecore>:

static Header*
morecore(uint nu)
{
     758:	55                   	push   %ebp
     759:	89 e5                	mov    %esp,%ebp
     75b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
     75e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
     765:	77 07                	ja     76e <morecore+0x16>
    nu = 4096;
     767:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
     76e:	8b 45 08             	mov    0x8(%ebp),%eax
     771:	c1 e0 03             	shl    $0x3,%eax
     774:	83 ec 0c             	sub    $0xc,%esp
     777:	50                   	push   %eax
     778:	e8 5d fc ff ff       	call   3da <sbrk>
     77d:	83 c4 10             	add    $0x10,%esp
     780:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
     783:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     787:	75 07                	jne    790 <morecore+0x38>
    return 0;
     789:	b8 00 00 00 00       	mov    $0x0,%eax
     78e:	eb 26                	jmp    7b6 <morecore+0x5e>
  hp = (Header*)p;
     790:	8b 45 f4             	mov    -0xc(%ebp),%eax
     793:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
     796:	8b 45 f0             	mov    -0x10(%ebp),%eax
     799:	8b 55 08             	mov    0x8(%ebp),%edx
     79c:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
     79f:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7a2:	83 c0 08             	add    $0x8,%eax
     7a5:	83 ec 0c             	sub    $0xc,%esp
     7a8:	50                   	push   %eax
     7a9:	e8 c8 fe ff ff       	call   676 <free>
     7ae:	83 c4 10             	add    $0x10,%esp
  return freep;
     7b1:	a1 c8 17 00 00       	mov    0x17c8,%eax
}
     7b6:	c9                   	leave  
     7b7:	c3                   	ret    

000007b8 <malloc>:

void*
malloc(uint nbytes)
{
     7b8:	55                   	push   %ebp
     7b9:	89 e5                	mov    %esp,%ebp
     7bb:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     7be:	8b 45 08             	mov    0x8(%ebp),%eax
     7c1:	83 c0 07             	add    $0x7,%eax
     7c4:	c1 e8 03             	shr    $0x3,%eax
     7c7:	83 c0 01             	add    $0x1,%eax
     7ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
     7cd:	a1 c8 17 00 00       	mov    0x17c8,%eax
     7d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
     7d5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     7d9:	75 23                	jne    7fe <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
     7db:	c7 45 f0 c0 17 00 00 	movl   $0x17c0,-0x10(%ebp)
     7e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7e5:	a3 c8 17 00 00       	mov    %eax,0x17c8
     7ea:	a1 c8 17 00 00       	mov    0x17c8,%eax
     7ef:	a3 c0 17 00 00       	mov    %eax,0x17c0
    base.s.size = 0;
     7f4:	c7 05 c4 17 00 00 00 	movl   $0x0,0x17c4
     7fb:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     7fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     801:	8b 00                	mov    (%eax),%eax
     803:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     806:	8b 45 f4             	mov    -0xc(%ebp),%eax
     809:	8b 40 04             	mov    0x4(%eax),%eax
     80c:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     80f:	77 4d                	ja     85e <malloc+0xa6>
      if(p->s.size == nunits)
     811:	8b 45 f4             	mov    -0xc(%ebp),%eax
     814:	8b 40 04             	mov    0x4(%eax),%eax
     817:	39 45 ec             	cmp    %eax,-0x14(%ebp)
     81a:	75 0c                	jne    828 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
     81c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     81f:	8b 10                	mov    (%eax),%edx
     821:	8b 45 f0             	mov    -0x10(%ebp),%eax
     824:	89 10                	mov    %edx,(%eax)
     826:	eb 26                	jmp    84e <malloc+0x96>
      else {
        p->s.size -= nunits;
     828:	8b 45 f4             	mov    -0xc(%ebp),%eax
     82b:	8b 40 04             	mov    0x4(%eax),%eax
     82e:	2b 45 ec             	sub    -0x14(%ebp),%eax
     831:	89 c2                	mov    %eax,%edx
     833:	8b 45 f4             	mov    -0xc(%ebp),%eax
     836:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
     839:	8b 45 f4             	mov    -0xc(%ebp),%eax
     83c:	8b 40 04             	mov    0x4(%eax),%eax
     83f:	c1 e0 03             	shl    $0x3,%eax
     842:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
     845:	8b 45 f4             	mov    -0xc(%ebp),%eax
     848:	8b 55 ec             	mov    -0x14(%ebp),%edx
     84b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
     84e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     851:	a3 c8 17 00 00       	mov    %eax,0x17c8
      return (void*)(p + 1);
     856:	8b 45 f4             	mov    -0xc(%ebp),%eax
     859:	83 c0 08             	add    $0x8,%eax
     85c:	eb 3b                	jmp    899 <malloc+0xe1>
    }
    if(p == freep)
     85e:	a1 c8 17 00 00       	mov    0x17c8,%eax
     863:	39 45 f4             	cmp    %eax,-0xc(%ebp)
     866:	75 1e                	jne    886 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
     868:	83 ec 0c             	sub    $0xc,%esp
     86b:	ff 75 ec             	pushl  -0x14(%ebp)
     86e:	e8 e5 fe ff ff       	call   758 <morecore>
     873:	83 c4 10             	add    $0x10,%esp
     876:	89 45 f4             	mov    %eax,-0xc(%ebp)
     879:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     87d:	75 07                	jne    886 <malloc+0xce>
        return 0;
     87f:	b8 00 00 00 00       	mov    $0x0,%eax
     884:	eb 13                	jmp    899 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     886:	8b 45 f4             	mov    -0xc(%ebp),%eax
     889:	89 45 f0             	mov    %eax,-0x10(%ebp)
     88c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     88f:	8b 00                	mov    (%eax),%eax
     891:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
     894:	e9 6d ff ff ff       	jmp    806 <malloc+0x4e>
  }
}
     899:	c9                   	leave  
     89a:	c3                   	ret    

0000089b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
         unsigned long long num, unsigned base, int width, int padc)
{
     89b:	55                   	push   %ebp
     89c:	89 e5                	mov    %esp,%ebp
     89e:	53                   	push   %ebx
     89f:	83 ec 14             	sub    $0x14,%esp
     8a2:	8b 45 10             	mov    0x10(%ebp),%eax
     8a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
     8a8:	8b 45 14             	mov    0x14(%ebp),%eax
     8ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
  // first recursively print all preceding (more significant) digits
  if (num >= base)
     8ae:	8b 45 18             	mov    0x18(%ebp),%eax
     8b1:	ba 00 00 00 00       	mov    $0x0,%edx
     8b6:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     8b9:	72 55                	jb     910 <printnum+0x75>
     8bb:	39 55 f4             	cmp    %edx,-0xc(%ebp)
     8be:	77 05                	ja     8c5 <printnum+0x2a>
     8c0:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     8c3:	72 4b                	jb     910 <printnum+0x75>
    printnum(putch, putdat, num / base, base, width - 1, padc);
     8c5:	8b 45 1c             	mov    0x1c(%ebp),%eax
     8c8:	8d 58 ff             	lea    -0x1(%eax),%ebx
     8cb:	8b 45 18             	mov    0x18(%ebp),%eax
     8ce:	ba 00 00 00 00       	mov    $0x0,%edx
     8d3:	52                   	push   %edx
     8d4:	50                   	push   %eax
     8d5:	ff 75 f4             	pushl  -0xc(%ebp)
     8d8:	ff 75 f0             	pushl  -0x10(%ebp)
     8db:	e8 a0 05 00 00       	call   e80 <__udivdi3>
     8e0:	83 c4 10             	add    $0x10,%esp
     8e3:	83 ec 04             	sub    $0x4,%esp
     8e6:	ff 75 20             	pushl  0x20(%ebp)
     8e9:	53                   	push   %ebx
     8ea:	ff 75 18             	pushl  0x18(%ebp)
     8ed:	52                   	push   %edx
     8ee:	50                   	push   %eax
     8ef:	ff 75 0c             	pushl  0xc(%ebp)
     8f2:	ff 75 08             	pushl  0x8(%ebp)
     8f5:	e8 a1 ff ff ff       	call   89b <printnum>
     8fa:	83 c4 20             	add    $0x20,%esp
     8fd:	eb 1b                	jmp    91a <printnum+0x7f>
  else {
    // print any needed pad characters before first digit
    while (--width > 0)
      putch(padc, putdat);
     8ff:	83 ec 08             	sub    $0x8,%esp
     902:	ff 75 0c             	pushl  0xc(%ebp)
     905:	ff 75 20             	pushl  0x20(%ebp)
     908:	8b 45 08             	mov    0x8(%ebp),%eax
     90b:	ff d0                	call   *%eax
     90d:	83 c4 10             	add    $0x10,%esp
    while (--width > 0)
     910:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
     914:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
     918:	7f e5                	jg     8ff <printnum+0x64>
  }

  // then print this (the least significant) digit
  putch("0123456789abcdef"[num % base], putdat);
     91a:	8b 4d 18             	mov    0x18(%ebp),%ecx
     91d:	bb 00 00 00 00       	mov    $0x0,%ebx
     922:	8b 45 f0             	mov    -0x10(%ebp),%eax
     925:	8b 55 f4             	mov    -0xc(%ebp),%edx
     928:	53                   	push   %ebx
     929:	51                   	push   %ecx
     92a:	52                   	push   %edx
     92b:	50                   	push   %eax
     92c:	e8 6f 06 00 00       	call   fa0 <__umoddi3>
     931:	83 c4 10             	add    $0x10,%esp
     934:	05 a0 11 00 00       	add    $0x11a0,%eax
     939:	0f b6 00             	movzbl (%eax),%eax
     93c:	0f be c0             	movsbl %al,%eax
     93f:	83 ec 08             	sub    $0x8,%esp
     942:	ff 75 0c             	pushl  0xc(%ebp)
     945:	50                   	push   %eax
     946:	8b 45 08             	mov    0x8(%ebp),%eax
     949:	ff d0                	call   *%eax
     94b:	83 c4 10             	add    $0x10,%esp
}
     94e:	90                   	nop
     94f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     952:	c9                   	leave  
     953:	c3                   	ret    

00000954 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
     954:	55                   	push   %ebp
     955:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     957:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     95b:	7e 14                	jle    971 <getuint+0x1d>
    return va_arg(*ap, unsigned long long);
     95d:	8b 45 08             	mov    0x8(%ebp),%eax
     960:	8b 00                	mov    (%eax),%eax
     962:	8d 48 08             	lea    0x8(%eax),%ecx
     965:	8b 55 08             	mov    0x8(%ebp),%edx
     968:	89 0a                	mov    %ecx,(%edx)
     96a:	8b 50 04             	mov    0x4(%eax),%edx
     96d:	8b 00                	mov    (%eax),%eax
     96f:	eb 30                	jmp    9a1 <getuint+0x4d>
  else if (lflag)
     971:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     975:	74 16                	je     98d <getuint+0x39>
    return va_arg(*ap, unsigned long);
     977:	8b 45 08             	mov    0x8(%ebp),%eax
     97a:	8b 00                	mov    (%eax),%eax
     97c:	8d 48 04             	lea    0x4(%eax),%ecx
     97f:	8b 55 08             	mov    0x8(%ebp),%edx
     982:	89 0a                	mov    %ecx,(%edx)
     984:	8b 00                	mov    (%eax),%eax
     986:	ba 00 00 00 00       	mov    $0x0,%edx
     98b:	eb 14                	jmp    9a1 <getuint+0x4d>
  else
    return va_arg(*ap, unsigned int);
     98d:	8b 45 08             	mov    0x8(%ebp),%eax
     990:	8b 00                	mov    (%eax),%eax
     992:	8d 48 04             	lea    0x4(%eax),%ecx
     995:	8b 55 08             	mov    0x8(%ebp),%edx
     998:	89 0a                	mov    %ecx,(%edx)
     99a:	8b 00                	mov    (%eax),%eax
     99c:	ba 00 00 00 00       	mov    $0x0,%edx
}
     9a1:	5d                   	pop    %ebp
     9a2:	c3                   	ret    

000009a3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
     9a3:	55                   	push   %ebp
     9a4:	89 e5                	mov    %esp,%ebp
  if (lflag >= 2)
     9a6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
     9aa:	7e 14                	jle    9c0 <getint+0x1d>
    return va_arg(*ap, long long);
     9ac:	8b 45 08             	mov    0x8(%ebp),%eax
     9af:	8b 00                	mov    (%eax),%eax
     9b1:	8d 48 08             	lea    0x8(%eax),%ecx
     9b4:	8b 55 08             	mov    0x8(%ebp),%edx
     9b7:	89 0a                	mov    %ecx,(%edx)
     9b9:	8b 50 04             	mov    0x4(%eax),%edx
     9bc:	8b 00                	mov    (%eax),%eax
     9be:	eb 28                	jmp    9e8 <getint+0x45>
  else if (lflag)
     9c0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     9c4:	74 12                	je     9d8 <getint+0x35>
    return va_arg(*ap, long);
     9c6:	8b 45 08             	mov    0x8(%ebp),%eax
     9c9:	8b 00                	mov    (%eax),%eax
     9cb:	8d 48 04             	lea    0x4(%eax),%ecx
     9ce:	8b 55 08             	mov    0x8(%ebp),%edx
     9d1:	89 0a                	mov    %ecx,(%edx)
     9d3:	8b 00                	mov    (%eax),%eax
     9d5:	99                   	cltd   
     9d6:	eb 10                	jmp    9e8 <getint+0x45>
  else
    return va_arg(*ap, int);
     9d8:	8b 45 08             	mov    0x8(%ebp),%eax
     9db:	8b 00                	mov    (%eax),%eax
     9dd:	8d 48 04             	lea    0x4(%eax),%ecx
     9e0:	8b 55 08             	mov    0x8(%ebp),%edx
     9e3:	89 0a                	mov    %ecx,(%edx)
     9e5:	8b 00                	mov    (%eax),%eax
     9e7:	99                   	cltd   
}
     9e8:	5d                   	pop    %ebp
     9e9:	c3                   	ret    

000009ea <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
     9ea:	55                   	push   %ebp
     9eb:	89 e5                	mov    %esp,%ebp
     9ed:	56                   	push   %esi
     9ee:	53                   	push   %ebx
     9ef:	83 ec 20             	sub    $0x20,%esp
  unsigned long long num;
  int base, lflag, width, precision, altflag;
  char padc;

  while (1) {
    while ((ch = *(unsigned char*)fmt++) != '%') {
     9f2:	eb 17                	jmp    a0b <vprintfmt+0x21>
      if (ch == '\0')
     9f4:	85 db                	test   %ebx,%ebx
     9f6:	0f 84 a0 03 00 00    	je     d9c <vprintfmt+0x3b2>
        return;
      putch(ch, putdat);
     9fc:	83 ec 08             	sub    $0x8,%esp
     9ff:	ff 75 0c             	pushl  0xc(%ebp)
     a02:	53                   	push   %ebx
     a03:	8b 45 08             	mov    0x8(%ebp),%eax
     a06:	ff d0                	call   *%eax
     a08:	83 c4 10             	add    $0x10,%esp
    while ((ch = *(unsigned char*)fmt++) != '%') {
     a0b:	8b 45 10             	mov    0x10(%ebp),%eax
     a0e:	8d 50 01             	lea    0x1(%eax),%edx
     a11:	89 55 10             	mov    %edx,0x10(%ebp)
     a14:	0f b6 00             	movzbl (%eax),%eax
     a17:	0f b6 d8             	movzbl %al,%ebx
     a1a:	83 fb 25             	cmp    $0x25,%ebx
     a1d:	75 d5                	jne    9f4 <vprintfmt+0xa>
    }

    // Process a %-escape sequence
    padc = ' ';
     a1f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
    width = -1;
     a23:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
    precision = -1;
     a2a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
    lflag = 0;
     a31:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    altflag = 0;
     a38:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
reswitch:
    switch (ch = *(unsigned char*)fmt++) {
     a3f:	8b 45 10             	mov    0x10(%ebp),%eax
     a42:	8d 50 01             	lea    0x1(%eax),%edx
     a45:	89 55 10             	mov    %edx,0x10(%ebp)
     a48:	0f b6 00             	movzbl (%eax),%eax
     a4b:	0f b6 d8             	movzbl %al,%ebx
     a4e:	8d 43 dd             	lea    -0x23(%ebx),%eax
     a51:	83 f8 55             	cmp    $0x55,%eax
     a54:	0f 87 15 03 00 00    	ja     d6f <vprintfmt+0x385>
     a5a:	8b 04 85 c4 11 00 00 	mov    0x11c4(,%eax,4),%eax
     a61:	ff e0                	jmp    *%eax

    // flag to pad on the right
    case '-':
      padc = '-';
     a63:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
      goto reswitch;
     a67:	eb d6                	jmp    a3f <vprintfmt+0x55>

    // flag to pad with 0's instead of spaces
    case '0':
      padc = '0';
     a69:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
      goto reswitch;
     a6d:	eb d0                	jmp    a3f <vprintfmt+0x55>
    case '5':
    case '6':
    case '7':
    case '8':
    case '9':
      for (precision = 0;; ++fmt) {
     a6f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
        precision = precision * 10 + ch - '0';
     a76:	8b 55 e0             	mov    -0x20(%ebp),%edx
     a79:	89 d0                	mov    %edx,%eax
     a7b:	c1 e0 02             	shl    $0x2,%eax
     a7e:	01 d0                	add    %edx,%eax
     a80:	01 c0                	add    %eax,%eax
     a82:	01 d8                	add    %ebx,%eax
     a84:	83 e8 30             	sub    $0x30,%eax
     a87:	89 45 e0             	mov    %eax,-0x20(%ebp)
        ch = *fmt;
     a8a:	8b 45 10             	mov    0x10(%ebp),%eax
     a8d:	0f b6 00             	movzbl (%eax),%eax
     a90:	0f be d8             	movsbl %al,%ebx
        if (ch < '0' || ch > '9')
     a93:	83 fb 2f             	cmp    $0x2f,%ebx
     a96:	7e 39                	jle    ad1 <vprintfmt+0xe7>
     a98:	83 fb 39             	cmp    $0x39,%ebx
     a9b:	7f 34                	jg     ad1 <vprintfmt+0xe7>
      for (precision = 0;; ++fmt) {
     a9d:	83 45 10 01          	addl   $0x1,0x10(%ebp)
        precision = precision * 10 + ch - '0';
     aa1:	eb d3                	jmp    a76 <vprintfmt+0x8c>
          break;
      }
      goto process_precision;

    case '*':
      precision = va_arg(ap, int);
     aa3:	8b 45 14             	mov    0x14(%ebp),%eax
     aa6:	8d 50 04             	lea    0x4(%eax),%edx
     aa9:	89 55 14             	mov    %edx,0x14(%ebp)
     aac:	8b 00                	mov    (%eax),%eax
     aae:	89 45 e0             	mov    %eax,-0x20(%ebp)
      goto process_precision;
     ab1:	eb 1f                	jmp    ad2 <vprintfmt+0xe8>

    case '.':
      if (width < 0)
     ab3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     ab7:	79 86                	jns    a3f <vprintfmt+0x55>
        width = 0;
     ab9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      goto reswitch;
     ac0:	e9 7a ff ff ff       	jmp    a3f <vprintfmt+0x55>

    case '#':
      altflag = 1;
     ac5:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
      goto reswitch;
     acc:	e9 6e ff ff ff       	jmp    a3f <vprintfmt+0x55>
      goto process_precision;
     ad1:	90                   	nop

process_precision:
      if (width < 0)
     ad2:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     ad6:	0f 89 63 ff ff ff    	jns    a3f <vprintfmt+0x55>
        width = precision, precision = -1;
     adc:	8b 45 e0             	mov    -0x20(%ebp),%eax
     adf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ae2:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
      goto reswitch;
     ae9:	e9 51 ff ff ff       	jmp    a3f <vprintfmt+0x55>

    // long flag (doubled for long long)
    case 'l':
      lflag++;
     aee:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      goto reswitch;
     af2:	e9 48 ff ff ff       	jmp    a3f <vprintfmt+0x55>

    // character
    case 'c':
      putch(va_arg(ap, int), putdat);
     af7:	8b 45 14             	mov    0x14(%ebp),%eax
     afa:	8d 50 04             	lea    0x4(%eax),%edx
     afd:	89 55 14             	mov    %edx,0x14(%ebp)
     b00:	8b 00                	mov    (%eax),%eax
     b02:	83 ec 08             	sub    $0x8,%esp
     b05:	ff 75 0c             	pushl  0xc(%ebp)
     b08:	50                   	push   %eax
     b09:	8b 45 08             	mov    0x8(%ebp),%eax
     b0c:	ff d0                	call   *%eax
     b0e:	83 c4 10             	add    $0x10,%esp
      break;
     b11:	e9 81 02 00 00       	jmp    d97 <vprintfmt+0x3ad>

    // error message
    case 'e':
      err = va_arg(ap, int);
     b16:	8b 45 14             	mov    0x14(%ebp),%eax
     b19:	8d 50 04             	lea    0x4(%eax),%edx
     b1c:	89 55 14             	mov    %edx,0x14(%ebp)
     b1f:	8b 18                	mov    (%eax),%ebx
      if (err < 0)
     b21:	85 db                	test   %ebx,%ebx
     b23:	79 02                	jns    b27 <vprintfmt+0x13d>
        err = -err;
     b25:	f7 db                	neg    %ebx
      if (err >= MAXERROR || (p = error_string[err]) == NULL)
     b27:	83 fb 0f             	cmp    $0xf,%ebx
     b2a:	7f 0b                	jg     b37 <vprintfmt+0x14d>
     b2c:	8b 34 9d 60 11 00 00 	mov    0x1160(,%ebx,4),%esi
     b33:	85 f6                	test   %esi,%esi
     b35:	75 19                	jne    b50 <vprintfmt+0x166>
        printfmt(putch, putdat, "error %d", err);
     b37:	53                   	push   %ebx
     b38:	68 b1 11 00 00       	push   $0x11b1
     b3d:	ff 75 0c             	pushl  0xc(%ebp)
     b40:	ff 75 08             	pushl  0x8(%ebp)
     b43:	e8 5c 02 00 00       	call   da4 <printfmt>
     b48:	83 c4 10             	add    $0x10,%esp
      else
        printfmt(putch, putdat, "%s", p);
      break;
     b4b:	e9 47 02 00 00       	jmp    d97 <vprintfmt+0x3ad>
        printfmt(putch, putdat, "%s", p);
     b50:	56                   	push   %esi
     b51:	68 ba 11 00 00       	push   $0x11ba
     b56:	ff 75 0c             	pushl  0xc(%ebp)
     b59:	ff 75 08             	pushl  0x8(%ebp)
     b5c:	e8 43 02 00 00       	call   da4 <printfmt>
     b61:	83 c4 10             	add    $0x10,%esp
      break;
     b64:	e9 2e 02 00 00       	jmp    d97 <vprintfmt+0x3ad>

    // string
    case 's':
      if ((p = va_arg(ap, char *)) == NULL)
     b69:	8b 45 14             	mov    0x14(%ebp),%eax
     b6c:	8d 50 04             	lea    0x4(%eax),%edx
     b6f:	89 55 14             	mov    %edx,0x14(%ebp)
     b72:	8b 30                	mov    (%eax),%esi
     b74:	85 f6                	test   %esi,%esi
     b76:	75 05                	jne    b7d <vprintfmt+0x193>
        p = "(null)";
     b78:	be bd 11 00 00       	mov    $0x11bd,%esi
      if (width > 0 && padc != '-')
     b7d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     b81:	7e 6f                	jle    bf2 <vprintfmt+0x208>
     b83:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
     b87:	74 69                	je     bf2 <vprintfmt+0x208>
        for (width -= strnlen(p, precision); width > 0; width--)
     b89:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b8c:	83 ec 08             	sub    $0x8,%esp
     b8f:	50                   	push   %eax
     b90:	56                   	push   %esi
     b91:	e8 f1 f5 ff ff       	call   187 <strnlen>
     b96:	83 c4 10             	add    $0x10,%esp
     b99:	29 45 e4             	sub    %eax,-0x1c(%ebp)
     b9c:	eb 17                	jmp    bb5 <vprintfmt+0x1cb>
          putch(padc, putdat);
     b9e:	0f be 45 db          	movsbl -0x25(%ebp),%eax
     ba2:	83 ec 08             	sub    $0x8,%esp
     ba5:	ff 75 0c             	pushl  0xc(%ebp)
     ba8:	50                   	push   %eax
     ba9:	8b 45 08             	mov    0x8(%ebp),%eax
     bac:	ff d0                	call   *%eax
     bae:	83 c4 10             	add    $0x10,%esp
        for (width -= strnlen(p, precision); width > 0; width--)
     bb1:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     bb5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     bb9:	7f e3                	jg     b9e <vprintfmt+0x1b4>
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     bbb:	eb 35                	jmp    bf2 <vprintfmt+0x208>
        if (altflag && (ch < ' ' || ch > '~'))
     bbd:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     bc1:	74 1c                	je     bdf <vprintfmt+0x1f5>
     bc3:	83 fb 1f             	cmp    $0x1f,%ebx
     bc6:	7e 05                	jle    bcd <vprintfmt+0x1e3>
     bc8:	83 fb 7e             	cmp    $0x7e,%ebx
     bcb:	7e 12                	jle    bdf <vprintfmt+0x1f5>
          putch('?', putdat);
     bcd:	83 ec 08             	sub    $0x8,%esp
     bd0:	ff 75 0c             	pushl  0xc(%ebp)
     bd3:	6a 3f                	push   $0x3f
     bd5:	8b 45 08             	mov    0x8(%ebp),%eax
     bd8:	ff d0                	call   *%eax
     bda:	83 c4 10             	add    $0x10,%esp
     bdd:	eb 0f                	jmp    bee <vprintfmt+0x204>
        else
          putch(ch, putdat);
     bdf:	83 ec 08             	sub    $0x8,%esp
     be2:	ff 75 0c             	pushl  0xc(%ebp)
     be5:	53                   	push   %ebx
     be6:	8b 45 08             	mov    0x8(%ebp),%eax
     be9:	ff d0                	call   *%eax
     beb:	83 c4 10             	add    $0x10,%esp
      for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
     bee:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     bf2:	89 f0                	mov    %esi,%eax
     bf4:	8d 70 01             	lea    0x1(%eax),%esi
     bf7:	0f b6 00             	movzbl (%eax),%eax
     bfa:	0f be d8             	movsbl %al,%ebx
     bfd:	85 db                	test   %ebx,%ebx
     bff:	74 26                	je     c27 <vprintfmt+0x23d>
     c01:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     c05:	78 b6                	js     bbd <vprintfmt+0x1d3>
     c07:	83 6d e0 01          	subl   $0x1,-0x20(%ebp)
     c0b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     c0f:	79 ac                	jns    bbd <vprintfmt+0x1d3>
      for (; width > 0; width--)
     c11:	eb 14                	jmp    c27 <vprintfmt+0x23d>
        putch(' ', putdat);
     c13:	83 ec 08             	sub    $0x8,%esp
     c16:	ff 75 0c             	pushl  0xc(%ebp)
     c19:	6a 20                	push   $0x20
     c1b:	8b 45 08             	mov    0x8(%ebp),%eax
     c1e:	ff d0                	call   *%eax
     c20:	83 c4 10             	add    $0x10,%esp
      for (; width > 0; width--)
     c23:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
     c27:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c2b:	7f e6                	jg     c13 <vprintfmt+0x229>
      break;
     c2d:	e9 65 01 00 00       	jmp    d97 <vprintfmt+0x3ad>

    // (signed) decimal
    case 'd':
      num = getint(&ap, lflag);
     c32:	83 ec 08             	sub    $0x8,%esp
     c35:	ff 75 e8             	pushl  -0x18(%ebp)
     c38:	8d 45 14             	lea    0x14(%ebp),%eax
     c3b:	50                   	push   %eax
     c3c:	e8 62 fd ff ff       	call   9a3 <getint>
     c41:	83 c4 10             	add    $0x10,%esp
     c44:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c47:	89 55 f4             	mov    %edx,-0xc(%ebp)
      if ((long long)num < 0) {
     c4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c50:	85 d2                	test   %edx,%edx
     c52:	79 23                	jns    c77 <vprintfmt+0x28d>
        putch('-', putdat);
     c54:	83 ec 08             	sub    $0x8,%esp
     c57:	ff 75 0c             	pushl  0xc(%ebp)
     c5a:	6a 2d                	push   $0x2d
     c5c:	8b 45 08             	mov    0x8(%ebp),%eax
     c5f:	ff d0                	call   *%eax
     c61:	83 c4 10             	add    $0x10,%esp
        num = -(long long)num;
     c64:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c67:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c6a:	f7 d8                	neg    %eax
     c6c:	83 d2 00             	adc    $0x0,%edx
     c6f:	f7 da                	neg    %edx
     c71:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c74:	89 55 f4             	mov    %edx,-0xc(%ebp)
      }
      base = 10;
     c77:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     c7e:	e9 b6 00 00 00       	jmp    d39 <vprintfmt+0x34f>

    // unsigned decimal
    case 'u':
      num = getuint(&ap, lflag);
     c83:	83 ec 08             	sub    $0x8,%esp
     c86:	ff 75 e8             	pushl  -0x18(%ebp)
     c89:	8d 45 14             	lea    0x14(%ebp),%eax
     c8c:	50                   	push   %eax
     c8d:	e8 c2 fc ff ff       	call   954 <getuint>
     c92:	83 c4 10             	add    $0x10,%esp
     c95:	89 45 f0             	mov    %eax,-0x10(%ebp)
     c98:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 10;
     c9b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
      goto number;
     ca2:	e9 92 00 00 00       	jmp    d39 <vprintfmt+0x34f>

    // (unsigned) octal
    case 'o':
      // Replace this with your code
      putch('X', putdat);
     ca7:	83 ec 08             	sub    $0x8,%esp
     caa:	ff 75 0c             	pushl  0xc(%ebp)
     cad:	6a 58                	push   $0x58
     caf:	8b 45 08             	mov    0x8(%ebp),%eax
     cb2:	ff d0                	call   *%eax
     cb4:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     cb7:	83 ec 08             	sub    $0x8,%esp
     cba:	ff 75 0c             	pushl  0xc(%ebp)
     cbd:	6a 58                	push   $0x58
     cbf:	8b 45 08             	mov    0x8(%ebp),%eax
     cc2:	ff d0                	call   *%eax
     cc4:	83 c4 10             	add    $0x10,%esp
      putch('X', putdat);
     cc7:	83 ec 08             	sub    $0x8,%esp
     cca:	ff 75 0c             	pushl  0xc(%ebp)
     ccd:	6a 58                	push   $0x58
     ccf:	8b 45 08             	mov    0x8(%ebp),%eax
     cd2:	ff d0                	call   *%eax
     cd4:	83 c4 10             	add    $0x10,%esp
      break;
     cd7:	e9 bb 00 00 00       	jmp    d97 <vprintfmt+0x3ad>

    // pointer
    case 'p':
      putch('0', putdat);
     cdc:	83 ec 08             	sub    $0x8,%esp
     cdf:	ff 75 0c             	pushl  0xc(%ebp)
     ce2:	6a 30                	push   $0x30
     ce4:	8b 45 08             	mov    0x8(%ebp),%eax
     ce7:	ff d0                	call   *%eax
     ce9:	83 c4 10             	add    $0x10,%esp
      putch('x', putdat);
     cec:	83 ec 08             	sub    $0x8,%esp
     cef:	ff 75 0c             	pushl  0xc(%ebp)
     cf2:	6a 78                	push   $0x78
     cf4:	8b 45 08             	mov    0x8(%ebp),%eax
     cf7:	ff d0                	call   *%eax
     cf9:	83 c4 10             	add    $0x10,%esp
      num = (unsigned long long)
            (uint)va_arg(ap, void *);
     cfc:	8b 45 14             	mov    0x14(%ebp),%eax
     cff:	8d 50 04             	lea    0x4(%eax),%edx
     d02:	89 55 14             	mov    %edx,0x14(%ebp)
     d05:	8b 00                	mov    (%eax),%eax
      num = (unsigned long long)
     d07:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
      base = 16;
     d11:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
      goto number;
     d18:	eb 1f                	jmp    d39 <vprintfmt+0x34f>

    // (unsigned) hexadecimal
    case 'x':
      num = getuint(&ap, lflag);
     d1a:	83 ec 08             	sub    $0x8,%esp
     d1d:	ff 75 e8             	pushl  -0x18(%ebp)
     d20:	8d 45 14             	lea    0x14(%ebp),%eax
     d23:	50                   	push   %eax
     d24:	e8 2b fc ff ff       	call   954 <getuint>
     d29:	83 c4 10             	add    $0x10,%esp
     d2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
     d2f:	89 55 f4             	mov    %edx,-0xc(%ebp)
      base = 16;
     d32:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
number:
      printnum(putch, putdat, num, base, width, padc);
     d39:	0f be 55 db          	movsbl -0x25(%ebp),%edx
     d3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d40:	83 ec 04             	sub    $0x4,%esp
     d43:	52                   	push   %edx
     d44:	ff 75 e4             	pushl  -0x1c(%ebp)
     d47:	50                   	push   %eax
     d48:	ff 75 f4             	pushl  -0xc(%ebp)
     d4b:	ff 75 f0             	pushl  -0x10(%ebp)
     d4e:	ff 75 0c             	pushl  0xc(%ebp)
     d51:	ff 75 08             	pushl  0x8(%ebp)
     d54:	e8 42 fb ff ff       	call   89b <printnum>
     d59:	83 c4 20             	add    $0x20,%esp
      break;
     d5c:	eb 39                	jmp    d97 <vprintfmt+0x3ad>

    // escaped '%' character
    case '%':
      putch(ch, putdat);
     d5e:	83 ec 08             	sub    $0x8,%esp
     d61:	ff 75 0c             	pushl  0xc(%ebp)
     d64:	53                   	push   %ebx
     d65:	8b 45 08             	mov    0x8(%ebp),%eax
     d68:	ff d0                	call   *%eax
     d6a:	83 c4 10             	add    $0x10,%esp
      break;
     d6d:	eb 28                	jmp    d97 <vprintfmt+0x3ad>

    // unrecognized escape sequence - just print it literally
    default:
      putch('%', putdat);
     d6f:	83 ec 08             	sub    $0x8,%esp
     d72:	ff 75 0c             	pushl  0xc(%ebp)
     d75:	6a 25                	push   $0x25
     d77:	8b 45 08             	mov    0x8(%ebp),%eax
     d7a:	ff d0                	call   *%eax
     d7c:	83 c4 10             	add    $0x10,%esp
      for (fmt--; fmt[-1] != '%'; fmt--)
     d7f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d83:	eb 04                	jmp    d89 <vprintfmt+0x39f>
     d85:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
     d89:	8b 45 10             	mov    0x10(%ebp),%eax
     d8c:	83 e8 01             	sub    $0x1,%eax
     d8f:	0f b6 00             	movzbl (%eax),%eax
     d92:	3c 25                	cmp    $0x25,%al
     d94:	75 ef                	jne    d85 <vprintfmt+0x39b>
        /* do nothing */;
      break;
     d96:	90                   	nop
    while ((ch = *(unsigned char*)fmt++) != '%') {
     d97:	e9 6f fc ff ff       	jmp    a0b <vprintfmt+0x21>
        return;
     d9c:	90                   	nop
    }
  }
}
     d9d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     da0:	5b                   	pop    %ebx
     da1:	5e                   	pop    %esi
     da2:	5d                   	pop    %ebp
     da3:	c3                   	ret    

00000da4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
     da4:	55                   	push   %ebp
     da5:	89 e5                	mov    %esp,%ebp
     da7:	83 ec 18             	sub    $0x18,%esp
  va_list ap;

  va_start(ap, fmt);
     daa:	8d 45 14             	lea    0x14(%ebp),%eax
     dad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  vprintfmt(putch, putdat, fmt, ap);
     db0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     db3:	50                   	push   %eax
     db4:	ff 75 10             	pushl  0x10(%ebp)
     db7:	ff 75 0c             	pushl  0xc(%ebp)
     dba:	ff 75 08             	pushl  0x8(%ebp)
     dbd:	e8 28 fc ff ff       	call   9ea <vprintfmt>
     dc2:	83 c4 10             	add    $0x10,%esp
  va_end(ap);
}
     dc5:	90                   	nop
     dc6:	c9                   	leave  
     dc7:	c3                   	ret    

00000dc8 <sprintputch>:
  int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
     dc8:	55                   	push   %ebp
     dc9:	89 e5                	mov    %esp,%ebp
  b->cnt++;
     dcb:	8b 45 0c             	mov    0xc(%ebp),%eax
     dce:	8b 40 08             	mov    0x8(%eax),%eax
     dd1:	8d 50 01             	lea    0x1(%eax),%edx
     dd4:	8b 45 0c             	mov    0xc(%ebp),%eax
     dd7:	89 50 08             	mov    %edx,0x8(%eax)
  if (b->buf < b->ebuf)
     dda:	8b 45 0c             	mov    0xc(%ebp),%eax
     ddd:	8b 10                	mov    (%eax),%edx
     ddf:	8b 45 0c             	mov    0xc(%ebp),%eax
     de2:	8b 40 04             	mov    0x4(%eax),%eax
     de5:	39 c2                	cmp    %eax,%edx
     de7:	73 12                	jae    dfb <sprintputch+0x33>
    *b->buf++ = ch;
     de9:	8b 45 0c             	mov    0xc(%ebp),%eax
     dec:	8b 00                	mov    (%eax),%eax
     dee:	8d 48 01             	lea    0x1(%eax),%ecx
     df1:	8b 55 0c             	mov    0xc(%ebp),%edx
     df4:	89 0a                	mov    %ecx,(%edx)
     df6:	8b 55 08             	mov    0x8(%ebp),%edx
     df9:	88 10                	mov    %dl,(%eax)
}
     dfb:	90                   	nop
     dfc:	5d                   	pop    %ebp
     dfd:	c3                   	ret    

00000dfe <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
     dfe:	55                   	push   %ebp
     dff:	89 e5                	mov    %esp,%ebp
     e01:	83 ec 18             	sub    $0x18,%esp
  struct sprintbuf b = { buf, buf+n-1, 0 };
     e04:	8b 45 08             	mov    0x8(%ebp),%eax
     e07:	89 45 ec             	mov    %eax,-0x14(%ebp)
     e0a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e0d:	8d 50 ff             	lea    -0x1(%eax),%edx
     e10:	8b 45 08             	mov    0x8(%ebp),%eax
     e13:	01 d0                	add    %edx,%eax
     e15:	89 45 f0             	mov    %eax,-0x10(%ebp)
     e18:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  if (buf == NULL || n < 1)
     e1f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     e23:	74 06                	je     e2b <vsnprintf+0x2d>
     e25:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
     e29:	7f 07                	jg     e32 <vsnprintf+0x34>
    return -E_INVAL;
     e2b:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
     e30:	eb 20                	jmp    e52 <vsnprintf+0x54>

  // print the string to the buffer
  vprintfmt((void*)sprintputch, &b, fmt, ap);
     e32:	ff 75 14             	pushl  0x14(%ebp)
     e35:	ff 75 10             	pushl  0x10(%ebp)
     e38:	8d 45 ec             	lea    -0x14(%ebp),%eax
     e3b:	50                   	push   %eax
     e3c:	68 c8 0d 00 00       	push   $0xdc8
     e41:	e8 a4 fb ff ff       	call   9ea <vprintfmt>
     e46:	83 c4 10             	add    $0x10,%esp

  // null terminate the buffer
  *b.buf = '\0';
     e49:	8b 45 ec             	mov    -0x14(%ebp),%eax
     e4c:	c6 00 00             	movb   $0x0,(%eax)

  return b.cnt;
     e4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e52:	c9                   	leave  
     e53:	c3                   	ret    

00000e54 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
     e54:	55                   	push   %ebp
     e55:	89 e5                	mov    %esp,%ebp
     e57:	83 ec 18             	sub    $0x18,%esp
  va_list ap;
  int rc;

  va_start(ap, fmt);
     e5a:	8d 45 14             	lea    0x14(%ebp),%eax
     e5d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  rc = vsnprintf(buf, n, fmt, ap);
     e60:	8b 45 f0             	mov    -0x10(%ebp),%eax
     e63:	50                   	push   %eax
     e64:	ff 75 10             	pushl  0x10(%ebp)
     e67:	ff 75 0c             	pushl  0xc(%ebp)
     e6a:	ff 75 08             	pushl  0x8(%ebp)
     e6d:	e8 8c ff ff ff       	call   dfe <vsnprintf>
     e72:	83 c4 10             	add    $0x10,%esp
     e75:	89 45 f4             	mov    %eax,-0xc(%ebp)
  va_end(ap);

  return rc;
     e78:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     e7b:	c9                   	leave  
     e7c:	c3                   	ret    
     e7d:	66 90                	xchg   %ax,%ax
     e7f:	90                   	nop

00000e80 <__udivdi3>:
     e80:	55                   	push   %ebp
     e81:	57                   	push   %edi
     e82:	56                   	push   %esi
     e83:	53                   	push   %ebx
     e84:	83 ec 1c             	sub    $0x1c,%esp
     e87:	8b 54 24 3c          	mov    0x3c(%esp),%edx
     e8b:	8b 6c 24 30          	mov    0x30(%esp),%ebp
     e8f:	8b 74 24 34          	mov    0x34(%esp),%esi
     e93:	8b 5c 24 38          	mov    0x38(%esp),%ebx
     e97:	85 d2                	test   %edx,%edx
     e99:	75 35                	jne    ed0 <__udivdi3+0x50>
     e9b:	39 f3                	cmp    %esi,%ebx
     e9d:	0f 87 bd 00 00 00    	ja     f60 <__udivdi3+0xe0>
     ea3:	85 db                	test   %ebx,%ebx
     ea5:	89 d9                	mov    %ebx,%ecx
     ea7:	75 0b                	jne    eb4 <__udivdi3+0x34>
     ea9:	b8 01 00 00 00       	mov    $0x1,%eax
     eae:	31 d2                	xor    %edx,%edx
     eb0:	f7 f3                	div    %ebx
     eb2:	89 c1                	mov    %eax,%ecx
     eb4:	31 d2                	xor    %edx,%edx
     eb6:	89 f0                	mov    %esi,%eax
     eb8:	f7 f1                	div    %ecx
     eba:	89 c6                	mov    %eax,%esi
     ebc:	89 e8                	mov    %ebp,%eax
     ebe:	89 f7                	mov    %esi,%edi
     ec0:	f7 f1                	div    %ecx
     ec2:	89 fa                	mov    %edi,%edx
     ec4:	83 c4 1c             	add    $0x1c,%esp
     ec7:	5b                   	pop    %ebx
     ec8:	5e                   	pop    %esi
     ec9:	5f                   	pop    %edi
     eca:	5d                   	pop    %ebp
     ecb:	c3                   	ret    
     ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ed0:	39 f2                	cmp    %esi,%edx
     ed2:	77 7c                	ja     f50 <__udivdi3+0xd0>
     ed4:	0f bd fa             	bsr    %edx,%edi
     ed7:	83 f7 1f             	xor    $0x1f,%edi
     eda:	0f 84 98 00 00 00    	je     f78 <__udivdi3+0xf8>
     ee0:	89 f9                	mov    %edi,%ecx
     ee2:	b8 20 00 00 00       	mov    $0x20,%eax
     ee7:	29 f8                	sub    %edi,%eax
     ee9:	d3 e2                	shl    %cl,%edx
     eeb:	89 54 24 08          	mov    %edx,0x8(%esp)
     eef:	89 c1                	mov    %eax,%ecx
     ef1:	89 da                	mov    %ebx,%edx
     ef3:	d3 ea                	shr    %cl,%edx
     ef5:	8b 4c 24 08          	mov    0x8(%esp),%ecx
     ef9:	09 d1                	or     %edx,%ecx
     efb:	89 f2                	mov    %esi,%edx
     efd:	89 4c 24 08          	mov    %ecx,0x8(%esp)
     f01:	89 f9                	mov    %edi,%ecx
     f03:	d3 e3                	shl    %cl,%ebx
     f05:	89 c1                	mov    %eax,%ecx
     f07:	d3 ea                	shr    %cl,%edx
     f09:	89 f9                	mov    %edi,%ecx
     f0b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
     f0f:	d3 e6                	shl    %cl,%esi
     f11:	89 eb                	mov    %ebp,%ebx
     f13:	89 c1                	mov    %eax,%ecx
     f15:	d3 eb                	shr    %cl,%ebx
     f17:	09 de                	or     %ebx,%esi
     f19:	89 f0                	mov    %esi,%eax
     f1b:	f7 74 24 08          	divl   0x8(%esp)
     f1f:	89 d6                	mov    %edx,%esi
     f21:	89 c3                	mov    %eax,%ebx
     f23:	f7 64 24 0c          	mull   0xc(%esp)
     f27:	39 d6                	cmp    %edx,%esi
     f29:	72 0c                	jb     f37 <__udivdi3+0xb7>
     f2b:	89 f9                	mov    %edi,%ecx
     f2d:	d3 e5                	shl    %cl,%ebp
     f2f:	39 c5                	cmp    %eax,%ebp
     f31:	73 5d                	jae    f90 <__udivdi3+0x110>
     f33:	39 d6                	cmp    %edx,%esi
     f35:	75 59                	jne    f90 <__udivdi3+0x110>
     f37:	8d 43 ff             	lea    -0x1(%ebx),%eax
     f3a:	31 ff                	xor    %edi,%edi
     f3c:	89 fa                	mov    %edi,%edx
     f3e:	83 c4 1c             	add    $0x1c,%esp
     f41:	5b                   	pop    %ebx
     f42:	5e                   	pop    %esi
     f43:	5f                   	pop    %edi
     f44:	5d                   	pop    %ebp
     f45:	c3                   	ret    
     f46:	8d 76 00             	lea    0x0(%esi),%esi
     f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     f50:	31 ff                	xor    %edi,%edi
     f52:	31 c0                	xor    %eax,%eax
     f54:	89 fa                	mov    %edi,%edx
     f56:	83 c4 1c             	add    $0x1c,%esp
     f59:	5b                   	pop    %ebx
     f5a:	5e                   	pop    %esi
     f5b:	5f                   	pop    %edi
     f5c:	5d                   	pop    %ebp
     f5d:	c3                   	ret    
     f5e:	66 90                	xchg   %ax,%ax
     f60:	31 ff                	xor    %edi,%edi
     f62:	89 e8                	mov    %ebp,%eax
     f64:	89 f2                	mov    %esi,%edx
     f66:	f7 f3                	div    %ebx
     f68:	89 fa                	mov    %edi,%edx
     f6a:	83 c4 1c             	add    $0x1c,%esp
     f6d:	5b                   	pop    %ebx
     f6e:	5e                   	pop    %esi
     f6f:	5f                   	pop    %edi
     f70:	5d                   	pop    %ebp
     f71:	c3                   	ret    
     f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     f78:	39 f2                	cmp    %esi,%edx
     f7a:	72 06                	jb     f82 <__udivdi3+0x102>
     f7c:	31 c0                	xor    %eax,%eax
     f7e:	39 eb                	cmp    %ebp,%ebx
     f80:	77 d2                	ja     f54 <__udivdi3+0xd4>
     f82:	b8 01 00 00 00       	mov    $0x1,%eax
     f87:	eb cb                	jmp    f54 <__udivdi3+0xd4>
     f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f90:	89 d8                	mov    %ebx,%eax
     f92:	31 ff                	xor    %edi,%edi
     f94:	eb be                	jmp    f54 <__udivdi3+0xd4>
     f96:	66 90                	xchg   %ax,%ax
     f98:	66 90                	xchg   %ax,%ax
     f9a:	66 90                	xchg   %ax,%ax
     f9c:	66 90                	xchg   %ax,%ax
     f9e:	66 90                	xchg   %ax,%ax

00000fa0 <__umoddi3>:
     fa0:	55                   	push   %ebp
     fa1:	57                   	push   %edi
     fa2:	56                   	push   %esi
     fa3:	53                   	push   %ebx
     fa4:	83 ec 1c             	sub    $0x1c,%esp
     fa7:	8b 6c 24 3c          	mov    0x3c(%esp),%ebp
     fab:	8b 74 24 30          	mov    0x30(%esp),%esi
     faf:	8b 5c 24 34          	mov    0x34(%esp),%ebx
     fb3:	8b 7c 24 38          	mov    0x38(%esp),%edi
     fb7:	85 ed                	test   %ebp,%ebp
     fb9:	89 f0                	mov    %esi,%eax
     fbb:	89 da                	mov    %ebx,%edx
     fbd:	75 19                	jne    fd8 <__umoddi3+0x38>
     fbf:	39 df                	cmp    %ebx,%edi
     fc1:	0f 86 b1 00 00 00    	jbe    1078 <__umoddi3+0xd8>
     fc7:	f7 f7                	div    %edi
     fc9:	89 d0                	mov    %edx,%eax
     fcb:	31 d2                	xor    %edx,%edx
     fcd:	83 c4 1c             	add    $0x1c,%esp
     fd0:	5b                   	pop    %ebx
     fd1:	5e                   	pop    %esi
     fd2:	5f                   	pop    %edi
     fd3:	5d                   	pop    %ebp
     fd4:	c3                   	ret    
     fd5:	8d 76 00             	lea    0x0(%esi),%esi
     fd8:	39 dd                	cmp    %ebx,%ebp
     fda:	77 f1                	ja     fcd <__umoddi3+0x2d>
     fdc:	0f bd cd             	bsr    %ebp,%ecx
     fdf:	83 f1 1f             	xor    $0x1f,%ecx
     fe2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     fe6:	0f 84 b4 00 00 00    	je     10a0 <__umoddi3+0x100>
     fec:	b8 20 00 00 00       	mov    $0x20,%eax
     ff1:	89 c2                	mov    %eax,%edx
     ff3:	8b 44 24 04          	mov    0x4(%esp),%eax
     ff7:	29 c2                	sub    %eax,%edx
     ff9:	89 c1                	mov    %eax,%ecx
     ffb:	89 f8                	mov    %edi,%eax
     ffd:	d3 e5                	shl    %cl,%ebp
     fff:	89 d1                	mov    %edx,%ecx
    1001:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1005:	d3 e8                	shr    %cl,%eax
    1007:	09 c5                	or     %eax,%ebp
    1009:	8b 44 24 04          	mov    0x4(%esp),%eax
    100d:	89 c1                	mov    %eax,%ecx
    100f:	d3 e7                	shl    %cl,%edi
    1011:	89 d1                	mov    %edx,%ecx
    1013:	89 7c 24 08          	mov    %edi,0x8(%esp)
    1017:	89 df                	mov    %ebx,%edi
    1019:	d3 ef                	shr    %cl,%edi
    101b:	89 c1                	mov    %eax,%ecx
    101d:	89 f0                	mov    %esi,%eax
    101f:	d3 e3                	shl    %cl,%ebx
    1021:	89 d1                	mov    %edx,%ecx
    1023:	89 fa                	mov    %edi,%edx
    1025:	d3 e8                	shr    %cl,%eax
    1027:	0f b6 4c 24 04       	movzbl 0x4(%esp),%ecx
    102c:	09 d8                	or     %ebx,%eax
    102e:	f7 f5                	div    %ebp
    1030:	d3 e6                	shl    %cl,%esi
    1032:	89 d1                	mov    %edx,%ecx
    1034:	f7 64 24 08          	mull   0x8(%esp)
    1038:	39 d1                	cmp    %edx,%ecx
    103a:	89 c3                	mov    %eax,%ebx
    103c:	89 d7                	mov    %edx,%edi
    103e:	72 06                	jb     1046 <__umoddi3+0xa6>
    1040:	75 0e                	jne    1050 <__umoddi3+0xb0>
    1042:	39 c6                	cmp    %eax,%esi
    1044:	73 0a                	jae    1050 <__umoddi3+0xb0>
    1046:	2b 44 24 08          	sub    0x8(%esp),%eax
    104a:	19 ea                	sbb    %ebp,%edx
    104c:	89 d7                	mov    %edx,%edi
    104e:	89 c3                	mov    %eax,%ebx
    1050:	89 ca                	mov    %ecx,%edx
    1052:	0f b6 4c 24 0c       	movzbl 0xc(%esp),%ecx
    1057:	29 de                	sub    %ebx,%esi
    1059:	19 fa                	sbb    %edi,%edx
    105b:	8b 5c 24 04          	mov    0x4(%esp),%ebx
    105f:	89 d0                	mov    %edx,%eax
    1061:	d3 e0                	shl    %cl,%eax
    1063:	89 d9                	mov    %ebx,%ecx
    1065:	d3 ee                	shr    %cl,%esi
    1067:	d3 ea                	shr    %cl,%edx
    1069:	09 f0                	or     %esi,%eax
    106b:	83 c4 1c             	add    $0x1c,%esp
    106e:	5b                   	pop    %ebx
    106f:	5e                   	pop    %esi
    1070:	5f                   	pop    %edi
    1071:	5d                   	pop    %ebp
    1072:	c3                   	ret    
    1073:	90                   	nop
    1074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1078:	85 ff                	test   %edi,%edi
    107a:	89 f9                	mov    %edi,%ecx
    107c:	75 0b                	jne    1089 <__umoddi3+0xe9>
    107e:	b8 01 00 00 00       	mov    $0x1,%eax
    1083:	31 d2                	xor    %edx,%edx
    1085:	f7 f7                	div    %edi
    1087:	89 c1                	mov    %eax,%ecx
    1089:	89 d8                	mov    %ebx,%eax
    108b:	31 d2                	xor    %edx,%edx
    108d:	f7 f1                	div    %ecx
    108f:	89 f0                	mov    %esi,%eax
    1091:	f7 f1                	div    %ecx
    1093:	e9 31 ff ff ff       	jmp    fc9 <__umoddi3+0x29>
    1098:	90                   	nop
    1099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10a0:	39 dd                	cmp    %ebx,%ebp
    10a2:	72 08                	jb     10ac <__umoddi3+0x10c>
    10a4:	39 f7                	cmp    %esi,%edi
    10a6:	0f 87 21 ff ff ff    	ja     fcd <__umoddi3+0x2d>
    10ac:	89 da                	mov    %ebx,%edx
    10ae:	89 f0                	mov    %esi,%eax
    10b0:	29 f8                	sub    %edi,%eax
    10b2:	19 ea                	sbb    %ebp,%edx
    10b4:	e9 14 ff ff ff       	jmp    fcd <__umoddi3+0x2d>
